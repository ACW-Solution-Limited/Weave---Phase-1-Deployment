page 83136 CRMPostedSalesCreditMemo
{
    ApplicationArea = All;
    Caption = 'CRMPostedSalesCreditMemo';
    PageType = List;
    SourceTable = "CDS acwapp_postedsalescreditmemo";
    UsageCategory = Lists;

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
                field(OrganizationId; Rec.OrganizationId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Organization Id field.';
                }
                field(OverriddenCreatedOn; Rec.OverriddenCreatedOn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Record Created On field.';
                }
                // field(SystemCreatedAt; Rec.SystemCreatedAt)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                // }
                // field(SystemCreatedBy; Rec.SystemCreatedBy)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                // }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                // field(SystemModifiedAt; Rec.SystemModifiedAt)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                // }
                // field(SystemModifiedBy; Rec.SystemModifiedBy)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                // }
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
                field(acwapp_AmountExcludingVAT; Rec.acwapp_AmountExcludingVAT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Excluding VAT field.';
                }
                field(acwapp_AmountIncludingVAT; Rec.acwapp_AmountIncludingVAT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }
                field(acwapp_BlobURL; Rec.acwapp_BlobURL)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blob URL field.';
                }
                field(acwapp_Company; Rec.acwapp_Company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company field.';
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
                field(acwapp_SalesCreditMemoNo; Rec.acwapp_SalesCreditMemoNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Credit Memo No. field.';
                }
                field(acwapp_TerminationDate; Rec.acwapp_TerminationDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Termination Date field.';
                }
                field(acwapp_amountexcludingvat_Base; Rec.acwapp_amountexcludingvat_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Excluding VAT (Base) field.';
                }
                field(acwapp_amountincludingvat_Base; Rec.acwapp_amountincludingvat_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT (Base) field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(acwapp_postedsalescreditmemoId; Rec.acwapp_postedsalescreditmemoId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Credit Memo field.';
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
        CurrentlyCoupledCRMPostedSalesCreditMemo: Record "CDS acwapp_postedsalescreditmemo";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMPostedSalesCreditMemo(CRMPostedSalesCreditMemo: Record "CDS acwapp_postedsalescreditmemo")
    begin
        CurrentlyCoupledCRMPostedSalesCreditMemo := CRMPostedSalesCreditMemo;
    end;
}
