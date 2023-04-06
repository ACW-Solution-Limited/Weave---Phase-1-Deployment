table 83133 "CDS acwapp_salesinvoice"
{
    ExternalName = 'acwapp_salesinvoice';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_salesinvoiceId; GUID)
        {
            ExternalName = 'acwapp_salesinvoiceid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Sales Invoice';
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
            Description = 'Status of the Sales Invoice';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Sales Invoice';
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
            Caption = 'Sales Invoice No.';
        }
        field(35; acwapp_Customer; GUID)
        {
            ExternalName = 'acwapp_customer';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Customer';
            TableRelation = "CRM Account".AccountId;
        }
        field(38; acwapp_PostingDate; Date)
        {
            ExternalName = 'acwapp_postingdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Posting Date';
        }
        field(39; acwapp_DueDate; Date)
        {
            ExternalName = 'acwapp_duedate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Due Date';
        }
        field(40; acwapp_PostedSalesInvoiceURL; Text[100])
        {
            ExternalName = 'acwapp_postedsalesinvoiceurl';
            ExternalType = 'String';
            Description = '';
            Caption = 'Posted Sales Invoice URL';
        }
        field(41; acwapp_PaymentLink; Text[2048])
        {
            ExternalName = 'acwapp_paymentlink';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Link';
        }
        field(42; acwapp_PaymentStatus; Option)
        {
            ExternalName = 'acwapp_paymentstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Payment Status';
            InitValue = " ";
            OptionMembers = " ",Pending,Overdue,Paid;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(46; acwapp_ContractStartDate; Date)
        {
            ExternalName = 'acwapp_contractstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract Start Date';
        }
        field(47; acwapp_ContractEndDate; Date)
        {
            ExternalName = 'acwapp_contractenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract End Date';
        }
        field(48; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(49; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(50; acwapp_BlobURL; Text[100])
        {
            ExternalName = 'acwapp_bloburl';
            ExternalType = 'String';
            Description = '';
            Caption = 'Blob URL';
        }
        field(51; acwapp_Amount; Decimal)
        {
            ExternalName = 'acwapp_amount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount';
        }
        field(52; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(54; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(55; acwapp_amount_Base; Decimal)
        {
            ExternalName = 'acwapp_amount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount in base currency.';
            Caption = 'Amount (Base)';
        }
        field(56; acwapp_PropertyBooking; GUID)
        {
            ExternalName = 'acwapp_propertybooking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(57; acwapp_PropertyBookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_PropertyBooking)));
            ExternalName = 'acwapp_propertybookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(58; acwapp_ContractNo; Text[100])
        {
            ExternalName = 'acwapp_contractno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract No.';
        }
        field(62; acwapp_AmountExcludingVAT; Decimal)
        {
            ExternalName = 'acwapp_amountexcludingvat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount Excluding VAT';
        }
        field(63; acwapp_amountexcludingvat_Base; Decimal)
        {
            ExternalName = 'acwapp_amountexcludingvat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount Excluding VAT in base currency.';
            Caption = 'Amount Excluding VAT (Base)';
        }
        field(64; acwapp_CustomerID; Text[100])
        {
            ExternalName = 'acwapp_customerid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Customer ID';
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
        key(PK; acwapp_salesinvoiceId)
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