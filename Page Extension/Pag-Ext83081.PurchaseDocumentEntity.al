pageextension 83081 "Purchase Document Entity" extends "Purchase Document Entity"
{
    layout
    {
        addlast(content)
        {

            field("Company Filter"; Rec."Company Filter")
            {
                ApplicationArea = All;
                Caption = 'Companyfilter', Locked = true;
            }
            field("User Name"; Rec."User Name")
            {
                ApplicationArea = All;
                Caption = 'Username', Locked = true;
            }

            field("Assigned PO No."; Rec."Assigned PO No.")
            {
                ApplicationArea = All;
                Caption = 'AssignedPoNo', Locked = true;
            }

            field("Request Approval"; Rec."Request Approval")
            {
                ApplicationArea = All;
                Caption = 'Request Approval', Locked = true;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
                Caption = 'Type', Locked = true;
            }
            field(Subtype; Rec.Subtype)
            {
                ApplicationArea = All;
                Caption = 'Subtype', Locked = true;
            }

        }

    }

}
