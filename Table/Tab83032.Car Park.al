table 83032 "Car Park"
{
    Caption = 'Car Park';
    DataClassification = ToBeClassified;
    LookupPageId = "Car Park";
    DrillDownPageId = "Car Park";

    fields
    {
        field(1; "CRM Guid"; Guid)
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Car Park ID"; Code[50])
        {
            Caption = 'Car Park ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Car Park Type Name"; Text[250])
        {
            Caption = 'Car Park Type Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Car Park Property Guid"; Guid)
        {
            Caption = 'Car Park Property Guid';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                l_recPropertyUnit: Record "Property Unit";
            begin
                l_recPropertyUnit.Reset();
                l_recPropertyUnit.SetRange("CRM GUID", "Car Park Property Guid");
                if l_recPropertyUnit.FindFirst() then
                    "Car Park Property No." := l_recPropertyUnit."No.";
            end;
        }
        field(5; "Car Park Property No."; Code[50])
        {
            Caption = 'Car Park Property No.';
            DataClassification = ToBeClassified;
        }

        field(6; "Monthy Rent"; Decimal) { }
        field(10; "Contract No."; Code[250])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = "Lease Contract Header"."No.";
        }
        field(11; "Start Date"; DateTime)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(12; "End Date"; DateTime)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Active,Inactive;
        }
        field(30; "Created On"; DateTime)
        {
            Caption = 'Created On';
            DataClassification = ToBeClassified;
        }
        field(31; "Modified On"; DateTime)
        {
            Caption = 'Modified On';
            DataClassification = ToBeClassified;
        }

        field(50; "Created to Billing Schedule"; Boolean) { }
        field(51; "Bill. Sche. Creation Datetime"; DateTime) { }

    }
    keys
    {
        key(PK; "Car Park ID")
        {
            Clustered = true;
        }
    }
}
