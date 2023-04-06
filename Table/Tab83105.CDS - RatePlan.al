table 83105 "CDS acwapp_rateplan"
{
  ExternalName = 'acwapp_rateplan';
  TableType = CDS;
  Description = '';

  fields
  {
    field(1;acwapp_rateplanId;GUID)
    {
      ExternalName = 'acwapp_rateplanid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Insert;
      Description = 'Unique identifier for entity instances';
      Caption = 'Rate Plan';
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
      Description = 'Status of the Rate Plan';
      Caption = 'Status';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 0, 1;
    }
    field(27;statuscode;Option)
    {
      ExternalName = 'statuscode';
      ExternalType = 'Status';
      Description = 'Reason for the status of the Rate Plan';
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
    field(35;acwapp_Description;Text[100])
    {
      ExternalName = 'acwapp_description';
      ExternalType = 'String';
      Description = '';
      Caption = 'Description';
    }
    field(36;acwapp_EffectiveDate;Date)
    {
      ExternalName = 'acwapp_effectivedate';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Effective Date';
    }
    field(37;acwapp_ExpiryDate;Date)
    {
      ExternalName = 'acwapp_expirydate';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Expiry Date';
    }
    field(38;acwapp_VATInclusive;Boolean)
    {
      ExternalName = 'acwapp_vatinclusive';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'VAT Inclusive';
    }
    field(40;acwapp_BookingTerm;Text[100])
    {
      ExternalName = 'acwapp_bookingterm';
      ExternalType = 'String';
      Description = '';
      Caption = 'Booking Term';
    }
    field(41;acwapp_VATProfile;Text[100])
    {
      ExternalName = 'acwapp_vatprofile';
      ExternalType = 'String';
      Description = '';
      Caption = 'VAT Profile';
    }
    field(42;acwapp_WebDescription;BLOB)
    {
      ExternalName = 'acwapp_webdescription';
      ExternalType = 'Memo';
      Description = '';
      Caption = 'Web Description';
      Subtype = Memo;
    }
    field(49;acwapp_Property;GUID)
    {
      ExternalName = 'acwapp_property';
      ExternalType = 'Lookup';
      Description = '';
      Caption = 'Property';
      TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
    }
    field(50;acwapp_PropertyName;Text[100])
    {
      FieldClass = FlowField;
      CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId=field(acwapp_Property)));
      ExternalName = 'acwapp_propertyname';
      ExternalType = 'String';
      ExternalAccess = Read;
    }
    field(51;acwapp_RoomType;GUID)
    {
      ExternalName = 'acwapp_roomtype';
      ExternalType = 'Lookup';
      Description = '';
      Caption = 'Room Type';
      TableRelation = "CDS acwapp_roomtype".acwapp_roomtypeId;
    }
    field(52;acwapp_RoomTypeName;Text[100])
    {
      FieldClass = FlowField;
      CalcFormula = lookup("CDS acwapp_roomtype".acwapp_name where(acwapp_roomtypeId=field(acwapp_RoomType)));
      ExternalName = 'acwapp_roomtypename';
      ExternalType = 'String';
      ExternalAccess = Read;
    }
    field(53;acwapp_pricelisttype;Option)
    {
      ExternalName = 'acwapp_pricelisttype';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Price List Type';
      InitValue = " ";
      OptionMembers = " ", NightPrice, MonthlyPrice, "6-11MonthsPrice", "12+MonthsPrice";
      OptionOrdinalValues = -1, 557130000, 557130001, 557130002, 557130003;
    }
    field(55;acwapp_MonthlyPlanPrice;Decimal)
    {
      ExternalName = 'acwapp_monthlyplanprice';
      ExternalType = 'Money';
      Description = '';
      Caption = 'Monthly Plan Price';
    }
    field(56;TransactionCurrencyId;GUID)
    {
      ExternalName = 'transactioncurrencyid';
      ExternalType = 'Lookup';
      Description = 'Unique identifier of the currency associated with the entity.';
      Caption = 'Currency';
      TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
    }
    field(58;ExchangeRate;Decimal)
    {
      ExternalName = 'exchangerate';
      ExternalType = 'Decimal';
      ExternalAccess = Read;
      Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
      Caption = 'Exchange Rate';
    }
    field(59;acwapp_monthlyplanprice_Base;Decimal)
    {
      ExternalName = 'acwapp_monthlyplanprice_base';
      ExternalType = 'Money';
      ExternalAccess = Read;
      Description = 'Value of the Monthly Plan Price in base currency.';
      Caption = 'Monthly Plan Price (Base)';
    }
    field(60;acwapp_611MonthsPrice;Decimal)
    {
      ExternalName = 'acwapp_611monthsprice';
      ExternalType = 'Money';
      Description = '';
      Caption = '6-11 Months Price';
    }
    field(61;acwapp_611monthsprice_Base;Decimal)
    {
      ExternalName = 'acwapp_611monthsprice_base';
      ExternalType = 'Money';
      ExternalAccess = Read;
      Description = 'Value of the 6-11 Months Price in base currency.';
      Caption = '6-11 Months Price (Base)';
    }
    field(62;acwapp_12MonthPrice;Decimal)
    {
      ExternalName = 'acwapp_12monthprice';
      ExternalType = 'Money';
      Description = '';
      Caption = '12+ Month Price';
    }
    field(63;acwapp_12monthprice_Base;Decimal)
    {
      ExternalName = 'acwapp_12monthprice_base';
      ExternalType = 'Money';
      ExternalAccess = Read;
      Description = 'Value of the 12+ Month Price in base currency.';
      Caption = '12+ Month Price (Base)';
    }
    field(64;acwapp_Price;Decimal)
    {
      ExternalName = 'acwapp_price';
      ExternalType = 'Money';
      Description = '';
      Caption = 'Price';
    }
    field(65;acwapp_price_Base;Decimal)
    {
      ExternalName = 'acwapp_price_base';
      ExternalType = 'Money';
      ExternalAccess = Read;
      Description = 'Value of the Price in base currency.';
      Caption = 'Price (Base)';
    }
    field(66;acwapp_DepositAmount;Decimal)
    {
      ExternalName = 'acwapp_depositamount';
      ExternalType = 'Money';
      Description = '';
      Caption = 'Deposit Amount';
    }
    field(67;acwapp_depositamount_Base;Decimal)
    {
      ExternalName = 'acwapp_depositamount_base';
      ExternalType = 'Money';
      ExternalAccess = Read;
      Description = 'Value of the Deposit Amount in base currency.';
      Caption = 'Deposit Amount (Base)';
    }
  }
  keys
  {
    key(PK;acwapp_rateplanId)
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