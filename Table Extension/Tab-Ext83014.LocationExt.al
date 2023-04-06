tableextension 83014 LocationExt extends Location
{
    fields
    {
        field(80000; "Company Name"; Text[250])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Company;
            trigger OnValidate()
            var
                l_recCompanyInformation: Record "Company Information";
            begin
                l_recCompanyInformation.Reset();
                l_recCompanyInformation.ChangeCompany("Company Name");
                l_recCompanyInformation.Get;
                "Country/Region Code" := l_recCompanyInformation."Country/Region Code";
            end;
        }

    }
}
