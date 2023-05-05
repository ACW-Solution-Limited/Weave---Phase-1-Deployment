table 83134 "CDS acwapp_postedsalesinvoiceline"
{
    ExternalName = 'acwapp_postedsalesinvoiceline';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_postedsalesinvoicelineId; GUID)
        {
            ExternalName = 'acwapp_postedsalesinvoicelineid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Posted Sales Invoice Line';
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
            Description = 'Status of the Posted Sales Invoice Line';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(20; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Posted Sales Invoice Line';
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
        field(28; acwapp_InvoiceNo; GUID)
        {
            ExternalName = 'acwapp_invoiceno';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Invoice No.';
            TableRelation = "CDS acwapp_salesinvoice".acwapp_salesinvoiceId;
        }
        field(29; acwapp_InvoiceNoName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_salesinvoice".acwapp_name where(acwapp_salesinvoiceId = field(acwapp_InvoiceNo)));
            ExternalName = 'acwapp_invoicenoname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(30; acwapp_LineNo; Integer)
        {
            ExternalName = 'acwapp_lineno';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Line No.';
        }
        field(31; acwapp_Description; Text[100])
        {
            ExternalName = 'acwapp_description';
            ExternalType = 'String';
            Description = '';
            Caption = 'Description';
        }
        field(32; acwapp_InvoiceDescription; Text[100])
        {
            ExternalName = 'acwapp_invoicedescription';
            ExternalType = 'String';
            Description = '';
            Caption = 'Invoice Description';
        }
        field(33; acwapp_Quantity; Integer)
        {
            ExternalName = 'acwapp_quantity';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity';
        }
        field(34; acwapp_UnitPrice; Decimal)
        {
            ExternalName = 'acwapp_unitprice';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Unit Price';
        }
        field(35; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(37; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(38; acwapp_unitprice_Base; Decimal)
        {
            ExternalName = 'acwapp_unitprice_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Unit Price in base currency.';
            Caption = 'Unit Price (Base)';
        }
        field(39; acwapp_UnitPriceIncludingVAT; Decimal)
        {
            ExternalName = 'acwapp_unitpriceincludingvat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Unit Price Including VAT';
        }
        field(40; acwapp_unitpriceincludingvat_Base; Decimal)
        {
            ExternalName = 'acwapp_unitpriceincludingvat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Unit Price Including VAT in base currency.';
            Caption = 'Unit Price Including VAT (Base)';
        }
        field(41; acwapp_TotalAmount; Decimal)
        {
            ExternalName = 'acwapp_totalamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Total Amount';
        }
        field(42; acwapp_totalamount_Base; Decimal)
        {
            ExternalName = 'acwapp_totalamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Amount in base currency.';
            Caption = 'Total Amount (Base)';
        }
        field(43; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(44; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(45; acwapp_Type; Text[100])
        {
            ExternalName = 'acwapp_type';
            ExternalType = 'String';
            Description = '';
            Caption = 'Type';
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
        field(49; acwapp_GST; Decimal)
        {
            ExternalName = 'acwapp_gst';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'GST%';
        }
        field(53; acwapp_InvoicePeriodFrom; Date)
        {
            ExternalName = 'acwapp_invoiceperiodfrom';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Invoice Period From';
        }
        field(54; acwapp_InvoicePeriodTo; Date)
        {
            ExternalName = 'acwapp_invoiceperiodto';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Invoice Period To';
        }
 field(58; acwapp_BillingScheduleType; Option)
    {
      ExternalName = 'acwapp_billingscheduletype';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Billing Schedule Type';
      InitValue = " ";
      OptionMembers = " ", Deposit, Rent, Item;
      OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
    }
    field(60; acwapp_BillingScheduleSubType; Text[100])
    {
      ExternalName = 'acwapp_billingschedulesubtype';
      ExternalType = 'String';
      Description = '';
      Caption = 'Billing Schedule Sub-Type';
    }
    field(61; acwapp_ExtensionStartDate; Date)
    {
      ExternalName = 'acwapp_extensionstartdate';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Extension Start Date';
    }
    field(62; acwapp_ExtensionEndDate; Date)
    {
      ExternalName = 'acwapp_extensionenddate';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Extension End Date';
    }
        field(67; acwapp_PaymentReferenceID; Text[100])
        {
            ExternalName = 'acwapp_paymentreferenceid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Reference ID';
        }
    }
    keys
    {
        key(PK; acwapp_postedsalesinvoicelineId)
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