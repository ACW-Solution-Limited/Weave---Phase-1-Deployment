table 83106 "CDS acwapp_roomtype"
{
    ExternalName = 'acwapp_roomtype';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_roomtypeId; GUID)
        {
            ExternalName = 'acwapp_roomtypeid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Room Type';
        }
        field(2; CreatedOn; Datetime)
        {
            ExternalName = 'createdon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Date and time when the record was created.';
            Caption = 'Created On';
        }
        field(3; CreatedBy; GUID)
        {
            ExternalName = 'createdby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the user who created the record.';
            Caption = 'Created By';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(4; ModifiedOn; Datetime)
        {
            ExternalName = 'modifiedon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Date and time when the record was modified.';
            Caption = 'Modified On';
        }
        field(5; ModifiedBy; GUID)
        {
            ExternalName = 'modifiedby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the user who modified the record.';
            Caption = 'Modified By';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(6; CreatedOnBehalfBy; GUID)
        {
            ExternalName = 'createdonbehalfby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the delegate user who created the record.';
            Caption = 'Created By (Delegate)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(7; ModifiedOnBehalfBy; GUID)
        {
            ExternalName = 'modifiedonbehalfby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the delegate user who modified the record.';
            Caption = 'Modified By (Delegate)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(16; OwnerId; GUID)
        {
            ExternalName = 'ownerid';
            ExternalType = 'Owner';
            Description = 'Owner Id';
            Caption = 'Owner';
        }
        field(21; OwningBusinessUnit; GUID)
        {
            ExternalName = 'owningbusinessunit';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier for the business unit that owns the record';
            Caption = 'Owning Business Unit';
            TableRelation = "CRM Businessunit".BusinessUnitId;
        }
        field(22; OwningUser; GUID)
        {
            ExternalName = 'owninguser';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier for the user that owns the record.';
            Caption = 'Owning User';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(23; OwningTeam; GUID)
        {
            ExternalName = 'owningteam';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier for the team that owns the record.';
            Caption = 'Owning Team';
            TableRelation = "CRM Team".TeamId;
        }
        field(25; statecode; Option)
        {
            ExternalName = 'statecode';
            ExternalType = 'State';
            ExternalAccess = Modify;
            Description = 'Status of the Room Type';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Room Type';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 1, 2;
        }
        field(29; VersionNumber; BigInteger)
        {
            ExternalName = 'versionnumber';
            ExternalType = 'BigInt';
            ExternalAccess = Read;
            Description = 'Version Number';
            Caption = 'Version Number';
        }
        field(30; ImportSequenceNumber; Integer)
        {
            ExternalName = 'importsequencenumber';
            ExternalType = 'Integer';
            ExternalAccess = Insert;
            Description = 'Sequence number of the import that created this record.';
            Caption = 'Import Sequence Number';
        }
        field(31; OverriddenCreatedOn; Date)
        {
            ExternalName = 'overriddencreatedon';
            ExternalType = 'DateTime';
            ExternalAccess = Insert;
            Description = 'Date and time that the record was migrated.';
            Caption = 'Record Created On';
        }
        field(32; TimeZoneRuleVersionNumber; Integer)
        {
            ExternalName = 'timezoneruleversionnumber';
            ExternalType = 'Integer';
            Description = 'For internal use only.';
            Caption = 'Time Zone Rule Version Number';
        }
        field(33; UTCConversionTimeZoneCode; Integer)
        {
            ExternalName = 'utcconversiontimezonecode';
            ExternalType = 'Integer';
            Description = 'Time zone code that was in use when the record was created.';
            Caption = 'UTC Conversion Time Zone Code';
        }
        field(34; acwapp_name; Text[100])
        {
            ExternalName = 'acwapp_name';
            ExternalType = 'String';
            Description = 'The name of the custom entity.';
            Caption = 'Name';
        }
        field(37; acwapp_EnglishDescription; Text[100])
        {
            ExternalName = 'acwapp_englishdescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'English Description';
        }
        field(39; acwapp_TraditionalChineseDescription; Text[100])
        {
            ExternalName = 'acwapp_traditionalchinesedescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'Traditional Chinese Description';
        }
        field(41; acwapp_SimplifiedChineseDescription; Text[100])
        {
            ExternalName = 'acwapp_simplifiedchinesedescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'Simplified Chinese Description';
        }
        field(43; acwapp_UnitTypeCode; Text[100])
        {
            ExternalName = 'acwapp_unittypecode';
            ExternalType = 'String';
            Description = '';
            Caption = 'Unit Type Code';
        }
        field(46; acwapp_LinktoExtras; Boolean)
        {
            ExternalName = 'acwapp_linktoextras';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Link to Extras';
        }
        field(48; acwapp_MaximumOccupancy; Integer)
        {
            ExternalName = 'acwapp_maximumoccupancy';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Maximum Occupancy';
        }
        field(49; acwapp_InternetBookingEngineMaxAvailableUnits; Integer)
        {
            ExternalName = 'acwapp_internetbookingenginemaxavailableunits';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Internet Booking Engine Max Available Units';
        }
        field(50; acwapp_MinimumStay; Integer)
        {
            ExternalName = 'acwapp_minimumstay';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Minimum Stay';
        }
        field(51; acwapp_MaximumStay; Integer)
        {
            ExternalName = 'acwapp_maximumstay';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Maximum Stay';
        }
        field(52; acwapp_FloorSpaceMin; Decimal)
        {
            ExternalName = 'acwapp_floorspacemin';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Floor Space Min';
        }
        field(53; acwapp_FloorSpaceMax; Decimal)
        {
            ExternalName = 'acwapp_floorspacemax';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Floor Space Max';
        }
        field(54; acwapp_RoomType; GUID)
        {
            ExternalName = 'acwapp_roomtype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Room Type GUID';
            TableRelation = "CDS acwapp_roomtypemaster".acwapp_roomtypemasterId;
        }
        field(55; acwapp_RoomTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_roomtypemaster".acwapp_name where(acwapp_roomtypemasterId = field(acwapp_RoomType)));
            ExternalName = 'acwapp_roomtypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(56; acwapp_Property; GUID)
        {
            ExternalName = 'acwapp_property';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(57; acwapp_PropertyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Property)));
            ExternalName = 'acwapp_propertyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(58; acwapp_EnglishLongDescription; BLOB)
        {
            ExternalName = 'acwapp_englishlongdescription';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'English Long Description';
            Subtype = Memo;
        }
        field(59; acwapp_TraditionalChineseLongDescription; BLOB)
        {
            ExternalName = 'acwapp_traditionalchineselongdescription';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Traditional Chinese Long Description';
            Subtype = Memo;
        }
        field(60; acwapp_SimplifiedChineseLongDescription; BLOB)
        {
            ExternalName = 'acwapp_simplifiedchineselongdescription';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Simplified Chinese Long Description';
            Subtype = Memo;
        }
        field(61; acwapp_RatePlan; GUID)
        {
            ExternalName = 'acwapp_rateplan';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Rate Plan';
            TableRelation = "CDS acwapp_rateplan".acwapp_rateplanId;
        }
        field(62; acwapp_RatePlanName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_rateplan".acwapp_name where(acwapp_rateplanId = field(acwapp_RatePlan)));
            ExternalName = 'acwapp_rateplanname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(63; acwapp_TotalNumberofRoom; Integer)
        {
            ExternalName = 'acwapp_totalnumberofroom';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Total Number of Room';
        }
        field(89; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CRM Company".cdm_companyId;
        }
    }
    keys
    {
        key(PK; acwapp_roomtypeId)
        {
            Clustered = true;
        }
        key(Name; acwapp_name)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; acwapp_name)
        {
        }
    }
}