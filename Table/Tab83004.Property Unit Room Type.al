table 83004 "Property Unit Room Type"
{
    Caption = 'Property Unit Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key"; Guid)
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[100])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(3; "Property No."; Code[20])
        {
            Caption = 'Property No.';
            DataClassification = SystemMetadata;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }

        field(5; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(6; "Company Guid for CRM"; Guid) { }
    }

    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }
}
