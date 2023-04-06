table 83139 "CDS acwapp_eventfee"
{
    ExternalName = 'acwapp_eventfee';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_eventfeeId; GUID)
        {
            ExternalName = 'acwapp_eventfeeid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Event Fee';
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
            Description = 'Status of the Event Fee';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Event Fee';
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
            Caption = 'ID';
        }
        field(35; acwapp_Contact; GUID)
        {
            ExternalName = 'acwapp_contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(46; acwapp_Amount; Decimal)
        {
            ExternalName = 'acwapp_amount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount';
        }
        field(47; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(49; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(50; acwapp_amount_Base; Decimal)
        {
            ExternalName = 'acwapp_amount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount in base currency.';
            Caption = 'Amount (Base)';
        }
        field(53; acwapp_Account; GUID)
        {
            ExternalName = 'acwapp_account';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Account';
            TableRelation = "CRM Account".AccountId;
        }
        field(56; acwapp_AccountID; Text[100])
        {
            ExternalName = 'acwapp_accountid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Account ID';
        }
        field(57; acwapp_AmountIncludeGST; Decimal)
        {
            ExternalName = 'acwapp_amountincludegst';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount Include GST';
        }
        field(58; acwapp_amountincludegst_Base; Decimal)
        {
            ExternalName = 'acwapp_amountincludegst_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount Include GST in base currency.';
            Caption = 'Amount Include GST (Base)';
        }
        field(61; acwapp_ContractNo; Text[100])
        {
            ExternalName = 'acwapp_contractno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract No';
        }
        field(62; acwapp_Date; Date)
        {
            ExternalName = 'acwapp_date';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Date';
        }
        field(63; acwapp_PaymentReferenceID; Text[100])
        {
            ExternalName = 'acwapp_paymentreferenceid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Reference ID';
        }
        field(64; acwapp_PropertyNo; Text[100])
        {
            ExternalName = 'acwapp_propertyno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property No';
        }
        field(65; acwapp_PropertyBooking; GUID)
        {
            ExternalName = 'acwapp_propertybooking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(66; acwapp_PropertyBookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_PropertyBooking)));
            ExternalName = 'acwapp_propertybookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(67; acwapp_Property; GUID)
        {
            ExternalName = 'acwapp_property';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(68; acwapp_PropertyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Property)));
            ExternalName = 'acwapp_propertyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(69; acwapp_APIGenerateNumber; Text[100])
        {
            ExternalName = 'acwapp_apigeneratenumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'API Generate Number';
        }
        field(70; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(71; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(72; acwapp_ContactID; Text[100])
        {
            ExternalName = 'acwapp_contactid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contact ID';
        }
        field(73; acwapp_CurrencyID; Text[100])
        {
            ExternalName = 'acwapp_currencyid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Currency ID';
        }
        field(74; acwapp_EventID; Text[100])
        {
            ExternalName = 'acwapp_eventid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Event ID';
        }
        field(75; acwapp_EventSessionID; Text[100])
        {
            ExternalName = 'acwapp_eventsessionid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Event Session ID';
        }
        field(76; acwapp_EventRegistrationID; Text[100])
        {
            ExternalName = 'acwapp_eventregistrationid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Event Registration ID';
        }
    }
    keys
    {
        key(PK; acwapp_eventfeeId)
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