codeunit 83002 EventSubscriber
{
    Permissions = tabledata "Sales Invoice Header" = rimd;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]

    local procedure C80_OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean)
    var

        l_recSalesInvLine: Record "Sales Invoice Line";
        l_recAsmOrderHeader: Record "Assembly Header";
        DocumentAttachment: Record "Document Attachment";
    begin

        l_recSalesInvLine.reset;
        l_recSalesInvLine.SetRange("Document No.", SalesInvHdrNo);
        if l_recSalesInvLine.findset then
            repeat
                if l_recAsmOrderHeader.get(l_recAsmOrderHeader."Document Type"::Order, l_recSalesInvLine."Linked Assembly Order No.") then
                    Codeunit.run(Codeunit::"Assembly-Post", l_recAsmOrderHeader);
            until l_recSalesInvLine.next = 0;


        UpdateBillingScheduleStatus(SalesHeader);

        if SalesHeader."Stripe Invoice ID" <> '' then
            ProcessFirstTimePayment(SalesInvHdrNo, SalesHeader)
        else
            ProcessSecondTimePayment(SalesInvHdrNo, SalesHeader);

    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', true, true)]
    procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)

    var
        l_recPurchInvLine: Record "Purch. Inv. Line";
        l_recCompany: Record Company;
        l_recICPartner: Record "IC Partner";
        l_recICTransBuffer: Record "IC Transaction Buffer";
        l_recExpenseType: Record "Expense Type";
        l_recICSetup: Record "IC Setup";

        //Expense Claim
        l_recExpenseClaim: Record "Expense Claim";
    begin
        l_recPurchInvLine.reset;
        l_recPurchInvLine.setrange("Document No.", PurchInvHdrNo);
        if l_recPurchInvLine.findset then
            repeat
                if l_recICPartner.get(l_recPurchInvLine."Expense IC Partner") Then begin
                    l_recICTransBuffer."Id" := '{00000000-0000-0000-0000-000000000000}';
                    l_recICTransBuffer.init;
                    l_recICTransBuffer."Document No." := l_recPurchInvLine."Document No.";
                    l_recICTransBuffer."Posting Date" := l_recPurchInvLine."Posting Date";
                    l_recICTransBuffer."From Company" := CompanyName;
                    l_recICTransBuffer."To Company" := CompanyName;
                    l_recICPartner.get(l_recPurchInvLine."Expense IC Partner");
                    l_recICTransBuffer."Account Type" := l_recICTransBuffer."Account Type"::"Bank Account";
                    l_recICTransBuffer."Account No." := l_recICPartner."Bank Account";
                    l_recICTransBuffer."Bal. Account Type" := l_recICTransBuffer."Bal. Account Type"::"G/L Account";
                    l_recICTransBuffer."Bal. Account No." := l_recPurchInvLine."No.";
                    l_recICTransBuffer.Amount := -l_recPurchInvLine."Line Amount";
                    if l_recICTransBuffer.insert(true) then;

                    l_recICTransBuffer.ChangeCompany(l_recICPartner."Inbox Details");
                    l_recICTransBuffer."Id" := '{00000000-0000-0000-0000-000000000000}';
                    l_recICTransBuffer.init;
                    l_recICTransBuffer."Document No." := l_recPurchInvLine."Document No.";
                    l_recICTransBuffer."Posting Date" := l_recPurchInvLine."Posting Date";
                    l_recICTransBuffer."From Company" := CompanyName;
                    l_recICTransBuffer."To Company" := l_recICPartner."Inbox Details";
                    l_recICTransBuffer."Account Type" := l_recICTransBuffer."Account Type"::"G/L Account";
                    l_recExpenseType.get(l_recPurchInvLine."Expense Type");
                    l_recICTransBuffer."Account No." := l_recExpenseType."G/L Account";
                    l_recICTransBuffer."Bal. Account Type" := l_recICTransBuffer."Bal. Account Type"::"Bank Account";
                    l_recICSetup.get;
                    l_recICTransBuffer."Bal. Account No." := l_recICSetup."IC Partner Code";
                    l_recICTransBuffer.Amount := l_recPurchInvLine."Line Amount";
                    if l_recICTransBuffer.insert(true) then;
                end;

            until l_recPurchInvLine.next = 0;


        //Expense Claim
        l_recExpenseClaim.Reset();
        l_recExpenseClaim.SetFilter("Purchase Order No.", PurchaseHeader."No.");
        if l_recExpenseClaim.FindFirst() then
            repeat
                l_recExpenseClaim.Status := l_recExpenseClaim.Status::Posted;
                l_recExpenseClaim.Modify();
            until l_recExpenseClaim.Next() = 0;
    end;





    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post", 'OnBeforeInsertICGenJnlLine', '', true, true)]
    local procedure OnBeforeInsertICGenJnlLine(var ICGenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean)

    begin
        ICGenJournalLine."Invoice Description" := SalesLine."Invoice Description";
    end;


    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."Invoice Description" := GenJournalLine."Invoice Description";
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post (Yes/No)", 'OnAfterPost', '', False, False)]
    local procedure OnAfterPost(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.DoPrintToDocumentAttachmentwhenpost(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Credit Memo", 'OnPostDocumentBeforeNavigateAfterPosting', '', False, False)]
    local procedure OnPostDocumentBeforeNavigateAfterPosting(var SalesHeader: Record "Sales Header"; var PostingCodeunitID: Integer; DocumentIsPosted: Boolean; var IsHandled: Boolean)
    begin
        SalesHeader.DoPrintToDocumentAttachmentwhenpostcreditmemo(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Invoice Post. Buffer", 'OnAfterInvPostBufferPrepareSales', '', False, False)]
    local procedure OnAfterInvPostBufferPrepareSales(var SalesLine: Record "Sales Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer")
    begin
        InvoicePostBuffer."Sales Invoice Description" := SalesLine."Invoice Description";

    end;

    [EventSubscriber(ObjectType::Table, Database::"Invoice Post. Buffer", 'OnAfterCopyToGenJnlLine', '', False, False)]
    local procedure OnAfterCopyToGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; InvoicePostBuffer: Record "Invoice Post. Buffer");
    begin
        GenJnlLine."Invoice Description" := InvoicePostBuffer."Sales Invoice Description";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure InsertCloneLine(var Rec: Record "Sales Invoice Line"; RunTrigger: Boolean)
    var
        PostedSalesInvoiceLineforCRM: Record "Posted Sales Inv. Line for CRM";
    begin
        If Rec.IsTemporary then
            exit;

        PostedSalesInvoiceLineforCRM.Init();
        PostedSalesInvoiceLineforCRM.TransferFields(Rec, true);
        if PostedSalesInvoiceLineforCRM.Insert() then;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Deferral Utilities", 'OnBeforeCreateDeferralSchedule', '', false, false)]
    local procedure OnBeforeCreateDeferralSchedule(DeferralCode: Code[10]; DeferralDocType: Integer; GenJnlTemplateName: Code[10]; GenJnlBatchName: Code[10]; DocumentType: Integer; DocumentNo: Code[20]; LineNo: Integer; AmountToDefer: Decimal; CalcMethod: Enum "Deferral Calculation Method"; StartDate: Date; NoOfPeriods: Integer; ApplyDeferralPercentage: Boolean; DeferralDescription: Text[100]; AdjustStartDate: Boolean; CurrencyCode: Code[10]; var IsHandled: Boolean)
    var
        l_recDeferralTemplate: Record "Deferral Template";
        l_recPurchaseLine: Record "Purchase Line";
    begin

        if l_recPurchaseLine.Get(DocumentType, DocumentNo, LineNo) then
            if l_recDeferralTemplate.Get(DeferralCode) then
                if l_recDeferralTemplate."Start Date" = l_recDeferralTemplate."Start Date"::"Refer to Purchase Invoice" then begin
                    l_recDeferralTemplate."Temp Posting Date" := l_recPurchaseLine."Deferral Start Date";
                    l_recDeferralTemplate.Modify();
                end;



    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Deferral Utilities", 'OnAfterSetStartDate', '', false, false)]
    local procedure OnAfterSetStartDate(DeferralTemplate: Record "Deferral Template"; var StartDate: Date; var AdjustedStartDate: Date)
    begin
        if DeferralTemplate."Start Date" = DeferralTemplate."Start Date"::"Refer to Purchase Invoice" then
            AdjustedStartDate := DeferralTemplate."Temp Posting Date";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGenJnlLine', '', false, false)]
    local procedure OnAfterPostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        l_recExtraCharge: Record "Extra Charge";
        l_recStripePayment: Record "Stripe Payment";
        l_recStripePayout: Record "Stripe Payout";
        l_recStripeRefund: Record "Stripe Refund";
        l_recQFPayPayment: Record "QFPay Payment";
    begin
        l_recExtraCharge.Reset();
        l_recExtraCharge.SetFilter("Posted Sales Invoice No.", GenJournalLine."Document No.");
        if l_recExtraCharge.FindFirst() then
            repeat
                l_recExtraCharge."BC Status" := l_recExtraCharge."BC Status"::Posted;
                l_recExtraCharge.Modify();
            until l_recExtraCharge.Next() = 0;

        l_recStripePayment.Reset();
        l_recStripePayment.SetFilter("General Journal Document No.", GenJournalLine."Document No.");
        if l_recStripePayment.FindFirst() then begin
            l_recStripePayment.Status := l_recStripePayment.Status::Posted;
            l_recStripePayment.Modify();
        end;

        l_recQFPayPayment.Reset();
        l_recQFPayPayment.SetFilter("General Journal Document No.", GenJournalLine."Document No.");
        if l_recQFPayPayment.FindFirst() then begin
            l_recQFPayPayment.Status := l_recQFPayPayment.Status::Posted;
            l_recQFPayPayment.Modify();
        end;

        l_recStripePayout.Reset();
        l_recStripePayout.SetFilter("General Journal Document No.", GenJournalLine."Document No.");
        if l_recStripePayout.FindFirst() then begin
            l_recStripePayout.Status := l_recStripePayout.Status::Posted;
            l_recStripePayout.Modify();
        end;

        l_recStripeRefund.Reset();
        l_recStripeRefund.SetFilter("General Journal Document No.", GenJournalLine."Document No.");
        if l_recStripeRefund.FindFirst() then begin
            l_recStripeRefund.Status := l_recStripeRefund.Status::Posted;
            l_recStripeRefund.Modify();
        end;


    end;


    procedure ProcessFirstTimePayment(SalesInvHdrNo: Code[20]; var SalesHeader: Record "Sales Header")
    var
        l_recSalesInvHdr: Record "Sales Invoice Header";

    begin
        if l_recSalesInvHdr.get(SalesInvHdrNo) then begin
            l_recSalesInvHdr."External Payment Gateway" := l_recSalesInvHdr."External Payment Gateway"::Stripe;
            l_recSalesInvHdr."Stripe Invoice ID" := SalesHeader."Stripe Invoice ID";
            l_recSalesInvHdr."Payment Status" := l_recSalesInvHdr."Payment Status"::Paid;
            l_recSalesInvHdr."External Payment Gateway" := GetExternalPaymentGateway();
            UpdateExtraCharge(l_recSalesInvHdr."No.", l_recSalesInvHdr."Stripe Payment Link", l_recSalesInvHdr."Stripe Invoice ID");
            l_recSalesInvHdr.Modify();
        end;

    end;

    procedure ProcessSecondTimePayment(SalesInvHdrNo: Code[20]; var SalesHeader: Record "Sales Header")
    var
        l_recSalesInvHdr: Record "Sales Invoice Header";
    begin
        if l_recSalesInvHdr.get(SalesInvHdrNo) then begin
            l_recSalesInvHdr."Payment Status" := l_recSalesInvHdr."Payment Status"::Pending;
            l_recSalesInvHdr.Modify();
        end;

    end;


    procedure UpdateExtraCharge(SalesInvoiceNo: Code[50]; PaymentLink: Text; InvoiceId: Text)
    var
        l_recLeaseContractBillingSched: Record "Lease Contract Billing Sched.";
        l_recExtraCharges: Record "Extra Charge";

    begin
        l_recLeaseContractBillingSched.Reset();
        l_recLeaseContractBillingSched.SetFilter("Document No.", SalesInvoiceNo);
        if l_recLeaseContractBillingSched.FindSet() then
            repeat
                l_recExtraCharges.Reset();
                l_recExtraCharges.SetFilter("Contract No.", l_recLeaseContractBillingSched."Contract No.");
                l_recExtraCharges.SetRange("Billing Schedule Line No.", l_recLeaseContractBillingSched."Line No.");
                if l_recExtraCharges.FindFirst() then begin
                    l_recExtraCharges."Posted Sales Invoice No." := SalesInvoiceNo;
                    l_recExtraCharges."Payment Link" := PaymentLink;
                    l_recExtraCharges."External Payment Gateway" := GetExternalPaymentGateway();
                    l_recExtraCharges."Stripe Invoice ID" := InvoiceId;
                    l_recExtraCharges."BC Status" := l_recExtraCharges."BC Status"::Posted;
                    l_recExtraCharges.Modify();
                end;

            until l_recLeaseContractBillingSched.Next() = 0;

    end;

    procedure GetExternalPaymentGateway(): Enum "External Payment Gateway"
    var
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
        l_recQFPaySetup: Record "QFPay Setup";
    begin

        if l_recStripePaymentSetup.Enabled then
            exit("External Payment Gateway"::Stripe);

        if l_recQFPaySetup.Enable then
            exit("External Payment Gateway"::QFPay);


    end;

    procedure UpdateBillingScheduleStatus(var SalesHeader: Record "Sales Header")
    var
        l_recLeaseBillingSchedule: Record "Lease Contract Billing Sched.";
    begin
        l_recLeaseBillingSchedule.SetRange("Contract No.", SalesHeader."Lease Contract No.");
        l_recLeaseBillingSchedule.SetRange("Document No.", SalesHeader."No.");
        l_recLeaseBillingSchedule.SetRange(l_recLeaseBillingSchedule.status, l_recLeaseBillingSchedule.status::Created);
        If l_recLeaseBillingSchedule.FindSet() then
            repeat
                l_recLeaseBillingSchedule.Status := l_recLeaseBillingSchedule.Status::Posted;
                if l_recLeaseBillingSchedule.Modify() then;
            until l_recLeaseBillingSchedule.next = 0;
    end;



    procedure UpdateStripeQFPayInvoiceToDocument(StripeQFPayInvoiceID: Text[250]; SalesInvoiceNo: Code[100])
    var
        l_recLeaseBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
    begin

        if (StripeQFPayInvoiceID = '') or (SalesInvoiceNo = '') then
            exit;

        l_recSalesInvoiceHeader.Reset();
        l_recSalesInvoiceHeader.SetFilter("No.", SalesInvoiceNo);
        if l_recSalesInvoiceHeader.FindFirst() then begin
            l_recSalesInvoiceHeader."Stripe Invoice ID" := StripeQFPayInvoiceID;
            l_recSalesInvoiceHeader."Payment Status" := l_recSalesInvoiceHeader."Payment Status"::Paid;
            l_recSalesInvoiceHeader.Modify();
        end;

        l_recLeaseBillingSchedule.Reset();
        l_recLeaseBillingSchedule.SetFilter("Document No.", SalesInvoiceNo);
        if l_recLeaseBillingSchedule.FindFirst() then
            repeat
                l_recLeaseBillingSchedule."Stripe Invoice ID" := StripeQFPayInvoiceID;
                l_recLeaseBillingSchedule."External Payment Gateway" := GetExternalPaymentGateway();
                l_recLeaseBillingSchedule.Status := l_recLeaseBillingSchedule.Status::Paid;
                l_recLeaseBillingSchedule.Modify();
            until l_recLeaseBillingSchedule.Next() = 0;


    end;
}
