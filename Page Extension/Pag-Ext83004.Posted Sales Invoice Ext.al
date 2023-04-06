pageextension 83004 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    layout

    {
        addafter("Sell-to Customer Name")
        {
            field("Lease Contract No."; Rec."Lease Contract No.") { ApplicationArea = All; }

            field("Lease Contract Name"; Rec."Lease Contract Name") { ApplicationArea = All; }

            field("Lease Contract Creation Date"; Rec."Lease Contract Creation Date") { ApplicationArea = All; }

            field(BlobURL; Rec.BlobURL) { ApplicationArea = All; }
        }


        addafter(SelectedPayments)
        {
            field("Stripe Payment Link"; Rec."Stripe Payment Link")
            {
                ApplicationArea = All;
                Trigger OnDrillDown()
                begin
                    System.Hyperlink(Rec."Stripe Payment Link");
                end;

            }

            field("Stripe/QFPay Invoice ID"; Rec."Stripe/QFPay Invoice ID") { ApplicationArea = all; }
            field("Payment Status"; Rec."Payment Status") { ApplicationArea = all; }

        }
        addafter("Salesperson Code")
        {
            field("Commission Type"; Rec."Commission Type")
            { ApplicationArea = All; }
            field("Calculation Type"; Rec."Calculation Type")
            { ApplicationArea = All; }
            field("Commission Amount"; Rec."Commission Amount")
            { ApplicationArea = All; }
        }

    }
    actions
    {
        addlast(processing)
        {
            action("Send to Stripe")
            {
                ApplicationArea = All;
                image = LinkWeb;
                Promoted = true;
                PromotedCategory = category7;
                trigger OnAction()
                begin
                    rec.SendInvoiceToStripe();
                end;
            }

            // Testing 03082023>>

            action(SendToBlob)
            {
                ApplicationArea = All;
                image = NewStatusChange;
                Promoted = true;
                PromotedCategory = Category7;
                trigger OnAction()
                begin
                    rec.MannualSaveToBlob(Rec);
                end;

            }

            // Testing 03082023>>

        }
        addlast("&Invoice")
        {
            action("Stripe Invoice")
            {
                ApplicationArea = All;
                image = ViewOrder;
                Promoted = true;
                PromotedCategory = category4;
                Enabled = rec."Stripe Payment Link" <> '';
                trigger OnAction()
                begin
                    Hyperlink(rec."Stripe Payment Link");
                end;
            }
        }


    }
    trigger OnOpenPage()
    begin
        Rec.SynchronizeNow(False);
    end;

}
