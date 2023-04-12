table 82005 "QFPay Setup"
{
    Caption = 'QFPay Setup';
    DataClassification = SystemMetadata;
    DrillDownPageId = "QFPay Setup";
    LookupPageId = "QFPay Setup";

    fields
    {
        field(1; "Primary Key"; Code[250])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "API Code"; Code[250])
        {
            Caption = 'API Code';
            DataClassification = ToBeClassified;
        }
        field(3; "API Key"; Code[250])
        {
            Caption = 'API Key';
            DataClassification = ToBeClassified;
        }

        field(10; "QF Pay Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(11; "QF Pay Processing Fee G/L Acc."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where(Blocked = const(false), "Direct Posting" = const(true));
        }
        field(12; "QF Pay Payment Jnl. Template"; Code[10])
        {
            Caption = 'QFPay Payment Journal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(13; "QF Pay Payment Jnl. Batch"; Code[10])
        {
            Caption = 'QFPay Payment Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("QF Pay Payment Jnl. Template"));
        }
        field(14; "QF Pay Payout Jnl. Template"; Code[10])
        {
            Caption = 'QFPay Payout Journal Template';

            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(15; "QF Pay Payout Jnl. Batch"; Code[10])
        {
            Caption = 'QFPay Payout Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("QF Pay Payout Jnl. Template"));
        }
        field(16; "Receiving Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
            DataClassification = ToBeClassified;
        }

        field(17; "QFPay Refund Jnl. Template"; Code[10])
        {
            Caption = 'QFPay Refund Journal Template';

            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(18; "QFPay Refund Jnl. Batch"; Code[10])
        {
            Caption = 'QFPay Refund Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("QFPay Refund Jnl. Template"));
        }

        field(20; "Enable"; Boolean)
        {

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
