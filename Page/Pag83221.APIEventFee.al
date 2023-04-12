page 83221 "API Event Fee"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiEventFee';
    DelayedInsert = true;
    EntityName = 'eventfee';
    EntitySetName = 'eventfee';
    PageType = API;
    SourceTable = "Event Fee";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(customerCode; Rec."Customer Code")
                {
                    Caption = 'Customer Code';
                }
                field(contactCode; Rec."Contact Code")
                {
                    Caption = 'Contact Code';
                }
                field(currency; Rec.Currency)
                {
                    Caption = 'Currency';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(paymentReferenceID; Rec."Payment Reference ID")
                {
                    Caption = 'Payment Reference ID';
                }
                field(companyGuid; Rec."Company  Guid")
                {
                    Caption = 'Company  Guid';
                }
                field(propertyNo; Rec."Property No.")
                {
                    Caption = 'Property No.';
                }
                field(propertyBookingNo; Rec."Property Booking No.")
                {
                    Caption = 'Property No.';
                }
                field(contractNo; Rec."Contract No.")
                {
                    Caption = 'Property No.';
                }
                field("event"; Rec."Event")
                {
                    Caption = 'Event';
                }
                field(eventSession; Rec."Event Session")
                {
                    Caption = 'Event Session';
                }
                field(eventRegistration; Rec."Event Registration")
                {
                    Caption = 'Event Registration';
                }
                field(bcStatus; Rec."BC Status")
                {
                    Caption = 'BC Status';
                }
                field(stripeInvoiceID; Rec."Stripe Invoice ID")
                {
                    Caption = 'Stripe Invoice ID';
                }
                field(postedSalesInvoiceNo; Rec."Posted Sales Invoice No.")
                {
                    Caption = 'Posted Sales Invoice No.';
                }
                field(billingScheduleLineNo; Rec."Billing Schedule Line No.")
                {
                    Caption = 'Billing Schedule Line No.';
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
