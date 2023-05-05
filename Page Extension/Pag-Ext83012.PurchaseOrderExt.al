pageextension 83012 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Due Date")
        {

            field(type; rec.Type)
            { ApplicationArea = All; }

            field(SubType; rec.SubType)
            { ApplicationArea = All; }

        }
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
        modify(Control1900383207)
        {
            Visible = true;
        }


    }

}
