pageextension 83030 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Product Type Code"; Rec."Product Type Code") { ApplicationArea = all; }
            field("Available On Booking Site"; Rec."Available On Booking Site") { ApplicationArea = all; }
            field("Subscription/Immediate"; Rec."Subscription/Immediate") { ApplicationArea = all; }
            field("Subscription Period Type"; Rec."Subscription Period Type") { ApplicationArea = all; }
            field("Subscription Period"; Rec."Subscription Period") { ApplicationArea = all; }


        }

    }
}
