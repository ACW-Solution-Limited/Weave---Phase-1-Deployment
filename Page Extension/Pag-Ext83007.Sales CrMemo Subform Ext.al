pageextension 83007 "Sales Cr. Memo Subform Ext" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Invoice Description"; Rec."Invoice Description")
            { ApplicationArea = All; }
        }
    }
}
