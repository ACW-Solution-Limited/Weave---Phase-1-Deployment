table 83008 "Expense Type"
{
    Caption = 'Expense Type';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(3; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }

    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
