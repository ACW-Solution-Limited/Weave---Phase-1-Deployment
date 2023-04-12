page 83007 "Lease Contract Billing Sched."
{
    Caption = 'Lease Contract Billing Schedule';
    PageType = List;
    SourceTable = "Lease Contract Billing Sched.";
    SourceTableView = sorting("Line No.") order(ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Editable = g_booEditable;
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Sub-Type"; Rec."Sub-Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Type field.';
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                // field("Amount Excluding VAT"; Rec."Amount Excluding VAT")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Amount field.';
                // }
                field("No. of Days to Bill"; rec."No. of Days to Bill")
                {
                    ApplicationArea = All;
                }
                field("No. of Days Current Month"; rec."No. of Days Current Month")
                {
                    ApplicationArea = All;
                }
                field("Additional Item Sales Date"; rec."Additional Item Sales Date")
                {
                    ApplicationArea = All;

                }
                field("Additional Sales Item No."; Rec."Additional Sales Item No.")
                {
                    ApplicationArea = All;

                }
                field("Additional Sales Item Quantity"; rec."Additional Sales Item Quantity")
                {
                    ApplicationArea = All;
                }
                field("Add. Sales Item Unit Price"; rec."Add. Sales Item Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Sales Invoice Creation Date"; Rec."Sales Invoice Creation Date") { ApplicationArea = All; }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Contract No."; rec."Contract No.")
                {
                    ApplicationArea = All;

                }
                field("Contract Line No."; rec."Contract Line No.")
                {
                    ApplicationArea = All;
                }

                field("Stripe/QFPay"; Rec."External Payment Gateway")
                {
                    ApplicationArea = All;
                }

                field("Stripe Invoice ID"; Rec."Stripe Invoice ID")
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
            action("Edit Page")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EditList;
                trigger OnAction()
                begin
                    g_booEditable := not g_booEditable;
                end;
            }
            action("Show Document")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                image = Document;
                trigger OnAction()
                var
                    l_recSalesHeader: Record "Sales Header";
                    l_recSalesInvoice: Record "Sales Invoice Header";
                    l_recSalesCreditMemo: Record "Sales Cr.Memo Header";
                begin
                    rec.TestField(Status);
                    case rec."Document Type" of
                        rec."Document Type"::Invoice:
                            begin
                                if Rec.Status = Rec.Status::Created then begin
                                    l_recSalesHeader.get(l_recSalesHeader."Document Type"::Invoice, rec."Document No.");
                                    page.run(page::"Sales Invoice", l_recSalesHeader);
                                end else
                                    if l_recSalesInvoice.get(rec."Document No.") then
                                        page.run(page::"Posted Sales Invoice", l_recSalesInvoice);
                            end;
                        rec."Document Type"::"Credit Memo":
                            begin
                                if Rec.Status = Rec.Status::Created then begin
                                    l_recSalesHeader.get(l_recSalesHeader."Document Type"::"Credit Memo", rec."Document No.");
                                    page.run(page::"Sales Credit Memo", l_recSalesHeader);
                                end else
                                    if l_recSalesCreditMemo.get(rec."Document No.") then
                                        page.run(page::"Posted Sales Credit Memo", l_recSalesCreditMemo);
                            end;
                    end;


                end;
            }

            action("Show Stripe Payment")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Stripe Payments";
                Image = ShowChart;
                RunPageLink = "Sales Document No." = field("Document No.");
            }

            action("Create Invoice/Credit Memo")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = JobSalesInvoice;
                trigger OnAction()
                var
                    l_rptLeaseContractCreateInvoice: Report "Lease Contract Create Invoices";
                    l_recLeaseBillingSchedule: Record "Lease Contract Billing Sched.";
                    l_recLeaseContractHeader: Record "Lease Contract Header";
                    l_subtype: Text;
                begin
                    l_recLeaseContractHeader.SetFilter("No.", Rec."Contract No.");
                    l_rptLeaseContractCreateInvoice.SetAsOfDate(Rec."Posting Date");
                    l_rptLeaseContractCreateInvoice.SetTableView(l_recLeaseContractHeader);
                    l_rptLeaseContractCreateInvoice.run;

                end;
            }
        }
    }

    var
        g_booEditable: Boolean;
}
