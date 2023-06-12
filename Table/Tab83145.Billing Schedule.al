table 83145 "CDS acwapp_billingschedule"
{
    ExternalName = 'acwapp_billingschedule';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_billingscheduleId; GUID)
        {
            ExternalName = 'acwapp_billingscheduleid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Billing Schedule';
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
            Description = 'Status of the Billing Schedule';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Billing Schedule';
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
        field(35; acwapp_PostingDate; Date)
        {
            ExternalName = 'acwapp_postingdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Posting Date';
        }
        field(36; acwapp_DueDate; Date)
        {
            ExternalName = 'acwapp_duedate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Due Date';
        }
        field(37; acwapp_ContractStartDate; Date)
        {
            ExternalName = 'acwapp_contractstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract Start Date';
        }
        field(38; acwapp_ContractEndDate; Date)
        {
            ExternalName = 'acwapp_contractenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract End Date';
        }
        field(39; acwapp_AmountExcludingVAT; Decimal)
        {
            ExternalName = 'acwapp_amountexcludingvat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Amount Excluding VAT';
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
        field(43; acwapp_amountexcludingvat_Base; Decimal)
        {
            ExternalName = 'acwapp_amountexcludingvat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Amount Excluding VAT in base currency.';
            Caption = 'Amount Excluding VAT (Base)';
        }
        field(44; acwapp_NoofDaystoBill; Integer)
        {
            ExternalName = 'acwapp_noofdaystobill';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'No. of Days to Bill';
        }
        field(45; acwapp_NoofDaysCurrentMonth; Integer)
        {
            ExternalName = 'acwapp_noofdayscurrentmonth';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'No. of Days Current Month';
        }
        field(46; acwapp_AdditionalItemSalesDate; Date)
        {
            ExternalName = 'acwapp_additionalitemsalesdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Additional Item Sales Date';
        }
        field(47; acwapp_AdditionalSalesItemNo; Text[100])
        {
            ExternalName = 'acwapp_additionalsalesitemno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Additional Sales Item No.';
        }
        field(48; acwapp_AdditionalSalesItemQuantity; Integer)
        {
            ExternalName = 'acwapp_additionalsalesitemquantity';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Additional Sales Item Quantity';
        }
        field(49; acwapp_AdditionalSalesItemUnitPrice; Decimal)
        {
            ExternalName = 'acwapp_additionalsalesitemunitprice';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Additional Sales Item Unit Price';
        }
        field(50; acwapp_additionalsalesitemunitprice_Base; Decimal)
        {
            ExternalName = 'acwapp_additionalsalesitemunitprice_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Additional Sales Item Unit Price in base currency.';
            Caption = 'Additional Sales Item Unit Price (Base)';
        }
        field(51; acwapp_DocumentNo; Text[100])
        {
            ExternalName = 'acwapp_documentno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Document No.';
        }
        field(52; acwapp_SalesInvoiceCreationDate; Datetime)
        {
            ExternalName = 'acwapp_salesinvoicecreationdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Sales Invoice Creation Date';
        }
        field(53; acwapp_ContractNo; Text[100])
        {
            ExternalName = 'acwapp_contractno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract No.';
        }
        field(54; acwapp_ContractLineNo; Text[100])
        {
            ExternalName = 'acwapp_contractlineno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract Line No.';
        }
        field(55; acwapp_ExternalPaymentGateway; Text[100])
        {
            ExternalName = 'acwapp_externalpaymentgateway';
            ExternalType = 'String';
            Description = '';
            Caption = 'External Payment Gateway';
        }
        field(56; acwapp_StripeQFPayInvoiceID; Text[100])
        {
            ExternalName = 'acwapp_stripeqfpayinvoiceid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Stripe/QFPay Invoice ID';
        }
        field(57; acwapp_Type; Option)
        {
            ExternalName = 'acwapp_type';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Type';
            InitValue = " ";
            OptionMembers = " ",Deposit,Rent,Item;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(59; acwapp_SubType; Text[100])
        {
            ExternalName = 'acwapp_subtype';
            ExternalType = 'String';
            Description = '';
            Caption = 'Sub-Type';
        }
        field(60; acwapp_DocumentType; Option)
        {
            ExternalName = 'acwapp_documenttype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Document Type';
            InitValue = " ";
            OptionMembers = " ",Invoice,CreditMemo;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
        field(62; acwapp_Status; Option)
        {
            ExternalName = 'acwapp_status';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Blank,Created,Posted,Renewed;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002, 557130003;
        }
        field(64; acwapp_ID; Text[100])
        {
            ExternalName = 'acwapp_id';
            ExternalType = 'String';
            Description = '';
            Caption = 'ID';
        }
    }
    keys
    {
        key(PK; acwapp_billingscheduleId)
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