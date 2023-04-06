page 83110 "CRM Product"
{
    ApplicationArea = All;
    Caption = 'CRM Product';
    PageType = List;
    SourceTable = "CDS acwapp_product";
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
                field(acwapp_BCStatus; Rec.acwapp_BCStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Status field.';
                }
                field(acwapp_ProductIDform; Rec.acwapp_ProductIDform)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product ID field.';
                }
                field(acwapp_ProductType; Rec.acwapp_ProductType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Type field.';
                }
                field(acwapp_ProductTypeName; Rec.acwapp_ProductTypeName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_ProductTypeName field.';
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
                field(acwapp_Quantity; Rec.acwapp_Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(acwapp_UnitOfMeasure; Rec.acwapp_UnitOfMeasure)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field(acwapp_UnitPrice; Rec.acwapp_UnitPrice)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(acwapp_productId; Rec.acwapp_productId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product field.';
                }
                field(acwapp_unitprice_Base; Rec.acwapp_unitprice_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price (Base) field.';
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
                field(acwapp_SubscriptionImmediate; Rec.acwapp_SubscriptionImmediate)
                {
                    ApplicationArea = All;

                }
                field(acwapp_AvailableOnBookingSite; Rec.acwapp_AvailableOnBookingSite)
                {
                    ApplicationArea = All;

                }
                field(acwapp_SubscriptionPeriod; Rec.acwapp_SubscriptionPeriod)
                {
                    ApplicationArea = All;

                }
                field(acwapp_SubscriptionPeriodType; Rec.acwapp_SubscriptionPeriodType)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        CurrentlyCoupledCRMProduct: Record "CDS acwapp_product";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMProduct(CRMProduct: Record "CDS acwapp_product")
    begin
        CurrentlyCoupledCRMProduct := CRMProduct;
    end;
}
