table 83002 Property
{
    Caption = 'Property';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';
            DataClassification = SystemMetadata;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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
