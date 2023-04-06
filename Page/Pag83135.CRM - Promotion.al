page 82006 "CRM Promotion"
{
    ApplicationArea = All;
    Caption = 'CRM Promotion';
    PageType = List;
    SourceTable = "CDS acwapp_promotioncode";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_promotioncodeId; Rec.acwapp_promotioncodeId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Promotion Code field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Promotion Code field.';
                }
                field(acwapp_Description; Rec.acwapp_Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(acwapp_EffectiveStartDate; Rec.acwapp_EffectiveStartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Effective Start Date field.';
                }
                field(acwapp_EffectiveEndDate; Rec.acwapp_EffectiveEndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Effective End Date field.';
                }
                field(acwapp_PriceDeductionType; Rec.acwapp_PriceDeductionType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Deduction Type field.';
                }
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
                field(acwapp_ChargeType; Rec.acwapp_ChargeType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Type field.';
                }
                field(acwapp_DeductionAmount; Rec.acwapp_DeductionAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deduction Amount field.';
                }
                field(acwapp_DeductionPercentage; Rec.acwapp_DeductionPercentage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deduction Percentage (%) field.';
                }
                field(acwapp_PromotionCodeChargeType; Rec.acwapp_PromotionCodeChargeType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Promotion Code Charge Type field.';
                }
                field(acwapp_RemainingQuota; Rec.acwapp_RemainingQuota)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Quota field.';
                }
                field(acwapp_RenewalPromotionCode; Rec.acwapp_RenewalPromotionCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Renewal Promotion Code field.';
                }
                field(acwapp_TotalQuota; Rec.acwapp_TotalQuota)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Quota field.';
                }
                field(acwapp_TriggerPoint; Rec.acwapp_TriggerPoint)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trigger Point field.';
                }
                field(acwapp_UsageQuota; Rec.acwapp_UsageQuota)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Usage Quota field.';
                }
                field(acwapp_UsageQuota_Date; Rec.acwapp_UsageQuota_Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Usage Quota (Last Updated On) field.';
                }
                field(acwapp_UsageQuota_State; Rec.acwapp_UsageQuota_State)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Usage Quota (State) field.';
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
    procedure SetCurrentlyCoupledCRMPromotion(CRMAPromotion: Record "CDS acwapp_promotioncode")
    begin
        CurrentlyCoupledCRMPromotion := CRMAPromotion;
    end;

    var
        CurrentlyCoupledCRMPromotion: Record "CDS acwapp_promotioncode";
}
