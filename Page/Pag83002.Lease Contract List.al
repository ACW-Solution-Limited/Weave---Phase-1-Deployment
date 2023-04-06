page 83002 "Lease Contract List"
{
    ApplicationArea = All;
    Caption = 'Lease Contract List';
    PageType = List;
    SourceTable = "Lease Contract Header";
    CardPageId = "Lease Contract";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field("Automatically Extend"; Rec."Automatically Extend")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Automatically Extend field.';
                }
            }
        }
    }


}
