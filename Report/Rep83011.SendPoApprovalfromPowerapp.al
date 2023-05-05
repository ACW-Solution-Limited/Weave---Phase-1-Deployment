report 83011 "Send Po Approval from Powerapp"
{
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = true;
    Caption = 'Send Po Approval from Powerapp';


    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = sorting("No.") where(Status = filter(Open | "Pending Approval"));

            trigger OnAfterGetRecord()
            var
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
            begin

                If Status = Status::Open then begin
                    If "Request Approval" = true then begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(PurchaseHeader) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(PurchaseHeader);
                    end;
                end else begin
                    If ("Request Approval" = false) And (Status = Status::"Pending Approval") then begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(PurchaseHeader);
                        WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;

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
}
