table 83138 "CDS acwapp_tendertypediscount"
{
    ExternalName = 'acwapp_tendertypediscount';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_tendertypediscountId; GUID)
        {
            ExternalName = 'acwapp_tendertypediscountid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Tender Type Discount';
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
            Description = 'Status of the Tender Type Discount';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Tender Type Discount';
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
        field(35; acwapp_PostedSalesInvoice; GUID)
        {
            ExternalName = 'acwapp_postedsalesinvoice';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Posted Sales Invoice';
            TableRelation = "CDS acwapp_salesinvoice".acwapp_salesinvoiceId;
        }
        field(36; acwapp_PostedSalesInvoiceName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_salesinvoice".acwapp_name where(acwapp_salesinvoiceId = field(acwapp_PostedSalesInvoice)));
            ExternalName = 'acwapp_postedsalesinvoicename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(39; acwapp_DiscountAmount; Decimal)
        {
            ExternalName = 'acwapp_discountamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Discount Amount';
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
        field(43; acwapp_discountamount_Base; Decimal)
        {
            ExternalName = 'acwapp_discountamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Discount Amount in base currency.';
            Caption = 'Discount Amount (Base)';
        }
        field(44; acwapp_PaymentAmount; Decimal)
        {
            ExternalName = 'acwapp_paymentamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Payment Amount';
        }
        field(45; acwapp_paymentamount_Base; Decimal)
        {
            ExternalName = 'acwapp_paymentamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Payment Amount in base currency.';
            Caption = 'Payment Amount (Base)';
        }
        field(46; acwapp_Currency; GUID)
        {
            ExternalName = 'acwapp_currency';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }

        field(48; acwapp_PaymentReferenceID; Text[100])
        {
            ExternalName = 'acwapp_paymentreferenceid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Reference ID';
        }
        field(49; acwapp_APIGenerateNumber; Text[100])
        {
            ExternalName = 'acwapp_apigeneratenumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'API Generate Number';
        }
        field(50; acwapp_TenderTypeText; Text[100])
        {
            ExternalName = 'acwapp_tendertypetext';
            ExternalType = 'String';
            Description = '';
            Caption = 'Tender Type (text)';
        }

        field(56; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(57; acwapp_CompanyName; Text[100])
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
        key(PK; acwapp_tendertypediscountId)
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