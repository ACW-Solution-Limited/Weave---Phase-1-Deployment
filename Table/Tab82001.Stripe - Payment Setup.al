table 82001 "Stripe Payment Setup"
{
    Caption = 'Stripe Payment Setup';
    DataClassification = SystemMetadata;
    LookupPageId = "Stripe Payment Setup";
    DrillDownPageId = "Stripe Payment Setup";
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(4; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = SystemMetadata;
        }
        field(5; "Always Include on Documents"; Boolean)
        {
            Caption = 'Always Include on Documents';
            DataClassification = SystemMetadata;
        }
        field(6; "Terms of Service"; Text[250])
        {
            Caption = 'Terms of Service';
            DataClassification = SystemMetadata;
        }
        field(7; "Target URL"; Text[250])
        {
            Caption = 'Target URL';
            DataClassification = SystemMetadata;
        }
        field(8; "Stripe Secret Key"; Text[250])
        {
            Caption = 'Stripe Secret Key';
            DataClassification = CustomerContent;
        }
        field(9; Logo; Blob)
        {
            Subtype = Bitmap;
            DataClassification = ToBeClassified;
        }
        field(10; "Stripe Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(11; "Stripe Processing Fee G/L Acc."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where(Blocked = const(false), "Direct Posting" = const(true));
        }
        field(12; "Stripe Payment Jnl. Template"; Code[10])
        {
            Caption = 'Stripe Payment Journal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(13; "Stripe Payment Jnl. Batch"; Code[10])
        {
            Caption = 'Stripe Payment Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Stripe Payment Jnl. Template"));
        }
        field(14; "Stripe Payout Jnl. Template"; Code[10])
        {
            Caption = 'Stripe Payout Journal Template';

            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(15; "Stripe Payout Jnl. Batch"; Code[10])
        {
            Caption = 'Stripe Payout Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Stripe Payout Jnl. Template"));
        }
        field(16; "Receiving Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
            DataClassification = ToBeClassified;
        }
        field(17; "Stripe Refund Jnl. Template"; Code[10])
        {
            Caption = 'Stripe Refund Journal Template';

            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(18; "Stripe Refund Jnl. Batch"; Code[10])
        {
            Caption = 'Stripe Refund Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Stripe Refund Jnl. Template"));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    // procedure GetTargetURL() TargetURL: Text
    // var
    //     TypeHelper: Codeunit "Type Helper";
    //     InStream: InStream;
    // begin
    //     CalcFields("Target URL");
    //     "Target URL".CreateInStream(InStream, TEXTENCODING::UTF8);
    //     if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), TargetURL) then
    //         Message('Cannot read %1.', FieldCaption("Target URL"));
    // end;

    // procedure SetTargetURL(NewTargetURL: Text)
    // var
    //     OutStream: OutStream;
    // begin
    //     Clear("Target URL");
    //     "Target URL".CreateOutStream(OutStream, TEXTENCODING::UTF8);
    //     OutStream.WriteText(NewTargetURL);
    //     Modify;
    // end;
}
