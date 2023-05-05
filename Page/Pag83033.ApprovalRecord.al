page 83033 "Approval Record"
{
    ApplicationArea = All;
    Caption = 'Approval Record';
    PageType = List;
    SourceTable = "Approval Record for PowerApp";
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Purchase No."; Rec."Purchase No.")
                {
                    ToolTip = 'Specifies the value of the Purchase No. field.';
                }
                field(WorkingInstanceID; Rec.WorkingInstanceID)
                {
                    ToolTip = 'Specifies the value of the WorkingInstanceID field.';
                }
                field("Line No"; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ToolTip = 'Specifies the value of the Sequence No. field.';
                }
                field("Approve/Reject"; Rec."Approve/Reject")
                {
                    ToolTip = 'Specifies the value of the Approve/Reject field.';
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ToolTip = 'Specifies the value of the Approved Date field.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ToolTip = 'Specifies the value of the Approver ID field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
            }
        }
    }
}
