pageextension 83009 "Sales Invoice Ext" extends "Sales Invoice"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Lease Contract No."; Rec."Lease Contract No.")
            { ApplicationArea = All; }
            field("Lease Contract Name"; Rec."Lease Contract Name")
            { ApplicationArea = All; }
            field("Lease Contract Creation Date"; Rec."Lease Contract Creation Date")
            { ApplicationArea = All; }
        }
        addafter("Salesperson Code")
        {
            field("Commission Type"; Rec."Commission Type")
            { ApplicationArea = All; Visible = false; }
            field("Calculation Type"; Rec."Calculation Type")
            { ApplicationArea = All; Visible = false; }
            field("Commission Amount"; Rec."Commission Amount")
            { ApplicationArea = All; Visible = false; }
        }

    }
    actions
    {
        modify(Post)
        {
            trigger OnAfterAction()
            begin
                //  Rec.DoPrintToDocumentAttachmentwhenPost();
            end;
        }
    }

}

