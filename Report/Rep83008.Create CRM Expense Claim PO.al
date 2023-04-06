report 83008 "Create CRM Expense Claim PO"
{
    ApplicationArea = All;
    Caption = 'Create CRM Expense Claim PO';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset

    {

        dataitem(ExpenseClaim; "Expense Claim")
        {
            DataItemTableView = sorting(Date) order(ascending) where(Status = const(Open));
            trigger OnAfterGetRecord()
            var
                l_recExpClaimAdmin: Record "Expense Claim Admin";
                l_recExpTypes: Record "Expense Type";
                l_cuNoSeriesMgt: Codeunit NoSeriesManagement;
                l_recPurchasePayableSetup: Record "Purchases & Payables Setup";
                l_recICPartner: Record "IC Partner";
            begin
                l_recPurchasePayableSetup.Get();
                g_codNewPONo := l_cuNoSeriesMgt.GetNextNo(l_recPurchasePayableSetup."Order Nos.", WorkDate(), true);

                if (g_codPrevExpClaimAdmin = '') OR (g_codPrevExpClaimAdmin <> GetUserByEmail("Staff Email")) then begin
                    g_recPOHeader.init;
                    g_recPOHeader."No." := g_codNewPONo;
                    g_recPOHeader."Document Type" := g_recPOHeader."Document Type"::Order;
                    g_recPOHeader."Document Date" := Date;
                    g_recPOHeader."Posting Date" := "Created On";

                    if g_recPOHeader.insert(true) then;

                    l_recExpClaimAdmin.get(GetUserByEmail("Staff Email"));
                    g_recPOHeader.validate("Buy-from Vendor No.", l_recExpClaimAdmin."Vendor No.");
                    g_recPOHeader.Modify((true));
                    g_intLineNo := 10000;
                    g_codPrevExpClaimAdmin := GetUserByEmail("Staff Email");
                end;
                g_recPOLine.init;
                g_recPOLine."Document Type" := g_recPOHeader."Document Type";
                g_recPOLine."Document No." := g_recPOHeader."No.";
                g_recPOLine."Line No." := g_intLineNo;
                if g_recPOLine.insert(true) then;

                g_recPOLine.Validate(Type, g_recPOLine.Type::"G/L Account");
                if l_recExpTypes.Get("Expense Type") then
                    g_recPOLine.Validate("No.", l_recExpTypes."G/L Account");

                g_recPOLine.Validate(Quantity, 1);


                if "Expense Type" <> '' then
                    g_recPOLine.Validate("Expense Type", "Expense Type");

                if "IC Partner" <> '' then begin
                    l_recICPartner.Reset();
                    l_recICPartner.SetFilter(Name, '%1', "IC Partner");
                    if l_recICPartner.FindFirst() then
                        g_recPOLine.Validate("Expense IC Partner", l_recICPartner.Code);
                end;

                g_recPOLine.Validate("Direct Unit Cost", ExpenseClaim.Amount);
                if g_recPOLine.Modify() then;
                ExpenseClaim."Purchase Order No." := g_recPOLine."Document No.";
                ExpenseClaim."Purchase Order Line No." := g_recPOLine."Line No.";
                ExpenseClaim.Status := ExpenseClaim.Status::Created;
                Modify();

                g_intLineNo += 10000;

            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPostReport()
    var
        l_recPurhcaseOrder: Record "Purchase Header";
    begin
        l_recPurhcaseOrder.SetFilter("No.", g_codNewPONo);

        g_pagePO.SetRecord(g_recPOHeader);
        g_pagePO.Run();

    end;


    procedure GetUserByEmail(Email: Text[250]): Text
    var
        l_recUser: Record User;
    begin
        l_recUser.Reset();
        l_recUser.SetFilter("Authentication Email", Email);
        if l_recUser.FindFirst() then
            exit(l_recUser."User Name")
        else
            exit('');

    end;




    var
        g_codPrevExpClaimAdmin: Code[20];
        g_recPOHeader: Record "Purchase Header";
        g_recPOLine: Record "Purchase Line";
        g_intLineNo: Integer;
        g_pagePO: Page "Purchase Order";
        g_codNewPONo: Code[50];

}
