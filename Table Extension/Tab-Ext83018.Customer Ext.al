tableextension 83018 CustomerExt extends Customer
{
    fields
    {
        field(83000; "First Name"; Text[100])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(83001; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(83002; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
        }
        field(83003; "CRM GUID"; Guid)
        {
            Caption = 'CRM GUID';
            DataClassification = ToBeClassified;
        }

        field(83010; "HK Customer"; Boolean) { Caption = 'HK Customer'; }
        field(83011; "SG Customer"; Boolean) { Caption = 'SG Customer'; }

    }
}
