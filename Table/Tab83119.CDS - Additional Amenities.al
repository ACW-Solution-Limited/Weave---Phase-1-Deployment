table 83119 "CDS acwapp_additionalamenities"
{
    ExternalName = 'acwapp_additionalamenities';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_additionalamenitiesId; GUID)
        {
            ExternalName = 'acwapp_additionalamenitiesid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Additional Amenities';
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
            Description = 'Status of the Additional Amenities';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Additional Amenities';
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
        field(35; acwapp_Booking; GUID)
        {
            ExternalName = 'acwapp_booking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(36; acwapp_BookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_Booking)));
            ExternalName = 'acwapp_bookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(43; acwapp_WorkOrder; GUID)
        {
            ExternalName = 'acwapp_workorder';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Work Order';
            TableRelation = "CDS acwapp_workorder".acwapp_workorderId;
        }
        field(44; acwapp_WorkOrderName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_workorder".acwapp_name where(acwapp_workorderId = field(acwapp_WorkOrder)));
            ExternalName = 'acwapp_workordername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(45; acwapp_Contact; GUID)
        {
            ExternalName = 'acwapp_contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(48; acwapp_Quantity; Integer)
        {
            ExternalName = 'acwapp_quantity';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Quantity';
        }
        field(49; acwapp_Price; Decimal)
        {
            ExternalName = 'acwapp_price';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Unit Price';
        }
        field(50; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(52; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(53; acwapp_price_Base; Decimal)
        {
            ExternalName = 'acwapp_price_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Price in base currency.';
            Caption = 'Price (Base)';
        }
        field(54; acwapp_Date; DateTime)
        {
            ExternalName = 'acwapp_date';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Start Date';
        }
        field(55; acwapp_BCStatus; Option)
        {
            ExternalName = 'acwapp_bcstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'BC Status';
            InitValue = " ";
            OptionMembers = " ",Open,Created,Posted;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(57; acwapp_Account; GUID)
        {
            ExternalName = 'acwapp_account';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Account';
            TableRelation = "CRM Account".AccountId;
        }
        field(60; acwapp_PaymentStatus; Option)
        {
            ExternalName = 'acwapp_paymentstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Payment Status';
            InitValue = " ";
            OptionMembers = " ",Pending,Overdue,Paid;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        // field(62; acwapp_EndDate; Date)
        // {
        //     ExternalName = 'acwapp_enddate';
        //     ExternalType = 'DateTime';
        //     Description = '';
        //     Caption = 'End Date';
        // }
        field(63; acwapp_Product; GUID)
        {
            ExternalName = 'acwapp_product';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Product';
            TableRelation = "CDS acwapp_product".acwapp_productId;
        }
        field(64; acwapp_ProductName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_product".acwapp_name where(acwapp_productId = field(acwapp_Product)));
            ExternalName = 'acwapp_productname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(65; acwapp_UnitofMeasure; Text[100])
        {
            ExternalName = 'acwapp_unitofmeasure';
            ExternalType = 'String';
            Description = '';
            Caption = 'Unit of Measure';
        }
        field(66; acwapp_TotalAmount; Decimal)
        {
            ExternalName = 'acwapp_totalamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Total Amount';
        }
        field(67; acwapp_totalamount_Base; Decimal)
        {
            ExternalName = 'acwapp_totalamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Amount in base currency.';
            Caption = 'Total Amount (Base)';
        }
        field(68; acwapp_Property; GUID)
        {
            ExternalName = 'acwapp_property';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(69; acwapp_PropertyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Property)));
            ExternalName = 'acwapp_propertyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(70; acwapp_PropertyUnit; GUID)
        {
            ExternalName = 'acwapp_propertyunit';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Unit';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(71; acwapp_PropertyUnitName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_PropertyUnit)));
            ExternalName = 'acwapp_propertyunitname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(72; acwapp_AccountID; Text[100])
        {
            ExternalName = 'acwapp_accountid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Account ID';
        }
        field(73; acwapp_ContactID; Text[100])
        {
            ExternalName = 'acwapp_contactid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contact ID';
        }
        field(74; acwapp_ContractNo; Text[100])
        {
            ExternalName = 'acwapp_contractno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract No';
        }
        field(75; acwapp_ProductID; Text[100])
        {
            ExternalName = 'acwapp_productid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Product ID';
        }
        field(76; acwapp_PostedSalesInvoice; GUID)
        {
            ExternalName = 'acwapp_postedsalesinvoice';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Posted Sales Invoice';
            TableRelation = "CDS acwapp_salesinvoice".acwapp_salesinvoiceId;
        }
        field(77; acwapp_PostedSalesInvoiceName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_salesinvoice".acwapp_name where(acwapp_salesinvoiceId = field(acwapp_PostedSalesInvoice)));
            ExternalName = 'acwapp_postedsalesinvoicename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(78; acwapp_StripeInvoiceID; Text[100])
        {
            ExternalName = 'acwapp_stripeinvoiceid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Stripe Invoice ID';
        }
        field(79; acwapp_PostedSalesInvoiceNo; Text[100])
        {
            ExternalName = 'acwapp_postedsalesinvoiceno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Posted Sales Invoice No.';
        }
        field(82; acwapp_BillingScheduleLineNo; Integer)
        {
            ExternalName = 'acwapp_billingschedulelineno';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Billing Schedule Line No.';
        }

        field(83; acwapp_CreatedOn; Date)
        {
            ExternalName = 'acwapp_createdon';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Created On (BC testibng)';
        }
        field(84; acwapp_PropertyNo; Text[100])
        {
            ExternalName = 'acwapp_propertyno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property No.';
        }
        field(85; acwapp_enddate; Datetime)
        {
            ExternalName = 'acwapp_enddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'End Date';
        }
        field(86; acwapp_NetAmountIncludingVAT; Decimal)
        {
            ExternalName = 'acwapp_netamountincludingvat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Net Amount Including VAT';
        }
        field(87; acwapp_netamountincludingvat_Base; Decimal)
        {
            ExternalName = 'acwapp_netamountincludingvat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Net Amount Including VAT in base currency.';
            Caption = 'Net Amount Including VAT (Base)';
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
        field(90; acwapp_PaymentLink; Text[100])
        {
            ExternalName = 'acwapp_paymentlink';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Link';
        }
        field(91; acwapp_APIGenerateNumber; Text[100])
        {
            ExternalName = 'acwapp_apigeneratenumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'API Generate Number';
        }
        field(92; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(93; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(94; acwapp_TotalAmountCal; Decimal)
        {
            ExternalName = 'acwapp_totalamountcal';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Amount (Cal)';
        }
        field(95; acwapp_totalamountcal_Base; Decimal)
        {
            ExternalName = 'acwapp_totalamountcal_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Amount (Cal) in base currency.';
            Caption = 'Total Amount (Cal) (Base)';
        }
        field(102; acwapp_TotalAmountExcludeVAT; Decimal)
        {
            ExternalName = 'acwapp_totalamountexcludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Total Amount Exclude VAT';
        }
        field(103; acwapp_totalamountexcludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_totalamountexcludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Amount Exclude VAT in base currency.';
            Caption = 'Total Amount Exclude VAT (Base)';
        }
        field(106; acwapp_Status; Option)
        {
            ExternalName = 'acwapp_status';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Pending,Confirmed;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }



    }
    keys
    {
        key(PK; acwapp_additionalamenitiesId)
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