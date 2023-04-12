page 82002 "Stripe Payments"
{
    ApplicationArea = All;
    Caption = 'Stripe Payments';
    PageType = List;
    SourceTable = "Stripe Payment";
    SourceTableView = sorting("Posting Date") order(descending);
    UsageCategory = Tasks;

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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Sales Document No."; Rec."Sales Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Document No. field.';
                }
                field("Sales Document Type"; Rec."Sales Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Document Type field.';
                }
                field("Charge Id"; Rec."Charge Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Id field.';
                }
                field("Stripe Invoice ID"; Rec."Stripe Invoice ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Invoice Id field.';
                }
                field("Payment Intent"; Rec."Payment Intent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Invoice Id field.';
                }
                field("Stripe Status"; Rec."Stripe Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Status field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Tender Type"; Rec."Tender Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Stripe Fee Amount"; rec."Stripe Fee Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Fee Amount field.';

                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Amount field.';

                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }

            }
        }

    }
    actions
    {
        area(Processing)
        {

            action("Get Payments")
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
                    l_cuStripe.GetPaymentbyInvoice();
                    l_cuStripe.GetPaymentbyPaymentIntents();

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
                    l_cuStripe.CreateStripeJournal('Payment');
                end;
            }
            action("Open Stripe Payment Journal")
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
                    l_recGenJournalBatch.Get(l_recStripePaymentSetup."Stripe Payment Jnl. Template", l_recStripePaymentSetup."Stripe Payment Jnl. Batch");
                    GenJnlManagement.TemplateSelectionFromBatch(l_recGenJournalBatch);
                end;


            }
        }

    }
}
