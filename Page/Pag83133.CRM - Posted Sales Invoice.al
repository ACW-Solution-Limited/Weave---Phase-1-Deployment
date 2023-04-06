page 83133 "CRM Posted Sales Invoice"
{

    Caption = 'CRM Posted Sales Invoice';
    PageType = List;
    SourceTable = "CDS acwapp_salesinvoice";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(CreatedBy; Rec.CreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created On field.';
                }
                field(CreatedOnBehalfBy; Rec.CreatedOnBehalfBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By (Delegate) field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(ImportSequenceNumber; Rec.ImportSequenceNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Import Sequence Number field.';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified By field.';
                }
                field(ModifiedOn; Rec.ModifiedOn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified On field.';
                }
                field(ModifiedOnBehalfBy; Rec.ModifiedOnBehalfBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified By (Delegate) field.';
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Record Created On field.';
                }
                field(OwnerId; Rec.OwnerId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Owner field.';
                }
                field(OwningBusinessUnit; Rec.OwningBusinessUnit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Owning Business Unit field.';
                }
                field(OwningTeam; Rec.OwningTeam)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Owning Team field.';
                }
                field(OwningUser; Rec.OwningUser)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Owning User field.';
                }

                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }

                field(TimeZoneRuleVersionNumber; Rec.TimeZoneRuleVersionNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Zone Rule Version Number field.';
                }
                field(TransactionCurrencyId; Rec.TransactionCurrencyId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(UTCConversionTimeZoneCode; Rec.UTCConversionTimeZoneCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UTC Conversion Time Zone Code field.';
                }
                field(VersionNumber; Rec.VersionNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Version Number field.';
                }
                field(acwapp_Amount; Rec.acwapp_Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(acwapp_AmountExcludingVAT; Rec.acwapp_AmountExcludingVAT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Excluding VAT field.';
                }
                field(acwapp_BlobURL; Rec.acwapp_BlobURL)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blob URL field.';
                }
                field(acwapp_ContractEndDate; Rec.acwapp_ContractEndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field(acwapp_ContractNo; Rec.acwapp_ContractNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field(acwapp_ContractStartDate; Rec.acwapp_ContractStartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                }
                field(acwapp_Customer; Rec.acwapp_Customer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer field.';
                }
                field(acwapp_CustomerID; Rec.acwapp_CustomerID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer ID field.';
                }
                field(acwapp_DueDate; Rec.acwapp_DueDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field(acwapp_PaymentLink; Rec.acwapp_PaymentLink)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Link field.';
                }
                field(acwapp_PaymentStatus; Rec.acwapp_PaymentStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Status field.';
                }
                field(acwapp_PostedSalesInvoiceURL; Rec.acwapp_PostedSalesInvoiceURL)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Invoice URL field.';
                }
                field(acwapp_PostingDate; Rec.acwapp_PostingDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(acwapp_PropertyBooking; Rec.acwapp_PropertyBooking)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Booking field.';
                }
                field(acwapp_PropertyBookingName; Rec.acwapp_PropertyBookingName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_PropertyBookingName field.';
                }
                field(acwapp_amount_Base; Rec.acwapp_amount_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount (Base) field.';
                }
                field(acwapp_amountexcludingvat_Base; Rec.acwapp_amountexcludingvat_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Excluding VAT (Base) field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Invoice No. field.';
                }
                field(acwapp_salesinvoiceId; Rec.acwapp_salesinvoiceId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Invoice field.';
                }
                field(statecode; Rec.statecode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Reason field.';
                }
            }
        }
    }
    var
        CurrentlyCoupledCRMPostedSalesInvoice: Record "CDS acwapp_salesinvoice";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMPostedSalesInvoice(CRMPostedSalesInvoice: Record "CDS acwapp_salesinvoice")
    begin
        CurrentlyCoupledCRMPostedSalesInvoice := CRMPostedSalesInvoice;
    end;
}
