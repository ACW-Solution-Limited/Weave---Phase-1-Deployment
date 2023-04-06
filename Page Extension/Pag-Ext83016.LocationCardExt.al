pageextension 83016 LocationCardExt extends "Location Card"
{
    layout
    {

        addafter("Use As In-Transit")
        {
            field("Company Name"; Rec."Company Name") { ApplicationArea = all; }
        }
    }
}
