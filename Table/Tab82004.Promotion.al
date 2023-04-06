table 82004 Promotion
{
    Caption = 'Promotion';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key"; Guid)
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(5; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(10; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ","First Month","Monthly";
        }
        field(15; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }
}
