table 83129 "CDS acwapp_extracharges"
{
    ExternalName = 'acwapp_extracharges';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_extrachargesId; GUID)
        {
            ExternalName = 'acwapp_extrachargesid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Extra Charges';
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
            Description = 'Status of the Extra Charges';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Extra Charges';
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
        field(37; acwapp_PropertyBooking; GUID)
        {
            ExternalName = 'acwapp_propertybooking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(38; acwapp_PropertyBookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_PropertyBooking)));
            ExternalName = 'acwapp_propertybookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(39; acwapp_Contact; GUID)
        {
            ExternalName = 'acwapp_contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(42; acwapp_Account; GUID)
        {
            ExternalName = 'acwapp_account';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Account';
            TableRelation = "CRM Account".AccountId;
        }
        field(45; acwapp_Amount; Decimal)
        {
            ExternalName = 'acwapp_amount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount';
        }
        field(46; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(48; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(49; acwapp_amount_Base; Decimal)
        {
            ExternalName = 'acwapp_amount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount in base currency.';
            Caption = 'Amount (Base)';
        }
        field(50; acwapp_Description; BLOB)
        {
            ExternalName = 'acwapp_description';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Description';
            Subtype = Memo;
        }
        field(51; acwapp_Product; GUID)
        {
            ExternalName = 'acwapp_product';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Product';
            TableRelation = "CDS acwapp_product".acwapp_productId;
        }
        field(52; acwapp_ProductName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_product".acwapp_name where(acwapp_productId = field(acwapp_Product)));
            ExternalName = 'acwapp_productname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(53; acwapp_BCStatus; Option)
        {
            ExternalName = 'acwapp_bcstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'BC Status';
            InitValue = " ";
            OptionMembers = " ",Open,Created,Posted;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(55; acwapp_SalesInvoice; GUID)
        {
            ExternalName = 'acwapp_salesinvoice';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Sales Invoice';
            TableRelation = "CDS acwapp_salesinvoice".acwapp_salesinvoiceId;
        }
        field(56; acwapp_SalesInvoiceName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_salesinvoice".acwapp_name where(acwapp_salesinvoiceId = field(acwapp_SalesInvoice)));
            ExternalName = 'acwapp_salesinvoicename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(57; acwapp_Type; Option)
        {
            ExternalName = 'acwapp_type';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Type';
            InitValue = " ";
            OptionMembers = " ",Deposit,ExtraCharge,AdminFee;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(59; acwapp_ID; Text[100])
        {
            ExternalName = 'acwapp_id';
            ExternalType = 'String';
            Description = '';
            Caption = 'ID';
        }
        field(60; acwapp_ProductType; GUID)
        {
            ExternalName = 'acwapp_producttype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Product Type';
            TableRelation = "CDS acwapp_producttype".acwapp_producttypeId;
        }
        field(61; acwapp_ProductTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_producttype".acwapp_name where(acwapp_producttypeId = field(acwapp_ProductType)));
            ExternalName = 'acwapp_producttypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(62; acwapp_ProductID; Text[100])
        {
            ExternalName = 'acwapp_productid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Product ID';
        }
        field(63; acwapp_AccountID; Text[100])
        {
            ExternalName = 'acwapp_accountid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Account ID';
        }
        field(64; acwapp_ContactID; Text[100])
        {
            ExternalName = 'acwapp_contactid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contact ID';
        }
        field(65; acwapp_ContractNo; Text[100])
        {
            ExternalName = 'acwapp_contractno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract No.';
        }
        field(66; acwapp_StripeInvoiceID; Text[100])
        {
            ExternalName = 'acwapp_stripeinvoiceid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Stripe Invoice ID';
        }
        field(67; acwapp_PostedSalesInvoiceNo; Text[100])
        {
            ExternalName = 'acwapp_postedsalesinvoiceno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Posted Sales Invoice No.';
        }
        field(68; acwapp_ChargesType; Option)
        {
            ExternalName = 'acwapp_chargestype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Charges Type';
            InitValue = " ";
            OptionMembers = " ",Deposit,AdHoc,"EarlyMove-in",Extension;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002, 557130003;
        }
        field(72; acwapp_CreatedOn; Date)
        {
            ExternalName = 'acwapp_createdon';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Created On (BC testing)';
        }
        field(73; acwapp_PaymentLink; Text[2048])
        {
            ExternalName = 'acwapp_paymentlink';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Link';
        }
        field(74; acwapp_PropertyNo; Text[100])
        {
            ExternalName = 'acwapp_propertyno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property No.';
        }
        field(75; acwapp_PostedSalesInvoices; GUID)
        {
            ExternalName = 'acwapp_postedsalesinvoices';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Posted Sales Invoices';
            TableRelation = "CDS acwapp_salesinvoice".acwapp_salesinvoiceId;
        }
        field(77; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(78; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(80; acwapp_NewContractStartDate; Datetime)
        {
            ExternalName = 'acwapp_newcontractstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'New Contract Start Date';
        }
        field(81; acwapp_NewContractEndDate; Datetime)
        {
            ExternalName = 'acwapp_newcontractenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'New Contract End Date';
        }
        field(82; acwapp_AmountIncludeGST; Decimal)
        {
            ExternalName = 'acwapp_amountincludegst';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount Include GST';
        }
        field(83; acwapp_amountincludegst_Base; Decimal)
        {
            ExternalName = 'acwapp_amountincludegst_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount Include GST in base currency.';
            Caption = 'Amount Include GST (Base)';
        }
        field(84; acwapp_Status; Option)
        {
            ExternalName = 'acwapp_status';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Status';
            InitValue = Pending;
            OptionMembers = Pending,Confirmed,Settled;
            OptionOrdinalValues = 557130000, 557130001, 557130003;
        }
        field(89; acwapp_ExtensionStartDate; Date)
        {
            ExternalName = 'acwapp_extensionstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Extension Start Date';
        }
        field(90; acwapp_ExtensionEndDate; Date)
        {
            ExternalName = 'acwapp_extensionenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Extension End Date';
        }
        field(91; acwapp_Descriptionnew; Text[1000])
        {
            ExternalName = 'acwapp_descriptionnew';
            ExternalType = 'String';
            Description = '';
            Caption = 'Description New';
        }

    }
    keys
    {
        key(PK; acwapp_extrachargesId)
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