table 83026 "Event Fee"
{
    Caption = 'Event Fee';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Customer Name"; Text[150])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Customer Code"; Code[50])
        {
            Caption = 'Customer Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Contact Code"; Code[20])
        {
            Caption = 'Contact Code';
            DataClassification = ToBeClassified;
        }
        field(5; Currency; Code[10])
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(9; "Amount Including VAT"; Decimal)
        {
            Caption = 'Amount Including VAT';
            DataClassification = ToBeClassified;
        }
        field(10; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(11; "Payment Reference ID"; Text[250])
        {
            Caption = 'Payment Reference ID';
            DataClassification = ToBeClassified;
        }
        field(12; "Company  Guid"; Guid)
        {
            Caption = 'Company  Guid';
            DataClassification = ToBeClassified;
        }
        field(13; "Property No."; Code[50])
        {
            Caption = 'Property No.';
            DataClassification = ToBeClassified;
        }
        field(14; "Property Booking No."; Code[50])
        {
            Caption = 'Property No.';
            DataClassification = ToBeClassified;
        }
        field(15; "Contract No."; Code[50])
        {
            Caption = 'Property No.';
            DataClassification = ToBeClassified;
        }
        field(16; "Event"; Code[30])
        {
            Caption = 'Event';
            DataClassification = ToBeClassified;
        }
        field(17; "Event Session"; Code[50])
        {
            Caption = 'Event Session';
            DataClassification = ToBeClassified;
        }
        field(18; "Event Registration"; Code[50])
        {
            Caption = 'Event Registration';
            DataClassification = ToBeClassified;
        }

        field(20; "BC Status"; Option)
        {
            Caption = 'BC Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Open,Created,Posted;
        }
        field(22; "Stripe/QFPay Invoice ID"; Text[250])
        {
            Caption = 'Stripe/QFPay Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(23; "Posted Sales Invoice No."; Code[50])
        {
            Caption = 'Posted Sales Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(24; "External Payment Gateway"; Enum "External Payment Gateway")
        {
            DataClassification = ToBeClassified;
        }


        field(100; "Billing Schedule Line No."; Integer) { Caption = 'Billing Schedule Line No.'; }

    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

        "BC Status" := "BC Status"::Open;
    end;
}
