pageextension 83001 "IC Partner Card Ext" extends "IC Partner Card"
{
    layout
    {
        addlast(General)
        {
            field("Bank Account"; Rec."Bank Account")
            {
                ApplicationArea = All;

            }
            field("CRM Guid"; Rec."CRM Guid")
            {
                ApplicationArea = All;
            }
        }
    }
}
