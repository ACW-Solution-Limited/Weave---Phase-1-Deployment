tableextension 83114 "Sales Cr.Memo Header Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(82000; "Stripe Payment Link"; Text[250])
        {
            Caption = 'Stripe Payment Link';
            DataClassification = SystemMetadata;
        }
        field(82001; "Stripe Customer ID"; Text[50])
        {
            Caption = 'Stripe Customer ID';
            DataClassification = AccountData;
            TableRelation = "Stripe Customer"."Stripe Customer ID";
        }
        field(82003; "Stripe Paid"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(82004; "Stripe/QFPay Invoice ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(83001; BlobURL; Text[250])
        {
            Caption = 'Blob URL';

        }

        field(83003; "Lease Contract No."; Code[50]) { Caption = 'Lease Contract No.'; }

        field(83004; "Lease Contract Name"; Text[250]) { Caption = 'Lease Contract Name'; }

        field(83005; "Lease Contract Creation Date"; Date) { Caption = 'Lease Contract Creation Date'; }
        field(83006; "Contract Start Date"; Date) { Caption = 'Contract Start Date'; }
        field(83007; "Contract End Date"; Date) { Caption = 'Contract End Date'; }
        field(83008; "Contract Termination Date"; Date) { Caption = 'Contract Termination Date'; }

        field(83009; "Commission Type"; option) { Caption = 'Commission Type'; OptionMembers = " ",DirectBooking,B2COutreach,B2BOutreach,B2CCompanyAssign,B2BRenewal,B2CRenewal; }
        field(83010; "Calculation Type"; Enum "Calculation Type") { Caption = 'Calculation Type'; }

        field(83011; "Commission Amount"; Decimal) { Caption = 'Commision Amount / %'; }

        field(83019; "Customer Guid for CRM"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CRM Account".AccountId where(acwapp_AccountID = field("Bill-to Customer No.")));
        }
        field(83020; "Company Name"; Text[250]) { }
        field(83021; "Company Guid for CRM"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Company Information"."CRM Company Guid");
        }

        field(83022; "Property Booking Guid for CRM"; Guid)
        {

            FieldClass = FlowField;
            CalcFormula = lookup("CDS acwapp_propertybooking".acwapp_propertybookingId where(acwapp_ContractNo = field("Lease Contract No.")));

        }
        field(83023; "Payment Status"; Enum "Payment Status") { }



    }

    procedure DoPrintToDocumentAttachmentBlob()
    var
        ReportSelections: Record "Report Selections";
        IsHandled: Boolean;
    begin
        //IsHandled := false;
        //OnBeforeDoPrintToDocumentAttachment(SalesInvoiceHeader, ShowNotificationAction, IsHandled);
        // if IsHandled then
        //     exit;

        Rec.SetRecFilter();
        ReportSelections.SaveAsDocumentAttachment(
            ReportSelections.Usage::"S.Cr.Memo".AsInteger(), Rec, Rec."No.", rec."Bill-to Customer No.", false);
    end;
}
