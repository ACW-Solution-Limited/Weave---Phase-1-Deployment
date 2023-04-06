table 83118 "CDS acwapp_workorder"
{
    ExternalName = 'acwapp_workorder';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_workorderId; GUID)
        {
            ExternalName = 'acwapp_workorderid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Work Order';
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
            Description = 'Status of the Work Order';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Work Order';
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
        field(36; acwapp_PropertyBooking; GUID)
        {
            ExternalName = 'acwapp_propertybooking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(37; acwapp_PropertyBookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_PropertyBooking)));
            ExternalName = 'acwapp_propertybookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(38; acwapp_PropertyUnit; GUID)
        {
            ExternalName = 'acwapp_propertyunit';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Unit';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(39; acwapp_PropertyUnitName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_PropertyUnit)));
            ExternalName = 'acwapp_propertyunitname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(40; acwapp_WorkOrderStartDate; Datetime)
        {
            ExternalName = 'acwapp_workorderstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Work Order Start Date';
        }
        field(41; acwapp_WorkOrderEndDate; Datetime)
        {
            ExternalName = 'acwapp_workorderenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Work Order End Date';
        }
        field(44; acwapp_AdditionalAmenities; GUID)
        {
            ExternalName = 'acwapp_additionalamenities';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Additional Amenities';
            TableRelation = "CDS acwapp_additionalamenities".acwapp_additionalamenitiesId;
        }
        field(45; acwapp_AdditionalAmenitiesName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_additionalamenities".acwapp_name where(acwapp_additionalamenitiesId = field(acwapp_AdditionalAmenities)));
            ExternalName = 'acwapp_additionalamenitiesname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(52; acwapp_Status; Option)
        {
            ExternalName = 'acwapp_status';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Open,InProgress,Completed;
            OptionOrdinalValues = -1, 557130002, 557130000, 557130001;
        }
        field(54; acwapp_OrderID; Text[100])
        {
            ExternalName = 'acwapp_orderid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Order ID';
        }
        field(55; acwapp_BedroomOffer; GUID)
        {
            ExternalName = 'acwapp_bedroomoffer';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Bedroom Offer';
            TableRelation = "CDS acwapp_bedroomoffer".acwapp_bedroomofferId;
        }
        field(56; acwapp_BedroomOfferName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bedroomoffer".acwapp_name where(acwapp_bedroomofferId = field(acwapp_BedroomOffer)));
            ExternalName = 'acwapp_bedroomoffername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(59; acwapp_Case; GUID)
        {
            ExternalName = 'acwapp_case';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Case';
            TableRelation = "CRM Incident".IncidentId;
        }
        field(61; acwapp_AdditionalService; GUID)
        {
            ExternalName = 'acwapp_additionalservice';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Additional Service';
            TableRelation = "CDS acwapp_additionalservice".acwapp_additionalserviceId;
        }
        field(62; acwapp_AdditionalServiceName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_additionalservice".acwapp_name where(acwapp_additionalserviceId = field(acwapp_AdditionalService)));
            ExternalName = 'acwapp_additionalservicename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
    }
    keys
    {
        key(PK; acwapp_workorderId)
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