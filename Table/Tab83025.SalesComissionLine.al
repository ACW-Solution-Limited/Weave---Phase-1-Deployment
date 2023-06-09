table 83025 "Sales Commission Line"
{
    Caption = 'Sales Commission Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Commission Type"; Enum "Commission Type")
        {
            Caption = 'Commission Type';
            DataClassification = ToBeClassified;
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Posted Sales Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Invoice Amount"; Decimal)
        {
            Caption = 'Invoice Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Invoice Amount Including VAT"; Decimal)
        {
            Caption = 'Invoice Amount Including VAT';
            DataClassification = ToBeClassified;
        }
        field(8; "Commission Amount"; Decimal)
        {
            Caption = 'Commission Amount';
            DataClassification = ToBeClassified;
        }

        field(9; Salesperson; Code[20])
        {
            Caption = 'Salesperson';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                l_recSalesperson: Record "Salesperson/Purchaser";
            begin
                l_recSalesperson.reset;
                l_recSalesperson.Get(Salesperson);
                "Salesperson Name" := l_recSalesperson.Name;
            end;
        }
        field(10; "Salesperson Name"; Text[50])
        {
            Caption = 'Salesperson Name';
            DataClassification = ToBeClassified;
        }

        field(20; "Viewing By"; Text[100])
        {
            Caption = 'Viewing By';
            DataClassification = ToBeClassified;
        }
        field(30; "Renewal By"; Text[100])
        {
            Caption = 'Renewal By';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Contract No.", "Commission Type", "Date", "Document No.")
        {
            Clustered = true;
        }
    }
}
