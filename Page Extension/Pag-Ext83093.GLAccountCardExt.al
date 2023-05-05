pageextension 83093 "G/L Account Card Ext" extends "G/L Account Card"
{
    layout
    {

        addafter("Omit Default Descr. in Jnl.")
        {
            field("PowerApp PO"; Rec."PowerApp PO")
            {
                ApplicationArea = All;
            }
        }
    }
}
