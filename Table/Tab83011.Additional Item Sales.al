table 83011 "Additional Item Sales"
{
    Caption = 'Additional Item Sales';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Guid)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = SystemMetadata;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = SystemMetadata;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = SystemMetadata;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = SystemMetadata;
        }
        field(8; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = SystemMetadata;
            OptionMembers = Open,Paid;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;
            OptionMembers = Open,Created,Posted;
        }
        field(10; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
        key(key1; Date, SystemCreatedAt)
        {

        }
        key(key2; "Contract No.", date, SystemCreatedAt)
        {

        }
    }
    trigger OnInsert()
    begin
        if IsNullGuid("Id") then
            "Id" := CreateGuid();
    end;

}
