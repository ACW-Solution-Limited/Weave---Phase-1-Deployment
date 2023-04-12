table 83006 "Lease Contract Billing Sched."
{
    Caption = 'Lease Contract Billing Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Contract Line No."; Integer)
        {
            Caption = 'Contract Line No.';
            DataClassification = SystemMetadata;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(4; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Deposit,Rent,Item;
            DataClassification = SystemMetadata;
        }
        field(5; "Contract Start Date"; Date)
        {
            Caption = 'Contract Start Date';
            DataClassification = SystemMetadata;
        }
        field(6; "Contract End Date"; Date)
        {
            Caption = 'Contract End Date';
            DataClassification = SystemMetadata;
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = SystemMetadata;
        }
        field(8; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = SystemMetadata;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount Excluding VAT';
            DataClassification = SystemMetadata;
        }
        field(10; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = Invoice,"Credit Memo";
            DataClassification = SystemMetadata;
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = SystemMetadata;
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Created,Posted,Paid;
            DataClassification = SystemMetadata;
        }
        field(13; "No. of Days Current Month"; Integer)
        {
            Caption = 'No. of Days Current Month';
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(14; "No. of Days to Bill"; Integer)
        {
            Caption = 'No. of Days to Bill';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }
        field(15; "Customer No."; Code[20])
        {

            DataClassification = SystemMetadata;
            TableRelation = customer."No.";

        }
        field(16; "Additional Sales Item No."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = Item."No.";
        }
        field(17; "Additional Item Sales Date"; Date)
        {
            DataClassification = SystemMetadata;
        }
        field(18; "Additional Sales Item Quantity"; Decimal)
        {
            DataClassification = SystemMetadata;
            DecimalPlaces = 0 : 5;

        }
        field(19; "Add. Sales Item Unit Price"; Decimal)
        {
            Caption = 'Additional Sales Item Unit Price';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(20; "Sub-Type"; Code[100])
        {
            Caption = 'Sub-Type';
            // OptionMembers = "Additional Amenities","Additional Service","Welcome Amenities","Extra Charges","Ad Hoc",Admin;
            // DataClassification = SystemMetadata;
        }
        field(21; "Stripe Invoice ID"; Text[250])
        {
            Caption = 'Stripe/QFPay Invoice ID';

        }








        // field(22; "Amount Excluding VAT"; Decimal) // To  be deleted 
        // {
        //     Caption = 'Amount Excluding VAT';
        //     DataClassification = SystemMetadata;
        // }

        field(22; "Sales Invoice Creation Date"; DateTime) { Caption = 'Sales Invoice Creation Date'; }
        field(23; "Tender Type"; Code[20]) { Caption = 'Tender Type'; }


        field(25; "Final Amount"; Decimal)
        {
            Caption = 'Final Amount';
            DataClassification = SystemMetadata;
        }

        field(26; "External Payment Gateway"; Enum "External Payment Gateway")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Contract No.", "Line No.")
        {
            Clustered = true;
        }
        key(key1; "Customer No.", "Posting Date", "Contract No.", "Line No.") { }

    }
}
