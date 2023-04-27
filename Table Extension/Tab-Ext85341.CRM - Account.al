tableextension 83500 AccountExt extends "CRM Account"
{
    Description = 'Business that represents a customer or potential customer. The company that is billed in business transactions.';

    fields
    {
        field(50223; TimeSpentByMeOnEmailAndMeetings; Text[1250])
        {
            ExternalName = 'timespentbymeonemailandmeetings';
            ExternalType = 'String';
            ExternalAccess = Read;
            Description = 'Total time spent for emails (read and write) and meetings by me in relation to account record.';
            Caption = 'Time Spent by me';
        }
        field(50236; PrimarySatoriId; Text[200])
        {
            ExternalName = 'primarysatoriid';
            ExternalType = 'String';
            Description = 'Primary Satori ID for Account';
            Caption = 'Primary Satori ID';
        }
        field(50237; PrimaryTwitterId; Text[128])
        {
            ExternalName = 'primarytwitterid';
            ExternalType = 'String';
            Description = 'Primary Twitter ID for Account';
            Caption = 'Primary Twitter ID';
        }
        field(50241; OnHoldTime; Integer)
        {
            ExternalName = 'onholdtime';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'Shows how long, in minutes, that the record was on hold.';
            Caption = 'On Hold Time (Minutes)';
        }
        field(50242; LastOnHoldTime; Datetime)
        {
            ExternalName = 'lastonholdtime';
            ExternalType = 'DateTime';
            Description = 'Contains the date and time stamp of the last on hold time.';
            Caption = 'Last On Hold Time';
        }
        field(50244; FollowEmail; Boolean)
        {
            ExternalName = 'followemail';
            ExternalType = 'Boolean';
            Description = 'Information about whether to allow following email activity like opens, attachment views and link clicks for emails sent to the account.';
            Caption = 'Follow Email Activity';
        }
        field(50247; MarketingOnly; Boolean)
        {
            ExternalName = 'marketingonly';
            ExternalType = 'Boolean';
            Description = 'Whether is only for marketing';
            Caption = 'Marketing Only';
        }
        field(50019; TeamsFollowed; Integer)
        {
            ExternalName = 'teamsfollowed';
            ExternalType = 'Integer';
            Description = 'Number of users or conversations followed the record';
            Caption = 'TeamsFollowed';
        }
        field(50022; msdyn_gdproptout; Boolean)
        {
            ExternalName = 'msdyn_gdproptout';
            ExternalType = 'Boolean';
            Description = 'Describes whether account is opted out or not';
            Caption = 'GDPR Optout';
        }
        field(50030; acwapp_LoyaltyProgram; GUID)
        {
            ExternalName = 'acwapp_loyaltyprogram';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Loyalty Program';
            TableRelation = "CDS acwapp_loyalprogram".acwapp_loyalprogramId;
        }
        // field(50031; acwapp_RedeemTransaction; GUID)
        // {
        //     ExternalName = 'acwapp_redeemtransaction';
        //     ExternalType = 'Lookup';
        //     Description = '';
        //     Caption = 'Redeem Transaction';
        //     TableRelation = "CDS acwapp_redeemtransaction".acwapp_redeemtransactionId;
        // }
        // field(50032; acwapp_Tenant; GUID)
        // {
        //     ExternalName = 'acwapp_tenant';
        //     ExternalType = 'Lookup';
        //     Description = '';
        //     Caption = 'Tenant';
        //     TableRelation = "CDS acwapp_store".acwapp_storeId;
        // }
        field(50033; acwapp_LoyaltyProgramName; Text[500])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_loyalprogram".acwapp_name where(acwapp_loyalprogramId = field(acwapp_LoyaltyProgram)));
            ExternalName = 'acwapp_loyaltyprogramname';
            ExternalType = 'String';
            ExternalAccess = Read;
        }
        // field(50034; acwapp_RedeemTransactionName; Text[500])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("CDS acwapp_redeemtransaction".acwapp_name where(acwapp_redeemtransactionId = field(acwapp_RedeemTransaction)));
        //     ExternalName = 'acwapp_redeemtransactionname';
        //     ExternalType = 'String';
        //     ExternalAccess = Read;
        // }
        // field(50035; acwapp_TenantName; Text[500])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("CDS acwapp_store".acwapp_name where(acwapp_storeId = field(acwapp_Tenant)));
        //     ExternalName = 'acwapp_tenantname';
        //     ExternalType = 'String';
        //     ExternalAccess = Read;
        // }
        field(50036; acwapp_CompanyName; Text[500])
        {
            ExternalName = 'acwapp_companyname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Company Name';
        }
        field(50037; acwapp_CompanyID; Text[500])
        {
            ExternalName = 'acwapp_companyid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Company ID';
        }
        field(50041; acwapp_Type; Option)
        {
            ExternalName = 'acwapp_type';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Type';
            InitValue = " ";
            OptionMembers = " ","Event",Profile;
            OptionOrdinalValues = -1, 557130000, 557130001;
        }
        field(50043; acwapp_WebsiteURL; Text[500])
        {
            ExternalName = 'acwapp_websiteurl';
            ExternalType = 'String';
            Description = '';
            Caption = 'Website URL';
        }
        field(50044; acwapp_Description; Text[500])
        {
            ExternalName = 'acwapp_description';
            ExternalType = 'String';
            Description = '';
            Caption = 'Description';
        }
        field(50054; acwapp_AnnualRevenue; Decimal)
        {
            ExternalName = 'acwapp_annualrevenue';
            ExternalType = 'Money';
            Description = '';
            Caption = 'Annual Revenue';
        }
        field(50055; acwapp_annualrevenue_Base; Decimal)
        {
            ExternalName = 'acwapp_annualrevenue_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Annual Revenue in base currency.';
            Caption = 'Annual Revenue (Base)';
        }
        field(50056; acwapp_YearFounded; Integer)
        {
            ExternalName = 'acwapp_yearfounded';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Year Founded';
        }
        field(50058; acwapp_NumberofChildCompany; Integer)
        {
            ExternalName = 'acwapp_numberofchildcompany';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Number of Child Company';
        }
        field(50059; acwapp_NumberofChildCompany_Date; Datetime)
        {
            ExternalName = 'acwapp_numberofchildcompany_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Number of Child Company.';
            Caption = 'Number of Child Company (Last Updated On)';
        }
        field(50060; acwapp_NumberofChildCompany_State; Integer)
        {
            ExternalName = 'acwapp_numberofchildcompany_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Number of Child Company.';
            Caption = 'Number of Child Company (State)';
        }
        field(50061; acwapp_NumberofEmployees; Integer)
        {
            ExternalName = 'acwapp_numberofemployees';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'Number of Employees';
        }
        field(50062; acwapp_NumberofAssociatedContact; Integer)
        {
            ExternalName = 'acwapp_numberofassociatedcontact';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Number of Associated Contact';
        }
        field(50063; acwapp_NumberofAssociatedContact_Date; Datetime)
        {
            ExternalName = 'acwapp_numberofassociatedcontact_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Number of Associated Contact.';
            Caption = 'Number of Associated Contact (Last Updated On)';
        }
        field(50064; acwapp_NumberofAssociatedContact_State; Integer)
        {
            ExternalName = 'acwapp_numberofassociatedcontact_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Number of Associated Contact.';
            Caption = 'Number of Associated Contact (State)';
        }
        field(50065; acwapp_NumberofAssociatedDeals; Integer)
        {
            ExternalName = 'acwapp_numberofassociateddeals';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Number of Associated Deals';
        }
        field(50066; acwapp_NumberofAssociatedDeals_Date; Datetime)
        {
            ExternalName = 'acwapp_numberofassociateddeals_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Number of Associated Deals.';
            Caption = 'Number of Associated Deals (Last Updated On)';
        }
        field(50067; acwapp_NumberofAssociatedDeals_State; Integer)
        {
            ExternalName = 'acwapp_numberofassociateddeals_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Number of Associated Deals.';
            Caption = 'Number of Associated Deals (State)';
        }
        field(50068; acwapp_NumberofOpenDeals; Integer)
        {
            ExternalName = 'acwapp_numberofopendeals';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Number of Open Deals';
        }
        field(50069; acwapp_NumberofOpenDeals_Date; Datetime)
        {
            ExternalName = 'acwapp_numberofopendeals_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Number of Open Deals.';
            Caption = 'Number of Open Deals (Last Updated On)';
        }
        field(50070; acwapp_NumberofOpenDeals_State; Integer)
        {
            ExternalName = 'acwapp_numberofopendeals_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Number of Open Deals.';
            Caption = 'Number of Open Deals (State)';
        }
        field(50071; acwapp_TotalOpenDealValue; Decimal)
        {
            ExternalName = 'acwapp_totalopendealvalue';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Open Deal Value';
        }
        field(50072; acwapp_totalopendealvalue_Base; Decimal)
        {
            ExternalName = 'acwapp_totalopendealvalue_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Open Deal Value in base currency.';
            Caption = 'Total Open Deal Value (Base)';
        }
        field(50073; acwapp_TotalOpenDealValue_Date; Datetime)
        {
            ExternalName = 'acwapp_totalopendealvalue_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Total Open Deal Value.';
            Caption = 'Total Open Deal Value (Last Updated On)';
        }
        field(50074; acwapp_TotalOpenDealValue_State; Integer)
        {
            ExternalName = 'acwapp_totalopendealvalue_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Total Open Deal Value.';
            Caption = 'Total Open Deal Value (State)';
        }
        field(50075; acwapp_TotalRevenue; Decimal)
        {
            ExternalName = 'acwapp_totalrevenue';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = '';
            Caption = 'Total Revenue';
        }
        field(50076; acwapp_totalrevenue_Base; Decimal)
        {
            ExternalName = 'acwapp_totalrevenue_base';
            ExternalType = 'Money';
            ExternalAccess = Read;
            Description = 'Value of the Total Revenue in base currency.';
            Caption = 'Total Revenue (Base)';
        }
        field(50077; acwapp_TotalRevenue_Date; Datetime)
        {
            ExternalName = 'acwapp_totalrevenue_date';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Last Updated time of rollup field Total Revenue.';
            Caption = 'Total Revenue (Last Updated On)';
        }
        field(50078; acwapp_TotalRevenue_State; Integer)
        {
            ExternalName = 'acwapp_totalrevenue_state';
            ExternalType = 'Integer';
            ExternalAccess = Read;
            Description = 'State of rollup field Total Revenue.';
            Caption = 'Total Revenue (State)';
        }
        field(50079; acwapp_FacebookCompanyPage; Text[500])
        {
            ExternalName = 'acwapp_facebookcompanypage';
            ExternalType = 'String';
            Description = '';
            Caption = 'Facebook Company Page';
        }
        field(50080; acwapp_LinkedInCompanyPage; Text[500])
        {
            ExternalName = 'acwapp_linkedincompanypage';
            ExternalType = 'String';
            Description = '';
            Caption = 'LinkedIn Company Page';
        }
        field(50081; acwapp_TwitterAccount; Text[500])
        {
            ExternalName = 'acwapp_twitteraccount';
            ExternalType = 'String';
            Description = '';
            Caption = 'Twitter Account';
        }
        field(50082; acwapp_Industry; Option)
        {
            ExternalName = 'acwapp_industry';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Industry';
            InitValue = " ";
            OptionMembers = " ",Business,Education,Engineering,"Health&Beauty",Legal,Media,Medical,Retail,Technology,Others;
            OptionOrdinalValues = -1, 557130000, 557130001, 557130002, 557130003, 557130004, 557130005, 557130006, 557130007, 557130008, 557130009;
        }
        field(50084; acwapp_OriginalSourceType; Option)
        {
            ExternalName = 'acwapp_originalsourcetype';
            ExternalType = 'Picklist';
            Description = '';
            Caption = 'Original Source Type';
            InitValue = " ";
            OptionMembers = " ";
            OptionOrdinalValues = -1;
        }
        field(50089; acwapp_PrimaryEmail; Text[500])
        {
            ExternalName = 'acwapp_primaryemail';
            ExternalType = 'String';
            Description = '';
            Caption = 'Primary Email';
        }
        field(50090; acwapp_ConfirmBRB; Boolean)
        {
            ExternalName = 'acwapp_confirmbrb';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Confirm BRB';
        }
        field(50092; acwapp_FirstName; Text[500])
        {
            ExternalName = 'acwapp_firstname';
            ExternalType = 'String';
            Description = '';
            Caption = 'First Name';
        }
        field(50093; acwapp_LastName; Text[500])
        {
            ExternalName = 'acwapp_lastname';
            ExternalType = 'String';
            Description = '';
            Caption = 'Last Name';
        }
        field(50094; acwapp_Contact; GUID)
        {
            ExternalName = 'acwapp_contact';
            ExternalType = 'Lookup';
            Description = '';
            Caption = 'Contact';
            TableRelation = "CRM Contact".ContactId;
        }
        field(50098; acwapp_Topic; Text[500])
        {
            ExternalName = 'acwapp_topic';
            ExternalType = 'String';
            Description = '';
            Caption = 'Topic';
        }
        field(50099; acwapp_AccountID; Text[500])
        {
            ExternalName = 'acwapp_accountid';
            ExternalType = 'String';
            Description = '';
            Caption = 'Account ID';
        }
        // field(10500; acwapp_Invoice; GUID)
        // {
        //     ExternalName = 'acwapp_invoice';
        //     ExternalType = 'Lookup';
        //     Description = '';
        //     Caption = 'Invoice';
        //     TableRelation = "CDS acwapp_invoice".acwapp_invoiceId;
        // }
        // field(50101; acwapp_InvoiceName; Text[500])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("CDS acwapp_invoice".acwapp_name where(acwapp_invoiceId = field(acwapp_Invoice)));
        //     ExternalName = 'acwapp_invoicename';
        //     ExternalType = 'String';
        //     ExternalAccess = Read;
        // }
        field(50102; acwapp_CustomerName; Text[500])
        {
            ExternalName = 'acwapp_customername';
            ExternalType = 'String';
            Description = '';
            Caption = 'Customer Name';
        }
        field(50103; acwapp_GenBusPostingGroup; Text[500])
        {
            ExternalName = 'acwapp_genbuspostinggroup';
            ExternalType = 'String';
            Description = '';
            Caption = 'Gen. Bus. Posting Group';
        }
        field(50104; acwapp_VATBusPostingGroup; Text[500])
        {
            ExternalName = 'acwapp_vatbuspostinggroup';
            ExternalType = 'String';
            Description = '';
            Caption = 'GST Bus. Posting Group';
        }
        field(50105; acwapp_CustomerPostingGroup; Text[500])
        {
            ExternalName = 'acwapp_customerpostinggroup';
            ExternalType = 'String';
            Description = '';
            Caption = 'Customer Posting Group';
        }
        field(50106; acwapp_HKCustomer; Boolean)
        {
            ExternalName = 'acwapp_hkcustomer';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'HK Customer';
        }
        field(50108; acwapp_SGCustomer; Boolean)
        {
            ExternalName = 'acwapp_sgcustomer';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'SG Customer';
        }
        field(50110; acwapp_CountryCallingCode; Text[500])
        {
            ExternalName = 'acwapp_countrycallingcode';
            ExternalType = 'String';
            Description = '';
            Caption = 'Country Calling Code';
        }
        field(50111; Adx_CreatedByIPAddress; Text[500])
        {
            ExternalName = 'adx_createdbyipaddress';
            ExternalType = 'String';
            Description = '';
            Caption = 'Created By (IP Address)';
        }
        field(50112; Adx_CreatedByUsername; Text[500])
        {
            ExternalName = 'adx_createdbyusername';
            ExternalType = 'String';
            Description = '';
            Caption = 'Created By (User Name)';
        }
        field(50113; Adx_ModifiedByIPAddress; Text[500])
        {
            ExternalName = 'adx_modifiedbyipaddress';
            ExternalType = 'String';
            Description = '';
            Caption = 'Modified By (IP Address)';
        }
        field(50114; Adx_ModifiedByUsername; Text[500])
        {
            ExternalName = 'adx_modifiedbyusername';
            ExternalType = 'String';
            Description = '';
            Caption = 'Modified By (User Name)';
        }
        field(50115; msa_managingpartnerid; GUID)
        {
            ExternalName = 'msa_managingpartnerid';
            ExternalType = 'Lookup';
            Description = 'Unique identifier for Account associated with Account.';
            Caption = 'Managing Partner';
            TableRelation = "CRM Account".AccountId;
        }
        field(50118; acwapp_B2BB2C; Boolean)
        {
            ExternalName = 'acwapp_b2bb2c';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'B2B/B2C';
        }
        field(50120; acwapp_DataMigration; Boolean)
        {
            ExternalName = 'acwapp_datamigration';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Data Migration';
        }
    }
}