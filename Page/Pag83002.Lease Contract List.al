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
                field("Contract Name"; Rec."Contract Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Name field.';
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
                field("Contract Start Date"; DT2Date(Rec."Contract Start Date"))
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                }
                field("Contract End Date"; DT2Date(Rec."Contract End Date"))
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Name field.';
                }

                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room No. field.';
                }
                field("Room Type"; Rec."Room Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room Type field.';
                }
                field("Room Name"; Rec."Room Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room Name field.';
                }
                field("Deposit Returned"; Rec."Deposit Returned")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Returnedfield.';
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
