pageextension 83002 PostedPurchInvSubform extends "Posted Purch. Invoice Subform"
{
    layout
    {
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
