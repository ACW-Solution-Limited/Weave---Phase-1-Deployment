pageextension 83020 "General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        modify("VAT Amount") { Visible = true; }
        modify("Source Code") { Visible = true; }
        modify("Source Type") { Visible = true; }
        modify("Source No.") { Visible = true; }

        //BC Version 22.0 >>
        modify("VAT Bus. Posting Group") { Visible = true; }
        modify("VAT Prod. Posting Group") { Visible = true; }
        //BC Version 22.0 <<

        addafter("Source No.")
        {
            //BC Version 21.0 >>
            //field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group") { ApplicationArea = all; Editable = false; }
            //field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group") { ApplicationArea = all; Editable = false; }
            //BC Version 21.0 <<
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
