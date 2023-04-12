page 83216 "API Stripe Payment"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiStripePayment';
    DelayedInsert = true;
    EntityName = 'stripepayment';
    EntitySetName = 'stripepayment';
    PageType = API;
    SourceTable = "Stripe Payment";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.Id)
                {
                    Caption = 'Id';
                }
                field(stripeStatus; Rec."Stripe Status")
                {
                    Caption = 'Stripe Status';
                }
                field(availableOn; Rec."Available On")
                {
                    Caption = 'Available On';
                }
                field(created; Rec.Created)
                {
                    Caption = 'Created';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(exchangeRate; Rec."Exchange Rate")
                {
                    Caption = 'Exchange Rate';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(salesDocumentType; Rec."Sales Document Type")
                {
                    Caption = 'Sales Document Type';
                }
                field(salesDocumentNo; Rec."Sales Document No.")
                {
                    Caption = 'Sales Document No.';
                }
                field(stripeInvoiceId; Rec."Stripe Invoice ID")
                {
                    Caption = 'Stripe Invoice Id';
                }
                field(netAmount; Rec."Net Amount")
                {
                    Caption = 'Net Amount';
                }
                field(stripeFeeAmount; Rec."Stripe Fee Amount")
                {
                    Caption = 'Stripe Fee Amount';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(paymentIntent; Rec."Payment Intent")
                {
                    Caption = 'Payment Intent';
                }
                field(chargeId; Rec."Charge Id")
                {
                    Caption = 'Charge Id';
                }
                field(tenderType; Rec."Tender Type")
                {
                    Caption = 'Tender Type';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
