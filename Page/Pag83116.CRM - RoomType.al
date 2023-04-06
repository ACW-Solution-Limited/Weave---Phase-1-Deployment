page 83116 "CRM Room Type"
{
    ApplicationArea = All;
    Caption = 'CRM Room Type';
    PageType = List;
    SourceTable = "CDS acwapp_roomtype";
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
                field(acwapp_EnglishDescription; Rec.acwapp_EnglishDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the English Description field.';
                }
                field(acwapp_EnglishLongDescription; Rec.acwapp_EnglishLongDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the English Long Description field.';
                }
                field(acwapp_FloorSpaceMax; Rec.acwapp_FloorSpaceMax)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Floor Space Max field.';
                }
                field(acwapp_FloorSpaceMin; Rec.acwapp_FloorSpaceMin)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Floor Space Min field.';
                }
                field(acwapp_InternetBookingEngineMaxAvailableUnits; Rec.acwapp_InternetBookingEngineMaxAvailableUnits)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Internet Booking Engine Max Available Units field.';
                }
                field(acwapp_LinktoExtras; Rec.acwapp_LinktoExtras)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Link to Extras field.';
                }
                field(acwapp_MaximumOccupancy; Rec.acwapp_MaximumOccupancy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Occupancy field.';
                }
                field(acwapp_MaximumStay; Rec.acwapp_MaximumStay)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Stay field.';
                }
                field(acwapp_MinimumStay; Rec.acwapp_MinimumStay)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Stay field.';
                }
                field(acwapp_Property; Rec.acwapp_Property)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property field.';
                }
                field(acwapp_PropertyName; Rec.acwapp_PropertyName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_PropertyName field.';
                }
                field(acwapp_RatePlan; Rec.acwapp_RatePlan)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate Plan field.';
                }
                field(acwapp_RatePlanName; Rec.acwapp_RatePlanName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_RatePlanName field.';
                }
                field(acwapp_RoomType; Rec.acwapp_RoomType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room Type field.';
                }
                field(acwapp_RoomTypeName; Rec.acwapp_RoomTypeName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_RoomTypeName field.';
                }
                field(acwapp_SimplifiedChineseDescription; Rec.acwapp_SimplifiedChineseDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Simplified Chinese Description field.';
                }
                field(acwapp_SimplifiedChineseLongDescription; Rec.acwapp_SimplifiedChineseLongDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Simplified Chinese Long Description field.';
                }
                field(acwapp_TotalNumberofRoom; Rec.acwapp_TotalNumberofRoom)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Number of Room field.';
                }
                field(acwapp_TraditionalChineseDescription; Rec.acwapp_TraditionalChineseDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Traditional Chinese Description field.';
                }
                field(acwapp_TraditionalChineseLongDescription; Rec.acwapp_TraditionalChineseLongDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Traditional Chinese Long Description field.';
                }
                field(acwapp_UnitTypeCode; Rec.acwapp_UnitTypeCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Type Code field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(acwapp_roomtypeId; Rec.acwapp_roomtypeId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room Type field.';
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
        CurrentlyCoupledCRMRoomType: Record "CDS acwapp_roomtype";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMRoomType(CRMRoomType: Record "CDS acwapp_roomtype")
    begin
        CurrentlyCoupledCRMRoomType := CRMRoomType;
    end;
}
