tableextension 83127 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(80000; "Company Filter"; Text[100])
        {
            Caption = 'Company filter for Powerapp';// TableRelation = Company.Name; 
        }
        field(80001; "User Name"; Text[80])
        {
            Caption = 'User Name';// TableRelation = "Generic User"."User Name"; 
        }
        field(80002; "Assigned PO No."; Code[20]) { Caption = 'Assigned PO NO.'; }

        field(80003; "Request Approval"; Boolean)
        {
            Caption = 'Request Approval';
            // Editable = false;

            // trigger OnValidate()
            // var
            //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //     WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
            // begin
            //     If "Request Approval" = true then begin
            //         if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
            //             ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
            //     end else begin
            //         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
            //         WorkflowWebhookMgt.FindAndCancel(RecordId);
            //     end;
            // end;

        }
        // trigger on()
        // var
        //     myInt: Integer;
        // begin

        // end;
        field(80004; "Sync to Companies"; Boolean)
        {
            Caption = 'Sync to Companies';
        }


    }
    // trigger OnModify()
    // var
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //     WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    // begin
    //     If "Request Approval" = true then begin
    //         if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
    //             ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
    //     end else begin
    //         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
    //         WorkflowWebhookMgt.FindAndCancel(RecordId);
    //     end;
    // end;
}
