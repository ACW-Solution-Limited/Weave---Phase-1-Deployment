tableextension 83037 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(83000; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = SystemMetadata;
        }
        field(83001; "Billing Schedule Line No."; Integer)
        {
            Caption = 'Billing Schedule Line No.';
            DataClassification = SystemMetadata;
        }
        field(83002; "Lease From Date"; Date)
        {
            Caption = 'Lease From Date';
            DataClassification = SystemMetadata;
        }
        field(83003; "Lease To Date"; Date)
        {
            Caption = 'Lease To Date';
            DataClassification = SystemMetadata;
        }
        field(83004; "Billing Schedule Type"; Option)
        {
            OptionMembers = " ",Deposit,Rent,Item;
            Caption = 'Billing Schedule Type';
            DataClassification = ToBeClassified;
        }
        field(83005; "Additional Sales Item No."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = Item."No.";
        }
        field(83006; "Additional Item Sales Date"; Date)
        {
            DataClassification = SystemMetadata;
        }
        field(83007; "Linked Assembly Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Assembly Header"."No." where("Document Type" = const(Order));
        }

        field(83008; "Invoice Description"; Text[2048])
        {
            DataClassification = ToBeClassified;

        }
        field(83009; "No. of Days to Bill"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(83010; "Tender Type"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(83030; "Billing Schedule Sub-Type"; Code[100])
        {
            Caption = 'Billing Schedule Sub-Type';
        }

        field(83031; "Extension Start Date"; Date) { }
        field(83032; "Extension End Date"; Date) { }
    }
    trigger OnDelete()
    var
        l_recBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recAsmOrderHeader: Record "Assembly Header";
    begin
        if l_recBillingSchedule.get("Contract No.", "Billing Schedule Line No.") and (l_recBillingSchedule.Status = l_recBillingSchedule.Status::Created) then begin
            l_recBillingSchedule.Status := 0;
            l_recBillingSchedule."Document Type" := 0;
            l_recBillingSchedule."Document No." := '';
            if l_recBillingSchedule.Modify() then;
        end;
        if "Linked Assembly Order No." <> '' then begin
            if l_recAsmOrderHeader.get(l_recAsmOrderHeader."Document Type"::Order, "Linked Assembly Order No.") then
                l_recAsmOrderHeader.Delete(True);
        end;
    end;
}
