pageextension 83013 "Purchase Order List Ext" extends "Purchase Order List"
{
    layout
    {
        addlast(Control1)
        {

            field("Company Filter"; Rec."Company Filter")
            {
                ApplicationArea = All;
            }
            field("User Name"; Rec."User Name")
            {
                ApplicationArea = All;
            }

            field("Assigned PO No."; Rec."Assigned PO No.")
            {
                ApplicationArea = All;
            }
            field("Request Approval"; Rec."Request Approval")
            {
                ApplicationArea = All;
            }

        }

    }

    actions
    {
        addlast(processing)
        {

            action("Testing")
            {
                ApplicationArea = All;
                image = NewStatusChange;
                Promoted = true;
                PromotedCategory = Category7;
                trigger OnAction()
                var
                    l_cduapprovalEntries: Codeunit "Approval Entries";
                begin
                    l_cduapprovalEntries.Run();
                end;
            }

        }


    }



}
