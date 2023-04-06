table 83110 "CDS acwapp_product"
{
    ExternalName = 'acwapp_product';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_productId; GUID)
        {
            ExternalName = 'acwapp_productid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Product';
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
            Description = 'Status of the Product';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Product';
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
        field(35; acwapp_UnitPrice; Decimal)
        {
            ExternalName = 'acwapp_unitprice';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Unit Price';
        }
        field(36; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(38; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(39; acwapp_unitprice_Base; Decimal)
        {
            ExternalName = 'acwapp_unitprice_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Unit Price in base currency.';
            Caption = 'Unit Price (Base)';
        }
        field(40; acwapp_Quantity; Integer)
        {
            ExternalName = 'acwapp_quantity';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity';
        }
        field(41; acwapp_ProductType; GUID)
        {
            ExternalName = 'acwapp_producttype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Product Type';
            TableRelation = "CDS acwapp_producttype".acwapp_producttypeId;
        }
        field(42; acwapp_ProductTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_producttype".acwapp_name where(acwapp_producttypeId = field(acwapp_ProductType)));
            ExternalName = 'acwapp_producttypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(43; acwapp_BCStatus; Option)
        {
            ExternalName = 'acwapp_bcstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'BC Status';
            InitValue = " ";
            OptionMembers = " ",Open,Created,Posted;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(45; acwapp_PropertyBooking; GUID)
        {
            ExternalName = 'acwapp_propertybooking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(46; acwapp_PropertyBookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_PropertyBooking)));
            ExternalName = 'acwapp_propertybookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(47; acwapp_UnitOfMeasure; Text[100])
        {
            ExternalName = 'acwapp_unitofmeasure';
            ExternalType = 'String';
            Description = '';
            Caption = 'Unit Of Measure';
        }
        field(48; acwapp_ProductIDform; Text[100])
        {
            ExternalName = 'acwapp_productidform';
            ExternalType = 'String';
            Description = '';
            Caption = 'Product ID';
        }
        field(49; acwapp_BCCompany; GUID)
        {
            ExternalName = 'acwapp_bccompany';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'BC Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(50; acwapp_BCCompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_BCCompany)));
            ExternalName = 'acwapp_bccompanyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(53; acwapp_AvailableOnBookingSite; Boolean)
        {
            ExternalName = 'acwapp_availableonbookingsite';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Available On Booking Site';
        }
        field(55; acwapp_TotalStock; Integer)
        {
            ExternalName = 'acwapp_totalstock';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Total Stock';
        }
        field(56; acwapp_SubscriptionImmediate; Boolean)
        {
            ExternalName = 'acwapp_subscriptionimmediate';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Subscription/Immediate';
        }
        field(58; acwapp_SubscriptionPeriod; Integer)
        {
            ExternalName = 'acwapp_subscriptionperiod';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Subscription Period';
        }
        field(59; acwapp_SubscriptionPeriodType; Option)
        {
            ExternalName = 'acwapp_subscriptionperiodtype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Subscription Period Type';
            InitValue = " ";
            OptionMembers = " ","Day(s)","Week(s)","Month(s)","Year(s)";
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002, 557130003;
        }
    }
    keys
    {
        key(PK; acwapp_productId)
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