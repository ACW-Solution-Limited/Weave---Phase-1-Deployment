pageextension 83012 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {

        addafter(Status)
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
            field("Sync to Companies"; Rec."Sync to Companies")
            {
                ApplicationArea = All;
            }


        }

    }


}
