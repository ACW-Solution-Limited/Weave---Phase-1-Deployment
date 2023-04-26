pageextension 83010 SalesInvoiceFubformExt extends "Sales Invoice Subform"
{
    layout
    {
        modify("Deferral Code")
        {
            Visible = true;
        }

        addafter(Description)
        {
            field("Invoice Description"; Rec."Invoice Description")
            { ApplicationArea = All; }


        }



        addafter(Quantity)
        {
            field("Qty. to Assemble to Order"; rec."Qty. to Assemble to Order")
            {
                ApplicationArea = All;
                //FieldPropertyName = FieldPropertyValue;
            }

        }
    }
}
