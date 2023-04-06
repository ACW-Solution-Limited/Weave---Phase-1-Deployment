table 83121 "CDS acwapp_welcomeamenities"
{
    ExternalName = 'acwapp_welcomeamenities';
    TableType = CDS;
    Description = '';


    fields
    {
        field(1; acwapp_welcomeamenitiesId; GUID)
        {
            ExternalName = 'acwapp_welcomeamenitiesid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Welcome Amenities';
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
            Description = 'Status of the Welcome Amenities';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Welcome Amenities';
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
        field(38; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(40; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(42; acwapp_ProdcutName; Text[100])
        {
            ExternalName = 'acwapp_prodcutname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Prodcut Name';
        }
        field(43; acwapp_Quantity; Integer)
        {
            ExternalName = 'acwapp_quantity';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity';
        }
        field(44; acwapp_UnitPrice; Decimal)
        {
            ExternalName = 'acwapp_unitprice';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Price';
        }
        field(45; acwapp_unitprice_Base; Decimal)
        {
            ExternalName = 'acwapp_unitprice_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Unit Price in base currency.';
            Caption = 'Unit Price (Base)';
        }
        field(46; acwapp_BCStatus; Option)
        {
            ExternalName = 'acwapp_bcstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'BC Status';
            InitValue = " ";
            OptionMembers = " ",Open,Created,Posted;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(48; acwapp_Contact; GUID)
        {
            ExternalName = 'acwapp_contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(51; acwapp_Date; Date)
        {
            ExternalName = 'acwapp_date';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Date';
        }
        field(52; acwapp_Product; GUID)
        {
            ExternalName = 'acwapp_product';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Product';
            TableRelation = "CDS acwapp_product".acwapp_productId;
        }
        field(53; acwapp_ProductName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_product".acwapp_name where(acwapp_productId = field(acwapp_Product)));
            ExternalName = 'acwapp_productname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(54; acwapp_PropertyBooking; GUID)
        {
            ExternalName = 'acwapp_propertybooking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(55; acwapp_PropertyBookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_PropertyBooking)));
            ExternalName = 'acwapp_propertybookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(56; acwapp_Account; GUID)
        {
            ExternalName = 'acwapp_account';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Account';
            TableRelation = "CRM Account".AccountId;
        }
        field(59; acwapp_PaymentStatus; Option)
        {
            ExternalName = 'acwapp_paymentstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Payment Status';
            InitValue = " ";
            OptionMembers = " ",Pending,Overdue,Paid;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(61; acwapp_UnitofMeasure; Text[100])
        {
            ExternalName = 'acwapp_unitofmeasure';
            ExternalType = 'String';
            Description = '';
            Caption = 'Unit of Measure';
        }
        field(62; acwapp_Property; GUID)
        {
            ExternalName = 'acwapp_property';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(63; acwapp_PropertyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Property)));
            ExternalName = 'acwapp_propertyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(64; acwapp_PropertyUnit; GUID)
        {
            ExternalName = 'acwapp_propertyunit';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Unit';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(65; acwapp_PropertyUnitName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_PropertyUnit)));
            ExternalName = 'acwapp_propertyunitname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(66; acwapp_AccountID; Text[100])
        {
            ExternalName = 'acwapp_accountid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Account ID';
        }
        field(67; acwapp_ProductID; Text[100])
        {
            ExternalName = 'acwapp_productid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Product ID';
        }
        field(68; acwapp_ContactID; Text[100])
        {
            ExternalName = 'acwapp_contactid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contact ID';
        }
        field(69; acwapp_ContractNo; Text[100])
        {
            ExternalName = 'acwapp_contractno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract No';
        }
        field(73; acwapp_StripeInvoiceID; Text[100])
        {
            ExternalName = 'acwapp_stripeinvoiceid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Stripe Invoice ID';
        }
        field(77; acwapp_BedroomOffer; GUID)
        {
            ExternalName = 'acwapp_bedroomoffer';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Bedroom Offer';
            TableRelation = "CDS acwapp_bedroomoffer".acwapp_bedroomofferId;
        }
        field(78; acwapp_BedroomOfferName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bedroomoffer".acwapp_name where(acwapp_bedroomofferId = field(acwapp_BedroomOffer)));
            ExternalName = 'acwapp_bedroomoffername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(83; acwapp_CreatedOnBCTesting; Date)
        {
            ExternalName = 'acwapp_createdonbctesting';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Created On (BC Testing)';
        }
        field(84; acwapp_PropertyNo; Text[100])
        {
            ExternalName = 'acwapp_propertyno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property No.';
        }
        field(85; acwapp_NetAmountIncludingVAT; Decimal)
        {
            ExternalName = 'acwapp_netamountincludingvat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Net Amount Including VAT';
        }
        field(86; acwapp_netamountincludingvat_Base; Decimal)
        {
            ExternalName = 'acwapp_netamountincludingvat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Net Amount Including VAT in base currency.';
            Caption = 'Net Amount Including VAT (Base)';
        }
        field(87; acwapp_PaymentLink; Text[100])
        {
            ExternalName = 'acwapp_paymentlink';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Link';
        }
        field(88; acwapp_PostedSalesInvoices; GUID)
        {
            ExternalName = 'acwapp_postedsalesinvoices';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Posted Sales Invoices';
            TableRelation = "CDS acwapp_salesinvoice".acwapp_salesinvoiceId;
        }
        field(89; acwapp_PostedSalesInvoicesName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_salesinvoice".acwapp_name where(acwapp_salesinvoiceId = field(acwapp_PostedSalesInvoices)));
            ExternalName = 'acwapp_postedsalesinvoicesname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(90; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(91; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(94; acwapp_TotalExcludeVAT; Decimal)
        {
            ExternalName = 'acwapp_totalexcludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Total Exclude VAT';
        }
        field(95; acwapp_totalexcludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_totalexcludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Exclude VAT in base currency.';
            Caption = 'Total Exclude VAT (Base)';
        }
        field(96; acwapp_TotalAmountIncludeVAT; Decimal)
        {
            ExternalName = 'acwapp_totalamountincludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Total Amount Include VAT';
        }
        field(97; acwapp_totalamountincludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_totalamountincludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Amount Include VAT in base currency.';
            Caption = 'Total Amount Include VAT (Base)';
        }
    }

    keys
    {
        key(PK; acwapp_welcomeamenitiesId)
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