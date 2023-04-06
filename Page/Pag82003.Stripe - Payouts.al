page 82003 "Stripe Payouts"
{
    ApplicationArea = All;
    Caption = 'Stripe Payouts';
    PageType = List;
    SourceTable = "Stripe Payout";
    SourceTableView = sorting("Posting Date") order(descending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Id field.';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created field.';
                }
                field("Arrival Date"; Rec."Arrival Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Arrival Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Payouts")
            {
                ApplicationArea = All;
                Image = CreateXMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    l_recSalesInvoice: Record "Sales Invoice Header";
                    l_cuStripe: Codeunit Stripe;
                begin
                    l_cuStripe.GetPayouts(20000101D);
                end;
            }
            action("Create Journal")
            {
                ApplicationArea = All;
                Image = CreateDocuments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    l_cuStripe: Codeunit Stripe;
                begin
                    l_cuStripe.CreateStripeJournal('Payout');
                end;
            }

            action("Open Stripe Payouts Journal")
            {
                ApplicationArea = All;
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    l_recGenJournalBatch: Record "Gen. Journal Batch";
                    l_recStripePaymentSetup: Record "Stripe Payment Setup";
                    GenJnlManagement: Codeunit GenJnlManagement;

                begin
                    l_recStripePaymentSetup.get;
                    l_recGenJournalBatch.Get(l_recStripePaymentSetup."Stripe Payout Jnl. Template", l_recStripePaymentSetup."Stripe Payout Jnl. Batch");
                    GenJnlManagement.TemplateSelectionFromBatch(l_recGenJournalBatch);
                end;


            }
        }
    }
}
