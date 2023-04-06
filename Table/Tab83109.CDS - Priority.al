table 83109 "CDS msdyn_priority"
{
  ExternalName = 'msdyn_priority';
  TableType = CDS;
  Description = 'Priorities to be used on bookings. In addition, a color could be specified for each priority type and the color selected will be shown visually on the schedule board.';

  fields
  {
    field(1;msdyn_priorityId;GUID)
    {
      ExternalName = 'msdyn_priorityid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Insert;
      Description = 'Shows the entity instances.';
      Caption = 'Priority';
    }
    field(2;CreatedOn;Datetime)
    {
      ExternalName = 'createdon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Shows the date and time when the record was created. The date and time are displayed in the time zone selected in Microsoft Dynamics CRM options.';
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
      Description = 'Shows the date and time when the record was last updated. The date and time are displayed in the time zone selected in Microsoft Dynamics CRM options.';
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
      Description = 'Shows who created the record on behalf of another user.';
      Caption = 'Created By (Delegate)';
      TableRelation = "CRM Systemuser".SystemUserId;
    }
    field(7;ModifiedOnBehalfBy;GUID)
    {
      ExternalName = 'modifiedonbehalfby';
      ExternalType = 'Lookup';
      ExternalAccess = Read;
      Description = 'Shows who last updated the record on behalf of another user.';
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
      Description = 'Status of the Priority';
      Caption = 'Status';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 0, 1;
    }
    field(27;statuscode;Option)
    {
      ExternalName = 'statuscode';
      ExternalType = 'Status';
      Description = 'Reason for the status of the Priority';
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
      Description = 'Shows the sequence number of the import that created this record.';
      Caption = 'Import Sequence Number';
    }
    field(31;OverriddenCreatedOn;Date)
    {
      ExternalName = 'overriddencreatedon';
      ExternalType = 'DateTime';
      ExternalAccess = Insert;
      Description = 'Shows the date and time that the record was migrated.';
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
      Description = 'Shows the time zone code that was in use when the record was created.';
      Caption = 'UTC Conversion Time Zone Code';
    }
    field(34;msdyn_name;Text[100])
    {
      ExternalName = 'msdyn_name';
      ExternalType = 'String';
      Description = 'Enter the priority name.';
      Caption = 'Name';
    }
    field(35;msdyn_LevelofImportance;Option)
    {
      ExternalName = 'msdyn_levelofimportance';
      ExternalType = 'Picklist';
      Description = 'Enter the importance level of the priority.';
      Caption = 'Level of Importance';
      InitValue = " ";
      OptionMembers = " ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10";
      OptionOrdinalValues = -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10;
    }
    field(37;msdyn_PriorityColor;Text[10])
    {
      ExternalName = 'msdyn_prioritycolor';
      ExternalType = 'String';
      Description = 'Select the color to be used to visualize the priority on the schedule board.';
      Caption = 'Priority Color';
    }
  }
  keys
  {
    key(PK;msdyn_priorityId)
    {
      Clustered = true;
    }
    key(Name;msdyn_name)
    {
    }
  }
  fieldgroups
  {
    fieldgroup(DropDown;msdyn_name)
    {
    }
  }
}