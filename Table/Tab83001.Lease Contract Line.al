table 83001 "Lease Contract Line"
{
    Caption = 'Lease Contract Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key"; Guid)
        {
            Caption = 'CRM Guid';
            DataClassification = SystemMetadata;

        }
        field(2; "Key2"; Guid)
        {
            Caption = 'CRM Guid 2';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            Var
                LeaseContractHeader: Record "Lease Contract Header";
            begin
                LeaseContractHeader.reset;
                LeaseContractHeader.setrange("Key", "Key");
                If LeaseContractHeader.FindFirst() then
                    "Contract No." := LeaseContractHeader."No.";
            end;
        }
        field(3; CompanyId; Guid)
        {
            Caption = 'Company Guid';
            DataClassification = SystemMetadata;

        }
        field(5; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = SystemMetadata;
            TableRelation = "Lease Contract Header"."No.";
        }
        field(8; "Contract Name"; Text[250])
        {
            Caption = 'Contract Name';
            //   DataClassification = SystemMetadata;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(15; "Property Unit No."; Code[100])
        {
            Caption = 'Property Unit No.';
            DataClassification = SystemMetadata;
            TableRelation = "Property Unit"."No.";

            trigger OnValidate()
            var
                l_recPropertyUnit: Record "Property Unit";
            begin
                if l_recPropertyUnit.Get("Property Unit No.") then
                    "Property No." := l_recPropertyUnit."Property No."
            end;
        }
        field(20; "Lease From Date"; Date)
        {
            Caption = 'Lease From Date';
            DataClassification = SystemMetadata;
        }
        field(25; "Lease To Date"; Date)
        {
            Caption = 'Lease To Date';
            DataClassification = SystemMetadata;
        }
        field(30; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = SystemMetadata;
        }
        field(35; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = SystemMetadata;
        }
        field(40; "Price Type"; Option)
        {
            OptionMembers = " ",Day,Night,Month;
            Caption = 'Price Type';
            DataClassification = SystemMetadata;
        }
        field(45; "Property No."; Code[50])
        {
            Caption = 'Property No.';
            DataClassification = ToBeClassified;
            TableRelation = "Property Unit"."Property No.";

        }
        field(50; "Billing Schedule Created"; Boolean)
        {
            Caption = 'Billing Scheduled Created';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Key", "Contract No.", "Line No.")
        {
            Clustered = true;
        }

    }

    trigger OnInsert()
    var
        l_recBookingLine: Record "Lease Contract Line";
    begin
        l_recBookingLine.reset;
        l_recBookingLine.setrange("Contract No.", Rec."Contract No.");
        If l_recBookingLine.FindLast() then
            "Line No." := l_recBookingLine."Line No." + 10000
        else
            "Line No." := 10000;
    end;

}