page 82013 "QFPay - Refund"
{
    ApplicationArea = All;
    Caption = 'QFPay Refund';
    PageType = List;
    SourceTable = "QFPay Refund";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ToolTip = 'Specifies the value of the id field.';
                }
                field(out_trade_no; Rec.out_trade_no)
                {
                    ToolTip = 'Specifies the value of the API Order Number field.';
                }
                field(syssn; Rec.syssn)
                {
                    ToolTip = 'Specifies the value of the Transaction ID field.';
                }
                field(sysdtm; Rec.sysdtm)
                {
                    ToolTip = 'Specifies the value of the Transaction Time field.';
                }
                field(paydtm; Rec.paydtm)
                {
                    ToolTip = 'Specifies the value of the paydtm field.';
                }
                field(txcurrcd; Rec.txcurrcd)
                {
                    ToolTip = 'Specifies the value of the Transaction Currency field.';
                }
                field(txamt; Rec.txamt)
                {
                    ToolTip = 'Specifies the value of the Transaction Amount field.';
                }
                field(errmsg; Rec.errmsg)
                {
                    ToolTip = 'Specifies the value of the txamt field.';
                }
                field(pay_type; Rec.pay_type)
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(clisn; Rec.clisn)
                {
                    ToolTip = 'Specifies the value of the clisn field.';
                }
                field(txdtm; Rec.txdtm)
                {
                    ToolTip = 'Specifies the value of the Request Transaction Time field.';
                }
                field("Service Charge"; Rec."Service Charge")
                {
                    ToolTip = 'Specifies the value of the Service Charge field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Refund Fee"; Rec."Refund Fee")
                {
                    ToolTip = 'Specifies the value of the Refund Fee field.';
                }
                field("Sales Document No."; Rec."Sales Document No.")
                {
                    ToolTip = 'Specifies the value of the Sales Document No. field.';
                }
                field("Sales Document Type"; Rec."Sales Document Type")
                {
                    ToolTip = 'Specifies the value of the Sales Document Type field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("General Journal Document Type"; Rec."General Journal Document Type")
                {
                    ToolTip = 'Specifies the value of the General Journal Document Type field.';
                }
                field("General Journal Document No."; Rec."General Journal Document No.")
                {
                    ToolTip = 'Specifies the value of the General Journal Document No. field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Get QFPay Refund")
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
                    l_cuQFPay.CreateQFPayRefundJournal();
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
                    l_recGenJournalBatch.Get(l_recQFPaySetup."QFPay Refund Jnl. Template", l_recQFPaySetup."QFPay Refund Jnl. Batch");
                    GenJnlManagement.TemplateSelectionFromBatch(l_recGenJournalBatch);
                end;




            }
        }
    }
}
