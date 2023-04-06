tableextension 83039 PurchsaeLineExt extends "Purchase Line"
{
    fields
    {
        field(83000; "Expense IC Partner"; Code[50])
        {
            Caption = 'Expense IC Partner';
            DataClassification = SystemMetadata;
            TableRelation = "IC Partner".Code;
            trigger OnValidate()
            var
                l_codExpType: Code[20];
                l_codExpICPartner: Code[20];
                l_recICPartner: Record "IC Partner";
            begin
                rec.TestField("Expense Type");
                l_codExpType := rec."Expense Type";
                l_codExpICPartner := "Expense IC Partner";
                Rec.Type := Rec.Type::"G/L Account";
                l_recICPartner.get("Expense IC Partner");
                rec.Validate("No.", l_recICPartner."Receivables Account");
                rec."Expense Type" := l_codExpType;
                rec."Expense IC Partner" := l_codExpICPartner;
            end;
        }
        field(83001; "Expense Type"; Code[20])
        {
            Caption = 'Expense Type';
            DataClassification = SystemMetadata;
            TableRelation = "Expense Type".Code;
            trigger OnValidate()
            var
                l_recExpType: Record "Expense Type";
            begin
                l_recExpType.get(rec."Expense Type");
                Rec.Type := Rec.Type::"G/L Account";
                Rec.validate("No.", l_recExpType."G/L Account");
                rec."Expense Type" := l_recExpType.Code;
            end;
        }

        field(83010; "Deferral Start Date"; Date)
        {
            Caption = 'Deferral Start Date';
            DataClassification = SystemMetadata;
        }
        field(83011; "Assigned PO No."; Code[20]) { Caption = 'Assigned PO NO.'; }

    }
}
