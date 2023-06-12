page 83145 "CRM Billing Schedule"
{
    ApplicationArea = All;
    Caption = 'CRM Billing Schedule';
    PageType = List;
    SourceTable = "CDS acwapp_billingschedule";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_billingscheduleId; Rec.acwapp_billingscheduleId)
                {
                    ToolTip = 'Specifies the value of the Billing Schedule field.';
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ToolTip = 'Specifies the value of the Created On field.';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ToolTip = 'Specifies the value of the Modified On field.';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'Specifies the value of the Modified By field.';
                }
                field(CreatedOnBehalfBy; Rec.CreatedOnBehalfBy)
                {
                    ToolTip = 'Specifies the value of the Created By (Delegate) field.';
                }
                field(ModifiedOnBehalfBy; Rec.ModifiedOnBehalfBy)
                {
                    ToolTip = 'Specifies the value of the Modified By (Delegate) field.';
                }
                field(OwnerId; Rec.OwnerId)
                {
                    ToolTip = 'Specifies the value of the Owner field.';
                }
                field(OwningBusinessUnit; Rec.OwningBusinessUnit)
                {
                    ToolTip = 'Specifies the value of the Owning Business Unit field.';
                }
                field(OwningUser; Rec.OwningUser)
                {
                    ToolTip = 'Specifies the value of the Owning User field.';
                }
                field(OwningTeam; Rec.OwningTeam)
                {
                    ToolTip = 'Specifies the value of the Owning Team field.';
                }
                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the Status Reason field.';
                }
                field(VersionNumber; Rec.VersionNumber)
                {
                    ToolTip = 'Specifies the value of the Version Number field.';
                }
                field(ImportSequenceNumber; Rec.ImportSequenceNumber)
                {
                    ToolTip = 'Specifies the value of the Import Sequence Number field.';
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                    ToolTip = 'Specifies the value of the Record Created On field.';
                }
                field(TimeZoneRuleVersionNumber; Rec.TimeZoneRuleVersionNumber)
                {
                    ToolTip = 'Specifies the value of the Time Zone Rule Version Number field.';
                }
                field(UTCConversionTimeZoneCode; Rec.UTCConversionTimeZoneCode)
                {
                    ToolTip = 'Specifies the value of the UTC Conversion Time Zone Code field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(acwapp_PostingDate; Rec.acwapp_PostingDate)
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(acwapp_DueDate; Rec.acwapp_DueDate)
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field(acwapp_ContractStartDate; Rec.acwapp_ContractStartDate)
                {
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                }
                field(acwapp_ContractEndDate; Rec.acwapp_ContractEndDate)
                {
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field(acwapp_AmountExcludingVAT; Rec.acwapp_AmountExcludingVAT)
                {
                    ToolTip = 'Specifies the value of the Amount Excluding VAT field.';
                }
                field(TransactionCurrencyId; Rec.TransactionCurrencyId)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(acwapp_amountexcludingvat_Base; Rec.acwapp_amountexcludingvat_Base)
                {
                    ToolTip = 'Specifies the value of the Amount Excluding VAT (Base) field.';
                }
                field(acwapp_NoofDaystoBill; Rec.acwapp_NoofDaystoBill)
                {
                    ToolTip = 'Specifies the value of the No. of Days to Bill field.';
                }
                field(acwapp_NoofDaysCurrentMonth; Rec.acwapp_NoofDaysCurrentMonth)
                {
                    ToolTip = 'Specifies the value of the No. of Days Current Month field.';
                }
                field(acwapp_AdditionalItemSalesDate; Rec.acwapp_AdditionalItemSalesDate)
                {
                    ToolTip = 'Specifies the value of the Additional Item Sales Date field.';
                }
                field(acwapp_AdditionalSalesItemNo; Rec.acwapp_AdditionalSalesItemNo)
                {
                    ToolTip = 'Specifies the value of the Additional Sales Item No. field.';
                }
                field(acwapp_AdditionalSalesItemQuantity; Rec.acwapp_AdditionalSalesItemQuantity)
                {
                    ToolTip = 'Specifies the value of the Additional Sales Item Quantity field.';
                }
                field(acwapp_AdditionalSalesItemUnitPrice; Rec.acwapp_AdditionalSalesItemUnitPrice)
                {
                    ToolTip = 'Specifies the value of the Additional Sales Item Unit Price field.';
                }
                field(acwapp_additionalsalesitemunitprice_Base; Rec.acwapp_additionalsalesitemunitprice_Base)
                {
                    ToolTip = 'Specifies the value of the Additional Sales Item Unit Price (Base) field.';
                }
                field(acwapp_DocumentNo; Rec.acwapp_DocumentNo)
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field(acwapp_SalesInvoiceCreationDate; Rec.acwapp_SalesInvoiceCreationDate)
                {
                    ToolTip = 'Specifies the value of the Sales Invoice Creation Date field.';
                }
                field(acwapp_ContractNo; Rec.acwapp_ContractNo)
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field(acwapp_ContractLineNo; Rec.acwapp_ContractLineNo)
                {
                    ToolTip = 'Specifies the value of the Contract Line No. field.';
                }
                field(acwapp_ExternalPaymentGateway; Rec.acwapp_ExternalPaymentGateway)
                {
                    ToolTip = 'Specifies the value of the External Payment Gateway field.';
                }
                field(acwapp_StripeQFPayInvoiceID; Rec.acwapp_StripeQFPayInvoiceID)
                {
                    ToolTip = 'Specifies the value of the Stripe/QFPay Invoice ID field.';
                }
                field(acwapp_Type; Rec.acwapp_Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(acwapp_SubType; Rec.acwapp_SubType)
                {
                    ToolTip = 'Specifies the value of the Sub-Type field.';
                }
                field(acwapp_DocumentType; Rec.acwapp_DocumentType)
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(acwapp_Status; Rec.acwapp_Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(acwapp_ID; Rec.acwapp_ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
            }
        }
    }
    var
        CurrentlyCoupledBillingSchedule: Record "CDS acwapp_billingschedule";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMBillingSchedule(CRMBillingSchedule: Record "CDS acwapp_billingschedule")
    begin
        CurrentlyCoupledBillingSchedule := CRMBillingSchedule;
    end;
}
