table 82000 "Stripe Customer"
{
    Caption = 'Stripe Customer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Stripe Customer ID"; Text[50])
        {
            Caption = 'Stripe Customer ID';
            DataClassification = AccountData;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = AccountData;
            TableRelation = customer."No.";
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = AccountData;

        }
        field(4; Currency; Code[10])
        {
            Caption = 'Currency';
            DataClassification = AccountData;
            TableRelation = Currency.Code;
        }
        field(5; Email; Text[80])
        {
            Caption = 'Email';
            DataClassification = AccountData;
        }
    }
    keys
    {
        key(PK; "Stripe Customer ID")
        {
            Clustered = true;
        }
    }
}
