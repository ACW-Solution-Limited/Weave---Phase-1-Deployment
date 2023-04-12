page 83201 APIBillingSchedule
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiBillingSchedule';
    DelayedInsert = true;
    EntityName = 'leasecontractbillingsched';
    EntitySetName = 'leasecontractbillingsched';
    PageType = API;
    SourceTable = "Lease Contract Billing Sched.";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(addSalesItemUnitPrice; Rec."Add. Sales Item Unit Price")
                {
                    Caption = 'Additional Sales Item Unit Price';
                }
                field(additionalItemSalesDate; Rec."Additional Item Sales Date")
                {
                    Caption = 'Additional Item Sales Date';
                }
                field(additionalSalesItemNo; Rec."Additional Sales Item No.")
                {
                    Caption = 'Additional Sales Item No.';
                }
                field(additionalSalesItemQuantity; Rec."Additional Sales Item Quantity")
                {
                    Caption = 'Additional Sales Item Quantity';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount Excluding VAT';
                }
                field(contractEndDate; Rec."Contract End Date")
                {
                    Caption = 'Contract End Date';
                }
                field(contractLineNo; Rec."Contract Line No.")
                {
                    Caption = 'Contract Line No.';
                }
                field(contractNo; Rec."Contract No.")
                {
                    Caption = 'Contract No.';
                }
                field(contractStartDate; Rec."Contract Start Date")
                {
                    Caption = 'Contract Start Date';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(finalAmount; Rec."Final Amount")
                {
                    Caption = 'Final Amount';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(noOfDaysCurrentMonth; Rec."No. of Days Current Month")
                {
                    Caption = 'No. of Days Current Month';
                }
                field(noOfDaysToBill; Rec."No. of Days to Bill")
                {
                    Caption = 'No. of Days to Bill';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }

                field(salesInvoiceCreationDate; Rec."Sales Invoice Creation Date")
                {
                    Caption = 'Sales Invoice Creation Date';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(stripeQFPayInvoiceID; Rec."Stripe Invoice ID")
                {
                    Caption = 'Stripe Invoice ID';
                }
                field(stripeQFPay; Rec."External Payment Gateway")
                {
                    Caption = 'Stripe/QFPay';
                }
                field(subType; Rec."Sub-Type")
                {
                    Caption = 'Sub-Type';
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
                field(tenderType; Rec."Tender Type")
                {
                    Caption = 'Tender Type';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
            }
        }
    }
}
