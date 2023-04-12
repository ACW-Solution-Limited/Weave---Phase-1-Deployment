report 82004 "Create Journal"
{
    Caption = 'Create Journal';
    dataset
    {
        dataitem(StripePayment; "Stripe Payment")
        {
            column(StripeStatus; "Stripe Status")
            {
            }
            column(StripeInvoiceId; "Stripe Invoice ID")
            {
            }
            column(StripeFeeAmount; "Stripe Fee Amount")
            {
            }
            column(Status; Status)
            {
            }
            Trigger OnAfterGetRecord()
            var

                l_recStripeTransactions2: Record "Stripe Payment";
                l_recGenJournalLine: Record "Gen. Journal Line";

                l_intLineNo: Integer;
                l_cduNoSeriesMgt: Codeunit NoSeriesManagement;
                l_recJnlBatch: Record "Gen. Journal Batch";
                l_codDocNo: code[20];
            begin
                //currpage.SetSelectionFilter(l_recStripeTransactions);

                l_recGenJournalLine.reset;
                l_recGenJournalLine.setrange("Journal Template Name", l_recStripePaymentSetup."Stripe Payment Jnl. Template");
                l_recGenJournalLine.setrange("Journal Batch Name", l_recStripePaymentSetup."Stripe Payment Jnl. Batch");
                if l_recGenJournalLine.find('+') then
                    l_intLineNo := l_recGenJournalLine."Line No." + 10000
                else
                    l_intLineNo := 10000;

                l_recJnlBatch.get(l_recStripePaymentSetup."Stripe Payment Jnl. Template", l_recStripePaymentSetup."Stripe Payment Jnl. Batch");
                l_codDocNo := l_cduNoSeriesMgt.TryGetNextNo(l_recJnlBatch."No. Series", "Posting Date");
                If Status = status::Open then;
                l_recGenJournalLine.init;
                l_recGenJournalLine."Journal Template Name" := l_recStripePaymentSetup."Stripe Payment Jnl. Template";
                l_recGenJournalLine."Journal Batch Name" := l_recStripePaymentSetup."Stripe Payment Jnl. Batch";
                l_recGenJournalLine."Line No." := l_intLineNo;
                if l_recGenJournalLine.insert then;
                l_recGenJournalLine."Posting Date" := "Posting Date";
                l_recGenJournalLine."Document Type" := l_recGenJournalLine."Document Type"::Payment;
                l_recGenJournalLine."Document No." := l_codDocNo;
                l_recGenJournalLine."Account Type" := l_recGenJournalLine."Account Type"::Customer;
                l_recGenJournalLine.validate("Account No.", "Customer No.");
                l_recGenJournalLine.validate(Amount, -Amount);
                l_recGenJournalLine."Applies-to Doc. Type" := l_recGenJournalLine."Applies-to Doc. Type"::Invoice;
                l_recGenJournalLine."Applies-to Doc. No." := "Sales Document No.";
                if l_recGenJournalLine.Modify() then;
                l_intLineNo += 10000;

                l_recGenJournalLine.init;
                l_recGenJournalLine."Journal Template Name" := l_recStripePaymentSetup."Stripe Payment Jnl. Template";
                l_recGenJournalLine."Journal Batch Name" := l_recStripePaymentSetup."Stripe Payment Jnl. Batch";
                l_recGenJournalLine."Line No." := l_intLineNo;
                if l_recGenJournalLine.insert then;
                l_recGenJournalLine."Posting Date" := "Posting Date";
                l_recGenJournalLine."Document Type" := l_recGenJournalLine."Document Type"::Payment;
                l_recGenJournalLine."Document No." := l_codDocNo;
                l_recGenJournalLine."Account Type" := l_recGenJournalLine."Account Type"::"Bank Account";
                l_recGenJournalLine.validate("Account No.", l_recStripePaymentSetup."Stripe Bank Account");
                l_recGenJournalLine.validate(Amount, "Net Amount");
                if l_recGenJournalLine.Modify() then;
                l_intLineNo += 10000;

                l_recGenJournalLine.init;
                l_recGenJournalLine."Journal Template Name" := l_recStripePaymentSetup."Stripe Payment Jnl. Template";
                l_recGenJournalLine."Journal Batch Name" := l_recStripePaymentSetup."Stripe Payment Jnl. Batch";
                l_recGenJournalLine."Line No." := l_intLineNo;
                if l_recGenJournalLine.insert then;
                l_recGenJournalLine."Posting Date" := "Posting Date";
                l_recGenJournalLine."Document Type" := l_recGenJournalLine."Document Type"::Payment;
                l_recGenJournalLine."Document No." := l_codDocNo;
                l_recGenJournalLine."Account Type" := l_recGenJournalLine."Account Type"::"G/L Account";
                l_recGenJournalLine.validate("Account No.", l_recStripePaymentSetup."Stripe Processing Fee G/L Acc.");
                l_recGenJournalLine.validate(Amount, "Stripe Fee Amount");
                if l_recGenJournalLine.Modify() then;
                l_intLineNo += 10000;

                l_codDocNo := IncStr(l_codDocNo);
                if l_recStripeTransactions2.get(Id) then begin
                    l_recStripeTransactions2.Status := l_recStripeTransactions2.status::Created;
                    l_recStripeTransactions2.Modify();
                end;

            end;
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        l_recStripePaymentSetup.get;
    end;

    var
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
}
