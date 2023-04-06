report 83004 "Ins. Add. Item Sales to Bill S"
{
    ApplicationArea = All;
    Caption = 'Insert Additional Item Sales to Billing Schedule';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(AdditionalItemSales; "Additional Item Sales")
        {

            DataItemTableView = sorting("Contract No.", Date, SystemCreatedAt) order(ascending) where(Status = const(Open));
            trigger OnAfterGetRecord()
            var
                l_recLCBillingSchedule: Record "Lease Contract Billing Sched.";
                l_recLCBillingScheduleInsert: Record "Lease Contract Billing Sched.";
                l_datPostingDate: Date;

            begin
                if g_codPrevContract <> "Contract No." then begin
                    l_recLCBillingSchedule.reset;
                    l_recLCBillingSchedule.SetRange("Contract No.", "Contract No.");
                    if l_recLCBillingSchedule.find('+') then
                        g_intLineNo := l_recLCBillingSchedule."Line No." + 10000
                    else
                        g_intLineNo := 10000;
                end;


                l_recLCBillingSchedule.reset;
                l_recLCBillingSchedule.SetRange("Contract No.", "Contract No.");
                l_recLCBillingSchedule.SetRange("Posting Date", Date, 99991231D);
                l_recLCBillingSchedule.SetRange(Status, l_recLCBillingSchedule.Status::" ");
                if l_recLCBillingSchedule.find('-') then begin
                    l_datPostingDate := l_recLCBillingSchedule."Posting Date";
                end else begin
                    l_datPostingDate := Date;
                end;

                l_recLCBillingScheduleInsert.init;
                l_recLCBillingScheduleInsert.Type := l_recLCBillingScheduleInsert.Type::Item;
                l_recLCBillingScheduleInsert."Customer No." := "Customer No.";
                l_recLCBillingScheduleInsert."Contract No." := "Contract No.";
                l_recLCBillingScheduleInsert."Line No." := g_intLineNo;
                l_recLCBillingScheduleInsert."Posting Date" := l_datPostingDate;
                l_recLCBillingScheduleInsert."Additional Item Sales Date" := Date;
                l_recLCBillingScheduleInsert."Additional Sales Item No." := "Item No.";
                l_recLCBillingScheduleInsert."Additional Sales Item Quantity" := Quantity;
                l_recLCBillingScheduleInsert."Add. Sales Item Unit Price" := "Unit Price";
                l_recLCBillingScheduleInsert.Amount := Quantity * "Unit Price";

                if l_recLCBillingScheduleInsert.insert then;


                Status := Status::Created;
                Modify;
                g_codPrevContract := "Contract No.";
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
    var
        g_codPrevContract: Code[20];
        g_intLineNo: Integer;
}
