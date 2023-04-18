pageextension 83020 "General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        modify("VAT Amount") { Visible = true; }
        modify("Source Code") { Visible = true; }
        modify("Source Type") { Visible = true; }
        modify("Source No.") { Visible = true; }

        addafter("VAT Amount")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group") { ApplicationArea = all; }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group") { ApplicationArea = all; }

        }

    }

}
