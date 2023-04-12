page 83217 "API Extra Charge"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiExtraCharge';
    DelayedInsert = true;
    EntityName = 'extracharge';
    EntitySetName = 'extracharge';
    PageType = API;
    SourceTable = "Extra Charge";

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
                field(contractNo; Rec."Contract No.")
                {
                    Caption = 'Contract No.';
                }
                field(itemType; Rec."Item Type")
                {
                    Caption = 'Item Type';
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
                field(contactNo; Rec."Contact No.")
                {
                    Caption = 'Contact No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(price; Rec.Price)
                {
                    Caption = 'Price';
                }
                field(serviceStartDate; Rec."Service Start Date")
                {
                    Caption = 'Service Start Date';
                }
                field(serviceEndDate; Rec."Service End Date")
                {
                    Caption = 'Service End Date';
                }
                field(totalAmount; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                }
                field(totalAmountIncluVAT; Rec."Total Amount Inclu. VAT")
                {
                    Caption = 'Total Amount Inclu. VAT';
                }
                field(createdOn; Rec."Created On")
                {
                    Caption = 'Created On';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(bcStatus; Rec."BC Status")
                {
                    Caption = 'BC Status';
                }
                field(paymentStatus; Rec."Payment Status")
                {
                    Caption = 'Payment Status';
                }
                field(stripeInvoiceID; Rec."Stripe Invoice ID")
                {
                    Caption = 'Stripe Invoice ID';
                }
                field(paymentLink; Rec."Payment Link")
                {
                    Caption = 'Payment Link';
                }
                field(postedSalesInvoiceGuid; Rec."Posted Sales Invoice Guid")
                {
                    Caption = 'Posted Sales Invoice Guid';
                }
                field(postedSalesInvoiceNo; Rec."Posted Sales Invoice No.")
                {
                    Caption = 'Posted Sales Invoice No.';
                }
                field(chargesType; Rec."Charges Type")
                {
                    Caption = 'Charges Type';
                }
                field(newContractStartDate; Rec."New Contract Start Date")
                {
                    Caption = 'New Contract Start Date';
                }
                field(newContractEndDate; Rec."New Contract End Date")
                {
                    Caption = 'New Contract End Date';
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
