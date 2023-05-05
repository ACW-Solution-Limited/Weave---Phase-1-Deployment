tableextension 83113 SalesInvoiceLineExt extends "Sales Invoice Line"
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
        field(83010; "Tender Type"; Code[20])
        {
            DataClassification = ToBeClassified;

        }


        field(83020; "Company Name"; Text[250]) { }
        field(83021; "Company Guid for CRM"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Company Information"."CRM Company Guid");
        }
        field(83022; "Property Booking Guid for CRM"; Guid) { }
        field(83023; "Sales Invoice Guid for CRM"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_salesinvoice".acwapp_salesinvoiceId where(acwapp_name = field("Document No.")));
        }



        field(83009; "No. of Days to Bill"; Integer)
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
}
