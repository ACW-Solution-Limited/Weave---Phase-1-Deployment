page 83032 APIApproveRecord
{
    APIGroup = 'app1';
    APIPublisher = 'weave';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiApproveRecord';
    DelayedInsert = true;
    EntityName = 'ApprovalRecord';
    EntitySetName = 'ApprovalRecord';
    PageType = API;
    SourceTable = "Approval Record for PowerApp";
    AutoSplitKey = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(workingInstanceID; Rec.WorkingInstanceID)
                {
                    Caption = 'WorkingInstanceID';
                }

                field(purchaseNo; Rec."Purchase No.")
                {
                    Caption = 'Purchase No.';
                }
                field(approveReject; Rec."Approve/Reject")
                {
                    Caption = 'Approve/Reject';
                }
                field(approvedDate; Rec."Approved Date")
                {
                    Caption = 'Approved Date';
                }
                field(approverID; Rec."Approver ID")
                {
                    Caption = 'Approver ID';
                }
                field(completed; Rec.Completed)
                {
                    Caption = 'Completed';
                }

                field(sequenceNo; Rec."Sequence No.")
                {
                    Caption = 'Completed';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }


            }
        }
    }
}
