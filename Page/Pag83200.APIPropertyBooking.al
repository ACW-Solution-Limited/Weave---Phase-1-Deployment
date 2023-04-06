page 83200 "API Property Booking"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiPropertyBooking';
    DelayedInsert = true;
    EntityName = 'leasecontractheader';
    EntitySetName = 'leasecontractheader';
    PageType = API;
    SourceTable = "Lease Contract Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(stPaymentStripeInvoiceID; Rec."1st Pymt. Stripe/QFPay Inv. ID")
                {
                    Caption = '1st Payment Stripe Invoice ID';
                }
                field(automaticallyExtend; Rec."Automatically Extend")
                {
                    Caption = 'Automatically Extend';
                }
                field(billingScheduleCreated; Rec."Billing Schedule Created")
                {
                    Caption = 'Billing Scheduled Created';
                }
                field(commissionType; Rec."Commission Type")
                {
                    Caption = 'Comission Type';
                }
                field(companyName; Rec."Company Name")
                {
                    Caption = 'Company Name';
                }
                field(companyId; Rec.CompanyId)
                {
                    Caption = 'Company ID';
                }
                field(contractEndDate; Rec."Contract End Date")
                {
                    Caption = 'Contract End Date';
                }
                field(contractName; Rec."Contract Name")
                {
                    Caption = 'Contract Name';
                }
                field(contractStartDate; Rec."Contract Start Date")
                {
                    Caption = 'Contract Start Date';
                }
                field(contractTerminationDate; Rec."Contract Termination Date")
                {
                    Caption = 'Contract Termination Date';
                }
                field(customerAddress; Rec."Customer Address")
                {
                    Caption = 'Customer Address';
                }
                field(customerAddress2; Rec."Customer Address 2")
                {
                    Caption = 'Customer Address 2';
                }
                field(customerCity; Rec."Customer City")
                {
                    Caption = 'Customer City';
                }
                field(customerCountryRegionCode; Rec."Customer Country/Region Code")
                {
                    Caption = 'Customer Country/Region Code';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(customerPostCode; Rec."Customer Post Code")
                {
                    Caption = 'Customer Post Code';
                }
                field(dailyRent; Rec."Daily Rent")
                {
                    Caption = 'Daily Rent';
                }
                field(depositAmount; Rec."Deposit Amount")
                {
                    Caption = 'Deposit Amount';
                }
                field(depositReturned; Rec."Deposit Returned")
                {
                    Caption = 'Deposit Returned';
                }
                field(finalAmount; Rec."Final Amount")
                {
                    Caption = 'Final Amount';
                }
                field("key"; Rec."Key")
                {
                    Caption = 'Key';
                }
                field(monthlyDiscount; Rec."Monthly Discount")
                {
                    Caption = 'Monthly Discount';
                }
                field(monthlyRent; Rec."Monthly Rent")
                {
                    Caption = 'Monthly Rent';
                }
                field(netAmount; Rec."Net Amount")
                {
                    Caption = 'Net Amount';
                }
                field(netAmountIncludeVAT; Rec."Net Amount include VAT")
                {
                    Caption = 'Net Amount include VAT';
                }
                field(newContractEndDate; Rec."New Contract End Date")
                {
                    Caption = 'New Contract End Date';
                }
                field(newContractStartDate; Rec."New Contract Start Date")
                {
                    Caption = 'New Contract Start Date';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(noOfExtraCharge; Rec."No. of Extra Charge")
                {
                    Caption = 'No. of Extra Charge';
                }
                field(oneOffDiscount; Rec."One off Discount")
                {
                    Caption = 'One off Discount';
                }
                field(paymentAmount; Rec."Payment Amount")
                {
                    Caption = 'Payment Amount';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(paymentType; Rec."Payment Type")
                {
                    Caption = 'Payment Type';
                }
                field(prepaidAmount; Rec."Prepaid Amount")
                {
                    Caption = 'Prepaid Amount';
                }
                field(prepaidDiscount; Rec."Prepaid Discount")
                {
                    Caption = 'Prepaid Discount';
                }
                field(price; Rec.Price)
                {
                    Caption = 'Price';
                }
                field(promotionAmount; Rec."Promotion Amount / %")
                {
                    Caption = 'Promotion Amount / %';
                }
                field(promotionCRMGuid; Rec."Promotion CRMGuid")
                {
                    Caption = 'Promotion CRMGuid';
                }
                field(promotionCode; Rec."Promotion Code")
                {
                    Caption = 'Promotion Code';
                }
                field(promotionCodeType; Rec."Promotion Code type")
                {
                    Caption = 'Promotion Code type';
                }
                field(promotionDeductionType; Rec."Promotion Deduction Type")
                {
                    Caption = 'Promotion Deduction Type';
                }
                field(propertyCRMGuid; Rec."Property CRMGuid")
                {
                    Caption = 'Property CRMGuid';
                }
                field(propertyName; Rec."Property Name")
                {
                    Caption = 'Property Name';
                }
                field(propertyNo; Rec."Property No.")
                {
                    Caption = 'Property No.';
                }
                field(propertyUnit; Rec."Property Unit")
                {
                    Caption = 'Property Unit';
                }
                field(propertyUnitName; Rec."Property Unit Name")
                {
                    Caption = 'Property Unit Name';
                }
                field(roomName; Rec."Room Name")
                {
                    Caption = 'Room Name';
                }
                field(roomNo; Rec."Room No.")
                {
                    Caption = 'Room No.';
                }
                field(roomType; Rec."Room Type")
                {
                    Caption = 'Room Type';
                }
                field(runTerminatedBillingSched; Rec."Run Terminated Billing Sched.")
                {
                    Caption = 'Run Terminated Billing Sched.';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(salespersonEmail; Rec."Salesperson Email")
                {
                    Caption = 'Salesperson Email';
                }
                field(salespersonName; Rec."Salesperson Name")
                {
                    Caption = 'Salesperson Name';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
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
                field(tenderTypeDiscountAmount; Rec."Tender Type Discount Amount")
                {
                    Caption = 'Tender Type Discount Amount';
                }
            }
        }
    }
}
