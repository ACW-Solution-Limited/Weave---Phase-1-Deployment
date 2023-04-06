table 83027 "Bank Transfer Payment"
{
    Caption = 'Bank Transfer Payment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Bedroom Offer"; Code[250])
        {
            Caption = 'Bedroom Offer';
            DataClassification = ToBeClassified;
        }
        field(3; "Bank Transfer Payslip"; Text[250])
        {
            Caption = 'Bank Transfer Payslip';
            DataClassification = ToBeClassified;
        }
        field(4; "Confirmed Transfer Payment"; Boolean)
        {
            Caption = 'Confirmed Bank Transfer Payment';
            DataClassification = ToBeClassified;
        }

        field(5; "Company Guid"; Guid)
        {
            Caption = 'Company Guid';
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
