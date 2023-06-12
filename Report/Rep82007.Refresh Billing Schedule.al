report 82007 "Refresh Billing Schedule"
{
    ApplicationArea = All;
    Caption = 'Refresh Billing Schedule';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = True;
    dataset
    {
        dataitem(LeaseContractHeader; "Lease Contract Header")
        {
            DataItemTableView = sorting("No.") where(Status = filter(ConfirmedWithRoomAllocated | Active | "ReadyForCheck-in"));
            trigger OnAfterGetRecord()
            var
                l_recLeasecontractBillingSched: Record "Lease Contract Billing Sched.";
                l_Codeleasecontract: Codeunit "Lease Contract Management";
            begin
                l_recLeasecontractBillingSched.Reset();
                l_recLeasecontractBillingSched.setrange("Contract No.", LeaseContractHeader."No.");
                If not l_recLeasecontractBillingSched.FindSet then
                    if LeaseContractHeader."Original Contract No." = '' then
                        l_Codeleasecontract.RefreshBillingSchedule(LeaseContractHeader, true)
                    else
                        l_Codeleasecontract.RenewalContract(LeaseContractHeader."Original Contract No.", LeaseContractHeader."No.");
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
}
