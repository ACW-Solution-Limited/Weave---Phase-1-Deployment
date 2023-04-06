table 83123 "CDS Email"
{
    ExternalName = 'email';
    TableType = CDS;
    Description = 'Activity that is delivered using email protocols.';

    fields
    {
        field(1; ScheduledStart; Datetime)
        {
            ExternalName = 'scheduledstart';
            ExternalType = 'DateTime';
            Description = 'Enter the expected start date and time for the activity to provide details about the tentative time when the email activity must be initiated.';
            Caption = 'Start Date';
        }
        field(2; StatusCode; Option)
        {
            ExternalName = 'statuscode';
            ExternalType = 'Status';
            Description = 'Select the email''s status.';
            Caption = 'Status Reason';
            InitValue = " ";
            OptionMembers = " ",Draft,Completed,Sent,Received,Canceled,PendingSend,Sending,Failed;
            OptionOrdinalValues = -1, 1, 2, 3, 4, 5, 6, 7, 8;
        }
        field(3; SubmittedBy; Text[250])
        {
            ExternalName = 'submittedby';
            ExternalType = 'String';
            Description = 'Shows the Microsoft Office Outlook account for the user who submitted the email to Microsoft Dynamics 365.';
            Caption = 'Submitted By';
        }
        field(4; Description; BLOB)
        {
            ExternalName = 'description';
            ExternalType = 'Memo';
            Description = 'Type the greeting and message text of the email.';
            Caption = 'Description';
            Subtype = Memo;
        }
        field(6; IsWorkflowCreated; Boolean)
        {
            ExternalName = 'isworkflowcreated';
            ExternalType = 'Boolean';
            Description = 'Indication if the email was created by a workflow rule.';
            Caption = 'Is Workflow Created';
        }
        field(7; ActivityId; GUID)
        {
            ExternalName = 'activityid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier of the email activity.';
            Caption = 'Email Message';
        }
        field(8; ScheduledEnd; Datetime)
        {
            ExternalName = 'scheduledend';
            ExternalType = 'DateTime';
            Description = 'Enter the expected due date and time for the activity to be completed to provide details about when the email will be sent.';
            Caption = 'Due Date';
        }
        field(9; MimeType; Text[256])
        {
            ExternalName = 'mimetype';
            ExternalType = 'String';
            Description = 'MIME type of the email message data.';
            Caption = 'Mime Type';
        }
        field(10; CreatedBy; GUID)
        {
            ExternalName = 'createdby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Shows who created the record.';
            Caption = 'Created By';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(11; VersionNumber; BigInteger)
        {
            ExternalName = 'versionnumber';
            ExternalType = 'BigInt';
            ExternalAccess = Read;
            Description = 'Version number of the email message.';
            Caption = 'Version Number';
        }
        field(12; ReadReceiptRequested; Boolean)
        {
            ExternalName = 'readreceiptrequested';
            ExternalType = 'Boolean';
            Description = 'Indicates that a read receipt is requested.';
            Caption = 'Read Receipt Requested';
        }
        field(13; Subcategory; Text[250])
        {
            ExternalName = 'subcategory';
            ExternalType = 'String';
            Description = 'Type a subcategory to identify the email type and relate the activity to a specific product, sales region, business group, or other function.';
            Caption = 'Sub-Category';
        }
        field(14; IsBilled; Boolean)
        {
            ExternalName = 'isbilled';
            ExternalType = 'Boolean';
            Description = 'Information regarding whether the email activity was billed as part of resolving a case.';
            Caption = 'Is Billed';
        }
        field(15; ActualDurationMinutes; Integer)
        {
            ExternalName = 'actualdurationminutes';
            ExternalType = 'Integer';
            Description = 'Type the number of minutes spent creating and sending the email. The duration is used in reporting.';
            Caption = 'Duration';
        }
        field(16; PriorityCode; Option)
        {
            ExternalName = 'prioritycode';
            ExternalType = 'Picklist';
            Description = 'Select the priority so that preferred customers or critical issues are handled quickly.';
            Caption = 'Priority';
            InitValue = Normal;
            OptionMembers = Low,Normal,High;
            OptionOrdinalValues = 0, 1, 2;
        }
        field(17; ModifiedBy; GUID)
        {
            ExternalName = 'modifiedby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Shows who last updated the record.';
            Caption = 'Modified By';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(18; ActualStart; Date)
        {
            ExternalName = 'actualstart';
            ExternalType = 'DateTime';
            Description = 'Enter the actual start date and time for the email. By default, it displays the date and time when the activity was created, but can be edited to capture the actual time to create and send the email.';
            Caption = 'Actual Start';
        }
        field(20; DirectionCode; Boolean)
        {
            ExternalName = 'directioncode';
            ExternalType = 'Boolean';
            Description = 'Select the direction of the email as incoming or outbound.';
            Caption = 'Direction';
        }
        field(21; ActualEnd; Date)
        {
            ExternalName = 'actualend';
            ExternalType = 'DateTime';
            Description = 'Enter the actual end date and time of the email. By default, it displays the date and time when the activity was completed or canceled, but can be edited to capture the actual time to create and send the email.';
            Caption = 'Actual End';
        }
        field(22; TrackingToken; Text[50])
        {
            ExternalName = 'trackingtoken';
            ExternalType = 'String';
            Description = 'Shows the tracking token assigned to the email to make sure responses are automatically tracked in Microsoft Dynamics 365.';
            Caption = 'Tracking Token';
        }
        field(25; ScheduledDurationMinutes; Integer)
        {
            ExternalName = 'scheduleddurationminutes';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'Scheduled duration of the email activity, specified in minutes.';
            Caption = 'Scheduled Duration';
        }
        field(26; Category; Text[250])
        {
            ExternalName = 'category';
            ExternalType = 'String';
            Description = 'Type a category to identify the email type, such as lead outreach, customer follow-up, or service alert, to tie the email to a business group or function.';
            Caption = 'Category';
        }
        field(27; CreatedOn; Datetime)
        {
            ExternalName = 'createdon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Shows the date and time when the record was created. The date and time are displayed in the time zone selected in Microsoft Dynamics 365 options.';
            Caption = 'Created On';
        }
        field(28; OwningBusinessUnit; GUID)
        {
            ExternalName = 'owningbusinessunit';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the business unit that owns the email activity.';
            Caption = 'Owning Business Unit';
            TableRelation = "CRM Businessunit".BusinessUnitId;
        }
        field(31; Sender; Text[250])
        {
            ExternalName = 'sender';
            ExternalType = 'String';
            Description = 'Sender of the email.';
            Caption = 'From';
        }
        field(32; Subject; Text[800])
        {
            ExternalName = 'subject';
            ExternalType = 'String';
            Description = 'Type a short description about the objective or primary topic of the email.';
            Caption = 'Subject';
        }
        field(33; ModifiedOn; Datetime)
        {
            ExternalName = 'modifiedon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Shows the date and time when the record was last updated. The date and time are displayed in the time zone selected in Microsoft Dynamics 365 options.';
            Caption = 'Modified On';
        }
        field(34; ToRecipients; Text[500])
        {
            ExternalName = 'torecipients';
            ExternalType = 'String';
            Description = 'Shows the email addresses corresponding to the recipients.';
            Caption = 'To Recipients';
        }
        field(35; DeliveryReceiptRequested; Boolean)
        {
            ExternalName = 'deliveryreceiptrequested';
            ExternalType = 'Boolean';
            Description = 'Select whether the sender should receive confirmation that the email was delivered.';
            Caption = 'Delivery Receipt Requested';
        }
        field(36; RegardingObjectId; GUID)
        {
            ExternalName = 'regardingobjectid';
            ExternalType = 'Lookup';
            Description = 'Choose the record that the email relates to.';
            Caption = 'Regarding';
            TableRelation = "CRM Account".AccountId;
        }
        field(37; StateCode; Option)
        {
            ExternalName = 'statecode';
            ExternalType = 'State';
            ExternalAccess = Modify;
            Description = 'Shows whether the email is open, completed, or canceled. Completed and canceled email is read-only and can''t be edited.';
            Caption = 'Activity Status';
            InitValue = Open;
            OptionMembers = Open,Completed,Canceled;
            OptionOrdinalValues = 0, 1, 2;
        }
        field(38; OwnerId; GUID)
        {
            ExternalName = 'ownerid';
            ExternalType = 'Owner';
            Description = 'Enter the user or team who is assigned to manage the record. This field is updated every time the record is assigned to a different user.';
            Caption = 'Owner';
        }
        field(39; MessageId; Text[320])
        {
            ExternalName = 'messageid';
            ExternalType = 'String';
            Description = 'Unique identifier of the email message. Used only for email that is received.';
            Caption = 'Message ID';
        }
        field(40; OwningUser; GUID)
        {
            ExternalName = 'owninguser';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the user who owns the email activity.';
            Caption = 'Owning User';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(59; OverriddenCreatedOn; Date)
        {
            ExternalName = 'overriddencreatedon';
            ExternalType = 'DateTime';
            ExternalAccess = Insert;
            Description = 'Date and time that the record was migrated.';
            Caption = 'Record Created On';
        }
        field(60; ImportSequenceNumber; Integer)
        {
            ExternalName = 'importsequencenumber';
            ExternalType = 'Integer';
            ExternalAccess = Insert;
            Description = 'Unique identifier of the data import or data migration that created this record.';
            Caption = 'Import Sequence Number';
        }
        field(61; DeliveryAttempts; Integer)
        {
            ExternalName = 'deliveryattempts';
            ExternalType = 'Integer';
            Description = 'Shows the count of the number of attempts made to send the email. The count is used as an indicator of email routing issues.';
            Caption = 'No. of Delivery Attempts';
        }
        field(63; Compressed; Boolean)
        {
            ExternalName = 'compressed';
            ExternalType = 'Boolean';
            ExternalAccess = Read;
            Description = 'Indicates if the body is compressed.';
            Caption = 'Compression';
        }
        field(64; Notifications; Option)
        {
            ExternalName = 'notifications';
            ExternalType = 'Picklist';
            Description = 'Select the notification code to identify issues with the email recipients or attachments, such as blocked attachments.';
            Caption = 'Notifications';
            InitValue = None;
            OptionMembers = None,TheMessageWasSavedAsAMicrosoftDynamics365EmailRecordButNotAllTheAttachmentsCouldBeSavedWithIt,TruncatedBody;
            OptionOrdinalValues = 0, 1, 2;
        }
        field(65; TimeZoneRuleVersionNumber; Integer)
        {
            ExternalName = 'timezoneruleversionnumber';
            ExternalType = 'Integer';
            Description = 'For internal use only.';
            Caption = 'Time Zone Rule Version Number';
        }
        field(66; UTCConversionTimeZoneCode; Integer)
        {
            ExternalName = 'utcconversiontimezonecode';
            ExternalType = 'Integer';
            Description = 'Time zone code that was in use when the record was created.';
            Caption = 'UTC Conversion Time Zone Code';
        }
        field(74; CreatedOnBehalfBy; GUID)
        {
            ExternalName = 'createdonbehalfby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Shows who created the record on behalf of another user.';
            Caption = 'Created By (Delegate)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(78; ModifiedOnBehalfBy; GUID)
        {
            ExternalName = 'modifiedonbehalfby';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Shows who last updated the record on behalf of another user.';
            Caption = 'Modified By (Delegate)';
            TableRelation = "CRM Systemuser".SystemUserId;
        }
        field(84; IsRegularActivity; Boolean)
        {
            ExternalName = 'isregularactivity';
            ExternalType = 'Boolean';
            ExternalAccess = Read;
            Description = 'Information regarding whether the activity is a regular activity type or event type.';
            Caption = 'Is Regular Activity';
        }
        field(86; OwningTeam; GUID)
        {
            ExternalName = 'owningteam';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Unique identifier of the team who owns the email activity.';
            Caption = 'Owning Team';
            TableRelation = "CRM Team".TeamId;
        }
        field(87; TransactionCurrencyId; GUID)
        {
            ExternalName = 'transactioncurrencyid';
            ExternalType = 'Lookup';
            Description = 'Choose the local currency for the record to make sure budgets are reported in the correct currency.';
            Caption = 'Currency';
            TableRelation = "CRM Transactioncurrency".TransactionCurrencyId;
        }
        field(89; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Shows the conversion rate of the record''s currency. The exchange rate is used to convert all money fields in the record from the local currency to the system''s default currency.';
            Caption = 'Exchange Rate';
        }
        field(90; EmailSender; GUID)
        {
            ExternalName = 'emailsender';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Shows the sender of the email.';
            Caption = 'Sender';
            TableRelation = "CRM Account".AccountId;
        }
        field(94; SendersAccount; GUID)
        {
            ExternalName = 'sendersaccount';
            ExternalType = 'Lookup';
            ExternalAccess = Read;
            Description = 'Shows the parent account of the sender of the email.';
            Caption = 'Senders Account';
            TableRelation = "CRM Account".AccountId;
        }
        field(96; AttachmentCount; Integer)
        {
            ExternalName = 'attachmentcount';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'Shows the umber of attachments of the email message.';
            Caption = 'Attachment Count';
        }
        field(100; DeliveryPriorityCode; Option)
        {
            ExternalName = 'deliveryprioritycode';
            ExternalType = 'Picklist';
            ExternalAccess = Insert;
            Description = 'Select the priority of delivery of the email to the email server.';
            Caption = 'Delivery Priority';
            InitValue = Normal;
            OptionMembers = Low,Normal,High;
            OptionOrdinalValues = 0, 1, 2;
        }
        field(102; ParentActivityId; GUID)
        {
            ExternalName = 'parentactivityid';
            ExternalType = 'Lookup';
            ExternalAccess = Insert;
            Description = 'Select the activity that the email is associated with.';
            Caption = 'Parent Activity Id';
            TableRelation = "CDS Email".ActivityId;
        }
        field(103; ParentActivityIdName; Text[800])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS Email".Subject where(ActivityId = field(ParentActivityId)));
            ExternalName = 'parentactivityidname';
            ExternalType = 'String';
            ExternalAccess = Read;
            Description = 'Parent Activity Name';
            Caption = 'Parent Activity Name';
        }
        field(104; InReplyTo; Text[320])
        {
            ExternalName = 'inreplyto';
            ExternalType = 'String';
            ExternalAccess = Read;
            Description = 'Type the ID of the email message that this email activity is a response to.';
            Caption = 'In Reply To Message';
        }
        field(105; BaseConversationIndexHash; Integer)
        {
            ExternalName = 'baseconversationindexhash';
            ExternalType = 'Integer';
            Description = 'Hash of base of conversation index.';
            Caption = 'Conversation Index (Hash)';
        }
        field(106; ConversationIndex; Text[2048])
        {
            ExternalName = 'conversationindex';
            ExternalType = 'String';
            ExternalAccess = Read;
            Description = 'Identifier for all the email responses for this conversation.';
            Caption = 'Conversation Index';
        }
        field(107; CorrelationMethod; Option)
        {
            ExternalName = 'correlationmethod';
            ExternalType = 'Picklist';
            ExternalAccess = Read;
            Description = 'Shows how an email is matched to an existing email in Microsoft Dynamics 365. For system use only.';
            Caption = 'Correlation Method';
            InitValue = None;
            OptionMembers = None,Skipped,XHeader,InReplyTo,TrackingToken,ConversationIndex,SmartMatching,CustomCorrelation;
            OptionOrdinalValues = 0, 1, 2, 3, 4, 5, 6, 7;
        }
        field(108; SentOn; Datetime)
        {
            ExternalName = 'senton';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Shows the date and time that the email was sent.';
            Caption = 'Date Sent';
        }
        field(109; PostponeEmailProcessingUntil; Datetime)
        {
            ExternalName = 'postponeemailprocessinguntil';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'For internal use only.';
            Caption = 'Delay email processing until';
        }
        field(111; ProcessId; GUID)
        {
            ExternalName = 'processid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Shows the ID of the process.';
            Caption = 'Process';
        }
        field(112; StageId; GUID)
        {
            ExternalName = 'stageid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Shows the ID of the stage.';
            Caption = '(Deprecated) Process Stage';
        }
        field(113; ActivityAdditionalParams; BLOB)
        {
            ExternalName = 'activityadditionalparams';
            ExternalType = 'Memo';
            Description = 'For internal use only.';
            Caption = 'Additional Parameters';
            Subtype = Memo;
        }
        field(115; IsUnsafe; Integer)
        {
            ExternalName = 'isunsafe';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'For internal use only.';
            Caption = 'IsUnsafe';
        }
        field(118; OnHoldTime; Integer)
        {
            ExternalName = 'onholdtime';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'Shows how long, in minutes, that the record was on hold.';
            Caption = 'On Hold Time (Minutes)';
        }
        field(119; LastOnHoldTime; Datetime)
        {
            ExternalName = 'lastonholdtime';
            ExternalType = 'DateTime';
            Description = 'Contains the date and time stamp of the last on hold time.';
            Caption = 'Last On Hold Time';
        }
        field(123; TraversedPath; Text[1250])
        {
            ExternalName = 'traversedpath';
            ExternalType = 'String';
            Description = 'For internal use only.';
            Caption = '(Deprecated) Traversed Path';
        }
        field(126; AttachmentOpenCount; Integer)
        {
            ExternalName = 'attachmentopencount';
            ExternalType = 'Integer';
            ExternalAccess = Modify;
            Description = 'Shows the number of times an email attachment has been viewed.';
            Caption = 'Attachment Open Count';
        }
        field(127; ConversationTrackingId; GUID)
        {
            ExternalName = 'conversationtrackingid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Conversation Tracking Id.';
            Caption = 'Conversation Tracking Id';
        }
        field(128; DelayedEmailSendTime; Datetime)
        {
            ExternalName = 'delayedemailsendtime';
            ExternalType = 'DateTime';
            Description = 'Enter the expected date and time when email will be sent.';
            Caption = 'Send Later';
        }
        field(129; LastOpenedTime; Datetime)
        {
            ExternalName = 'lastopenedtime';
            ExternalType = 'DateTime';
            Description = 'Shows the latest date and time when email was opened.';
            Caption = 'Last Opened Time';
        }
        field(130; LinksClickedCount; Integer)
        {
            ExternalName = 'linksclickedcount';
            ExternalType = 'Integer';
            ExternalAccess = Modify;
            Description = 'Shows the number of times a link in an email has been clicked.';
            Caption = 'Links Clicked Count';
        }
        field(131; OpenCount; Integer)
        {
            ExternalName = 'opencount';
            ExternalType = 'Integer';
            ExternalAccess = Modify;
            Description = 'Shows the number of times an email has been opened.';
            Caption = 'Open Count';
        }
        field(132; ReplyCount; Integer)
        {
            ExternalName = 'replycount';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'Shows the number of replies received for an email.';
            Caption = 'Reply Count';
        }
        field(133; EmailTrackingId; GUID)
        {
            ExternalName = 'emailtrackingid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Email Tracking Id.';
            Caption = 'Email Tracking Id';
        }
        field(134; FollowEmailUserPreference; Boolean)
        {
            ExternalName = 'followemailuserpreference';
            ExternalType = 'Boolean';
            Description = 'Select whether the email allows following recipient activities sent from Microsoft Dynamics 365.This is user preference state which can be overridden by system evaluated state.';
            Caption = 'Following';
        }
        field(136; IsEmailFollowed; Boolean)
        {
            ExternalName = 'isemailfollowed';
            ExternalType = 'Boolean';
            ExternalAccess = Read;
            Description = 'For internal use only. Shows whether this email is followed. This is evaluated state which overrides user selection of follow email.';
            Caption = 'Followed';
        }
        field(138; EmailReminderExpiryTime; Datetime)
        {
            ExternalName = 'emailreminderexpirytime';
            ExternalType = 'DateTime';
            Description = 'Shows the date and time when an email reminder expires.';
            Caption = 'Email Reminder Expiry Time';
        }
        field(139; EmailReminderType; Option)
        {
            ExternalName = 'emailremindertype';
            ExternalType = 'Picklist';
            Description = 'Shows the type of the email reminder.';
            Caption = 'Email Reminder Type';
            InitValue = IfIDoNotReceiveAReplyBy;
            OptionMembers = IfIDoNotReceiveAReplyBy,IfTheEmailIsNotOpenedBy,RemindMeAnywaysAt;
            OptionOrdinalValues = 0, 1, 2;
        }
        field(141; EmailReminderStatus; Option)
        {
            ExternalName = 'emailreminderstatus';
            ExternalType = 'Picklist';
            ExternalAccess = Read;
            Description = 'Shows the status of the email reminder.';
            Caption = 'Email Reminder Status';
            InitValue = NotSet;
            OptionMembers = NotSet,ReminderSet,ReminderExpired,ReminderInvalid;
            OptionOrdinalValues = 0, 1, 2, 3;
        }
        field(143; EmailReminderText; Text[1250])
        {
            ExternalName = 'emailremindertext';
            ExternalType = 'String';
            Description = 'For internal use only.';
            Caption = 'Email Reminder Text';
        }
        field(147; ReminderActionCardId; GUID)
        {
            ExternalName = 'reminderactioncardid';
            ExternalType = 'Uniqueidentifier';
            Description = 'Reminder Action Card Id.';
            Caption = 'Reminder Action Card Id.';
        }
        field(149; SortDate; Datetime)
        {
            ExternalName = 'sortdate';
            ExternalType = 'DateTime';
            Description = 'Shows the date and time by which the activities are sorted.';
            Caption = 'Sort Date';
        }
        field(151; IsEmailReminderSet; Boolean)
        {
            ExternalName = 'isemailreminderset';
            ExternalType = 'Boolean';
            ExternalAccess = Read;
            Description = 'For internal use only. Shows whether this email Reminder is Set.';
            Caption = 'Reminder Set';
        }
        field(10001; CorrelatedActivityId; GUID)
        {
            ExternalName = 'correlatedactivityid';
            ExternalType = 'Lookup';
            ExternalAccess = Insert;
            Description = 'Correlated Activity Id';
            Caption = 'Correlated Activity Id';
            TableRelation = "CDS Email".ActivityId;
        }
        field(10003; AcceptingEntityId; GUID)
        {
            ExternalName = 'acceptingentityid';
            ExternalType = 'Lookup';
            ExternalAccess = Insert;
            Description = 'The Entity that Accepted the Email';
            Caption = 'Accepting Entity';
        }
        field(10006; CorrelatedActivityIdName; Text[800])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS Email".Subject where(ActivityId = field(CorrelatedActivityId)));
            ExternalName = 'correlatedactivityidname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        field(10008; ReservedForInternalUse; BLOB)
        {
            ExternalName = 'reservedforinternaluse';
            ExternalType = 'Memo';
            Description = 'For internal use only';
            Caption = 'Reserved for internal use';
            Subtype = Memo;
        }
        field(10013; msdyn_RecipientList; Text[2048])
        {
            ExternalName = 'msdyn_recipientlist';
            ExternalType = 'String';
            Description = 'Individual email will be sent to each recipient.';
            Caption = 'Recipient List';
        }
        field(10014; acwapp_PropertyBooking; GUID)
        {
            ExternalName = 'acwapp_propertybooking';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Property Booking';
            TableRelation = "CDS acwapp_propertybooking".acwapp_propertybookingId;
        }
        field(10015; acwapp_PropertyBookingName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_name where(acwapp_propertybookingId = field(acwapp_PropertyBooking)));
            ExternalName = 'acwapp_propertybookingname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
    }
    keys
    {
        key(PK; ActivityId)
        {
            Clustered = true;
        }
        key(Name; Subject)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Subject)
        {
        }
    }
}