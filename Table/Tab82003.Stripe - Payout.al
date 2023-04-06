table 82003 "Stripe Payout"
{
    Caption = 'Stripe Payout';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Text[50])
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }
        field(2; Created; DateTime)
        {
            Caption = 'Created';
            DataClassification = SystemMetadata;
        }
        field(3; "Arrival Date"; DateTime)
        {
            Caption = 'Arrival Date';
            DataClassification = SystemMetadata;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(5; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = SystemMetadata;
        }
        field(7; Status; Option)
        {
            OptionMembers = Open,Created,Posted;
            Caption = 'Status';
            DataClassification = SystemMetadata;
        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sales Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Sales Document Type';
            DataClassification = SystemMetadata;
        }
        field(10; "Sales Document No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }




        field(24; "General Journal Document Type"; Enum "Gen. Journal Document Type") { DataClassification = ToBeClassified; }
        field(25; "General Journal Document No."; Code[100]) { DataClassification = ToBeClassified; }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
        key(Key1; "Posting Date")
        { }
    }
}
