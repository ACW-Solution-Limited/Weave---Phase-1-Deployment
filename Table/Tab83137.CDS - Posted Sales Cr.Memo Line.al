table 83137 "CDS acwapp_postedsalescmLine"
{
    ExternalName = 'acwapp_postedsalescreditmemoline';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_postedsalescreditmemolineId; GUID)
        {
            ExternalName = 'acwapp_postedsalescreditmemolineid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Posted Sales Credit Memo Line';
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
        field(16; OrganizationId; GUID)
        {
            ExternalName = 'organizationid';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier for the organization';
            Caption = 'Organization Id';
            TableRelation = "CRM Organization".OrganizationId;
        }
        field(18; statecode; Option)
        {
            ExternalName = 'statecode';
            ExternalType = 'State';
            ExternalAccess = Modify;
            Description = 'Status of the Posted Sales Credit Memo Line';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(20; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Posted Sales Credit Memo Line';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 1, 2;
        }
        field(22; VersionNumber; BigInteger)
        {
            ExternalName = 'versionnumber';
            ExternalType = 'BigInt';
            ExternalAccess = Read;
            Description = 'Version Number';
            Caption = 'Version Number';
        }
        field(23; ImportSequenceNumber; Integer)
        {
            ExternalName = 'importsequencenumber';
            ExternalType = 'Integer';
            ExternalAccess = Insert;
            Description = 'Sequence number of the import that created this record.';
            Caption = 'Import Sequence Number';
        }
        field(24; OverriddenCreatedOn; Date)
        {
            ExternalName = 'overriddencreatedon';
            ExternalType = 'DateTime';
            ExternalAccess = Insert;
            Description = 'Date and time that the record was migrated.';
            Caption = 'Record Created On';
        }
        field(25; TimeZoneRuleVersionNumber; Integer)
        {
            ExternalName = 'timezoneruleversionnumber';
            ExternalType = 'Integer';
            Description = 'For internal use only.';
            Caption = 'Time Zone Rule Version Number';
        }
        field(26; UTCConversionTimeZoneCode; Integer)
        {
            ExternalName = 'utcconversiontimezonecode';
            ExternalType = 'Integer';
            Description = 'Time zone code that was in use when the record was created.';
            Caption = 'UTC Conversion Time Zone Code';
        }
        field(27; acwapp_name; Text[100])
        {
            ExternalName = 'acwapp_name';
            ExternalType = 'String';
            Description = 'The name of the custom entity.';
            Caption = 'Name';
        }
        field(28; acwapp_SalesCreditMemoNo; Text[100])
        {
            ExternalName = 'acwapp_salescreditmemono';
            ExternalType = 'String';
            Description = '';
            Caption = 'Sales Credit Memo No.';
        }
        field(29; acwapp_InvoiceNo; Text[100])
        {
            ExternalName = 'acwapp_invoiceno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Invoice No.';
        }
        field(30; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(31; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(32; acwapp_LineNo; Text[100])
        {
            ExternalName = 'acwapp_lineno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Line No.';
        }
        field(33; acwapp_Type; Text[100])
        {
            ExternalName = 'acwapp_type';
            ExternalType = 'String';
            Description = '';
            Caption = 'Type';
        }
        field(34; acwapp_InvoiceDescription; Text[100])
        {
            ExternalName = 'acwapp_invoicedescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'Invoice Description';
        }
        field(35; acwapp_Quantity; Integer)
        {
            ExternalName = 'acwapp_quantity';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity';
        }
        field(36; acwapp_UnitPriceIncludeVAT; Decimal)
        {
            ExternalName = 'acwapp_unitpriceincludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Unit Price Include VAT';
        }
        field(37; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(39; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(40; acwapp_unitpriceincludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_unitpriceincludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Unit Price Include VAT in base currency.';
            Caption = 'Unit Price Include VAT (Base)';
        }
        field(41; acwapp_UnitPriceExcludeVAT; Decimal)
        {
            ExternalName = 'acwapp_unitpriceexcludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Unit Price Exclude VAT';
        }
        field(42; acwapp_unitpriceexcludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_unitpriceexcludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Unit Price Exclude VAT in base currency.';
            Caption = 'Unit Price Exclude VAT (Base)';
        }
        field(43; acwapp_TotalAmountIncludeVAT; Decimal)
        {
            ExternalName = 'acwapp_totalamountincludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Total Amount Include VAT';
        }
        field(44; acwapp_totalamountincludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_totalamountincludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Amount Include VAT in base currency.';
            Caption = 'Total Amount Include VAT (Base)';
        }
        field(45; acwapp_GST; Text[100])
        {
            ExternalName = 'acwapp_gst';
            ExternalType = 'String';
            Description = '';
            Caption = 'GST%';
        }
        field(46; acwapp_TotalAmountExcludeVAT; Decimal)
        {
            ExternalName = 'acwapp_totalamountexcludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Total Amount Exclude VAT';
        }
        field(47; acwapp_totalamountexcludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_totalamountexcludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Amount Exclude VAT in base currency.';
            Caption = 'Total Amount Exclude VAT (Base)';
        }
        field(48; acwapp_PostedSalesCreditMemo; GUID)
        {
            ExternalName = 'acwapp_postedsalescreditmemo';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Posted Sales Credit Memo';
            TableRelation = "CDS acwapp_postedsalescreditmemo".acwapp_postedsalescreditmemoId;
        }
        field(49; acwapp_PostedSalesCreditMemoName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_postedsalescreditmemo".acwapp_name where(acwapp_postedsalescreditmemoId = field(acwapp_PostedSalesCreditMemo)));
            ExternalName = 'acwapp_postedsalescreditmemoname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(52; acwapp_InvoicePeriodFrom; Date)
        {
            ExternalName = 'acwapp_invoiceperiodfrom';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Invoice Period From';
        }
        field(53; acwapp_InvoicePeriodTo; Date)
        {
            ExternalName = 'acwapp_invoiceperiodto';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Invoice Period To';
        }
    }
    keys
    {
        key(PK; acwapp_postedsalescreditmemolineId)
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