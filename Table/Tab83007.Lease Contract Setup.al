table 83007 "Lease Contract Setup"
{
    Caption = 'Lease Contract Setup';
    DataClassification = ToBeClassified;
    LookupPageId = "Lease Contract Setup";
    DrillDownPageId = "Lease Contract Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(3; "Rental Deposit G/L Account No."; Code[20])
        {
            Caption = 'Deposit G/L Account No.';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Rental Income G/L Account No."; Code[20])
        {
            Caption = 'Rent G/L Account No.';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
        field(5; "Rental Income Deferral Templ."; Code[20])
        {
            Caption = 'Rental Income Deferral Template';
            DataClassification = ToBeClassified;
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(6; "Item Sales Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }

        field(7; "Monthly Disc G/L Account No."; Code[20])
        {
            Caption = 'Monthly Discount Account No.';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
        field(8; "One-Off Disc G/L Account No."; Code[20])
        {
            Caption = 'One-Off Discount Account No.';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
        field(9; "Prepaid Disc G/L Account No."; Code[20])
        {
            Caption = 'Prepaid Discount Account No.';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }

        field(10; "Tender Disc G/L Account No."; Code[20])
        {
            Caption = 'Tender Type Discount Account No.';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }

        field(11; "Event Fee G/L Account No."; Code[20])
        {
            Caption = 'Event Fee G/L Account No.';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }



    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
