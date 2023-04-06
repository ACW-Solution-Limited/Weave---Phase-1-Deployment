page 83025 "Generic Users"
{
    ApplicationArea = All;
    Caption = 'Generic Users';
    PageType = List;
    SourceTable = "Generic User";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Vender No."; Rec."Vender No.")
                {
                    ToolTip = 'Specifies the value of the Vender No. field.';
                }
                field("Vender Name"; Rec."Vender Name")
                {
                    ToolTip = 'Specifies the value of the Vender Name field.';
                }
            }
        }
    }
}
