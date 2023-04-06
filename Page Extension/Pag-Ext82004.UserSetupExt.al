pageextension 82004 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addbefore("Allow Posting To")
        {
            field("Generic User"; Rec."Generic User")
            {
                ApplicationArea = Basic, Suite;
            }

        }
    }

}
