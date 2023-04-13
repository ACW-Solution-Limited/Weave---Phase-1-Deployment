table 82009 "QFPay Refund"
{
    Caption = 'QFPay - Payment';
    DataClassification = ToBeClassified;
    DrillDownPageId = "QFPay - Refund";
    LookupPageId = "QFPay - Refund";

    fields
    {
        field(1; id; Text[250])
        {
            Caption = 'id';
            DataClassification = ToBeClassified;
        }
        field(2; out_trade_no; Text[250])
        {
            Caption = 'API Order Number';
            DataClassification = ToBeClassified;
        }
        field(3; syssn; Text[250])
        {
            Caption = 'Transaction ID';
            DataClassification = ToBeClassified;
        }
        field(4; sysdtm; DateTime)
        {
            Caption = 'Transaction Time';
            DataClassification = ToBeClassified;
        }
        field(5; paydtm; DateTime)
        {
            Caption = 'paydtm';
            DataClassification = ToBeClassified;
        }
        field(6; txcurrcd; Text[250])
        {
            Caption = 'Transaction Currency';
            DataClassification = ToBeClassified;
        }
        field(7; txamt; Decimal)
        {
            Caption = 'Transaction Amount';
            DataClassification = ToBeClassified;
        }
        field(8; errmsg; Text[250])
        {
            Caption = 'txamt';
            DataClassification = ToBeClassified;
        }
        field(9; pay_type; Text[250])
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(10; "clisn"; Text[250])
        {
            Caption = 'clisn';
            DataClassification = ToBeClassified;
        }
        field(11; "txdtm"; DateTime)
        {
            Caption = 'Request Transaction Time';
            DataClassification = ToBeClassified;
        }
        field(12; "Service Charge"; Decimal)
        {
            Caption = 'Service Charge';
            DataClassification = ToBeClassified;
        }
        field(13; Origssn; Text[250])
        {
            Caption = 'Original Transaction ID';
            DataClassification = ToBeClassified;
        }
        field(14; "Refund Fee"; Decimal)
        {
            Caption = 'Refund Fee';
            DataClassification = ToBeClassified;
        }


        field(20; Status; Option)
        {
            OptionMembers = Open,Created,Posted;
            Caption = 'Status';
            DataClassification = SystemMetadata;
        }

        field(21; "Sales Document No."; Code[50])
        {
            Caption = 'Sales Document No.';
            DataClassification = ToBeClassified;
        }
        field(22; "Sales Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Sales Document Type';
            DataClassification = SystemMetadata;
        }
        field(23; "Customer No."; Code[50])
        {
            Caption = 'Customer No.';
            DataClassification = SystemMetadata;
            TableRelation = Customer;
        }

        field(24; "General Journal Document Type"; Enum "Gen. Journal Document Type") { }
        field(25; "General Journal Document No."; Code[100]) { }
    }
    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }
}
