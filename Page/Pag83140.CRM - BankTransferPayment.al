page 83140 "CRM  Bank Transfer Payment"
{
    ApplicationArea = All;
    Caption = 'CRM  Bank Transfer Payment';
    PageType = List;
    SourceTable = "CDS acwapp_banktransferpayment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_banktransferpaymentId; Rec.acwapp_banktransferpaymentId)
                {
                    ToolTip = 'Specifies the value of the Bank Transfer Payment field.';
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
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(acwapp_BedroomOffer; Rec.acwapp_BedroomOffer)
                {
                    ToolTip = 'Specifies the value of the Bedroom Offer field.';
                }
                field(acwapp_BedroomOfferName; Rec.acwapp_BedroomOfferName)
                {
                    ToolTip = 'Specifies the value of the acwapp_BedroomOfferName field.';
                }
                field(acwapp_BankTransferSlip; Rec.acwapp_BankTransferSlip)
                {
                    ToolTip = 'Specifies the value of the Bank Transfer Slip field.';
                }
                field(acwapp_ConfirmBankTransferPayment; Rec.acwapp_ConfirmBankTransferPayment)
                {
                    ToolTip = 'Specifies the value of the Confirm Bank Transfer Payment field.';
                }
                field(acwapp_APIGenerateNumber; Rec.acwapp_APIGenerateNumber)
                {
                    ToolTip = 'Specifies the value of the API Generate Number field.';
                }

                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }

            }
        }
    }
    var
        CurrentlyCoupledCRMBankTransferPayment: Record "CDS acwapp_banktransferpayment";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMBankTransferPayment(CRMBankTransferPayment: Record "CDS acwapp_banktransferpayment")
    begin
        CurrentlyCoupledCRMBankTransferPayment := CRMBankTransferPayment;
    end;
}
