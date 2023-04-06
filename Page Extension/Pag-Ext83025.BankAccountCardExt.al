pageextension 83025 "Bank Account Card Ext" extends "Bank Account Card"
{
    layout
    {
        addbefore("Bank Branch No.")
        {

            field("Bank Code"; Rec."Bank Code")
            {
                ApplicationArea = All;
            }

        }

    }
}
