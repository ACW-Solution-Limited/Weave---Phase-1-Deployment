page 83137 CRMPostedSalesCreditMemoLine
{

    Caption = 'CRMPostedSalesCreditMemoLine';
    PageType = List;
    SourceTable = "CDS acwapp_postedsalescmLine";
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
                field(acwapp_Company; Rec.acwapp_Company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company field.';
                }
                field(acwapp_CompanyName; Rec.acwapp_CompanyName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_CompanyName field.';
                }
                field(acwapp_GST; Rec.acwapp_GST)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST% field.';
                }
                field(acwapp_InvoiceDescription; Rec.acwapp_InvoiceDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Description field.';
                }
                field(acwapp_InvoiceNo; Rec.acwapp_InvoiceNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field(acwapp_LineNo; Rec.acwapp_LineNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(acwapp_PostedSalesCreditMemo; Rec.acwapp_PostedSalesCreditMemo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Credit Memo field.';
                }
                field(acwapp_PostedSalesCreditMemoName; Rec.acwapp_PostedSalesCreditMemoName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_PostedSalesCreditMemoName field.';
                }
                field(acwapp_Quantity; Rec.acwapp_Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(acwapp_TotalAmountExcludeVAT; Rec.acwapp_TotalAmountExcludeVAT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Exclude VAT field.';
                }
                field(acwapp_TotalAmountIncludeVAT; Rec.acwapp_TotalAmountIncludeVAT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Include VAT field.';
                }
                field(acwapp_Type; Rec.acwapp_Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(acwapp_UnitPriceExcludeVAT; Rec.acwapp_UnitPriceExcludeVAT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price Exclude VAT field.';
                }
                field(acwapp_UnitPriceIncludeVAT; Rec.acwapp_UnitPriceIncludeVAT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price Include VAT field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(acwapp_postedsalescreditmemolineId; Rec.acwapp_postedsalescreditmemolineId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Credit Memo Line field.';
                }
                field(acwapp_totalamountexcludevat_Base; Rec.acwapp_totalamountexcludevat_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Exclude VAT (Base) field.';
                }
                field(acwapp_totalamountincludevat_Base; Rec.acwapp_totalamountincludevat_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Include VAT (Base) field.';
                }
                field(acwapp_unitpriceexcludevat_Base; Rec.acwapp_unitpriceexcludevat_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price Exclude VAT (Base) field.';
                }
                field(acwapp_unitpriceincludevat_Base; Rec.acwapp_unitpriceincludevat_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price Include VAT (Base) field.';
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
        CurrentlyCoupledCRMPostedSalesCreditMemoLine: Record "CDS acwapp_postedsalescmLine";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMPostedSalesCreditMemoLine(CRMPostedSalesCreditMemoLine: Record "CDS acwapp_postedsalescmLine")
    begin
        CurrentlyCoupledCRMPostedSalesCreditMemoLine := CRMPostedSalesCreditMemoLine;
    end;
}
