table 83103 "CDS acwapp_period"
{
  ExternalName = 'acwapp_period';
  TableType = CDS;
  Description = '';

  fields
  {
    field(1;acwapp_periodId;GUID)
    {
      ExternalName = 'acwapp_periodid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Insert;
      Description = 'Unique identifier for entity instances';
      Caption = 'Period';
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
    field(16;OrganizationId;GUID)
    {
      ExternalName = 'organizationid';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Unique identifier for the organization';
      Caption = 'Organization Id';
      TableRelation = "CRM Organization".OrganizationId;
    }
    field(18;statecode;Option)
    {
      ExternalName = 'statecode';
      ExternalType = 'State';
      ExternalAccess = Modify;
      Description = 'Status of the Period';
      Caption = 'Status';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 0, 1;
    }
    field(20;statuscode;Option)
    {
      ExternalName = 'statuscode';
      ExternalType = 'Status';
      Description = 'Reason for the status of the Period';
      Caption = 'Status Reason';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 1, 2;
    }
    field(22;VersionNumber;BigInteger)
    {
      ExternalName = 'versionnumber';
      ExternalType = 'BigInt';
      ExternalAccess = Read;
      Description = 'Version Number';
      Caption = 'Version Number';
    }
    field(23;ImportSequenceNumber;Integer)
    {
      ExternalName = 'importsequencenumber';
      ExternalType = 'Integer';
      ExternalAccess = Insert;
      Description = 'Sequence number of the import that created this record.';
      Caption = 'Import Sequence Number';
    }
    field(24;OverriddenCreatedOn;Date)
    {
      ExternalName = 'overriddencreatedon';
      ExternalType = 'DateTime';
      ExternalAccess = Insert;
      Description = 'Date and time that the record was migrated.';
      Caption = 'Record Created On';
    }
    field(25;TimeZoneRuleVersionNumber;Integer)
    {
      ExternalName = 'timezoneruleversionnumber';
      ExternalType = 'Integer';
      Description = 'For internal use only.';
      Caption = 'Time Zone Rule Version Number';
    }
    field(26;UTCConversionTimeZoneCode;Integer)
    {
      ExternalName = 'utcconversiontimezonecode';
      ExternalType = 'Integer';
      Description = 'Time zone code that was in use when the record was created.';
      Caption = 'UTC Conversion Time Zone Code';
    }
    field(27;acwapp_name;Text[100])
    {
      ExternalName = 'acwapp_name';
      ExternalType = 'String';
      Description = 'The name of the custom entity.';
      Caption = 'Name';
    }
    field(28;acwapp_CalculatedBy;Date)
    {
      ExternalName = 'acwapp_calculatedby';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Calculated By';
    }
    field(29;acwapp_EndDate;Date)
    {
      ExternalName = 'acwapp_enddate';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'End Date';
    }
    field(30;acwapp_EndDayAdjust;Integer)
    {
      ExternalName = 'acwapp_enddayadjust';
      ExternalType = 'Integer';
      Description = '';
      Caption = 'End Day Adjust';
    }
    field(31;acwapp_EndRoundTo;Option)
    {
      ExternalName = 'acwapp_endroundto';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'End Round To';
      InitValue = " ";
      OptionMembers = " ", "Begin", "End";
      OptionOrdinalValues = -1, 557130000, 557130001;
    }
    field(33;acwapp_EndUnit;Option)
    {
      ExternalName = 'acwapp_endunit';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'End Unit';
      InitValue = " ";
      OptionMembers = " ", Day, Month, Year;
      OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
    }
    field(35;acwapp_EndValue;Integer)
    {
      ExternalName = 'acwapp_endvalue';
      ExternalType = 'Integer';
      Description = '';
      Caption = 'End Value';
    }
    field(36;acwapp_StartDate;Date)
    {
      ExternalName = 'acwapp_startdate';
      ExternalType = 'DateTime';
      Description = '';
      Caption = 'Start Date';
    }
    field(37;acwapp_StartDayAdjust;Integer)
    {
      ExternalName = 'acwapp_startdayadjust';
      ExternalType = 'Integer';
      Description = '';
      Caption = 'Start Day Adjust';
    }
    field(38;acwapp_StartRoundTo;Option)
    {
      ExternalName = 'acwapp_startroundto';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Start Round To';
      InitValue = " ";
      OptionMembers = " ", "Begin", "End";
      OptionOrdinalValues = -1, 557130000, 557130001;
    }
    field(40;acwapp_StartUnit;Option)
    {
      ExternalName = 'acwapp_startunit';
      ExternalType = 'Picklist';
      Description = '';
      Caption = 'Start Unit';
      InitValue = " ";
      OptionMembers = " ", Day, Month, Year;
      OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
    }
    field(42;acwapp_StartValue;Integer)
    {
      ExternalName = 'acwapp_startvalue';
      ExternalType = 'Integer';
      Description = '';
      Caption = 'Start Value';
    }
    field(43;acwapp_Monday;Boolean)
    {
      ExternalName = 'acwapp_monday';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Monday';
    }
    field(45;acwapp_Tuesday;Boolean)
    {
      ExternalName = 'acwapp_tuesday';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Tuesday';
    }
    field(47;acwapp_Wednesday;Boolean)
    {
      ExternalName = 'acwapp_wednesday';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Wednesday';
    }
    field(49;acwapp_Thursday;Boolean)
    {
      ExternalName = 'acwapp_thursday';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Thursday';
    }
    field(51;acwapp_Friday;Boolean)
    {
      ExternalName = 'acwapp_friday';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Friday';
    }
    field(53;acwapp_Saturday;Boolean)
    {
      ExternalName = 'acwapp_saturday';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Saturday';
    }
    field(55;acwapp_Sunday;Boolean)
    {
      ExternalName = 'acwapp_sunday';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Sunday';
    }
    field(57;acwapp_Biweekly;Boolean)
    {
      ExternalName = 'acwapp_biweekly';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Biweekly';
    }
    field(59;acwapp_Monthly;Boolean)
    {
      ExternalName = 'acwapp_monthly';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Monthly';
    }
    field(61;acwapp_OptoutServiceClean;Boolean)
    {
      ExternalName = 'acwapp_optoutserviceclean';
      ExternalType = 'Boolean';
      Description = '';
      Caption = 'Opt out Service Clean';
    }
  }
  keys
  {
    key(PK;acwapp_periodId)
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