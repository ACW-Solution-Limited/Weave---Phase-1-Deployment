table 83136 "CDS acwapp_postedsalescreditmemo"
{
    ExternalName = 'acwapp_postedsalescreditmemo';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_postedsalescreditmemoId; GUID)
        {
            ExternalName = 'acwapp_postedsalescreditmemoid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Posted Sales Credit Memo';
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
            Description = 'Status of the Posted Sales Credit Memo';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(20; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Posted Sales Credit Memo';
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
        field(29; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(33; acwapp_Customer; GUID)
        {
            ExternalName = 'acwapp_customer';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Customer';
            TableRelation = "CRM Account".AccountId;
        }
        field(36; acwapp_CustomerID; Text[100])
        {
            ExternalName = 'acwapp_customerid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Customer ID';
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
        field(39; acwapp_ContractNo; Text[100])
        {
            ExternalName = 'acwapp_contractno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract No.';
        }
        field(40; acwapp_ContractStartDate; Date)
        {
            ExternalName = 'acwapp_contractstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract Start Date';
        }
        field(41; acwapp_ContractEndDate; Date)
        {
            ExternalName = 'acwapp_contractenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract End Date';
        }
        field(42; acwapp_TerminationDate; Date)
        {
            ExternalName = 'acwapp_terminationdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Termination Date';
        }
        field(43; acwapp_PostingDate; Date)
        {
            ExternalName = 'acwapp_postingdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Posting Date';
        }
        field(44; acwapp_DueDate; Date)
        {
            ExternalName = 'acwapp_duedate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Due Date';
        }
        field(45; acwapp_AmountExcludingVAT; Decimal)
        {
            ExternalName = 'acwapp_amountexcludingvat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount Excluding VAT';
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
        field(49; acwapp_amountexcludingvat_Base; Decimal)
        {
            ExternalName = 'acwapp_amountexcludingvat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount Excluding VAT in base currency.';
            Caption = 'Amount Excluding VAT (Base)';
        }
        field(50; acwapp_AmountIncludingVAT; Decimal)
        {
            ExternalName = 'acwapp_amountincludingvat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount Including VAT';
        }
        field(51; acwapp_amountincludingvat_Base; Decimal)
        {
            ExternalName = 'acwapp_amountincludingvat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount Including VAT in base currency.';
            Caption = 'Amount Including VAT (Base)';
        }
        field(52; acwapp_PaymentStatus; Option)
        {
            ExternalName = 'acwapp_paymentstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Payment Status';
            InitValue = " ";
            OptionMembers = " ",Pending,Overdue,Paid;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(54; acwapp_BlobURL; Text[1000])
        {
            ExternalName = 'acwapp_bloburl';
            ExternalType = 'String';
            Description = '';
            Caption = 'Blob URL';
        }
        field(55; acwapp_PaymentLink; Text[1000])
        {
            ExternalName = 'acwapp_paymentlink';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Link';
        }
    }
    keys
    {
        key(PK; acwapp_postedsalescreditmemoId)
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