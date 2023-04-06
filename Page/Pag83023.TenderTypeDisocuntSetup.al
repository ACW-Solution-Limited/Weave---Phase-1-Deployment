page 83023 "Tender Type Disocunt Setup"
{
    ApplicationArea = All;
    Caption = 'Tender Type Disocunt Setup';
    PageType = List;
    SourceTable = "Tender Type Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tender Type"; Rec."Tender Type")
                {
                    ToolTip = 'Specifies the value of the Tender Type field.';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }
                field("Invoice Description"; Rec."Invoice Description")
                {
                    ToolTip = 'Specifies the value of the Invoice Description field.';
                }
            }
        }
    }

}
