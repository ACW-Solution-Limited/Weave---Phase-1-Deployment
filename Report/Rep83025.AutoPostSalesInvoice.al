report 83025 "Auto Post Sales Invoice"
{
    ApplicationArea = All;
    Caption = 'Auto Post Sales Invoice';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(No; "No.")
            {

            }

            trigger OnAfterGetRecord()
            var
                l_cuLeaseContractManagement: Codeunit "Lease Contract Management";
            begin
                if SalesHeader."Posting Date" > WorkDate() then
                    CurrReport.Skip();

                if SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice then
                    CurrReport.Skip();

                l_cuLeaseContractManagement.PostSalesDocument("No.");

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

    }
}
