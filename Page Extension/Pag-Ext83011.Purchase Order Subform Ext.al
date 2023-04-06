pageextension 83011 PurchaseOrderSubformExt extends "Purchase Order Subform"
{

    layout
    {
        modify("Deferral Code") { Visible = true; }
        addbefore("Deferral Code") { field("Deferral Start Date"; Rec."Deferral Start Date") { ApplicationArea = all; } }


        addlast(Control1)
        {
            field("Expense Type"; rec."Expense Type")
            {
                ApplicationArea = All;
            }
            field("Expense IC Partner"; rec."Expense IC Partner")
            {
                ApplicationArea = All;
            }

        }
    }
}
