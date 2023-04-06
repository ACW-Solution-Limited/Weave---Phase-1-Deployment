table 83131 "CDS acwapp_expenseclaim"
{
    ExternalName = 'acwapp_expenseclaim';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_expenseclaimId; GUID)
        {
            ExternalName = 'acwapp_expenseclaimid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Expense Claim';
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
            Description = 'Status of the Expense Claim';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Expense Claim';
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
        field(35; acwapp_Staff; GUID)
        {
            ExternalName = 'acwapp_staff';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Staff';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(38; acwapp_Departure; GUID)
        {
            ExternalName = 'acwapp_departure';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Departure';
            TableRelation = "CRM Businessunit".BusinessUnitId;
        }
        field(40; acwapp_ClaimDate; Date)
        {
            ExternalName = 'acwapp_claimdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Claim Date';
        }
        field(41; acwapp_Description; Text[100])
        {
            ExternalName = 'acwapp_description';
            ExternalType = 'String';
            Description = '';
            Caption = 'Description';
        }
        field(42; acwapp_UnitPrice; Decimal)
        {
            ExternalName = 'acwapp_unitprice';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Unit Price';
        }
        field(43; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(45; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(46; acwapp_unitprice_Base; Decimal)
        {
            ExternalName = 'acwapp_unitprice_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Unit Price in base currency.';
            Caption = 'Unit Price (Base)';
        }
        field(47; acwapp_AttachmentId; GUID)
        {
            ExternalName = 'acwapp_attachmentid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Read;
        }
        field(53; acwapp_ApprovedBy; GUID)
        {
            ExternalName = 'acwapp_approvedby';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Approved By';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(56; acwapp_PaymentDate; Date)
        {
            ExternalName = 'acwapp_paymentdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Payment Date';
        }
        field(57; acwapp_ApprovalStatus; Option)
        {
            ExternalName = 'acwapp_approvalstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Approval Status';
            InitValue = " ";
            OptionMembers = " ",Submitted,Approved,Paid,Rejected,Cancelled,Posted;
            OptionOrdinalValues = -1, 805110000, 805110003, 557130000, 805110001, 805110002, 805110004;
        }
        field(61; acwapp_ExpenseID; Text[14])
        {
            ExternalName = 'acwapp_expenseid';
            ExternalType = 'String';
            Description = '';
            Caption = 'ExpenseID';
        }
        field(62; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(63; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(64; acwapp_ExpenseType; GUID)
        {
            ExternalName = 'acwapp_expensetype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Expense Type';
            TableRelation = "CDS acwapp_expensetype".acwapp_expensetypeId;
        }
        field(65; acwapp_ExpenseTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_expensetype".acwapp_name where(acwapp_expensetypeId = field(acwapp_ExpenseType)));
            ExternalName = 'acwapp_expensetypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(66; acwapp_BCStatus; Option)
        {
            ExternalName = 'acwapp_bcstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'BC Status';
            InitValue = " ";
            OptionMembers = " ",Open,Created,Posted;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(68; acwapp_ExpenseClaimName; Text[100])
        {
            ExternalName = 'acwapp_expenseclaimname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Expense Claim Name';
        }
        field(69; acwapp_StaffEmail; Text[100])
        {
            ExternalName = 'acwapp_staffemail';
            ExternalType = 'String';
            Description = '';
            Caption = 'Staff Email';
        }
        field(70; acwapp_PurchaseOrder; Text[100])
        {
            ExternalName = 'acwapp_purchaseorder';
            ExternalType = 'String';
            Description = '';
            Caption = 'Purchase Order';
        }
        field(71; acwapp_PurchaseOrderLineNo; Integer)
        {
            ExternalName = 'acwapp_purchaseorderlineno';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Purchase Order Line No.';
        }
        field(72; acwapp_CompanyNameBC; Text[100])
        {
            ExternalName = 'acwapp_companynamebc';
            ExternalType = 'String';
            Description = '';
            Caption = 'Company Name';
        }

        field(78; acwapp_ExpenseClaimLocation; Option)
        {
            ExternalName = 'acwapp_expenseclaimlocation';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Claim Master Location';
            InitValue = " ";
            OptionMembers = " ",HongKong,Singapore;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }

    }
    keys
    {
        key(PK; acwapp_expenseclaimId)
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