page 83138 "CRM - Tender Type Discount"
{
    ApplicationArea = All;
    Caption = 'CRM - Tender Type Discount';
    PageType = List;
    SourceTable = "CDS acwapp_tendertypediscount";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_name; Rec.acwapp_name)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(acwapp_tendertypediscountId; Rec.acwapp_tendertypediscountId)
                {
                    ToolTip = 'Specifies the value of the Tender Type Discount field.';
                }
                field(acwapp_PostedSalesInvoiceName; Rec.acwapp_PostedSalesInvoiceName)
                {
                    ToolTip = 'Specifies the value of the acwapp_PostedSalesInvoiceName field.';
                }
                field(acwapp_PostedSalesInvoice; Rec.acwapp_PostedSalesInvoice)
                {
                    ToolTip = 'Specifies the value of the Posted Sales Invoice field.';
                }
                field(acwapp_Currency; Rec.acwapp_Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(acwapp_DiscountAmount; Rec.acwapp_DiscountAmount)
                {
                    ToolTip = 'Specifies the value of the Discount Amount field.';
                }
                field(acwapp_PaymentAmount; Rec.acwapp_PaymentAmount)
                {
                    ToolTip = 'Specifies the value of the Payment Amount field.';
                }
                field(acwapp_PaymentReferenceID; Rec.acwapp_PaymentReferenceID)
                {
                    ToolTip = 'Specifies the value of the Payment Reference ID field.';
                }
            }
        }
    }

    var
        CurrentlyCoupledCRMTenderTypeDiscount: Record "CDS acwapp_tendertypediscount";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMTenderTypeDiscount(CRMTenderTypeDiscount: Record "CDS acwapp_tendertypediscount")
    begin
        CurrentlyCoupledCRMTenderTypeDiscount := CRMTenderTypeDiscount;
    end;
}
