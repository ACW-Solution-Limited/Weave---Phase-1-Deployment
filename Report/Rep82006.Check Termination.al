report 82006 "Check Term/Create Sales Inv"
{
    ApplicationArea = All;
    Caption = 'Check Term and Create Sales Inv.';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(p_recLeaseContractHeader; "Lease Contract Header")
        {
            DataItemTableView = sorting("No.") /*where(Status = filter(Confirmed | ConfirmedWithRoomAllocated))*/;

            Trigger OnAfterGetRecord()
            var
                TerminationDateCodunit: Codeunit "Lease Contract Management";
                CreateInvoiceCreditMemo: Report "Lease Contract Create Invoices";
                l_recBillingSchedule: Record "Lease Contract Billing Sched.";
                l_recBillingSchedule2: Record "Lease Contract Billing Sched.";
            begin
                /* Check whether the deposit is returned. If yes, means that the whole contract process is completed*/
                If "Deposit Returned" = true then
                    CurrReport.Skip();

                CreateInvoiceCreditMemo.SetTableView(p_recLeaseContractHeader);
                CreateInvoiceCreditMemo.UseRequestPage := false;
                l_recBillingSchedule.reset;
                l_recBillingSchedule2.reset;
                //Check whether the termination is run 
                If p_recLeaseContractHeader."Run Terminated Billing Sched." <> 0DT then begin
                    CreateInvoiceCreditMemo.Run;
                end else begin
                    If DT2date("Contract Termination Date") <> 0D then begin
                        TerminationDateCodunit.TerminateContract(p_recLeaseContractHeader, true);
                        //p_recLeaseContractHeader."Run Terminated Billing Sched." := CurrentDateTime;
                        //p_recLeaseContractHeader.Modify;
                        /*l_recBillingSchedule.SetRange("Contract No.", p_recLeaseContractHeader."No.");
                        l_recBillingSchedule.setrange(Type, l_recBillingSchedule.Type::Deposit);
                        l_recBillingSchedule.SetFilter(Amount, '<%1', 0);
                        If l_recBillingSchedule.findlast() then begin
                            l_recBillingSchedule."Posting Date" := CalcDate('2D', DT2Date("Contract Termination Date"));
                            l_recBillingSchedule.Modify;
                        end;*/
                        CreateInvoiceCreditMemo.Run;
                    end else begin

                        // If DT2date("Contract End Date") = WorkDate() then begin
                        //TerminationDateCodunit.TerminateContract(p_recLeaseContractHeader);
                        // p_recLeaseContractHeader."Run Terminated Billing Sched." := CurrentDateTime;
                        //  CreateInvoiceCreditMemo.Run;
                        // end else begin
                        //If not in contract end date and no termination date, run create invoice
                        CreateInvoiceCreditMemo.Run;
                        // end;
                    end;

                    l_recBillingSchedule2.SetRange("Contract No.", p_recLeaseContractHeader."No.");
                    l_recBillingSchedule2.setrange(Type, l_recBillingSchedule.Type::Deposit);
                    l_recBillingSchedule2.SetFilter(Amount, '<%1', 0);
                    If l_recBillingSchedule2.FindLast() then
                        If l_recBillingSchedule2."Posting Date" < WorkDate() then begin
                            p_recLeaseContractHeader."Deposit Returned" := True;
                        end;

                    //If DT2date("Contract Termination Date") = WorkDate() then begin

                    //  p_recLeaseContractHeader.Terminated := True;
                    //  p_recLeaseContractHeader.Modify;
                    //     end
                    // end else begin
                    // If DT2Date(p_recLeaseContractHeader."Contract End Date") = WorkDate then
                    //     TerminationDateCodunit.TerminateContract(p_recLeaseContractHeader);
                    //  p_recLeaseContractHeader.Terminated := True;
                    //p_recLeaseContractHeader.Modify;
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
    var
    //JobQueueEntry: Record "Job Queue Entry";
    begin
        // JobQueueEntry.SetRange("Object ID to Run", 82006);
        // IF JobQueueEntry.FindFirst() then
        //     JobQueueEntry."Run in User Session" := True;
        // JobQueueEntry.Modify();
        //  Codeunit.Run(Codeunit::"CRM Integration Management");
        // SynchronizeNow(false);

    end;

    // procedure SynchronizeNow(DoFullSynch: Boolean)
    // var
    //     IntegrationTableMapping: Record "Integration Table Mapping";
    //     TempNameValueBuffer: Record "Name/Value Buffer" temporary;
    //     CDSSetupDefaults: Codeunit "CDS Setup Defaults";
    // begin
    //     CDSSetupDefaults.GetPrioritizedMappingList(TempNameValueBuffer);

    //     TempNameValueBuffer.Ascending(true);
    //     if not TempNameValueBuffer.FindSet() then
    //         exit;

    //     repeat
    //         if IntegrationTableMapping.Get(TempNameValueBuffer.Value) then
    //             IntegrationTableMapping.SynchronizeNow(DoFullSynch);
    //     until TempNameValueBuffer.Next() = 0;
    // end;

}
