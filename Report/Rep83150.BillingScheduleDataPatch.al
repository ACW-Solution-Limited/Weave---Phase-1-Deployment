report 83150 "Billing Schedule Data Patch"
{
    ApplicationArea = All;
    Caption = 'Billing Schedule Data Patch';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(LeaseContractHeader; "Lease Contract Header")
        {
            DataItemTableView = sorting("No.") where(Status = filter(ConfirmedWithRoomAllocated | Active | "ReadyForCheck-in"));
            column(No; "No.")
            {
            }

            trigger OnPreDataItem()
            var
                l_recBillingScheduleDelete: Record "Lease Contract Billing Sched.";
            begin
                l_recBillingScheduleDelete.Reset();
                l_recBillingScheduleDelete.SetRange("Line No.", 9999999);
                if l_recBillingScheduleDelete.FindFirst() then
                    repeat
                        l_recBillingScheduleDelete.Delete();
                    until l_recBillingScheduleDelete.Next() = 0;

            end;

            trigger OnAfterGetRecord()
            var
                l_recBillingSchedule: Record "Lease Contract Billing Sched.";
                l_recBillingScheduleChecking: Record "Lease Contract Billing Sched.";
                l_recBillingScheduleCheckingNoOfDepost: Record "Lease Contract Billing Sched.";

            begin

                if DT2Date("Contract End Date") <= g_dateOfPatch then
                    CurrReport.Skip();

                l_recBillingScheduleChecking.Reset();
                l_recBillingScheduleChecking.SetFilter("Contract No.", LeaseContractHeader."No.");
                l_recBillingScheduleChecking.SetRange(Type, l_recBillingScheduleChecking.Type::Deposit);
                l_recBillingScheduleChecking.SetFilter(Amount, '>0');
                if l_recBillingScheduleChecking.FindFirst() then begin
                    l_recBillingScheduleCheckingNoOfDepost.Reset();
                    l_recBillingScheduleCheckingNoOfDepost.SetFilter("Contract No.", LeaseContractHeader."No.");
                    l_recBillingScheduleCheckingNoOfDepost.SetRange(Type, l_recBillingScheduleCheckingNoOfDepost.Type::Deposit);
                    if l_recBillingScheduleCheckingNoOfDepost.Count = 1 then begin
                        l_recBillingSchedule.Init();
                        l_recBillingSchedule.TransferFields(l_recBillingScheduleChecking);
                        l_recBillingSchedule."Line No." := 9999999;
                        l_recBillingSchedule."Posting Date" := CalcDate('+2D', DT2Date(LeaseContractHeader."Contract End Date"));
                        l_recBillingSchedule."Due Date" := l_recBillingSchedule."Posting Date";
                        l_recBillingSchedule."Document No." := '';
                        l_recBillingSchedule.Status := l_recBillingSchedule.Status::" ";
                        l_recBillingSchedule."Sales Invoice Creation Date" := 0DT;
                        l_recBillingSchedule.Amount := l_recBillingScheduleChecking.Amount * -1;
                        l_recBillingSchedule.Insert();
                    end;
                end

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Date of Patch"; g_dateOfPatch) { ApplicationArea = all; }
            }
        }
        trigger OnOpenPage()
        begin
            g_dateOfPatch := DMY2Date(8, 5, 2023);
        end;
    }
    var

        g_dateOfPatch: Date;
}

