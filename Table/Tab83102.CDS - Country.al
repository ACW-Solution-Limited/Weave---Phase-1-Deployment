table 83102 "CDS acwapp_country"
{
  ExternalName = 'acwapp_country';
  TableType = CDS;
  Description = '';

  fields
  {
    field(1;acwapp_countryId;GUID)
    {
      ExternalName = 'acwapp_countryid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Insert;
      Description = 'Unique identifier for entity instances';
      Caption = 'Country';
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
      Description = 'Status of the Country';
      Caption = 'Status';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 0, 1;
    }
    field(27;statuscode;Option)
    {
      ExternalName = 'statuscode';
      ExternalType = 'Status';
      Description = 'Reason for the status of the Country';
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
      Caption = 'Country';
    }
    field(35;acwapp_countryinitialcode;Text[100])
    {
      ExternalName = 'acwapp_countryinitialcode';
      ExternalType = 'String';
      Description = '';
      Caption = 'Country Initial Code';
    }
    field(36;acwapp_Descirption_sim;Text[100])
    {
      ExternalName = 'acwapp_descirption_sim';
      ExternalType = 'String';
      Description = '';
      Caption = 'Simplified Chinese';
    }
    field(37;acwapp_Description_eng;Text[100])
    {
      ExternalName = 'acwapp_description_eng';
      ExternalType = 'String';
      Description = '';
      Caption = 'Description_eng';
    }
    field(38;acwapp_Description_trad;Text[100])
    {
      ExternalName = 'acwapp_description_trad';
      ExternalType = 'String';
      Description = '';
      Caption = 'Traditional Chinese';
    }
    field(39;acwapp_IDD;Text[100])
    {
      ExternalName = 'acwapp_idd';
      ExternalType = 'String';
      Description = '';
      Caption = 'IDD';
    }
    field(40;acwapp_loyaltyprogram;GUID)
    {
      ExternalName = 'acwapp_loyaltyprogram';
      ExternalType = 'Lookup';
      Description = '';
      Caption = 'loyalty program';
      TableRelation = "CDS acwapp_loyalprogram".acwapp_loyalprogramId;
    }
    field(41;acwapp_Sequence;Integer)
    {
      ExternalName = 'acwapp_sequence';
      ExternalType = 'Integer';
      Description = '';
      Caption = 'Sequence';
    }
    field(42;acwapp_Sourceid;Text[100])
    {
      ExternalName = 'acwapp_sourceid';
      ExternalType = 'String';
      Description = '';
      Caption = 'Sourceid';
    }
    field(43;acwapp_loyaltyprogramName;Text[100])
    {
      FieldClass = FlowField;
      CalcFormula = lookup("CDS acwapp_loyalprogram".acwapp_name where(acwapp_loyalprogramId=field(acwapp_loyaltyprogram)));
      ExternalName = 'acwapp_loyaltyprogramname';
      ExternalType = 'String';
      ExternalAccess = Read;
    }
  }
  keys
  {
    key(PK;acwapp_countryId)
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