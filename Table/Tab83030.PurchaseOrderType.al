table 83030 "Purchase Order Type"
{
    Caption = 'Purchase Order Type';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Type"; Code[30])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(2; Subtype; Code[30])
        {
            Caption = 'Subtype';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Type",Subtype)
        {
            Clustered = true;
        }
    }
}
