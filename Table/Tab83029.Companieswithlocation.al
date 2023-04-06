table 83029 "Companies with location"
{
    Caption = 'Companies with location';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
            trigger OnValidate()
            var
                l_recCompany: Record Company;
            begin
                l_recCompany.Get(Name);
                Rec."Display Name" := l_recCompany."Display Name";
            end;
        }
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; Location; Option)
        {
            Caption = 'Location';
            OptionMembers = HK,SG;
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }

}
