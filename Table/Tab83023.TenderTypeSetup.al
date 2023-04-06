table 83023 "Tender Type Setup"
{
    Caption = 'Tender Type Setup';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Key"; Guid)
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Tender Type"; Code[20])
        {
            Caption = 'Tender Type';
            DataClassification = ToBeClassified;
        }
        field(4; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }

        field(5; "Invoice Description"; Text[2048])
        {
            Caption = 'Invoice Description';
            DataClassification = ToBeClassified;
        }

        field(6; "Currencyid"; Guid)
        {
            Caption = 'Currencyid';
            DataClassification = ToBeClassified;
        }

        field(7; "Currency"; Code[10])
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }

        field(8; "Percentage"; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = ToBeClassified;
        }
        field(9; "Effective Start Date"; Date)
        {
            Caption = 'Effective Start Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Effective End Date"; Date)
        {
            Caption = 'Effective End Date';
            DataClassification = ToBeClassified;
        }



    }
    keys
    {
        key(PK; "Tender Type")
        {
            Clustered = true;
        }
    }
}
