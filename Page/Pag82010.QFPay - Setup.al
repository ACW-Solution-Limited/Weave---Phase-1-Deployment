page 82010 "QFPay Setup"
{
    ApplicationArea = All;
    Caption = 'QFPay Setup';
    PageType = Card;
    SourceTable = "QFPay Setup";
    UsageCategory = Tasks;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Enable; Rec.Enable) { ApplicationArea = all; }
                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.';
                    ApplicationArea = all;
                }
                field("API Code"; Rec."API Code")
                {
                    ToolTip = 'Specifies the value of the API Code field.';
                    ApplicationArea = all;
                }
                field("API Key"; Rec."API Key")
                {
                    ToolTip = 'Specifies the value of the API Key field.';
                    ApplicationArea = all;
                }

                field("QFPay Processing Fee G/L Acc."; Rec."QF Pay Processing Fee G/L Acc.") { ApplicationArea = all; }
                field("QFPay Payment Jnl. Template"; Rec."QF Pay Payment Jnl. Template") { ApplicationArea = all; }
                field("QFPay Payment Jnl. Batch"; Rec."QF Pay Payment Jnl. Batch") { ApplicationArea = all; }

                field("QFPay Refund Jnl. Template"; Rec."QFPay Refund Jnl. Template") { ApplicationArea = all; }
                field("QFPay Refund Jnl. Batch"; Rec."QFPay Refund Jnl. Batch") { ApplicationArea = all; }
                field("Receiving Bank Account"; Rec."Receiving Bank Account") { ApplicationArea = all; }






            }
        }
    }

}
