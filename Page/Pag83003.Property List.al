page 83003 "Property List"
{
    //ApplicationArea = All;
    Caption = 'Property List';
    PageType = List;
    SourceTable = Property;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
