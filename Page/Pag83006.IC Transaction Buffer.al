page 83006 "IC Transaction Buffer"
{
    ApplicationArea = All;
    Caption = 'IC Transaction Buffer';
    PageType = List;
    SourceTable = "IC Transaction Buffer";
    UsageCategory = Lists;
    SourceTableView = Sorting(SystemCreatedAt) Order(Ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';

                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("From Company"; Rec."From Company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Company field.';
                }
                field("To Company"; Rec."To Company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Company field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Account No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Journal Template"; Rec."Journal Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Tempalte field.';

                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                }

                field("Journal Line No."; Rec."Journal Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Line No. field.';

                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Post")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = Post;
                RunObject = report "Post IC Trans Buffer";

            }
        }
    }

}
