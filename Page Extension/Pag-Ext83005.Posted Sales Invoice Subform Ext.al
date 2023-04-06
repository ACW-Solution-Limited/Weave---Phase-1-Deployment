pageextension 83005 "Posted Sales InvoiceSubformExt" extends "Posted Sales Invoice Subform"
{
    layout
    {

        addafter(Description)
        {
            field("Invoice Description"; Rec."Invoice Description")
            { ApplicationArea = All; }

        }
        addafter("Line Amount")
        {

            field("Amount Including VAT"; Rec."Amount Including VAT") { ApplicationArea = all; }

        }
        addlast(content)
        {


            field("Sales Invoice Guid for CRM"; Rec."Sales Invoice Guid for CRM") { ApplicationArea = all; }
        }


    }
}