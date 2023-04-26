report 83003 "Create Expense Claim PO"
{
    ApplicationArea = All;
    Caption = 'Create Expense Claim PO';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    UseRequestPage = true;
    dataset
    {
        dataitem(ExpenseClaimAdmin; "Expense Claim Admin")
        {
            dataitem(ExpenseClaim; "Expense Claim")
            {
                DataItemTableView = sorting(Date) order(ascending) where(Status = const(Open));
                DataItemLink = "Expense Claim Admin" = field("No.");
                RequestFilterFields = "Expense Claim Admin", Date;

                trigger OnPreDataItem()
                begin
                    SetRange(Date, g_datStart, g_datEnd);
                end;

                trigger OnAfterGetRecord()
                begin
                    if g_boolCreatePurchaseHeader then
                        g_codeNewPONo := InsertPurchaseHeader(ExpenseClaimAdmin, ExpenseClaim);

                    InsertPurchaseLine(ExpenseClaim);
                end;
            }

            trigger OnPreDataItem()
            begin
                if g_codAdmin <> '' then
                    ExpenseClaimAdmin.SetFilter("No.", g_codAdmin);
            end;

            trigger OnAfterGetRecord()
            begin
                g_boolCreatePurchaseHeader := true;
                g_intLineNo := 10000;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Date)
                {
                    field(Admin; g_codAdmin) { ApplicationArea = all; TableRelation = "Expense Claim Admin"."No."; }
                    field("Start Date"; g_datStart)
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            g_datEnd := CalcDate('1M', g_datStart);
                        end;
                    }
                    field("End Date"; g_datEnd)
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            if g_datStart > g_datEnd then
                                Error('The date range is not valid.');
                        end;
                    }
                }
            }
        }

    }
    trigger OnInitReport()
    begin
        g_datStart := WorkDate();
        g_datEnd := CalcDate('1M', g_datStart);
    end;

    trigger OnPostReport()
    var
        l_recPurhcaseOrder: Record "Purchase Header";
        l_pagePO: Page "Purchase Order";
    begin
        if l_recPurhcaseOrder.Get(l_recPurhcaseOrder."Document Type"::Order, g_codeNewPONo) then begin
            l_pagePO.SetRecord(l_recPurhcaseOrder);
            l_pagePO.Run();
        end;
    end;

    procedure InsertPurchaseHeader(ExpenseClaimAdmin: Record "Expense Claim Admin"; ExpenseClaim: Record "Expense Claim"): Code[50]
    var
        l_recPurchaseHeader: Record "Purchase Header";
    begin

        l_recPurchaseHeader.init;
        l_recPurchaseHeader."No." := '';
        l_recPurchaseHeader."Document Type" := l_recPurchaseHeader."Document Type"::Order;
        l_recPurchaseHeader."Document Date" := WorkDate();
        l_recPurchaseHeader."Posting Date" := WorkDate();
        l_recPurchaseHeader."Vendor Invoice No." := ExpenseClaim."No.";


        if l_recPurchaseHeader.insert(true) then;
        l_recPurchaseHeader.validate("Buy-from Vendor No.", ExpenseClaimAdmin."Vendor No.");

        l_recPurchaseHeader.Modify((true));

        g_boolCreatePurchaseHeader := false;

        exit(l_recPurchaseHeader."No.");
    end;

    procedure InsertPurchaseLine(var ExpenseClaim: Record "Expense Claim")
    var
        l_recPurchaseLine: Record "Purchase Line";
    begin
        l_recPurchaseLine.init;
        l_recPurchaseLine."Document Type" := l_recPurchaseLine."Document Type"::Order;
        l_recPurchaseLine."Document No." := g_codeNewPONo;

        l_recPurchaseLine."Line No." := g_intLineNo;
        if l_recPurchaseLine.insert(true) then begin

            l_recPurchaseLine.Validate(Type, l_recPurchaseLine.Type::"G/L Account");
            l_recPurchaseLine.Validate(Quantity, 1);


            if ExpenseClaim."Expense Type" <> '' then
                l_recPurchaseLine.Validate("Expense Type", ExpenseClaim."Expense Type");

            if ExpenseClaim."IC Partner" <> '' then
                l_recPurchaseLine.Validate("Expense IC Partner", ExpenseClaim."IC Partner");

            l_recPurchaseLine.Validate("Direct Unit Cost", ExpenseClaim.Amount);


            if l_recPurchaseLine.Modify() then;

            ExpenseClaim."Purchase Order No." := l_recPurchaseLine."Document No.";
            ExpenseClaim."Purchase Order Line No." := l_recPurchaseLine."Line No.";
            ExpenseClaim.status := ExpenseClaim.status::Created;
            ExpenseClaim.Modify();
            g_intLineNo += 10000;
        end;


    end;


    var
        g_boolCreatePurchaseHeader: Boolean;
        g_codeNewPONo: Code[50];
        g_intLineNo: Integer;

        g_datStart: Date;
        g_datEnd: Date;
        g_codAdmin: Code[20];

}
