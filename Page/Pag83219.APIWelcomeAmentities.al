page 83219 "API Welcome Amentities"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiWelcomeAmentities';
    DelayedInsert = true;
    EntityName = 'welcomeamentities';
    EntitySetName = 'welcomeamentities';
    PageType = API;
    SourceTable = "Welcome Amenities";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("key"; Rec."Key")
                {
                    Caption = 'Key';
                }
                field(companyID; Rec.CompanyID)
                {
                    Caption = 'CompanyID';
                }
                field(contractNo; Rec."Contract No.")
                {
                    Caption = 'Contract No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(itemDescription; Rec."Item Description")
                {
                    Caption = 'Item Description';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer No.';
                }
                field(price; Rec.Price)
                {
                    Caption = 'Price';
                }
                field(totalAmountIncluVAT; Rec."Total Amount Inclu. VAT")
                {
                    Caption = 'Total Amount Inclu. VAT';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(totalAmount; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'End Date';
                }
                field(paymentStatus; Rec."Payment Status")
                {
                    Caption = 'Payment Status';
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
                field(createdOn; Rec."Created On")
                {
                    Caption = 'Created On';
                }
                field(paymentLink; Rec."Payment Link")
                {
                    Caption = 'Payment Link';
                }
                field(priceIncluVAT; Rec."Price Inclu. VAT")
                {
                    Caption = 'Price Amount Inclu. VAT';
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
