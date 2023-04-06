table 83141 "CDS acwapp_tendertype"
{
    ExternalName = 'acwapp_tendertype';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_tendertypeId; GUID)
        {
            ExternalName = 'acwapp_tendertypeid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Tender Type';
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
            Description = 'Status of the Tender Type';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Tender Type';
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
        field(35; acwapp_PaymentType; Text[100])
        {
            ExternalName = 'acwapp_paymenttype';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Type';
        }
        field(36; acwapp_Description; Text[100])
        {
            ExternalName = 'acwapp_description';
            ExternalType = 'String';
            Description = '';
            Caption = 'Description';
        }
        field(37; acwapp_PriceDeductionType; Option)
        {
            ExternalName = 'acwapp_pricedeductiontype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Price Deduction Type';
            InitValue = " ";
            OptionMembers = " ",ByPercentage,ByExactDollarValue;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
        field(39; acwapp_DeductionAmountHKD; Decimal)
        {
            ExternalName = 'acwapp_deductionamounthkd';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Deduction Amount (HKD)';
        }
        field(40; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(42; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(43; acwapp_deductionamounthkd_Base; Decimal)
        {
            ExternalName = 'acwapp_deductionamounthkd_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Deduction Amount (HKD) in base currency.';
            Caption = 'Deduction Amount (HKD) (Base)';
        }
        field(45; acwapp_EffectiveStartDate; Date)
        {
            ExternalName = 'acwapp_effectivestartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Effective Start Date';
        }
        field(46; acwapp_EffectiveEndDate; Date)
        {
            ExternalName = 'acwapp_effectiveenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Effective End Date';
        }
        field(47; acwapp_PercentageDeduction; Decimal)
        {
            ExternalName = 'acwapp_percentagededuction';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Deduction Percentage (%)';
        }
        field(48; acwapp_CurrencyText; Text[100])
        {
            ExternalName = 'acwapp_currencytext';
            ExternalType = 'String';
            Description = '';
            Caption = 'Currency (Text)';
        }
    }
    keys
    {
        key(PK; acwapp_tendertypeId)
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