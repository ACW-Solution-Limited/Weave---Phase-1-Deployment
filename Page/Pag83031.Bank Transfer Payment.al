page 83031 "Bank Transfer Payment"
{
    ApplicationArea = All;
    Caption = 'Bank Transfer Payment';
    PageType = List;
    SourceTable = "Bank Transfer Payment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Bedroom Offer"; Rec."Bedroom Offer")
                {
                    ToolTip = 'Specifies the value of the Bed Room Offer field.';
                }
                field("Bank Transfer Payslip"; Rec."Bank Transfer Payslip")
                {
                    ToolTip = 'Specifies the value of the Bank Transfer Payslip field.';
                }
                field("Confirmed Transfer Payment"; Rec."Confirmed Transfer Payment")
                {
                    ToolTip = 'Specifies the value of the Confirmed Bank Transfer Payment field.';
                }
            }
        }
    }
}
