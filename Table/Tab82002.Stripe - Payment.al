table 82002 "Stripe Payment"
{
    Caption = 'Stripe Payment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Text[50])
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }
        field(2; "Stripe Status"; Text[50])
        {
            Caption = 'Stripe Status';
            DataClassification = SystemMetadata;
        }
        field(3; "Available On"; Integer)
        {
            Caption = 'Available On';
            DataClassification = SystemMetadata;
        }
        field(4; Created; Integer)
        {
            Caption = 'Created';
            DataClassification = SystemMetadata;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(6; "Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';
            DataClassification = SystemMetadata;
        }
        field(7; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = SystemMetadata;
        }
        field(8; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = SystemMetadata;
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = SystemMetadata;
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
        }
        field(11; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = SystemMetadata;
        }
        field(12; "Sales Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Sales Document Type';
            DataClassification = SystemMetadata;
        }
        field(13; "Sales Document No."; Code[20])
        {
            Caption = 'Sales Document No.';
            DataClassification = SystemMetadata;
        }
        field(14; "Stripe/QFPay Invoice ID"; Text[50])
        {
            Caption = 'Stripe Invoice Id';
            DataClassification = SystemMetadata;
        }
        field(15; "Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Stripe Fee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Status; Option)
        {
            OptionMembers = Open,Created,Posted;
            DataClassification = ToBeClassified;
        }

        field(18; "Payment Intent"; Text[250]) { DataClassification = ToBeClassified; }
        field(19; "Charge Id"; Text[250]) { DataClassification = ToBeClassified; }
        field(20; "Tender Type"; Text[50]) { DataClassification = ToBeClassified; }

        field(24; "General Journal Document Type"; Enum "Gen. Journal Document Type") { DataClassification = ToBeClassified; }
        field(25; "General Journal Document No."; Code[100]) { DataClassification = ToBeClassified; }

    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
        key(Key1; "Posting Date") { }
    }


}
