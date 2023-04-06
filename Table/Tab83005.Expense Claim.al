table 83005 "Expense Claim"
{
    Caption = 'Expense Claim';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(4; "Expense Claim Admin"; Code[20])
        {
            Caption = 'Expense Claim Admin';
            DataClassification = SystemMetadata;
            TableRelation = "Expense Claim Admin"."No.";
        }
        field(5; "Expense Type"; Code[20])
        {
            Caption = 'Expense Type';
            DataClassification = SystemMetadata;
            TableRelation = "Expense Type".Code;
        }
        field(6; "IC Partner"; Code[20])
        {
            Caption = 'IC Partner';
            TableRelation = "IC Partner".Code;
            DataClassification = SystemMetadata;
        }
        field(7; Status; Option)
        {
            OptionMembers = " ",Open,Created,Posted;
            Caption = 'Status';
            DataClassification = SystemMetadata;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = SystemMetadata;
        }
        field(9; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Purchase Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Staff Email"; Text[250])
        {

            trigger OnValidate()
            var
                l_recExpenseClaimAdmin: Record "Expense Claim Admin";
            begin
                l_recExpenseClaimAdmin.Reset();
                l_recExpenseClaimAdmin.SetFilter(Email, "Staff Email");
                if l_recExpenseClaimAdmin.FindFirst() then
                    "Expense Claim Admin" := l_recExpenseClaimAdmin."No."
                else
                    "Expense Claim Admin" := '';
            end;
        }
        field(12; "Created On"; Date) { }
        field(13; "CRM Guid"; Guid)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            var
                l_recICPartner: Record "IC Partner";
            begin
                l_recICPartner.reset;
                l_recICPartner.setrange("CRM Guid", "CRM Guid");
                If l_recICPartner.findlast then
                    "IC Partner" := l_recICPartner.Code;

            end;

        }




    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Expense Claim Admin", Date)
        { }
    }
}
