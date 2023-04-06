table 83003 "Property Unit"
{
    Caption = 'Property Unit';
    DataClassification = SystemMetaData;


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Property No."; Code[20])
        {
            Caption = 'Property No.';
            DataClassification = SystemMetadata;
            TableRelation = "Property Unit"."No.";
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(4; "Property Unit Type"; Text[100])
        {
            DataClassification = SystemMetadata;
            // TableRelation = "Property Unit Type".Code;

        }
        field(5; "Property Unit Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            // TableRelation = "Property Unit Type".Code;

        }
        field(6; "Property Unit Group No."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Property Unit"."No.";
        }
        field(7; "Property Unit Group"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(8; "Address"; Text[100])
        {
            DataClassification = SystemMetadata;
        }
        field(9; "Address 2"; text[100])
        {
            DataClassification = SystemMetadata;
        }
        field(10; "Country Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            var
                l_txtCounty: Text;
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", l_txtCounty, "Country Code", xRec."Country Code");
            end;
        }
        field(15; "Post Code"; Code[20])
        {
            DataClassification = SystemMetaData;

            TableRelation = IF ("Country Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                l_txtCounty: Text;
            begin
                PostCode.LookupPostCode(City, "Post Code", l_txtCounty, "Country Code");
            end;

            trigger OnValidate()
            var
                l_txtCounty: Text;

            begin
                PostCode.ValidatePostCode(City, "Post Code", l_txtCounty, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(20; City; Text[50])
        {
            DataClassification = ToBeClassified;

            TableRelation = IF ("Country Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                l_txtCounty: Text;
            begin
                PostCode.LookupPostCode(City, "Post Code", l_txtCounty, "Country Code");
            end;

            trigger OnValidate()
            var
                l_txtCounty: Text;
            begin
                PostCode.ValidateCity(City, "Post Code", l_txtCounty, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;

        }
        field(24; "Property Unit"; Code[20])
        {
            DataClassification = SystemMetaData;
        }
        field(25; "Room No."; Code[20])
        {
            DataClassification = SystemMetaData;
        }
        field(30; "Room Type Name"; Text[100])
        {
            DataClassification = SystemMetaData;
        }
        field(35; "Floor"; code[20])
        {
            DataClassification = SystemMetaData;
        }
        field(40; "Sort Order"; Integer)
        {
            DataClassification = SystemMetaData;
        }
        field(45; "Indentation"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(50; Type; Option)
        {
            DataClassification = SystemMetadata;
            InitValue = " ";
            OptionMembers = " ",Property,Floor,Room,Facilities;

        }
        field(55; "CRM GUID"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(56; MyField; Blob)
        {
            DataClassification = ToBeClassified;
        }

        field(57; "Cleaning Status"; Option)
        {
            DataClassification = SystemMetadata;
            Caption = 'Cleaning Status';
            InitValue = " ";
            OptionMembers = " ",VacantClean,VacantInspected,OccupiedDirty,OccupiedClean,VacantDirty;
            OptionCaption = ' ,Vacant Clean,Vacant Inspected,Occupied Dirty,Occupied Clean,Vacant Dirty';
        }

        field(58; "Sub Type Name"; Text[250]) { }

        field(100; "Company Guid for CRM"; Guid) { }







    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Property No.", "Sort Order")
        {

        }
    }

    trigger OnInsert()
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;
        "Company Guid for CRM" := CompanyInformation."CRM Company Guid";
    end;

    var
        PostCode: Record "Post Code";
}
