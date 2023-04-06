table 83117 "CDS acwapp_promotioncode"
{
    ExternalName = 'acwapp_promotioncode';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_promotioncodeId; GUID)
        {
            ExternalName = 'acwapp_promotioncodeid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Promotion Guid';
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
            Description = 'Status of the Promotion Code';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Promotion Code';
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
            Caption = 'Promotion Code';
        }
        field(36; acwapp_Description; BLOB)
        {
            ExternalName = 'acwapp_description';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Description';
            Subtype = Memo;
        }
        field(37; acwapp_EffectiveStartDate; Date)
        {
            ExternalName = 'acwapp_effectivestartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Effective Start Date';
        }
        field(38; acwapp_EffectiveEndDate; Date)
        {
            ExternalName = 'acwapp_effectiveenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Effective End Date';
        }
        field(39; acwapp_PriceDeductionType; Option)
        {
            ExternalName = 'acwapp_pricedeductiontype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Price Deduction Type';
            InitValue = " ";
            OptionMembers = " ",ByPercentage,ByExactDollarValue;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
        field(42; acwapp_DeductionAmount; Decimal)
        {
            ExternalName = 'acwapp_deductionamount';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Deduction Amount';
        }
        field(43; acwapp_DeductionPercentage; Decimal)
        {
            ExternalName = 'acwapp_deductionpercentage';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Deduction Percentage (%)';
        }
        field(45; acwapp_RemainingQuota; Integer)
        {
            ExternalName = 'acwapp_remainingquota';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Remaining Quota';
        }
        field(47; acwapp_TotalQuota; Integer)
        {
            ExternalName = 'acwapp_totalquota';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Total Quota';
        }
        field(51; acwapp_UsageQuota; Integer)
        {
            ExternalName = 'acwapp_usagequota';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Usage Quota';
        }
        field(52; acwapp_UsageQuota_Date; Datetime)
        {
            ExternalName = 'acwapp_usagequota_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Usage Quota.';
            Caption = 'Usage Quota (Last Updated On)';
        }
        field(53; acwapp_UsageQuota_State; Integer)
        {
            ExternalName = 'acwapp_usagequota_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Usage Quota.';
            Caption = 'Usage Quota (State)';
        }
        field(54; acwapp_RenewalPromotionCode; Boolean)
        {
            ExternalName = 'acwapp_renewalpromotioncode';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Renewal Promotion Code';
        }
        field(56; acwapp_TriggerPoint; Option)
        {
            ExternalName = 'acwapp_triggerpoint';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Trigger Point';
            InitValue = " ";
            OptionMembers = " ","EstimatedMove-inDate",BookingDate;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
        field(58; acwapp_ChargeType; Option)
        {
            ExternalName = 'acwapp_chargetype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Charge Type';
            InitValue = " ";
            OptionMembers = " ","Pre-paid","One-off(ShortStay)",Monthly;
            OptionOrdinalValues = -1, 557130002, 557130000, 557130001;
        }
        field(60; acwapp_PromotionCodeChargeType; Option)
        {
            ExternalName = 'acwapp_promotioncodechargetype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Promotion Code Charge Type';
            InitValue = " ";
            OptionMembers = " ",FirstMonth,Monthly;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
    }
    keys
    {
        key(PK; acwapp_promotioncodeId)
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