page 83020 "Product Type"
{
    ApplicationArea = All;
    Caption = 'Product Type';
    PageType = List;
    SourceTable = "Product Type";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("CRM GUID"; Rec."CRM GUID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CRM GUID field.';
                }
            }
        }
    }
}
