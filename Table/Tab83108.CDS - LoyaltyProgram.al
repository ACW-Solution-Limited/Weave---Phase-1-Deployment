table 83108 "CDS acwapp_loyalprogram"
{
  ExternalName = 'acwapp_loyalprogram';
  TableType = CDS;
  Description = '';

  fields
  {
    field(1;acwapp_loyalprogramId;GUID)
    {
      ExternalName = 'acwapp_loyalprogramid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Insert;
      Description = 'Unique identifier for entity instances';
      Caption = 'Loyalty Program';
    }
    field(2;CreatedOn;Datetime)
    {
      ExternalName = 'createdon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Date and time when the record was created.';
      Caption = 'Created On';
    }
    field(3;CreatedBy;GUID)
    {
      ExternalName = 'createdby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier of the user who created the record.';
      Caption = 'Created By';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(4;ModifiedOn;Datetime)
    {
      ExternalName = 'modifiedon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Date and time when the record was modified.';
      Caption = 'Modified On';
    }
    field(5;ModifiedBy;GUID)
    {
      ExternalName = 'modifiedby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier of the user who modified the record.';
      Caption = 'Modified By';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(6;CreatedOnBehalfBy;GUID)
    {
      ExternalName = 'createdonbehalfby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier of the delegate user who created the record.';
      Caption = 'Created By (Delegate)';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(7;ModifiedOnBehalfBy;GUID)
    {
      ExternalName = 'modifiedonbehalfby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier of the delegate user who modified the record.';
      Caption = 'Modified By (Delegate)';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(16;OwnerId;GUID)
    {
      ExternalName = 'ownerid';
      ExternalType = 'Owner';
      Description = 'Owner Id';
      Caption = 'Owner';
    }
    field(21;OwningBusinessUnit;GUID)
    {
      ExternalName = 'owningbusinessunit';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier for the business unit that owns the record';
      Caption = 'Owning Business Unit';
      TableRelation = "CRM Businessunit".BusinessUnitId;
    }
    field(22;OwningUser;GUID)
    {
      ExternalName = 'owninguser';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier for the user that owns the record.';
      Caption = 'Owning User';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(23;OwningTeam;GUID)
    {
      ExternalName = 'owningteam';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier for the team that owns the record.';
      Caption = 'Owning Team';
      TableRelation = "CRM Team".TeamId;
    }
    field(25;statecode;Option)
    {
      ExternalName = 'statecode';
      ExternalType = 'State';
      ExternalAccess = Modify;
      Description = 'Status of the Loyalty Program';
      Caption = 'Status';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 0, 1;
    }
    field(27;statuscode;Option)
    {
      ExternalName = 'statuscode';
      ExternalType = 'Status';
      Description = 'Reason for the status of the Loyalty Program';
      Caption = 'Status Reason';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 1, 2;
    }
    field(29;VersionNumber;BigInteger)
    {
      ExternalName = 'versionnumber';
      ExternalType = 'BigInt';
      ExternalAccess = Read;
      Description = 'Version Number';
      Caption = 'Version Number';
    }
    field(30;ImportSequenceNumber;Integer)
    {
      ExternalName = 'importsequencenumber';
      ExternalType = 'Integer';
      ExternalAccess = Insert;
      Description = 'Sequence number of the import that created this record.';
      Caption = 'Import Sequence Number';
    }
    field(31;OverriddenCreatedOn;Date)
    {
      ExternalName = 'overriddencreatedon';
      ExternalType = 'DateTime';
      ExternalAccess = Insert;
      Description = 'Date and time that the record was migrated.';
      Caption = 'Record Created On';
    }
    field(32;TimeZoneRuleVersionNumber;Integer)
    {
      ExternalName = 'timezoneruleversionnumber';
      ExternalType = 'Integer';
      Description = 'For internal use only.';
      Caption = 'Time Zone Rule Version Number';
    }
    field(33;UTCConversionTimeZoneCode;Integer)
    {
      ExternalName = 'utcconversiontimezonecode';
      ExternalType = 'Integer';
      Description = 'Time zone code that was in use when the record was created.';
      Caption = 'UTC Conversion Time Zone Code';
    }
    field(34;acwapp_name;Text[100])
    {
      ExternalName = 'acwapp_name';
      ExternalType = 'String';
      Description = 'The name of the custom entity.';
      Caption = 'Name';
    }
    field(35;acwapp_AccumulatedPeriod1;GUID)
    {
      ExternalName = 'acwapp_accumulatedperiod1';
      ExternalType = 'Lookup';
      Description = '';
      Caption = 'Accumulated Period 1';
      TableRelation = "CDS acwapp_period".acwapp_periodId;
    }
    field(36;acwapp_AccumulatedPeriod2;GUID)
    {
      ExternalName = 'acwapp_accumulatedperiod2';
      ExternalType = 'Lookup';
      Description = '';
      Caption = 'Accumulated Period 2';
      TableRelation = "CDS acwapp_period".acwapp_periodId;
    }
    field(37;acwapp_AutoTierUpgrade;Boolean)
    {
      ExternalName = 'acwapp_autotierupgrade';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Auto Tier Upgrade';
    }
    field(39;acwapp_CombineRelatedLoyaltyCards;Boolean)
    {
      ExternalName = 'acwapp_combinerelatedloyaltycards';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Combine Related Loyalty Cards';
    }
    field(41;acwapp_ConversionFactor;Decimal)
    {
      ExternalName = 'acwapp_conversionfactor';
      ExternalType = 'Decimal';
      Description = '';
      Caption = 'Conversion Factor';
    }
    field(42;acwapp_countrycode;Text[100])
    {
      ExternalName = 'acwapp_countrycode';
      ExternalType = 'String';
      Description = '';
      Caption = 'Country Code';
    }
    field(43;acwapp_Currency;GUID)
    {
      ExternalName = 'acwapp_currency';
      ExternalType = 'Lookup';
      Description = '';
      Caption = 'Currency';
      TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
    }
    field(44;acwapp_Description;BLOB)
    {
      ExternalName = 'acwapp_description';
      ExternalType = 'Memo';
      Description = '';
      Caption = 'Description';
      Subtype = Memo;
    }
    field(45;acwapp_LastReportDate;Date)
    {
      ExternalName = 'acwapp_lastreportdate';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Last Report Date';
    }
    field(47;acwapp_maxiumpointsearn;Decimal)
    {
      ExternalName = 'acwapp_maxiumpointsearn';
      ExternalType = 'Decimal';
      Description = '';
      Caption = 'Maxium Points Earn';
    }
    field(48;acwapp_MemoPath;Text[100])
    {
      ExternalName = 'acwapp_memopath';
      ExternalType = 'String';
      Description = '';
      Caption = 'Memo Path';
    }
    field(49;acwapp_multipleegcamount;Decimal)
    {
      ExternalName = 'acwapp_multipleegcamount';
      ExternalType = 'Decimal';
      Description = '';
      Caption = 'Multiple eGC Amount';
    }
    field(50;acwapp_OverseaOptin;Boolean)
    {
      ExternalName = 'acwapp_overseaoptin';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Oversea Optin';
    }
    field(52;acwapp_PhotoPath;Text[100])
    {
      ExternalName = 'acwapp_photopath';
      ExternalType = 'String';
      Description = '';
      Caption = 'Photo Path';
    }
    field(53;acwapp_PointHold;Integer)
    {
      ExternalName = 'acwapp_pointhold';
      ExternalType = 'Integer';
      Description = '';
      Caption = 'Points Hold Days';
    }
    field(54;acwapp_PointShared;Boolean)
    {
      ExternalName = 'acwapp_pointshared';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Point Shared';
    }
    field(56;acwapp_RegistrationChannel;Option)
    {
      ExternalName = 'acwapp_registrationchannel';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Channel';
      InitValue = " ";
      OptionMembers = " ", Retail, Ecom, CRM, SMS, MobileApps, HKWeChat, Web, WhatsApp, Store, Facebook, CNWechat, Line, "Self-upload", WifiUser, Email, "Event";
      OptionOrdinalValues = -1, 805110000, 805110001, 557130007, 557130006, 557130000, 557130001, 557130002, 557130003, 557130004, 557130005, 557130008, 557130009, 557130010, 557130011, 557130012, 557130013;
    }
    field(58;acwapp_RenewalCalculation;Option)
    {
      ExternalName = 'acwapp_renewalcalculation';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Renewal Calculation';
      InitValue = Spending;
      OptionMembers = Spending, Points;
      OptionOrdinalValues = 557130000, 557130001;
    }
    field(60;acwapp_StartRegional;Boolean)
    {
      ExternalName = 'acwapp_startregional';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Start Regional';
    }
    field(62;acwapp_TobePeriod;GUID)
    {
      ExternalName = 'acwapp_tobeperiod';
      ExternalType = 'Lookup';
      Description = '';
      Caption = 'To be Period';
      TableRelation = "CDS acwapp_period".acwapp_periodId;
    }
    field(63;acwapp_UpgradeCalculation;Option)
    {
      ExternalName = 'acwapp_upgradecalculation';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Upgrade Calculation';
      InitValue = Spending;
      OptionMembers = Spending, Points;
      OptionOrdinalValues = 557130000, 557130001;
    }
    field(66;acwapp_AccumulatedPeriod1Name;Text[100])
    {
      FieldClass = FlowField;
      CalcFormula = lookup("CDS acwapp_period".acwapp_name where(acwapp_periodId=field(acwapp_AccumulatedPeriod1)));
      ExternalName = 'acwapp_accumulatedperiod1name';
      ExternalType = 'String';
      ExternalAccess = Read;
    }
    field(67;acwapp_AccumulatedPeriod2Name;Text[100])
    {
      FieldClass = FlowField;
      CalcFormula = lookup("CDS acwapp_period".acwapp_name where(acwapp_periodId=field(acwapp_AccumulatedPeriod2)));
      ExternalName = 'acwapp_accumulatedperiod2name';
      ExternalType = 'String';
      ExternalAccess = Read;
    }
    field(68;acwapp_TobePeriodName;Text[100])
    {
      FieldClass = FlowField;
      CalcFormula = lookup("CDS acwapp_period".acwapp_name where(acwapp_periodId=field(acwapp_TobePeriod)));
      ExternalName = 'acwapp_tobeperiodname';
      ExternalType = 'String';
      ExternalAccess = Read;
    }
  }
  keys
  {
    key(PK;acwapp_loyalprogramId)
    {
      Clustered = true;
    }
    key(Name;acwapp_name)
    {
    }
  }
  fieldgroups
  {
    fieldgroup(DropDown;acwapp_name)
    {
    }
  }
}