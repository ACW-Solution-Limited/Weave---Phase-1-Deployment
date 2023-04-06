table 83015 "Additional Amenities"
{
    Caption = 'Additional Amenities';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key"; Guid)
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Contract No."; Code[50])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Item No."; Code[50])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            // TableRelation = Item."No.";
            Trigger OnValidate()
            Var
                l_recItem: Record Item;
            begin
                l_recItem.reset;
                l_recItem.setrange("No.", "Item No.");
                If l_recItem.FindFirst() then
                    "Item Description" := l_recItem.Description;
            end;
        }
        field(4; "Item Description"; Text[250])
        {
            Caption = 'Item Description';
            DataClassification = ToBeClassified;
            // TableRelation = Item.Description;
        }
        field(5; "Customer No."; Code[50])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Contact No."; Code[50])
        {
            Caption = 'Contact No.';
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(8; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(9; "Start Date"; Datetime)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }

        field(10; "End Date"; Datetime)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(11; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(12; "Total Amount Inclu. VAT"; Decimal)
        {
            Caption = '"Total Amount Inclu. VAT"';
            DataClassification = ToBeClassified;
        }

        field(13; "Created On"; DateTime)
        {
            Caption = 'Created On';
            DataClassification = ToBeClassified;

        }
        field(20; "BC Status"; Option)
        {
            Caption = 'BC Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Open,Created,Posted;
        }
        field(21; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Pending,Overdue,Paid;
        }
        field(22; "Stripe/QFPay Invoice ID"; Text[250])
        {
            Caption = '"Stripe/QFPay Invoice ID"';
            DataClassification = ToBeClassified;
        }
        field(23; "External Payment Gateway"; Enum "External Payment Gateway")
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Posted Sales Invoice No."; Code[50])
        {
            Caption = 'Posted Sales Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(35; "Price Inclu. VAT"; Decimal)
        {
            Caption = 'Price Amount Inclu. VAT';
            DataClassification = ToBeClassified;
        }
        field(40; "Payment Link"; Text[1024])
        {
            Caption = 'Payment Link';
            DataClassification = ToBeClassified;
        }


        field(100; "Billing Schedule Line No."; Integer) { Caption = 'Billing Schedule Line No.'; }
    }
    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }
}
