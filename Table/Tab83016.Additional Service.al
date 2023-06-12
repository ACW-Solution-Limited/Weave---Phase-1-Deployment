table 83016 "Additional Service"
{
    Caption = 'Additional Service';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Additional Service";
    LookupPageId = "Additional Service";

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
            //  TableRelation = Item."No.";
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
            //TableRelation = Item.Description where("No." = field("Item No."));
        }
        field(5; "Customer No."; Code[50])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Customer Name"; Code[50])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Contact No."; Code[50])
        {
            Caption = 'Contact No.';
            DataClassification = ToBeClassified;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(15; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(20; "Service Start Date"; DateTime)
        {
            Caption = 'Service Start Date';
            DataClassification = ToBeClassified;
        }

        field(25; "Service End Date"; DateTime)
        {
            Caption = 'Service End Date';
            DataClassification = ToBeClassified;
        }


        field(27; "Payment Amount"; Decimal)
        {
            Caption = 'Payment Amount';
            DataClassification = ToBeClassified;
        }
        field(28; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(30; "Total Amount Inclu. VAT"; Decimal)
        {
            Caption = '"Total Amount Inclu. VAT"';
            DataClassification = ToBeClassified;
        }

        field(35; "Created On"; Datetime)
        {
            Caption = 'Created On';
            DataClassification = ToBeClassified;

        }
        field(40; "BC Status"; Option)
        {
            Caption = 'BC Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Open,Created,Posted;
        }
        field(41; "CRM Status"; Option)
        {
            Caption = 'CRM Status';
            OptionMembers = " ",Pending,Confirmed;

        }
        field(45; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Pending,Overdue,Paid;
        }

        field(49; "External Payment Gateway"; Enum "External Payment Gateway")
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Stripe Invoice ID"; Text[250])
        {
            Caption = 'Stripe Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(55; "Posted Sales Invoice No."; Code[50])
        {
            Caption = 'Posted Sales Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(60; CompanyId; Guid)
        {
            Caption = 'Companyid';
            DataClassification = ToBeClassified;
        }
        field(65; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
        }

        field(70; "Price Inclu. VAT"; Decimal)
        {
            Caption = '"Total Amount Inclu. VAT"';
            DataClassification = ToBeClassified;
        }


        field(75; "Payment Link"; Text[1024])
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
