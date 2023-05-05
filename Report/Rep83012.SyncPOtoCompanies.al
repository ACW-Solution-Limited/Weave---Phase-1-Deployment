report 83012 "Sync PO to Companies"
{
    Caption = 'Sync PO to Companies';
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = true;

    // Only Run in HK and SG Master for sync PO which created in PowerApps.
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = sorting("No.") where(Status = filter(Released));



            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = PurchaseHeader;
                DataItemTableView = SORTING("Document No.", "Line No.");


                trigger OnAfterGetRecord()

                var
                    l_recPurchaseLine: Record "Purchase Line";

                begin
                    l_recPurchaseLine.Reset;


                    l_recPurchaseLine.ChangeCompany(g_Companyfilter);
                    l_recPurchaseLine.Init();
                    l_recPurchaseLine.TransferFields(PurchaseLine);
                    l_recPurchaseLine."Document No." := g_Purchase_No;
                    // Message('%1 :%2', "No.", g_Purchase_No);
                    l_recPurchaseLine.Insert();
                end;


            }

            trigger OnAfterGetRecord()
            var
                l_recPurchaseHeader: Record "Purchase Header";
                l_recLocation: Record Location;
                l_PurchasesPayablesSetup: Record "Purchases & Payables Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
                l_NoSeriesLine: Record "No. Series Line";
                l_PoNumber: Integer;
                l_l_PoNumberCode: Code[20];

            begin
                Clear(g_Purchase_No);
                Clear(g_Companyfilter);
                Clear(l_PoNumber);
                Clear(l_l_PoNumberCode);
                l_PurchasesPayablesSetup.reset;
                l_recLocation.reset;
                l_NoSeriesLine.reset;
                If ("Sync to Companies" = true) OR ("Assigned PO No." <> '') then
                    CurrReport.skip;

                If ("Company Filter" = '') then
                    CurrReport.skip;

                l_recLocation.Get("Company Filter");
                g_Companyfilter := l_recLocation."Company Name";

                // g_Companyfilter := "Company Filter".TrimEnd().TrimStart();

                l_recPurchaseHeader.ChangeCompany(g_Companyfilter);
                l_recPurchaseHeader.reset;
                l_PurchasesPayablesSetup.ChangeCompany(g_Companyfilter);
                l_NoSeriesLine.ChangeCompany(g_Companyfilter);
                l_PurchasesPayablesSetup.Get;
                l_recPurchaseHeader.Init();
                l_recPurchaseHeader.TransferFields(PurchaseHeader);
                l_NoSeriesLine.reset;
                l_NoSeriesLine.SetRange("Series Code", l_PurchasesPayablesSetup."Order Nos.");
                l_NoSeriesLine.SetFilter("Starting Date", '<=%1', "Posting Date");
                If l_NoSeriesLine.findlast then begin
                    If l_NoSeriesLine."Last No. Used" <> '' then begin
                        g_Purchase_No := INCSTR(l_NoSeriesLine."Last No. Used");
                    end else begin
                        g_Purchase_No := l_NoSeriesLine."Starting No.";
                    end;
                end else begin
                    g_Purchase_No := "No.";
                end;
                //  g_Purchase_No := "No.";
                l_recPurchaseHeader."No." := g_Purchase_No;
                //Message('%1', l_recPurchaseHeader."No.");
                l_recPurchaseHeader."Assigned PO No." := PurchaseHeader."No.";
                l_recPurchaseHeader.Insert();
                // Message('%1 :%2', "No.", g_Companyfilter);
                //  Message('%1 :%2', "No.", g_Purchase_No);
                "Assigned PO No." := l_recPurchaseHeader."No.";
                "Sync to Companies" := true;
                Modify();
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
    var
        g_Companyfilter: Text[100];
        g_Purchase_No: Code[20];
}
