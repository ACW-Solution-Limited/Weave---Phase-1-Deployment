page 83144 "CRM Locker"
{
    ApplicationArea = All;
    Caption = 'CRM Locker';
    PageType = List;
    SourceTable = "CDS acwapp_locker";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_lockerId; Rec.acwapp_lockerId)
                {
                    ToolTip = 'Specifies the value of the Locker field.';
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
                field(acwapp_Company; Rec.acwapp_Company)
                {
                    ToolTip = 'Specifies the value of the Company field.';
                }
                field(acwapp_CompanyName; Rec.acwapp_CompanyName)
                {
                    ToolTip = 'Specifies the value of the acwapp_CompanyName field.';
                }
                field(acwapp_PropertyNo; Rec.acwapp_PropertyNo)
                {
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field(acwapp_ContractNo; Rec.acwapp_ContractNo)
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field(acwapp_ContractStatus; Rec.acwapp_ContractStatus)
                {
                    ToolTip = 'Specifies the value of the Contract Status field.';
                }
                field(acwapp_Account; Rec.acwapp_Account)
                {
                    ToolTip = 'Specifies the value of the Account field.';
                }
                field(acwapp_AccountID; Rec.acwapp_AccountID)
                {
                    ToolTip = 'Specifies the value of the Account ID field.';
                }
                field(acwapp_PayeeContact; Rec.acwapp_PayeeContact)
                {
                    ToolTip = 'Specifies the value of the Payee Contact field.';
                }
                field(acwapp_Property; Rec.acwapp_Property)
                {
                    ToolTip = 'Specifies the value of the Property field.';
                }
                field(acwapp_PropertyName; Rec.acwapp_PropertyName)
                {
                    ToolTip = 'Specifies the value of the acwapp_PropertyName field.';
                }
                field(acwapp_PropertyBooking; Rec.acwapp_PropertyBooking)
                {
                    ToolTip = 'Specifies the value of the Property Booking field.';
                }
                field(acwapp_PropertyBookingName; Rec.acwapp_PropertyBookingName)
                {
                    ToolTip = 'Specifies the value of the acwapp_PropertyBookingName field.';
                }
                field(acwapp_Locker; Rec.acwapp_Locker)
                {
                    ToolTip = 'Specifies the value of the Locker field.';
                }
                field(acwapp_LockerName; Rec.acwapp_LockerName)
                {
                    ToolTip = 'Specifies the value of the acwapp_LockerName field.';
                }
                field(acwapp_StartDate; Rec.acwapp_StartDate)
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(acwapp_EndDate; Rec.acwapp_EndDate)
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(acwapp_MonthlyRent; Rec.acwapp_MonthlyRent)
                {
                    ToolTip = 'Specifies the value of the Monthly Rent field.';
                }
                field(TransactionCurrencyId; Rec.TransactionCurrencyId)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(acwapp_monthlyrent_Base; Rec.acwapp_monthlyrent_Base)
                {
                    ToolTip = 'Specifies the value of the Monthly Rent (Base) field.';
                }
                field(acwapp_PaymentType; Rec.acwapp_PaymentType)
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field(acwapp_ID; Rec.acwapp_ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(acwapp_LockerType; Rec.acwapp_LockerType)
                {
                    ToolTip = 'Specifies the value of the Locker Type field.';
                }
                field(acwapp_LockerTypeName; Rec.acwapp_LockerTypeName)
                {
                    ToolTip = 'Specifies the value of the acwapp_LockerTypeName field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
            }
        }
    }
    var
        CurrentlyCoupledLocker: Record "CDS acwapp_locker";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMLocker(CRMLocker: Record "CDS acwapp_locker")
    begin
        CurrentlyCoupledLocker := CRMLocker;
    end;
}
