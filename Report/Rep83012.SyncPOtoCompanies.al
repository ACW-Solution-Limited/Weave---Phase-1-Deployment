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

            begin
                Clear(g_Purchase_No);
                l_PurchasesPayablesSetup.reset;
                l_recLocation.reset;
                If ("Sync to Companies" = true) OR ("Assigned PO No." <> '') then
                    CurrReport.skip;

                If ("Company Filter" = '') then
                    CurrReport.skip;

                l_recLocation.Get("Company Filter");
                g_Companyfilter := l_recLocation."Company Name";
                // g_Companyfilter := "Company Filter".TrimEnd().TrimStart();
                l_recPurchaseHeader.reset;
                l_recPurchaseHeader.ChangeCompany(g_Companyfilter);
                l_PurchasesPayablesSetup.ChangeCompany(g_Companyfilter);
                l_PurchasesPayablesSetup.Get;
                l_recPurchaseHeader.Init();
                //l_recPurchaseHeader := PurchaseHeader;
                l_recPurchaseHeader.TransferFields(PurchaseHeader);
                l_recPurchaseHeader."No." := NoSeriesMgt.GetNextNo(l_PurchasesPayablesSetup."Order Nos.", WorkDate(), true);
                g_Purchase_No := l_recPurchaseHeader."No.";
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
