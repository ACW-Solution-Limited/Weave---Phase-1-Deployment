table 83128 "CDS acwapp_propertybooking"
{
    ExternalName = 'acwapp_propertybooking';
    TableType = CDS;
    Description = '';
    DataCaptionFields = acwapp_ContractNo;

    fields
    {
        field(1; acwapp_propertybookingId; GUID)
        {
            ExternalName = 'acwapp_propertybookingid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Property Booking';
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
            Description = 'Status of the Property Booking';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Property Booking';
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
        field(35; acwapp_ContractNo; Text[100])
        {
            ExternalName = 'acwapp_contractno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Contract No.';
        }
        field(36; acwapp_Contact; GUID)
        {
            ExternalName = 'acwapp_contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(39; acwapp_PropertyUnit; GUID)
        {
            ExternalName = 'acwapp_propertyunit';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(40; acwapp_PropertyUnitName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_PropertyUnit)));
            ExternalName = 'acwapp_propertyunitname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(41; acwapp_RoomType; GUID)
        {
            ExternalName = 'acwapp_roomtype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Unit Type';
            TableRelation = "CDS acwapp_roomtype".acwapp_roomtypeId;
        }
        field(42; acwapp_RoomTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_roomtype".acwapp_name where(acwapp_roomtypeId = field(acwapp_RoomType)));
            ExternalName = 'acwapp_roomtypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(43; acwapp_ContractStartDate; Datetime)
        {
            ExternalName = 'acwapp_contractstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract Start Date';
        }
        field(44; acwapp_ContractEndDate; Datetime)
        {
            ExternalName = 'acwapp_contractenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract End Date';
        }
        field(46; acwapp_CleaningSchedule; GUID)
        {
            ExternalName = 'acwapp_cleaningschedule';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Cleaning Schedule';
            TableRelation = "CDS acwapp_period".acwapp_periodId;
        }
        field(47; acwapp_CleaningScheduleName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_period".acwapp_name where(acwapp_periodId = field(acwapp_CleaningSchedule)));
            ExternalName = 'acwapp_cleaningschedulename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(48; acwapp_CleaningRemarks; BLOB)
        {
            ExternalName = 'acwapp_cleaningremarks';
            ExternalType = 'Memo';
            Description = '';
            Caption = 'Cleaning Remarks';
            Subtype = Memo;
        }
        field(49; acwapp_ContractStatus; Option)
        {
            ExternalName = 'acwapp_contractstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Contract Status';
            InitValue = " ";
            OptionMembers = " ",ConfirmedWithRoomAllocated,"ReadyForCheck-in",Active,FinishedContract,Terminated;
            OptionOrdinalValues = -1, 557130002, 557130004, 557130000, 557130005, 557130003;
        }
        field(54; acwapp_OvernightStayVisitorCount; Integer)
        {
            ExternalName = 'acwapp_overnightstayvisitorcount';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Overnight Stay Visitor Count (this month)';
        }
        field(56; acwapp_ConfigurationSetting; GUID)
        {
            ExternalName = 'acwapp_configurationsetting';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Configuration Setting';
            TableRelation = "CDS acwapp_configurationsetting".acwapp_configurationsettingId;
        }
        field(57; acwapp_ConfigurationSettingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_configurationsetting".acwapp_name where(acwapp_configurationsettingId = field(acwapp_ConfigurationSetting)));
            ExternalName = 'acwapp_configurationsettingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(58; acwapp_PropertyName; Text[100])
        {
            ExternalName = 'acwapp_propertyname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property Name';
        }
        field(59; acwapp_HouseRuleURL; Text[1000])
        {
            ExternalName = 'acwapp_houseruleurl';
            ExternalType = 'String';
            Description = '';
            Caption = 'House Rule URL';
        }
        field(60; acwapp_LicenseAgreementURL; Text[1000])
        {
            ExternalName = 'acwapp_licenseagreementurl';
            ExternalType = 'String';
            Description = '';
            Caption = 'License Agreement URL';
        }
        field(64; acwapp_InAppReminder; Boolean)
        {
            ExternalName = 'acwapp_inappreminder';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'In-App Reminder';
        }
        field(66; acwapp_Account; GUID)
        {
            ExternalName = 'acwapp_account';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Account';
            TableRelation = "CRM Account".AccountId;
        }

        field(71; acwapp_RentalPeriod; Text[100])
        {
            ExternalName = 'acwapp_rentalperiod';
            ExternalType = 'String';
            Description = '';
            Caption = 'Rental Period';
        }
        field(72; acwapp_RentalPeriodLookup; GUID)
        {
            ExternalName = 'acwapp_rentalperiodlookup';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Rental Period';
            TableRelation = "CDS acwapp_rentalperiod".acwapp_rentalperiodId;
        }
        field(73; acwapp_RentalPeriodLookupName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_rentalperiod".acwapp_name where(acwapp_rentalperiodId = field(acwapp_RentalPeriodLookup)));
            ExternalName = 'acwapp_rentalperiodlookupname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(74; acwapp_BedroomOffer; GUID)
        {
            ExternalName = 'acwapp_bedroomoffer';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Bedroom Offer';
            TableRelation = "CDS acwapp_bedroomoffer".acwapp_bedroomofferId;
        }
        field(75; acwapp_BedroomOfferName; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bedroomoffer".acwapp_name where(acwapp_bedroomofferId = field(acwapp_BedroomOffer)));
            ExternalName = 'acwapp_bedroomoffername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(78; acwapp_CleaningStatus; GUID)
        {
            ExternalName = 'acwapp_cleaningstatus';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Room Status';
            TableRelation = "CDS acwapp_cleaningstatus".acwapp_cleaningstatusId;
        }
        field(79; acwapp_CleaningStatusName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_cleaningstatus".acwapp_name where(acwapp_cleaningstatusId = field(acwapp_CleaningStatus)));
            ExternalName = 'acwapp_cleaningstatusname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(80; acwapp_InventoryList; GUID)
        {
            ExternalName = 'acwapp_inventorylist';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Inventory List';
            TableRelation = "CDS acwapp_inventorylistheader".acwapp_inventorylistheaderId;
        }
        field(81; acwapp_InventoryListName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_inventorylistheader".acwapp_name where(acwapp_inventorylistheaderId = field(acwapp_InventoryList)));
            ExternalName = 'acwapp_inventorylistname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(82; acwapp_CustomerRemarks; Text[100])
        {
            ExternalName = 'acwapp_customerremarks';
            ExternalType = 'String';
            Description = '';
            Caption = 'Customer Remarks';
        }
        field(83; acwapp_Room; GUID)
        {
            ExternalName = 'acwapp_room';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Room';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(84; acwapp_RoomName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Room)));
            ExternalName = 'acwapp_roomname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(85; acwapp_RenewalPeriod; GUID)
        {
            ExternalName = 'acwapp_renewalperiod';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Renewal Period';
            TableRelation = "CDS acwapp_renewalperiod".acwapp_renewalperiodId;
        }
        field(86; acwapp_RenewalPeriodName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_renewalperiod".acwapp_name where(acwapp_renewalperiodId = field(acwapp_RenewalPeriod)));
            ExternalName = 'acwapp_renewalperiodname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(87; acwapp_Stay; Integer)
        {
            ExternalName = 'acwapp_stay';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Stay Duration (Days)';
        }
        field(88; acwapp_CheckInDate; Datetime)
        {
            ExternalName = 'acwapp_checkindate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Check-In Date';
        }
        field(89; acwapp_CheckOutDate; Datetime)
        {
            ExternalName = 'acwapp_checkoutdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Check-Out Date';
        }
        field(90; acwapp_RenewalContract; Boolean)
        {
            ExternalName = 'acwapp_renewalcontract';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Confirm Renew Contract';
        }
        field(92; acwapp_BookingLine; GUID)
        {
            ExternalName = 'acwapp_bookingline';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Booking Line';
            TableRelation = "CDS acwapp_bookingline".acwapp_bookinglineId;
        }
        field(93; acwapp_BookingLineName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bookingline".acwapp_name where(acwapp_bookinglineId = field(acwapp_BookingLine)));
            ExternalName = 'acwapp_bookinglinename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(94; acwapp_BookingOccupants; GUID)
        {
            ExternalName = 'acwapp_bookingoccupants';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Booking Occupants';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(95; acwapp_BookingOccupantsName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_BookingOccupants)));
            ExternalName = 'acwapp_bookingoccupantsname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(96; acwapp_Email; GUID)
        {
            ExternalName = 'acwapp_email';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Email';
            TableRelation = "CDS Email".ActivityId;
        }
        field(97; acwapp_EmailName; Text[800])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS Email".Subject where(ActivityId = field(acwapp_Email)));
            ExternalName = 'acwapp_emailname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(98; acwapp_RenewalBedroomOffer; GUID)
        {
            ExternalName = 'acwapp_renewalbedroomoffer';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Renewal Bedroom Offer';
            TableRelation = "CDS acwapp_bedroomoffer".acwapp_bedroomofferId;
        }
        field(99; acwapp_RenewalBedroomOfferName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bedroomoffer".acwapp_name where(acwapp_bedroomofferId = field(acwapp_RenewalBedroomOffer)));
            ExternalName = 'acwapp_renewalbedroomoffername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(107; acwapp_ExpectedCheckInDate; Datetime)
        {
            ExternalName = 'acwapp_expectedcheckindate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Expected Check-In Date';
        }
        field(108; acwapp_ExpectedCheckOutDate; Datetime)
        {
            ExternalName = 'acwapp_expectedcheckoutdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Expected Check-Out Date';
        }
        field(109; acwapp_WorkOrder; GUID)
        {
            ExternalName = 'acwapp_workorder';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Work Order';
            TableRelation = "CDS acwapp_workorder".acwapp_workorderId;
        }
        field(110; acwapp_WorkOrderName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_workorder".acwapp_name where(acwapp_workorderId = field(acwapp_WorkOrder)));
            ExternalName = 'acwapp_workordername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(111; acwapp_PropertyBookingHeader; GUID)
        {
            ExternalName = 'acwapp_propertybookingheader';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking Header';
            TableRelation = "CDS acwapp_propertybookingheader".acwapp_propertybookingheaderId;
        }
        field(112; acwapp_PropertyBookingHeaderName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybookingheader".acwapp_name where(acwapp_propertybookingheaderId = field(acwapp_PropertyBookingHeader)));
            ExternalName = 'acwapp_propertybookingheadername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(113; acwapp_RenewalEmailDate; Date)
        {
            ExternalName = 'acwapp_renewalemaildate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Renewal Email Date';
        }
        field(114; acwapp_RenewalReminderEmailDate; Date)
        {
            ExternalName = 'acwapp_renewalreminderemaildate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Renewal Reminder Email Date';
        }
        field(115; acwapp_promotioncode; GUID)
        {
            ExternalName = 'acwapp_promotioncode';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Promotion Code';
            TableRelation = "CDS acwapp_promotioncode".acwapp_promotioncodeId;
        }
        field(116; acwapp_promotioncodeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_promotioncode".acwapp_name where(acwapp_promotioncodeId = field(acwapp_promotioncode)));
            ExternalName = 'acwapp_promotioncodename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(117; acwapp_Price; Decimal)
        {
            ExternalName = 'acwapp_price';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Price';
        }
        field(118; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(120; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(121; acwapp_price_Base; Decimal)
        {
            ExternalName = 'acwapp_price_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Price in base currency.';
            Caption = 'Price (Base)';
        }
        field(124; acwapp_discount; Decimal)
        {
            ExternalName = 'acwapp_discount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Discount';
        }
        field(125; acwapp_discount_Base; Decimal)
        {
            ExternalName = 'acwapp_discount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the discount in base currency.';
            Caption = 'discount (Base)';
        }
        field(126; acwapp_NetAmount; Decimal)
        {
            ExternalName = 'acwapp_netamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Net Amount';
        }
        field(127; acwapp_netamount_Base; Decimal)
        {
            ExternalName = 'acwapp_netamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Net Amount in base currency.';
            Caption = 'Net Amount (Base)';
        }
        field(128; acwapp_DepositAmount; Decimal)
        {
            ExternalName = 'acwapp_depositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Deposit Amount';
        }
        field(129; acwapp_depositamount_Base; Decimal)
        {
            ExternalName = 'acwapp_depositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Deposit Amount in base currency.';
            Caption = 'Deposit Amount (Base)';
        }
        field(130; acwapp_PaymentType; Option)
        {
            ExternalName = 'acwapp_paymenttype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Payment Type';
            InitValue = " ";
            OptionMembers = " ","Pre-paid","One-off (ShortStay)",Monthly;
            OptionOrdinalValues = -1, 557130002, 557130000, 557130001;
        }
        field(132; acwapp_Product; GUID)
        {
            ExternalName = 'acwapp_product';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Product';
            TableRelation = "CDS acwapp_product".acwapp_productId;
        }
        field(133; acwapp_ProductName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_product".acwapp_name where(acwapp_productId = field(acwapp_Product)));
            ExternalName = 'acwapp_productname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(136; acwapp_CurrentBooking; Boolean)
        {
            ExternalName = 'acwapp_currentbooking';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Current Booking';
        }
        field(138; acwapp_NewMoveOutDate; Date)
        {
            ExternalName = 'acwapp_newmoveoutdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'New Move Out Date';
        }
        field(139; acwapp_SentPrearrivalEmail; Boolean)
        {
            ExternalName = 'acwapp_sentprearrivalemail';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Sent Pre-arrival Email';
        }
        field(141; acwapp_CheckinStatus; Option)
        {
            ExternalName = 'acwapp_checkinstatus';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Check-in Status';
            InitValue = " ";
            OptionMembers = " ",Confirmed,CheckedIn,NoShow;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }

        field(145; acwapp_NewBedroomType; GUID)
        {
            ExternalName = 'acwapp_newbedroomtype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'New Bedroom Type';
            TableRelation = "CDS acwapp_roomtype".acwapp_roomtypeId;
        }
        field(146; acwapp_NewBedroomTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_roomtype".acwapp_name where(acwapp_roomtypeId = field(acwapp_NewBedroomType)));
            ExternalName = 'acwapp_newbedroomtypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(149; acwapp_ExtraCharges; GUID)
        {
            ExternalName = 'acwapp_extracharges';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Extra Charges';
            TableRelation = "CDS acwapp_extracharges".acwapp_extrachargesId;
        }
        field(150; acwapp_ExtraChargesName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_extracharges".acwapp_name where(acwapp_extrachargesId = field(acwapp_ExtraCharges)));
            ExternalName = 'acwapp_extrachargesname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(151; acwapp_ActivatedApp; Boolean)
        {
            ExternalName = 'acwapp_activatedapp';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Activated App';
        }
        field(153; acwapp_TotalVisitorCountthismonth; Integer)
        {
            ExternalName = 'acwapp_totalvisitorcountthismonth';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Visitor Count (this month)';
        }
        field(154; acwapp_TotalVisitorCountthismonth_Date; Datetime)
        {
            ExternalName = 'acwapp_totalvisitorcountthismonth_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Total Visitor Count (this month).';
            Caption = 'Total Visitor Count (this month) (Last Updated On)';
        }
        field(155; acwapp_TotalVisitorCountthismonth_State; Integer)
        {
            ExternalName = 'acwapp_totalvisitorcountthismonth_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Total Visitor Count (this month).';
            Caption = 'Total Visitor Count (this month) (State)';
        }
        field(156; acwapp_TotalSameDayVisitorCountthismonth; Integer)
        {
            ExternalName = 'acwapp_totalsamedayvisitorcountthismonth';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Same Day Visitor Count (this month)';
        }
        field(157; acwapp_TotalSameDayVisitorCountthismonth_Date; Datetime)
        {
            ExternalName = 'acwapp_totalsamedayvisitorcountthismonth_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Total Same Day Visitor Count (this month).';
            Caption = 'Total Same Day Visitor Count (this month) (Last Updated On)';
        }
        field(158; acwapp_TotalSameDayVisitorCountthismonth_State; Integer)
        {
            ExternalName = 'acwapp_totalsamedayvisitorcountthismonth_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Total Same Day Visitor Count (this month).';
            Caption = 'Total Same Day Visitor Count (this month) (State)';
        }
        field(159; acwapp_SameDayVisitorCountPerDay; Integer)
        {
            ExternalName = 'acwapp_samedayvisitorcountperday';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Same Day Visitor Count (Per Day)';
        }
        field(160; acwapp_SameDayVisitorCountPerDay_Date; Datetime)
        {
            ExternalName = 'acwapp_samedayvisitorcountperday_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Same Day Visitor Count (Per Day).';
            Caption = 'Same Day Visitor Count (Per Day) (Last Updated On)';
        }
        field(161; acwapp_SameDayVisitorCountPerDay_State; Integer)
        {
            ExternalName = 'acwapp_samedayvisitorcountperday_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Same Day Visitor Count (Per Day).';
            Caption = 'Same Day Visitor Count (Per Day) (State)';
        }
        field(162; acwapp_OvernightStayVisitorCountthismonth; Integer)
        {
            ExternalName = 'acwapp_overnightstayvisitorcountthismonth';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Overnight Stay Visitor Count (this month)';
        }
        field(163; acwapp_OvernightStayVisitorCountthismonth_Date; Datetime)
        {
            ExternalName = 'acwapp_overnightstayvisitorcountthismonth_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Overnight Stay Visitor Count (this month).';
            Caption = 'Overnight Stay Visitor Count (this month) (Last Updated On)';
        }
        field(164; acwapp_OvernightStayVisitorCountthismonth_State; Integer)
        {
            ExternalName = 'acwapp_overnightstayvisitorcountthismonth_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Overnight Stay Visitor Count (this month).';
            Caption = 'Overnight Stay Visitor Count (this month) (State)';
        }
        field(165; acwapp_VistorTotalVisitorCount; Integer)
        {
            ExternalName = 'acwapp_vistortotalvisitorcount';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Total Visitor Count (this month)';
        }
        field(166; acwapp_SameDayVisitorCount; Integer)
        {
            ExternalName = 'acwapp_samedayvisitorcount';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Same Day Visitor Count (Per Day)';
        }
        field(167; acwapp_TotalSameDayVisitorCount; Integer)
        {
            ExternalName = 'acwapp_totalsamedayvisitorcount';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Total Same Day Visitor Count (this month)';
        }
        field(168; acwapp_ContractTerminationDate; Datetime)
        {
            ExternalName = 'acwapp_contractterminationdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Contract Termination Date';
        }

        field(170; acwapp_PropertyID; Text[100])
        {
            ExternalName = 'acwapp_propertyid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property ID';
        }
        field(171; acwapp_ConfirmRenewalContract; Option)
        {
            ExternalName = 'acwapp_confirmrenewalcontract';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Confirm Renewal Contract';
            InitValue = " ";
            OptionMembers = " ",Yes,No,NotSure;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002;
        }
        field(173; acwapp_PaymentReferenceID; Text[100])
        {
            ExternalName = 'acwapp_paymentreferenceid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payment Reference ID';
        }
        field(174; acwapp_PaymentAmount; Decimal)
        {
            ExternalName = 'acwapp_paymentamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Payment Amount';
        }
        field(175; acwapp_paymentamount_Base; Decimal)
        {
            ExternalName = 'acwapp_paymentamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Payment Amount in base currency.';
            Caption = 'Payment Amount (Base)';
        }
        field(176; acwapp_FinalRenewalEmailDate; Date)
        {
            ExternalName = 'acwapp_finalrenewalemaildate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Final Renewal Reminder Email Date';
        }
        field(177; acwapp_AccountID; Text[100])
        {
            ExternalName = 'acwapp_accountid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Account ID';
        }
        field(178; acwapp_PropertyNo; Text[100])
        {
            ExternalName = 'acwapp_propertyno';
            ExternalType = 'String';
            Description = '';
            Caption = 'Property No.';
        }
        field(181; acwapp_OneoffDiscount; Decimal)
        {
            ExternalName = 'acwapp_oneoffdiscount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'One-off Discount';
        }
        field(182; acwapp_oneoffdiscount_Base; Decimal)
        {
            ExternalName = 'acwapp_oneoffdiscount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the One-off Discount in base currency.';
            Caption = 'One-off Discount (Base)';
        }

        field(183; acwapp_PromotionCodeChargeType; Option)
        {
            ExternalName = 'acwapp_promotioncodechargetype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Promotion Code Charge Type';
            InitValue = " ";
            OptionMembers = " ",FirstMonth,Monthly;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
        field(185; acwapp_TerminateContract; Boolean)
        {
            ExternalName = 'acwapp_terminatecontract';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Terminate Contract';
        }
        field(188; acwapp_PrepaidDiscount; Decimal)
        {
            ExternalName = 'acwapp_prepaiddiscount';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Prepaid Discount %';
        }
        field(189; acwapp_PrepaidAmount; Decimal)
        {
            ExternalName = 'acwapp_prepaidamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Prepaid Amount';
        }
        field(190; acwapp_prepaidamount_Base; Decimal)
        {
            ExternalName = 'acwapp_prepaidamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Prepaid Amount in base currency.';
            Caption = 'Prepaid Amount (Base)';
        }
        field(193; acwapp_DailyRent; Decimal)
        {
            ExternalName = 'acwapp_dailyrent';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Daily Rent';
        }
        field(194; acwapp_dailyrent_Base; Decimal)
        {
            ExternalName = 'acwapp_dailyrent_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Daily Rent in base currency.';
            Caption = 'Daily Rent (Base)';
        }
        field(195; acwapp_MonthlyRent; Decimal)
        {
            ExternalName = 'acwapp_monthlyrent';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Monthly Rent';
        }
        field(196; acwapp_monthlyrent_Base; Decimal)
        {
            ExternalName = 'acwapp_monthlyrent_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Monthly Rent in base currency.';
            Caption = 'Monthly Rent (Base)';
        }


        field(197; acwapp_NetAmountIncludeVAT; Decimal)
        {
            ExternalName = 'acwapp_netamountincludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Net Amount Include VAT';
        }
        field(198; acwapp_netamountincludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_netamountincludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Net Amount Include VAT in base currency.';
            Caption = 'Net Amount Include VAT (Base)';
        }
        field(199; acwapp_Company; GUID)
        {
            ExternalName = 'acwapp_company';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Company';
            TableRelation = "CDS acwapp_bccompany".acwapp_bccompanyId;
        }
        field(200; acwapp_CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_bccompany".acwapp_name where(acwapp_bccompanyId = field(acwapp_Company)));
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }

        field(204; acwapp_PriceIncludeVAT; Decimal)
        {
            ExternalName = 'acwapp_priceincludevat';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Price Include VAT';
        }
        field(205; acwapp_priceincludevat_Base; Decimal)
        {
            ExternalName = 'acwapp_priceincludevat_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Price Include VAT in base currency.';
            Caption = 'Price Include VAT (Base)';
        }


        field(216; acwapp_NewContractStartDate; Datetime)
        {
            ExternalName = 'acwapp_newcontractstartdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'New Contract Start Date';
        }
        field(217; acwapp_NewContractEndDate; Datetime)
        {
            ExternalName = 'acwapp_newcontractenddate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'New Contract End Date';
        }
        field(222; acwapp_NoofExtraChargesLine; Integer)
        {
            ExternalName = 'acwapp_noofextrachargesline';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'No. of Extra Charges Line';
        }

        field(50000; AccountNoLookup; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CRM Account".acwapp_AccountID where(AccountId = field(acwapp_Account)));
            Caption = 'Customer No.';


        }
        field(227; acwapp_PriceDeductionType; Option)
        {
            ExternalName = 'acwapp_pricedeductiontype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Price Deduction Type';
            InitValue = " ";
            OptionMembers = " ",ByPercentage,ByExactDollarValue;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
        field(229; acwapp_DeductionAmountdecimal; Decimal)
        {
            ExternalName = 'acwapp_deductionamountdecimal';
            ExternalType = 'Decimal';
            Description = '';
            Caption = 'Deduction Amount';
        }

        field(234; acwapp_TenderType; GUID)
        {
            ExternalName = 'acwapp_tendertype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Tender Type';
            TableRelation = "CDS acwapp_tendertype".acwapp_tendertypeId;
        }
        field(235; acwapp_TenderTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_tendertype".acwapp_name where(acwapp_tendertypeId = field(acwapp_TenderType)));
            ExternalName = 'acwapp_tendertypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(236; acwapp_DiscountAmount; Decimal)
        {
            ExternalName = 'acwapp_discountamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Discount Amount';
        }
        field(237; acwapp_discountamount_Base; Decimal)
        {
            ExternalName = 'acwapp_discountamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Discount Amount in base currency.';
            Caption = 'Discount Amount (Base)';
        }



        field(262; acwapp_CommissionType; Option)
        {
            ExternalName = 'acwapp_commissiontype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Commission Type';
            InitValue = " ";
            OptionMembers = " ",DirectBooking,B2COutreach,B2BOutreach,B2CCompanyAssign,B2BRenewal,B2CRenewal,"B2CCompanyAssign-PropertyViewing(OperationTeam)";
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002, 557130003, 557130004, 557130005, 557130006;
        }
        field(264; acwapp_NumberofDaysExtension; Integer)
        {
            ExternalName = 'acwapp_numberofdaysextension';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Number of Days (Extension)';
        }
        field(265; acwapp_OwnerEmail; Text[200])
        {
            ExternalName = 'acwapp_owneremail';
            ExternalType = 'String';
            Description = '';
            Caption = 'Owner Email';
        }



    }

    keys
    {
        key(PK; acwapp_propertybookingId)
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