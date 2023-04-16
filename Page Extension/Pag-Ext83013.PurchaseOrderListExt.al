pageextension 83013 "Purchase Order List Ext" extends "Purchase Order List"
{
    layout
    {
        addlast(Control1)
        {

            field("Company Filter"; Rec."Company Filter")
            {
                ApplicationArea = All;
            }
            field("User Name"; Rec."User Name")
            {
                ApplicationArea = All;
            }

            field("Assigned PO No."; Rec."Assigned PO No.")
            {
                ApplicationArea = All;
            }
            field("Request Approval"; Rec."Request Approval")
            {
                ApplicationArea = All;
            }

        }

    }





}
