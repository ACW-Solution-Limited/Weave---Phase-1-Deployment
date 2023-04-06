table 83022 "Generic User"
{
    Caption = 'Generic User';
    DataClassification = ToBeClassified;
    //DataPerCompany = false;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "User Setup"."User ID" where("Generic User" = filter(true));
            ValidateTableRelation = false;
            // trigger OnValidate()
            // var
            //     l_recUser: Record User;
            // begin
            //     l_recUser.Reset;
            //     l_recUser.Get("User Name", "User ID");
            //     "User Name" := l_recUser."Full Name";
            //     "E-Mail" := l_recUser."Contact Email";
            // end;
        }
        field(2; "User Name"; Text[80])
        {
            Caption = 'User Name';
            DataClassification = ToBeClassified;

        }
        field(3; "E-Mail"; Text[250])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
        field(4; "Vender No."; Code[20])
        {
            Caption = 'Vender No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            var
                l_recVendor: Record Vendor;
            begin
                l_recVendor.reset;
                l_recVendor.Get("Vender No.");
                "Vender Name" := l_recVendor.Name;

            end;
        }
        field(5; "Vender Name"; Text[100])
        {
            Caption = 'Vender Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "User ID", "User Name")
        {
            Clustered = true;
        }
    }
}
