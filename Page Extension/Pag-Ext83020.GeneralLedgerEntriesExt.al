pageextension 83020 "General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        modify("VAT Amount") { Visible = true; }
        modify("Source Code") { Visible = true; }
        modify("Source Type") { Visible = true; }
        modify("Source No.") { Visible = true; }
        // modify("VAT Bus. Posting Group") { Visible = true; }
        // modify("VAT Prod. Posting Group") { Visible = true; }



        addafter("Source No.")
        {

            // field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group") { ApplicationArea = all; }
            //field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group") { ApplicationArea = all; }
            field("Customer Name"; g_txtCustomerName) { ApplicationArea = all; Editable = false; }

        }

        addafter(Description)
        {
            field("Invoice Description"; Rec."Invoice Description") { ApplicationArea = all; Editable = false; }
        }

    }

    trigger OnAfterGetRecord()
    begin
        if g_recCustomer.Get(Rec."Source No.") then
            g_txtCustomerName := g_recCustomer.Name
        else
            g_txtCustomerName := '';
    end;

    var
        g_txtCustomerName: Text;
        g_recCustomer: Record Customer;

}
