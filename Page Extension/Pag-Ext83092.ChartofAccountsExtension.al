pageextension 83092 "Chart of Accounts Extension" extends "Chart of Accounts"
{
    layout
    {

        addlast(Control1)
        {

            field("PowerApp PO"; Rec."PowerApp PO")
            {
                ApplicationArea = All;
            }
        }
    }
}
