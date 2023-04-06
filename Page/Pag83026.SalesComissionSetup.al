page 83026 "Sales Commission Setup"
{
    ApplicationArea = All;
    Caption = 'Sales Commission Setup';
    PageType = List;
    SourceTable = "Sales Commission Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ToolTip = 'Specifies the value of the Commission Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Minimum Contract Period"; Rec."Minimum Contract Period")
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }

}
