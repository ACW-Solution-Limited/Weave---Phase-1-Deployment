table 83017 "Extra Charge"
{
    Caption = 'Extra Charge';
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
            trigger OnValidate()
            begin
                "BC Status" := "BC Status"::Open;
            end;
        }
        field(3; "Item Type"; Text[50])
        {
            Caption = 'Item Type';
            DataClassification = ToBeClassified;
        }
        field(4; "Item No."; Code[50])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                l_recItem: Record Item;
            begin
                if l_recItem.Get("Item No.") then "Item Description" := l_recItem.Description;
            end;
        }
        field(5; "Item Description"; Text[250])
        {
            Caption = 'Item Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Customer No."; Code[50])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Contact No."; Code[50])
        {
            Caption = 'Contact No.';
            DataClassification = ToBeClassified;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(9; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(10; "Service Start Date"; Date)
        {
            Caption = 'Service Start Date';
            DataClassification = ToBeClassified;
        }

        field(11; "Service End Date"; Date)
        {
            Caption = 'Service End Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(13; "Total Amount Inclu. VAT"; Decimal)
        {
            Caption = 'Total Amount Inclu. VAT';
            DataClassification = ToBeClassified;
        }

        field(14; "Created On"; Datetime)
        {
            Caption = 'Created On';
            DataClassification = ToBeClassified;

        }
        field(15; Description; Text[250]) { Caption = 'Description'; DataClassification = ToBeClassified; }
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
        field(22; "Stripe Invoice ID"; Text[250])
        {
            Caption = 'Stripe/QFPay Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(23; "Payment Link"; Text[250])
        {
            Caption = 'Payment Link';
            DataClassification = ToBeClassified;
        }

        field(29; "Posted Sales Invoice Guid"; Guid)
        {
            Caption = 'Posted Sales Invoice Guid';
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_salesinvoice".acwapp_salesinvoiceId where(acwapp_name = field("Posted Sales Invoice No.")));
        }

        field(30; "Posted Sales Invoice No."; Code[50])
        {
            Caption = 'Posted Sales Invoice No.';
            DataClassification = ToBeClassified;
        }

        field(31; "Charges Type"; Option)
        {
            OptionMembers = " ",Deposit,AdHoc,"EarlyMove-in",Extension;

        }

        field(32; "New Contract Start Date"; Datetime) { DataClassification = ToBeClassified; Caption = 'New Contract Start Date'; }


        field(33; "New Contract End Date"; Datetime)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Contract End Date';
        }
        field(34; "Extra Charge ID"; Text[250]) { DataClassification = ToBeClassified; }


        field(40; "CRM Status"; Option)
        {
            Caption = 'CRM Status';
            OptionMembers = Pending,Confirmed;

        }
        field(49; "External Payment Gateway"; Enum "External Payment Gateway")
        {
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
