table 83027 "Bank Transfer Payment"
{
    Caption = 'Bank Transfer Payment';
    DataClassification = ToBeClassified;
    LookupPageId = "Bank Transfer Payment";
    DrillDownPageId = "Bank Transfer Payment";

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

        field(6; Type; Option) { OptionMembers = " ",First,Regular; }
        field(7; "Posted Sales Invoice No."; Code[250]) { }

        field(8; Status; Option)
        {
            InitValue = Pending;
            OptionMembers = " ",Pending,Paid,Rejected;
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
