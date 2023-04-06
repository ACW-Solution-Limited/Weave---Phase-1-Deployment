report 83005 "CRM account Update to BC "
{
    Caption = 'CRM account Update to BC ';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = False;
    dataset
    {
        dataitem(CRMAccount; "CRM Account")
        {

            trigger OnAfterGetRecord()
            var
                l_recCustomer: Record Customer;

            begin
                l_recCustomer.reset;
                l_recCustomer.SetRange("No.", acwapp_accountid);
                If Not l_recCustomer.FindSet() then begin
                    l_recCustomer.init;
                    l_recCustomer."No." := acwapp_accountid;
                    l_recCustomer.Name := acwapp_FirstName + ' ' + acwapp_LastName;
                    l_recCustomer."Gen. Bus. Posting Group" := acwapp_GenBusPostingGroup;
                    l_recCustomer."Vat Bus. Posting Group" := acwapp_VATBusPostingGroup;
                    l_recCustomer."Customer Posting Group" := acwapp_CustomerPostingGroup;
                    l_recCustomer.insert;
                    Error('%1', l_recCustomer."No.");
                end else begin
                    l_recCustomer.Name := acwapp_FirstName + ' ' + acwapp_LastName;
                    l_recCustomer."Gen. Bus. Posting Group" := acwapp_GenBusPostingGroup;
                    l_recCustomer."Vat Bus. Posting Group" := acwapp_VATBusPostingGroup;
                    l_recCustomer."Customer Posting Group" := acwapp_CustomerPostingGroup;
                    l_recCustomer.Modify();
                    Error('%1', l_recCustomer."No.");
                end;

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
    trigger OnInitReport()

    begin
        InitCRMConnection();
    end;

    procedure InitCRMConnection()
    var
        CRMIntegrationTableSynch: Codeunit "CRM Integration Table Synch.";
        IntegrationTableMapping: Record "Integration Table Mapping";
        CDSIntergration: Codeunit "CDS Integration Mgt.";
    begin

        CDSIntergration.RegisterConnection();
        // CRMIntegrationTableSynch.Run(IntegrationTableMapping);

    end;

}
