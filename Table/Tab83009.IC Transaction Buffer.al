table 83009 "IC Transaction Buffer"
{
    Caption = 'IC Transaction Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Id"; Guid)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }
        field(2; "From Company"; Text[30])
        {
            TableRelation = Company.Name;
            Caption = 'From Company';
            DataClassification = SystemMetadata;
        }
        field(3; "To Company"; Text[30])
        {
            TableRelation = Company.Name;
            Caption = 'To Company';
            DataClassification = SystemMetadata;
        }
        field(4; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = SystemMetadata;
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = SystemMetadata;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee;
        }
        field(6; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            DataClassification = SystemMetadata;

        }
        field(7; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = SystemMetadata;
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Bal. Account Type" = CONST(Employee)) Employee;
        }
        field(8; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = SystemMetadata;
        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = SystemMetadata;
        }
        field(11; Status; Option)
        {
            OptionMembers = Open,Created,Posted;
            Caption = 'Status';
            DataClassification = SystemMetadata;
        }
        field(12; "Journal Template"; Code[20])
        {
            Caption = 'Journal Template';
            DataClassification = SystemMetadata;
        }
        field(13; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = SystemMetadata;
        }
        field(14; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
            DataClassification = SystemMetadata;
        }
        field(15; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
        key(key1; SystemCreatedAt)
        {

        }
    }
    trigger OnInsert()
    begin
        if IsNullGuid("Id") then
            "Id" := CreateGuid();
    end;

}
