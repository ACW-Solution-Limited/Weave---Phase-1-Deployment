page 82012 "QFPay Service Charge"
{
    ApplicationArea = All;
    Caption = 'QFPay Service Charge';
    PageType = List;
    SourceTable = "QFPay Service Charge";
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
                field("Tender Type"; Rec."Tender Type")
                {
                    ToolTip = 'Specifies the value of the Tender Type field.';
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.';
                }
                field("Plus Fixed Amount"; Rec."Plus Fixed Amount")
                {
                    ToolTip = 'Specifies the value of the Plus Fixed Amount field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
            }
        }
    }
}
