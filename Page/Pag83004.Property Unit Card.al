page 83004 "Property Unit Card"
{
    Caption = 'Property Unit Card';
    PageType = Card;
    SourceTable = "Property Unit";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Room Type Name"; Rec."Room Type Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room No. field.';
                }
                field("Sub Type Name"; Rec."Sub Type Name")
                {
                    ApplicationArea = All;
                }
                field("Property Unit Name"; Rec."Property Unit Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Unit Name field.';
                }


            }

            group("Details")
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specified the value of the Type field.';
                }


                field("Property Unit Group"; Rec."Property Unit Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Unit Group field.';
                }
                field("Property Unit Group No."; Rec."Property Unit Group No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Unit Group No. field.';
                }
                field(Floor; Rec.Floor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Floor field.';
                }
            }

            group("Address Information")
            {

                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country Code field.';
                }
                field("Sort Order"; rec."Sort Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Spcifies the value of the Sort Order.';
                }

            }
        }
    }
}
