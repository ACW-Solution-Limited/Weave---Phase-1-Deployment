pageextension 83003 "Posted Sales Invoices Ext" extends "Posted Sales Invoices"
{
    layout
    {

        addafter(Closed) { field("Payment Status"; Rec."Payment Status") { ApplicationArea = all; } }

        addafter(Corrective)
        {
            field("Stripe Payment Link"; Rec."Stripe Payment Link") { ApplicationArea = all; }
            field("Stripe Customer ID"; Rec."Stripe Customer ID") { ApplicationArea = all; }
            field("Stripe Paid"; Rec."Stripe Paid") { ApplicationArea = all; }
            field(BlobURL; Rec.BlobURL) { ApplicationArea = all; }
            field("Stripe Invoice ID"; rec."Stripe Invoice ID") { ApplicationArea = all; }
            field("Lease Contract No."; Rec."Lease Contract No.") { ApplicationArea = all; }
            field("Lease Contract Name"; Rec."Lease Contract Name") { ApplicationArea = all; }
            field("Lease Contract Creation Date"; Rec."Lease Contract Creation Date") { ApplicationArea = all; }
            field("Contract Start Date"; Rec."Contract Start Date") { ApplicationArea = all; }
            field("Contract End Date"; Rec."Contract End Date") { ApplicationArea = all; }
            field("Customer Guid for CRM"; Rec."Customer Guid for CRM") { ApplicationArea = all; }
            field("Company Name"; Rec."Company Name") { ApplicationArea = all; }
            field("Company Guid for CRM"; Rec."Company Guid for CRM") { ApplicationArea = all; }
            field("Property Booking Guid for CRM"; Rec."Property Booking Guid for CRM") { ApplicationArea = all; }


        }
    }

    actions
    {

        addafter(Print)

        {
            action(Blob)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Upload to Blob storage';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category7;

                trigger OnAction()
                begin
                    Rec.DoPrintToDocumentAttachmentBlob();

                end;
            }

        }

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
