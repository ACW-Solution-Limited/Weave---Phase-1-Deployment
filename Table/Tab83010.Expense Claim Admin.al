table 83010 "Expense Claim Admin"
{
    Caption = 'Expense Claim Admin';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[100])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = SystemMetadata;
            TableRelation = Vendor."No.";
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(4; Email; Text[250])
        {
            Caption = 'Email';
            DataClassification = SystemMetadata;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
