pageextension 83015 LocationListExt extends "Location List"
{
    layout
    {
        addlast(Control1)
        {
            field("Company Name"; Rec."Company Name") { ApplicationArea = all; }
            field("Country/Region Code"; Rec."Country/Region Code") { ApplicationArea = all; }
        }
    }
}
