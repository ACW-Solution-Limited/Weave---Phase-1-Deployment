tableextension 83123 PurchInvLineExt extends "Purch. Inv. Line"
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
        field(83002; "IC Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    var
        l_recCompanyInformation: Record "Company Information";
    begin
        l_recCompanyInformation.Get;
        if l_recCompanyInformation."Purch. Inv. Default Location" <> '' then
            Validate("Location Code", l_recCompanyInformation."Purch. Inv. Default Location");
    end;
}
