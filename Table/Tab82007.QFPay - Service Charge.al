table 82007 "QFPay Service Charge"
{
    Caption = 'QFPay Service Charge';
    DataClassification = ToBeClassified;
    DrillDownPageId = "QFPay Service Charge";
    LookupPageId = "QFPay Service Charge";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Tender Type"; Text[250])
        {
            Caption = 'Tender Type';
            DataClassification = ToBeClassified;
        }
        field(3; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = ToBeClassified;
        }
        field(4; "Plus Fixed Amount"; Decimal)
        {
            Caption = 'Plus Fixed Amount';
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Refund Fee"; Boolean)
        {
            Caption = 'Refund Fee';
            DataClassification = ToBeClassified;
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
