page 83031 "Bank Transfer Payment"
{
    ApplicationArea = All;
    Caption = 'Bank Transfer Payment';
    PageType = List;
    SourceTable = "Bank Transfer Payment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Bedroom Offer"; Rec."Bedroom Offer")
                {
                    ToolTip = 'Specifies the value of the Bed Room Offer field.';
                }
                field("Bank Transfer Payslip"; Rec."Bank Transfer Payslip")
                {
                    ToolTip = 'Specifies the value of the Bank Transfer Payslip field.';
                }
                field("Confirmed Transfer Payment"; Rec."Confirmed Transfer Payment")
                {
                    ToolTip = 'Specifies the value of the Confirmed Bank Transfer Payment field.';
                }
                field("Posted Sales Invoice No."; Rec."Posted Sales Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Posted Sales Invoice No. field.';
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Accept)
            {

                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction()
                var
                    l_recBankTransferPayment: Record "Bank Transfer Payment";
                begin
                    CurrPage.SetSelectionFilter(l_recBankTransferPayment);
                    if l_recBankTransferPayment.FindSet() then
                        repeat
                            if l_recBankTransferPayment.Status <> l_recBankTransferPayment.Status::Pending then
                                Error('Only pending records can be accepted.');

                            l_recBankTransferPayment.Status := l_recBankTransferPayment.Status::Paid;
                            l_recBankTransferPayment."Confirmed Transfer Payment" := true;
                            l_recBankTransferPayment.Modify();
                        until l_recBankTransferPayment.Next() = 0;
                end;

            }
            action(Reject)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;

                trigger OnAction()
                var
                    l_recBankTransferPayment: Record "Bank Transfer Payment";
                begin
                    CurrPage.SetSelectionFilter(l_recBankTransferPayment);
                    if l_recBankTransferPayment.FindSet() then
                        repeat
                            if l_recBankTransferPayment.Status <> l_recBankTransferPayment.Status::Pending then
                                Error('Only pending records can be rejected.');

                            l_recBankTransferPayment.Status := l_recBankTransferPayment.Status::Rejected;
                            l_recBankTransferPayment.Modify();
                        until l_recBankTransferPayment.Next() = 0;
                end;
            }
        }

    }
}
