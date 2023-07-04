table 83101 "CDS acwapp_propertyunit"
{
    ExternalName = 'acwapp_propertyunit';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_propertyunitId; GUID)
        {
            ExternalName = 'acwapp_propertyunitid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Property Unit';
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
            Description = 'Status of the Property Unit';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Property Unit';
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
            Caption = 'Property Name';
        }
        field(35; acwapp_PropertyID; Text[100])
        {
            ExternalName = 'acwapp_propertyid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property ID';
        }
        field(38; acwapp_Unit; Text[100])
        {
            ExternalName = 'acwapp_unit';
            ExternalType = 'String';
            Description = '';
            Caption = 'Unit';
        }
        field(39; acwapp_Type; Option)
        {
            ExternalName = 'acwapp_type';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Type';
            InitValue = " ";
            OptionMembers = " ",Property,Room,Facilities,Carpark,Locker;
            OptionOrdinalValues = -1, 557130000, 557130002, 557130003, 557130001, 557130004;
        }

        field(41; acwapp_EnglishShortDescription; Text[100])
        {
            ExternalName = 'acwapp_englishshortdescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'English Short Description';
        }
        field(42; acwapp_EnglishLongDescription; BLOB)
        {
            ExternalName = 'acwapp_englishlongdescription';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'English Long Description';
            Subtype = Memo;
        }
        field(43; acwapp_EnglishDirections; BLOB)
        {
            ExternalName = 'acwapp_englishdirections';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'English Directions';
            Subtype = Memo;
        }
        field(44; acwapp_TraditionalChineseShortDescription; Text[100])
        {
            ExternalName = 'acwapp_traditionalchineseshortdescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'Traditional Chinese Short Description';
        }
        field(45; acwapp_TraditionalChineseLongDescription; BLOB)
        {
            ExternalName = 'acwapp_traditionalchineselongdescription';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Traditional Chinese Long Description';
            Subtype = Memo;
        }
        field(46; acwapp_TraditionalChineseDirections; BLOB)
        {
            ExternalName = 'acwapp_traditionalchinesedirections';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Traditional Chinese Directions';
            Subtype = Memo;
        }
        field(47; acwapp_SimplifiedChineseShortDescription; Text[100])
        {
            ExternalName = 'acwapp_simplifiedchineseshortdescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'Simplified Chinese Short Description';
        }
        field(48; acwapp_SimplifiedChineseLongDescription; BLOB)
        {
            ExternalName = 'acwapp_simplifiedchineselongdescription';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Simplified Chinese Long Description';
            Subtype = Memo;
        }
        field(49; acwapp_SimplifiedChineseDirections; BLOB)
        {
            ExternalName = 'acwapp_simplifiedchinesedirections';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Simplified Chinese Directions';
            Subtype = Memo;
        }
        field(50; acwapp_AddressNickname; Text[100])
        {
            ExternalName = 'acwapp_addressnickname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Address Nickname';
        }
        field(51; acwapp_AddressLine1; Text[100])
        {
            ExternalName = 'acwapp_addressline1';
            ExternalType = 'String';
            Description = '';
            Caption = 'Address Line 1';
        }
        field(52; acwapp_AddressLine2; Text[100])
        {
            ExternalName = 'acwapp_addressline2';
            ExternalType = 'String';
            Description = '';
            Caption = 'Address Line 2';
        }
        field(53; acwapp_AddressLine3; Text[100])
        {
            ExternalName = 'acwapp_addressline3';
            ExternalType = 'String';
            Description = '';
            Caption = 'Address Line 3';
        }
        field(54; acwapp_PostCode; Text[100])
        {
            ExternalName = 'acwapp_postcode';
            ExternalType = 'String';
            Description = '';
            Caption = 'Post Code';
        }
        field(55; acwapp_Country; GUID)
        {
            ExternalName = 'acwapp_country';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Country';
            TableRelation = "CDS acwapp_country".acwapp_countryId;
        }
        field(56; acwapp_CountryName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_country".acwapp_name where(acwapp_countryId = field(acwapp_Country)));
            ExternalName = 'acwapp_countryname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(57; acwapp_Latitude; Text[100])
        {
            ExternalName = 'acwapp_latitude';
            ExternalType = 'String';
            Description = '';
            Caption = 'Latitude';
        }
        field(58; acwapp_Longitude; Text[100])
        {
            ExternalName = 'acwapp_longitude';
            ExternalType = 'String';
            Description = '';
            Caption = 'Longitude';
        }
        field(59; acwapp_CostCentre; Text[100])
        {
            ExternalName = 'acwapp_costcentre';
            ExternalType = 'String';
            Description = '';
            Caption = 'Cost Centre';
        }
        field(60; acwapp_PrimaryLockIdentifier; Text[100])
        {
            ExternalName = 'acwapp_primarylockidentifier';
            ExternalType = 'String';
            Description = '';
            Caption = 'Primary Lock Identifier';
        }
        field(61; acwapp_SortOrder; Integer)
        {
            ExternalName = 'acwapp_sortorder';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Sort Order';
        }
        field(62; acwapp_StripeAPIKey; Text[100])
        {
            ExternalName = 'acwapp_stripeapikey';
            ExternalType = 'String';
            Description = '';
            Caption = 'Stripe API Key';
        }
        field(63; acwapp_XeroAPIKey; Text[100])
        {
            ExternalName = 'acwapp_xeroapikey';
            ExternalType = 'String';
            Description = '';
            Caption = 'Xero API Key';
        }
        field(64; acwapp_Gender; Option)
        {
            ExternalName = 'acwapp_gender';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Gender';
            InitValue = " ";
            OptionMembers = " ",Male,Female,Unisex;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(66; acwapp_PetsAllowed; Boolean)
        {
            ExternalName = 'acwapp_petsallowed';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Pets Allowed';
        }
        field(70; acwapp_InternalDirections; Option)
        {
            ExternalName = 'acwapp_internaldirections';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Internal Directions';
            InitValue = " ";
            OptionMembers = " ",East,South,West,North;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002, 557130003;
        }
        field(72; acwapp_FloorZone; Option)
        {
            ExternalName = 'acwapp_floorzone';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Floor Zone';
            InitValue = " ";
            OptionMembers = " ",Low,Middle,High;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(75; acwapp_MarketingPageLink; Text[100])
        {
            ExternalName = 'acwapp_marketingpagelink';
            ExternalType = 'String';
            Description = '';
            Caption = 'Marketing Page Link';
        }
        field(76; acwapp_CleaningSchedule; GUID)
        {
            ExternalName = 'acwapp_cleaningschedule';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Cleaning Schedule';
            TableRelation = "CDS acwapp_period".acwapp_periodId;
        }
        field(77; acwapp_CleaningScheduleName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_period".acwapp_name where(acwapp_periodId = field(acwapp_CleaningSchedule)));
            ExternalName = 'acwapp_cleaningschedulename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(78; acwapp_CleaningStatus; Option)
        {
            ExternalName = 'acwapp_cleaningstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Cleaning Status';
            InitValue = " ";
            OptionMembers = " ",VacantClean,VacantInspected,OccupiedDirty,OccupiedClean,VacantDirty;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002, 557130003, 557130004;
        }
        field(80; acwapp_LastCleanedon; Datetime)
        {
            ExternalName = 'acwapp_lastcleanedon';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Last Cleaned on';
        }
        field(81; acwapp_LastInspectedon; Datetime)
        {
            ExternalName = 'acwapp_lastinspectedon';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Last Inspected on';
        }
        field(82; acwapp_City; GUID)
        {
            ExternalName = 'acwapp_city';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'City';
            TableRelation = "CDS acwapp_city".acwapp_cityId;
        }
        field(83; acwapp_CityName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_city".acwapp_name where(acwapp_cityId = field(acwapp_City)));
            ExternalName = 'acwapp_cityname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(84; acwapp_RatePlan; GUID)
        {
            ExternalName = 'acwapp_rateplan';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Rate Plan';
            TableRelation = "CDS acwapp_rateplan".acwapp_rateplanId;
        }
        field(85; acwapp_RatePlanName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_rateplan".acwapp_name where(acwapp_rateplanId = field(acwapp_RatePlan)));
            ExternalName = 'acwapp_rateplanname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(86; acwapp_RoomType; GUID)
        {
            ExternalName = 'acwapp_roomtype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Room Type';
            TableRelation = "CDS acwapp_roomtype".acwapp_roomtypeId;
        }
        field(87; acwapp_RoomTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_roomtype".acwapp_name where(acwapp_roomtypeId = field(acwapp_RoomType)));
            ExternalName = 'acwapp_roomtypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(88; acwapp_Priority; GUID)
        {
            ExternalName = 'acwapp_priority';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Priority';
            TableRelation = "CDS msdyn_priority".msdyn_priorityId;
        }
        field(89; acwapp_PriorityName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS msdyn_priority".msdyn_name where(msdyn_priorityId = field(acwapp_Priority)));
            ExternalName = 'acwapp_priorityname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(90; acwapp_Properties; GUID)
        {
            ExternalName = 'acwapp_properties';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(91; acwapp_PropertiesName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Properties)));
            ExternalName = 'acwapp_propertiesname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }

        field(92; acwapp_PropertyUnitStatus; Option)
        {
            ExternalName = 'acwapp_propertyunitstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Property Unit Status';
            InitValue = Normal;
            OptionMembers = Normal,OOO,OOS;
            OptionOrdinalValues = 557130002, 557130000, 557130001;
        }
        field(94; acwapp_OOOStartDate; Date)
        {
            ExternalName = 'acwapp_ooostartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'OOO Start Date';
        }
        field(95; acwapp_OOOEndDate; Date)
        {
            ExternalName = 'acwapp_oooenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'OOO End Date';
        }
        field(96; acwapp_OOSStartDate; Date)
        {
            ExternalName = 'acwapp_oosstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'OOS Start Date';
        }
        field(97; acwapp_OOSEndDate; Date)
        {
            ExternalName = 'acwapp_oosenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'OOS End Date';
        }
        field(100; acwapp_Floor; Text[100])
        {
            ExternalName = 'acwapp_floor';
            ExternalType = 'String';
            Description = '';
            Caption = 'Floor';
        }
        field(101; acwapp_Subtype; GUID)
        {
            ExternalName = 'acwapp_subtype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Subtype';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(102; acwapp_SubtypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Subtype)));
            ExternalName = 'acwapp_subtypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(107; acwapp_OvernightStayReminder; Boolean)
        {
            ExternalName = 'acwapp_overnightstayreminder';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Overnight Stay Reminder';
        }
        field(109; acwapp_PropertyUnit; GUID)
        {
            ExternalName = 'acwapp_propertyunit';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Unit Group';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(110; acwapp_PropertyUnitName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_PropertyUnit)));
            ExternalName = 'acwapp_propertyunitname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }


        field(120; acwapp_PropertyNo; Text[100])
        {
            ExternalName = 'acwapp_propertyno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property No.';
        }
        field(122; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(123; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
    }
    keys
    {
        key(PK; acwapp_propertyunitId)
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