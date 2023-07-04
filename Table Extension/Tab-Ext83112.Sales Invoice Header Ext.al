tableextension 83008 "Sales Invoice Header Ext" extends "Sales Invoice Header"
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
        field(82004; "Stripe Invoice ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(82005; "External Payment Gateway"; Enum "External Payment Gateway")
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

        field(83009; "Commission Type"; Option) { Caption = 'Commission Type'; OptionMembers = " ",DirectBooking,B2COutreach,B2BOutreach,"B2BOutreach-AgencyCommission",B2CCompanyAssign,B2BRenewal,B2CRenewal,"B2CCompanyAssign-PropertyViewing(OperationTeam)"; }
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

    procedure UpdateInvoiceIDToBillingSchdeule(InvoiceID: Code[250])
    var
        l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.";
    begin
        l_recLeaseContractBillingSchedule.Reset();
        l_recLeaseContractBillingSchedule.SetFilter("Document No.", "No.");
        if l_recLeaseContractBillingSchedule.FindFirst() then
            repeat
                l_recLeaseContractBillingSchedule.Status := l_recLeaseContractBillingSchedule.Status::Paid;
                l_recLeaseContractBillingSchedule."Stripe Invoice ID" := InvoiceID;
                l_recLeaseContractBillingSchedule.Modify();
            until l_recLeaseContractBillingSchedule.Next() = 0;


    end;

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
            ReportSelections.Usage::"S.Invoice".AsInteger(), Rec, Rec."No.", rec."Bill-to Customer No.", ShowNotificationAction);
    end;


    procedure SendInvoiceToStripe(): Text

    var
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
        l_cuStripe: Codeunit Stripe;
        l_txtStripeInvoiceURL: text;
    begin
        if rec."Stripe Payment Link" <> '' then
            Hyperlink(rec."Stripe Payment Link")
        else begin
            if l_cuStripe.SendSalesInvoiceToStripe(rec, l_txtStripeInvoiceURL) then
                Hyperlink(l_txtStripeInvoiceURL);
        end;
    end;

    procedure SynchronizeNow(DoFullSynch: Boolean)
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        CDSSetupDefaults: Codeunit "CDS Setup Defaults";
    begin
        CDSSetupDefaults.GetPrioritizedMappingList(TempNameValueBuffer);

        TempNameValueBuffer.Ascending(true);
        if not TempNameValueBuffer.FindSet() then
            exit;

        repeat
            if IntegrationTableMapping.Get(TempNameValueBuffer.Value) then
                IntegrationTableMapping.SynchronizeNow(DoFullSynch);
        until TempNameValueBuffer.Next() = 0;
    end;
    // Testing on 08032023>>
    Procedure MannualSaveToBlob(Var SalesInvHeader: Record "Sales Invoice Header")
    var
        ReportSelections: Record "Report Selections";
        l_recSalesInvHeader: Record "Sales Invoice Header";
        l_recBlobstorage: Record "ABS Container setup";
        l_recSalesReceivableSetup: Record "Sales & Receivables Setup";
        l_varBlobURL: Text;
    begin
        l_recBlobstorage.Get;
        l_recSalesReceivableSetup.Get;
        // l_recSalesInvHeader.SetCurrentKey(SystemCreatedAt);
        // l_recSalesInvHeader.Ascending(True);
        // l_recSalesInvHeader.setrange(SystemCreatedBy, UserSecurityId());
        // If l_recSalesInvHeader.FindLast() then begin
        //     g_docmentNo := l_recSalesInvHeader."No.";
        // end;
        /*  l_recSalesInvHeader.reset;
          g_docmentNo := SalesHeader."No.";
          If l_recSalesReceivableSetup."Invoice Nos." = l_recSalesReceivableSetup."Posted Invoice Nos." then
              l_recSalesInvHeader.SetFilter("No.", '=%1', g_docmentNo)
          else
              l_recSalesInvHeader.SetFilter("Pre-Assigned No.", '=%1', g_docmentNo);*/

        //l_recSalesInvHeader.SetRecFilter();
        //If l_recSalesInvHeader.findfirst then;
        If (l_recBlobstorage."Container Name" = '') or (l_recBlobstorage."Account Name" = '') or (l_recBlobstorage."Shared Access Key" = '') then begin
            Message('%1', 'Please set up the Azure Blob Storage.');
        end else begin
            ReportSelections.SaveAsDocumentAttachment(
                ReportSelections.Usage::"S.Invoice".AsInteger(), SalesInvHeader, SalesInvHeader."No.", SalesInvHeader."Bill-to Customer No.", ShowNotificationAction);
            // Message('%1', l_recSalesInvHeader."No.");
        end;
    end;
    // Testing on 08032023<<
    var
        ShowNotificationAction: Boolean;
}
