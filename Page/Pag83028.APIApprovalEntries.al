page 83028 APIApprovalEntries
{
    APIGroup = 'app1';
    APIPublisher = 'weave';
    APIVersion = 'v2.0';
    Caption = 'apiApprovalEntries';
    DelayedInsert = true;
    EntityName = 'ApprovalEntries';
    EntitySetName = 'ApprovalEntries';
    PageType = API;
    SourceTable = "Approval Entry";



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(approvalCode; Rec."Approval Code")
                {
                    Caption = 'Approval Code';
                }
                field(approvalType; Rec."Approval Type")
                {
                    Caption = 'Approval Type';
                }
                field(approverID; Rec."Approver ID")
                {
                    Caption = 'Approver ID';
                }
                field(availableCreditLimitLCY; Rec."Available Credit Limit (LCY)")
                {
                    Caption = 'Available Credit Limit (LCY)';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(dateTimeSentForApproval; Rec."Date-Time Sent for Approval")
                {
                    Caption = 'Date-Time Sent for Approval';
                }
                field(delegationDateFormula; Rec."Delegation Date Formula")
                {
                    Caption = 'Delegation Date Formula';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Approval Due Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(lastDateTimeModified; Rec."Last Date-Time Modified")
                {
                    Caption = 'Last Date-Time Modified';
                }
                field(lastModifiedByUserID; Rec."Last Modified By User ID")
                {
                    Caption = 'Last Modified By User ID';
                }
                field(limitType; Rec."Limit Type")
                {
                    Caption = 'Limit Type';
                }
                field(numberOfApprovedRequests; Rec."Number of Approved Requests")
                {
                    Caption = 'Number of Approved Requests';
                }
                field(numberOfRejectedRequests; Rec."Number of Rejected Requests")
                {
                    Caption = 'Number of Rejected Requests';
                }
                field(pendingApprovals; Rec."Pending Approvals")
                {
                    Caption = 'Pending Approvals';
                }
                field(recordIDToApprove; Rec."Record ID to Approve")
                {
                    Caption = 'Record ID to Approve';
                }
                field(relatedToChange; Rec."Related to Change")
                {
                    Caption = 'Related to Change';
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                    Caption = 'Salespers./Purch. Code';
                }
                field(senderID; Rec."Sender ID")
                {
                    Caption = 'Sender ID';
                }
                field(sequenceNo; Rec."Sequence No.")
                {
                    Caption = 'Sequence No.';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(tableID; Rec."Table ID")
                {
                    Caption = 'Table ID';
                }
                field(workflowStepInstanceID; Rec."Workflow Step Instance ID")
                {
                    Caption = 'Workflow Step Instance ID';
                }
            }
        }
    }
}
