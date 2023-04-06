table 83115 "CDS acwapp_bedroomoffer"
{
    ExternalName = 'acwapp_bedroomoffer';
    TableType = CDS;
    Description = '';

    fields
    {
        field(1; acwapp_bedroomofferId; GUID)
        {
            ExternalName = 'acwapp_bedroomofferid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier for entity instances';
            Caption = 'Bedroom Offer';
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
            Description = 'Status of the Bedroom Offer';
            Caption = 'Status';
            InitValue = " ";
            OptionMembers = " ",Active,Inactive;
            OptionOrdinalValues = -1, 0, 1;
        }
        field(27; statuscode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Reason for the status of the Bedroom Offer';
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
        field(35; acwapp_Property; GUID)
        {
            ExternalName = 'acwapp_property';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(36; acwapp_PropertyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Property)));
            ExternalName = 'acwapp_propertyname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(37; acwapp_RoomType; GUID)
        {
            ExternalName = 'acwapp_roomtype';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Unit Type';
            TableRelation = "CDS acwapp_roomtype".acwapp_roomtypeId;
        }
        field(38; acwapp_RoomTypeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_roomtype".acwapp_name where(acwapp_roomtypeId = field(acwapp_RoomType)));
            ExternalName = 'acwapp_roomtypename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(39; acwapp_MovinginDate; Datetime)
        {
            ExternalName = 'acwapp_movingindate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Moving-in Date';
        }
        field(41; acwapp_PromotionCode; GUID)
        {
            ExternalName = 'acwapp_promotioncode';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Promotion Code';
            TableRelation = "CDS acwapp_promotioncode".acwapp_promotioncodeId;
        }
        field(42; acwapp_PromotionCodeName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_promotioncode".acwapp_name where(acwapp_promotioncodeId = field(acwapp_PromotionCode)));
            ExternalName = 'acwapp_promotioncodename';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(45; acwapp_Remarks; Text[100])
        {
            ExternalName = 'acwapp_remarks';
            ExternalType = 'String';
            Description = '';
            Caption = 'Remarks';
        }
        field(46; acwapp_Room; GUID)
        {
            ExternalName = 'acwapp_room';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Room';
            TableRelation = "CDS acwapp_propertyunit".acwapp_propertyunitId;
        }
        field(47; acwapp_RoomName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertyunit".acwapp_name where(acwapp_propertyunitId = field(acwapp_Room)));
            ExternalName = 'acwapp_roomname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(52; acwapp_ReserveExpiaryDate_1; Date)
        {
            ExternalName = 'acwapp_reserveexpiarydate_1';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Reserve Expiry Date';
        }
        field(72; acwapp_LicensingAgreementURL; Text[100])
        {
            ExternalName = 'acwapp_licensingagreementurl';
            ExternalType = 'String';
            Description = '';
            Caption = 'Licensing Agreement URL';
        }
        field(73; acwapp_SignedLicensingAgreementURL; Text[100])
        {
            ExternalName = 'acwapp_signedlicensingagreementurl';
            ExternalType = 'String';
            Description = '';
            Caption = 'Signed Licensing Agreement URL';
        }
        field(77; acwapp_PayeeEmail; Text[100])
        {
            ExternalName = 'acwapp_payeeemail';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payee Email';
        }
        field(78; acwapp_PayeeFirstName; Text[100])
        {
            ExternalName = 'acwapp_payeefirstname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payee First Name';
        }
        field(79; acwapp_PayeeLastName; Text[100])
        {
            ExternalName = 'acwapp_payeelastname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Payee Last Name';
        }
        field(80; acwapp_PayeeContact; GUID)
        {
            ExternalName = 'acwapp_payeecontact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Payee Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(83; acwapp_PayeeAccount; GUID)
        {
            ExternalName = 'acwapp_payeeaccount';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Payee Account';
            TableRelation = "CRM Account".AccountId;
        }
        field(87; acwapp_Resident1LastName; Text[100])
        {
            ExternalName = 'acwapp_resident1lastname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Resident 1 Last Name';
        }
        field(88; acwapp_Resident1FirstName; Text[100])
        {
            ExternalName = 'acwapp_resident1firstname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Resident 1 First Name';
        }
        field(89; acwapp_Resident1Email; Text[100])
        {
            ExternalName = 'acwapp_resident1email';
            ExternalType = 'String';
            Description = '';
            Caption = 'Resident 1 Email';
        }
        field(90; acwapp_Resident1Contact; GUID)
        {
            ExternalName = 'acwapp_resident1contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Resident 1 Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(93; acwapp_LookupConfiguration; GUID)
        {
            ExternalName = 'acwapp_lookupconfiguration';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Lookup Configuration';
            TableRelation = "CDS acwapp_configurationsetting".acwapp_configurationsettingId;
        }
        field(94; acwapp_LookupConfigurationName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_configurationsetting".acwapp_name where(acwapp_configurationsettingId = field(acwapp_LookupConfiguration)));
            ExternalName = 'acwapp_lookupconfigurationname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(95; acwapp_RejectOffer; Boolean)
        {
            ExternalName = 'acwapp_rejectoffer';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Reject Offer';
        }
        field(98; acwapp_MovingoutDate; Datetime)
        {
            ExternalName = 'acwapp_movingoutdate';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Moving-out Date';
        }
        field(99; acwapp_ConfirmBRB; Boolean)
        {
            ExternalName = 'acwapp_confirmbrb';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Confirm Generate BRB';
        }
        field(101; acwapp_resident2firstname; Text[100])
        {
            ExternalName = 'acwapp_resident2firstname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Resident 2 First Name';
        }
        field(102; acwapp_Resident2LastName; Text[100])
        {
            ExternalName = 'acwapp_resident2lastname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Resident 2 Last Name';
        }
        field(103; acwapp_Resident2Email; Text[100])
        {
            ExternalName = 'acwapp_resident2email';
            ExternalType = 'String';
            Description = '';
            Caption = 'Resident 2 Email';
        }
        field(104; acwapp_Resident2Contact; GUID)
        {
            ExternalName = 'acwapp_resident2contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Resident 2 Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(107; acwapp_ConfirmedPropertyBooking; GUID)
        {
            ExternalName = 'acwapp_confirmedpropertybooking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Confirmed Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(108; acwapp_ConfirmedPropertyBookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_ConfirmedPropertyBooking)));
            ExternalName = 'acwapp_confirmedpropertybookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(114; acwapp_ID; Text[100])
        {
            ExternalName = 'acwapp_id';
            ExternalType = 'String';
            Description = '';
            Caption = 'ID';
        }
        field(115; acwapp_Topic; Text[100])
        {
            ExternalName = 'acwapp_topic';
            ExternalType = 'String';
            Description = '';
            Caption = 'Topic';
        }
        field(117; acwapp_RentalPeriodMonths; Integer)
        {
            ExternalName = 'acwapp_rentalperiodmonths';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Rental Period (Months)';
        }
        field(118; acwapp_RentalPeriodDays; Integer)
        {
            ExternalName = 'acwapp_rentalperioddays';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Rental Period (Days)';
        }
        field(119; acwapp_WorkOrder; GUID)
        {
            ExternalName = 'acwapp_workorder';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Work Order';
            TableRelation = "CDS acwapp_workorder".acwapp_workorderId;
        }
        field(120; acwapp_WorkOrderName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_workorder".acwapp_name where(acwapp_workorderId = field(acwapp_WorkOrder)));
            ExternalName = 'acwapp_workordername';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(123; acwapp_DepositAmount; Decimal)
        {
            ExternalName = 'acwapp_depositamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Deposit Amount';
        }
        field(124; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier of the currency associated with the entity.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(126; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Exchange rate for the currency associated with the entity with respect to the base currency.';
            Caption = 'Exchange Rate';
        }
        field(127; acwapp_depositamount_Base; Decimal)
        {
            ExternalName = 'acwapp_depositamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Deposit Amount in base currency.';
            Caption = 'Deposit Amount (Base)';
        }
        field(133; acwapp_Discount; Decimal)
        {
            ExternalName = 'acwapp_discount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Discount';
        }
        field(134; acwapp_discount_Base; Decimal)
        {
            ExternalName = 'acwapp_discount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Discount in base currency.';
            Caption = 'Discount (Base)';
        }
        field(135; acwapp_NetAmount; Decimal)
        {
            ExternalName = 'acwapp_netamount';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Net Amount';
        }
        field(136; acwapp_netamount_Base; Decimal)
        {
            ExternalName = 'acwapp_netamount_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Net Amount in base currency.';
            Caption = 'Net Amount (Base)';
        }
        field(137; acwapp_Price; Decimal)
        {
            ExternalName = 'acwapp_price';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Price';
        }
        field(138; acwapp_price_Base; Decimal)
        {
            ExternalName = 'acwapp_price_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Price in base currency.';
            Caption = 'Price (Base)';
        }
        field(141; acwapp_Discountpercent; Decimal)
        {
            ExternalName = 'acwapp_discountpercent';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Amount after discount';
        }
        field(142; acwapp_IDnumber; Text[100])
        {
            ExternalName = 'acwapp_idnumber';
            ExternalType = 'String';
            Description = '';
            Caption = 'ID number';
        }
        field(143; acwapp_ImageId; GUID)
        {
            ExternalName = 'acwapp_imageid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Read;
        }
        field(149; acwapp_Image2Id; GUID)
        {
            ExternalName = 'acwapp_image2id';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Read;
        }
        field(155; acwapp_paymenttype; Option)
        {
            ExternalName = 'acwapp_paymenttype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Payment Type';
            InitValue = " ";
            OptionMembers = " ","One-off",Monthly;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
        field(158; acwapp_ListedMonthlyRentText; Text[100])
        {
            ExternalName = 'acwapp_listedmonthlyrenttext';
            ExternalType = 'String';
            Description = '';
            Caption = 'Listed Monthly Rent Text';
        }
        field(159; acwapp_DepositText; Text[100])
        {
            ExternalName = 'acwapp_deposittext';
            ExternalType = 'String';
            Description = '';
            Caption = 'Deposit Text';
        }
        field(160; acwapp_DiscountedMonthlyRentText; Text[100])
        {
            ExternalName = 'acwapp_discountedmonthlyrenttext';
            ExternalType = 'String';
            Description = '';
            Caption = 'Discounted Monthly Rent Text';
        }
        field(161; processid; GUID)
        {
            ExternalName = 'processid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Contains the id of the process associated with the entity.';
            Caption = 'Process Id';
        }
        field(162; stageid; GUID)
        {
            ExternalName = 'stageid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Contains the id of the stage where the entity is located.';
            Caption = '(Deprecated) Stage Id';
        }
        field(163; traversedpath; Text[1250])
        {
            ExternalName = 'traversedpath';
            ExternalType = 'String';
            Description = 'A comma separated list of string values representing the unique identifiers of stages in a Business Process Flow Instance in the order that they occur.';
            Caption = '(Deprecated) Traversed Path';
        }
        field(164; acwapp_ConfirmBedroomOffer; Boolean)
        {
            ExternalName = 'acwapp_confirmbedroomoffer';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Confirm Bedroom Offer';
        }
        field(166; acwapp_IDName; Text[100])
        {
            ExternalName = 'acwapp_idname';
            ExternalType = 'String';
            Description = '';
            Caption = 'ID Name';
        }
        field(167; acwapp_SignatureId; GUID)
        {
            ExternalName = 'acwapp_signatureid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Read;
        }
    }
    keys
    {
        key(PK; acwapp_bedroomofferId)
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