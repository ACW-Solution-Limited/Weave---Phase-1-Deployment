page 82011 "QFPay Payment"
{
    ApplicationArea = All;
    Caption = 'QFPay Payment';
    PageType = List;
    SourceTable = "QFPay Payment";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(id; Rec.id)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the id field.';
                }
                field("Merchant Order ID"; Rec.out_trade_no)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the out_trade_no field.';
                }
                field("Transaction Date Time"; Rec.paydtm)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the paydtm field.';
                }
                field("System Date Time"; Rec.sysdtm)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the sysdtm field.';
                }
                field("Transaction ID"; Rec.syssn)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the syssn field.';
                }
                field("Amount"; Rec.txamt)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the txamt field.';
                }

                field("Service Charge"; Rec."Service Charge")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec.txcurrcd)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the txcurrcd field.';
                }
                field("Transaction Type"; Rec.pay_type) { ApplicationArea = all; }
                field("Sales Document Type"; Rec."Sales Document Type") { ApplicationArea = all; }
                field("Sales Document No."; Rec."Sales Document No.") { ApplicationArea = all; }
                field(Status; Rec.Status) { ApplicationArea = all; }
                field("General Journal Document Type"; Rec."General Journal Document Type") { ApplicationArea = all; }
                field("General Journal Document No."; Rec."General Journal Document No.") { ApplicationArea = all; }


            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Get QFPay Payment")
            {
                ApplicationArea = All;
                Image = CreateXMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    l_cuQFPay: Codeunit "Integration - QFPay";
                begin
                    l_cuQFPay.GetCurrentAndLastMonthTransaction();
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
                    l_cuQFPay: Codeunit "Integration - QFPay";
                begin
                    l_cuQFPay.CreateQFPayPayoutJournal();
                end;
            }

            action("Open QFPay Payment Journal")
            {
                ApplicationArea = All;
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    l_recGenJournalBatch: Record "Gen. Journal Batch";
                    l_recQFPaySetup: Record "QFPay Setup";
                    GenJnlManagement: Codeunit GenJnlManagement;
                begin
                    l_recQFPaySetup.FindFirst();
                    l_recGenJournalBatch.Get(l_recQFPaySetup."QF Pay Payment Jnl. Template", l_recQFPaySetup."QF Pay Payment Jnl. Batch");
                    GenJnlManagement.TemplateSelectionFromBatch(l_recGenJournalBatch);
                end;




            }
        }
    }


}
