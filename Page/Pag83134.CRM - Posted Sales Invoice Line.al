page 83134 "CRM Posted Sales Invoice Line"
{
    Caption = 'CRM Posted Sales Invoice Line';
    PageType = List;
    SourceTable = "CDS acwapp_postedsalesinvoiceline";
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
                field(acwapp_Description; Rec.acwapp_Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
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
                field(acwapp_InvoiceNoName; Rec.acwapp_InvoiceNoName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_InvoiceNoName field.';
                }
                field(acwapp_LineNo; Rec.acwapp_LineNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(acwapp_Quantity; Rec.acwapp_Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(acwapp_TotalAmount; Rec.acwapp_TotalAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(acwapp_UnitPrice; Rec.acwapp_UnitPrice)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field(acwapp_UnitPriceIncludingVAT; Rec.acwapp_UnitPriceIncludingVAT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price Including VAT field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(acwapp_postedsalesinvoicelineId; Rec.acwapp_postedsalesinvoicelineId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Invoice Line field.';
                }
                field(acwapp_totalamount_Base; Rec.acwapp_totalamount_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount (Base) field.';
                }
                field(acwapp_unitprice_Base; Rec.acwapp_unitprice_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price (Base) field.';
                }
                field(acwapp_unitpriceincludingvat_Base; Rec.acwapp_unitpriceincludingvat_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price Including VAT (Base) field.';
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
        CurrentlyCoupledCRMPostedSalesInvoiceLine: Record "CDS acwapp_postedsalesinvoiceline";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMPostedSalesInvoiceLine(CRMPostedSalesInvoiceLine: Record "CDS acwapp_postedsalesinvoiceline")
    begin
        CurrentlyCoupledCRMPostedSalesInvoiceLine := CRMPostedSalesInvoiceLine;
    end;
}
