table 83014 "Welcome Amenities"
{
    Caption = 'Welcome Amenities';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key"; Guid)
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(2; CompanyID; GUID)
        {
        }
        field(3; "Contract No."; Code[50])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Item No."; Code[50])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
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
        field(5; "Item Description"; Text[250])
        {
            Caption = 'Item Description';
            DataClassification = ToBeClassified;
            TableRelation = Item.Description;
        }
        field(6; "Customer No."; Code[50])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }

        field(7; "Customer Name"; Text[100])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(8; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(9; "Total Amount Inclu. VAT"; Decimal)
        {
            Caption = 'Total Amount Inclu. VAT';
            DataClassification = ToBeClassified;
        }

        field(11; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }

        field(18; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(20; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(22; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }

        field(25; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Pending,Overdue,Paid;
        }
        field(26; "BC Status"; Option)
        {
            Caption = 'BC Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Open,Created,Posted;
        }
        field(27; "Stripe/QFPay Invoice ID"; Text[250])
        {
            Caption = '/QFPay Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(28; "External Payment Gateway"; Enum "External Payment Gateway")
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Posted Sales Invoice No."; Code[50])
        {
            Caption = 'Posted Sales Invoice No.';
            DataClassification = ToBeClassified;
        }

        field(32; "Created On"; Datetime)
        {
            Caption = 'Created On';
            DataClassification = ToBeClassified;
        }
        field(35; "Payment Link"; Text[1024])
        {
            Caption = 'Payment Link';
            DataClassification = ToBeClassified;
        }
        field(40; "Price Inclu. VAT"; Decimal)
        {
            Caption = 'Price Amount Inclu. VAT';
            DataClassification = ToBeClassified;
        }



        // field(100; "Billing Schedule Line No."; Integer) { Caption = 'Billing Schedule Line No.'; }

    }

    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }
}
