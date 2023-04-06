page 83141 "CRM - Tender Type"
{
    ApplicationArea = All;
    Caption = 'CRM - Tender Type';
    PageType = List;
    SourceTable = "CDS acwapp_tendertype";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_DeductionAmountHKD; Rec.acwapp_DeductionAmountHKD)
                {
                    ToolTip = 'Specifies the value of the Deduction Amount (HKD) field.';
                }
                field(acwapp_Description; Rec.acwapp_Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(acwapp_EffectiveStartDate; Rec.acwapp_EffectiveStartDate)
                {
                    ToolTip = 'Specifies the value of the Effective Start Date field.';
                }
                field(acwapp_EffectiveEndDate; Rec.acwapp_EffectiveEndDate)
                {
                    ToolTip = 'Specifies the value of the Effective End Date field.';
                }
                field(acwapp_PriceDeductionType; Rec.acwapp_PriceDeductionType)
                {
                    ToolTip = 'Specifies the value of the Price Deduction Type field.';
                }
                field(acwapp_PercentageDeduction; Rec.acwapp_PercentageDeduction)
                {
                    ToolTip = 'Specifies the value of the Deduction Percentage (%) field.';
                }
                field(acwapp_PaymentType; Rec.acwapp_PaymentType)
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(acwapp_tendertypeId; Rec.acwapp_tendertypeId)
                {
                    ToolTip = 'Specifies the value of the Tender Type field.';
                }
            }
        }
    }

    var
        CurrentlyCoupledCRMTenderType: Record "CDS acwapp_tendertype";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMTenderType(CRMTenderType: Record "CDS acwapp_tendertype")
    begin
        CurrentlyCoupledCRMTenderType := CRMTenderType;
    end;
}

