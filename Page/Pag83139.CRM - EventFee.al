page 83139 "CRM Event Fee"
{
    ApplicationArea = All;
    Caption = 'CRM Event Fee';
    PageType = List;
    SourceTable = "CDS acwapp_eventfee";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_eventfeeId; Rec.acwapp_eventfeeId)
                {
                    ToolTip = 'Specifies the value of the Event Fee field.';
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
                field(acwapp_Contact; Rec.acwapp_Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field(acwapp_Amount; Rec.acwapp_Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(TransactionCurrencyId; Rec.TransactionCurrencyId)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(acwapp_amount_Base; Rec.acwapp_amount_Base)
                {
                    ToolTip = 'Specifies the value of the Amount (Base) field.';
                }
                field(acwapp_Account; Rec.acwapp_Account)
                {
                    ToolTip = 'Specifies the value of the Account field.';
                }
                field(acwapp_AccountID; Rec.acwapp_AccountID)
                {
                    ToolTip = 'Specifies the value of the Account ID field.';
                }
                field(acwapp_AmountIncludeGST; Rec.acwapp_AmountIncludeGST)
                {
                    ToolTip = 'Specifies the value of the Amount Include GST field.';
                }
                field(acwapp_amountincludegst_Base; Rec.acwapp_amountincludegst_Base)
                {
                    ToolTip = 'Specifies the value of the Amount Include GST (Base) field.';
                }
                field(acwapp_ContractNo; Rec.acwapp_ContractNo)
                {
                    ToolTip = 'Specifies the value of the Contract No field.';
                }
                field(acwapp_Date; Rec.acwapp_Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(acwapp_PaymentReferenceID; Rec.acwapp_PaymentReferenceID)
                {
                    ToolTip = 'Specifies the value of the Payment Reference ID field.';
                }
                field(acwapp_PropertyNo; Rec.acwapp_PropertyNo)
                {
                    ToolTip = 'Specifies the value of the Property No field.';
                }
                field(acwapp_PropertyBooking; Rec.acwapp_PropertyBooking)
                {
                    ToolTip = 'Specifies the value of the Property Booking field.';
                }
                field(acwapp_PropertyBookingName; Rec.acwapp_PropertyBookingName)
                {
                    ToolTip = 'Specifies the value of the acwapp_PropertyBookingName field.';
                }
                field(acwapp_Property; Rec.acwapp_Property)
                {
                    ToolTip = 'Specifies the value of the Property field.';
                }
                field(acwapp_PropertyName; Rec.acwapp_PropertyName)
                {
                    ToolTip = 'Specifies the value of the acwapp_PropertyName field.';
                }
                field(acwapp_APIGenerateNumber; Rec.acwapp_APIGenerateNumber)
                {
                    ToolTip = 'Specifies the value of the API Generate Number field.';
                }
                field(acwapp_Company; Rec.acwapp_Company)
                {
                    ToolTip = 'Specifies the value of the Company field.';
                }
                field(acwapp_CompanyName; Rec.acwapp_CompanyName)
                {
                    ToolTip = 'Specifies the value of the acwapp_CompanyName field.';
                }

            }
        }
    }

    var
        CurrentlyCoupledCRMEventFee: Record "CDS acwapp_eventfee";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMEventFee(CRMEventFee: Record "CDS acwapp_eventfee")
    begin
        CurrentlyCoupledCRMEventFee := CRMEventFee;
    end;
}
