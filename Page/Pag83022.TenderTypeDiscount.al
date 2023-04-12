page 83022 "Tender Type Discount"
{
    ApplicationArea = All;
    Caption = 'Tender Type Discount';
    PageType = List;
    SourceTable = "Tender Type Discount";
    SourceTableView = sorting("Posting Date") order(descending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Key"; Rec."Key")
                {
                    ToolTip = 'Specifies the value of the key field.';
                }
                field("Sales Invoice No."; Rec."Sales Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Sales Invoice No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Tender Type"; Rec."Tender Type")
                {
                    ToolTip = 'Specifies the value of the Tender Type field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }

                field("Tender Discount Amount"; Rec."Tender Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Tender Discount Amount field.';
                }

                field("Payment Amount"; Rec."Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Payment Amount field.';
                }

                field("Payment Intent"; Rec."Payment Intent")
                {
                    ToolTip = 'Specifies the value of the Payment Intent field.';
                }

                field("Stripe Invoice ID"; Rec."Stripe Invoice ID")
                {
                    ToolTip = 'Specifies the value of the Stripe Invoice Id field.';
                }
                field("Credit Memo No."; Rec."Credit Memo No.")
                {
                    ToolTip = 'Specifies the value of the Credit Memo No. field.';
                }
                field("Credit Memo Created Date"; Rec."Credit Memo Created Date")
                {
                    ToolTip = 'Specifies the value of the Credit Memo Created Date field.';
                }


                field(Id; Rec.Id)
                {
                    ToolTip = 'Specifies the value of the Id field.';
                    Visible = false;
                }
                field("Sales Document Type"; Rec."Sales Document Type")
                {
                    ToolTip = 'Specifies the value of the Sales Document Type field.';
                    Visible = false;
                }


                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Visible = false;
                }
                field("Stripe Status"; Rec."Stripe Status")
                {
                    ToolTip = 'Specifies the value of the Stripe Status field.';
                    Visible = false;
                }








                // field("Charge Id"; Rec."Charge Id")
                // {
                //     ToolTip = 'Specifies the value of the Charge Id field.';
                // }




                // field(Description; Rec.Description)
                // {
                //     ToolTip = 'Specifies the value of the Description field.';
                // }
                // field("Exchange Rate"; Rec."Exchange Rate")
                // {
                //     ToolTip = 'Specifies the value of the Exchange Rate field.';
                // }
                // field("Net Amount"; Rec."Net Amount")
                // {
                //     ToolTip = 'Specifies the value of the Net Amount field.';
                // }




                // field("Stripe Fee Amount"; Rec."Stripe Fee Amount")
                // {
                //     ToolTip = 'Specifies the value of the Stripe Fee Amount field.';
                // }


            }
        }
    }

    actions
    {

        area(Processing)
        {

            action("Create Credit Memo")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = JobSalesInvoice;
                trigger OnAction()
                var
                    l_rptStripePaymentTenderType: Report "Stripe Payment - Tender Type";
                    l_recTenderTypeDiscount: Record "Tender Type Discount";

                begin

                    l_recTenderTypeDiscount.SetFilter("Sales Invoice No.", Rec."Sales Invoice No.");
                    //  l_rptLeaseContractCreateInvoice.SetAsOfDate(Rec."Posting Date");
                    l_rptStripePaymentTenderType.SetTableView(l_recTenderTypeDiscount);
                    l_rptStripePaymentTenderType.run;

                end;
            }
            action("Insert into Billing Schedule")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = JobSalesInvoice;
                trigger OnAction()
                var
                    l_CoduInserttoBillSch: Codeunit "Addi.Item Sales to Bill. Sch.";
                    l_recTenderTypeDiscount: Record "Tender Type Discount";

                begin
                    // l_recTenderTypeDiscount.reset;
                    CurrPage.SetSelectionFilter(l_recTenderTypeDiscount);
                    l_recTenderTypeDiscount.FindFirst();
                    l_CoduInserttoBillSch.InsertTenderTypeDiscount(l_recTenderTypeDiscount, false);

                end;

            }
            action("Show Sales Invoice")
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
                begin

                    if Rec."Sales Invoice No." <> '' then begin
                        If l_recSalesHeader.get(l_recSalesHeader."Document Type"::Invoice, rec."Sales Invoice No.") then
                            page.run(page::"Sales Invoice", l_recSalesHeader)
                        else
                            if l_recSalesInvoice.get(rec."Sales Invoice No.") then
                                page.run(page::"Posted Sales Invoice", l_recSalesInvoice);
                    end;
                end;

            }
            action("Show Credit Memo")
            {

                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                image = Document;
                trigger OnAction()
                var
                    l_recSalesHeader: Record "Sales Header";
                    l_recSalesCreditMemo: Record "Sales Cr.Memo Header";

                begin
                    if Rec."Credit Memo Created Date" <> 0DT then begin
                        If l_recSalesHeader.get(l_recSalesHeader."Document Type"::"Credit Memo", rec."Credit Memo No.") then
                            page.run(page::"Sales Credit Memo", l_recSalesHeader)
                        else
                            if l_recSalesCreditMemo.get(rec."Credit Memo No.") then
                                page.run(page::"Posted Sales Credit Memo", l_recSalesCreditMemo);
                    end;
                end;

            }

            action("Show Lease Contract")
            {

                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                image = Document;
                Enabled = Rec."Contract No." <> '';
                trigger OnAction()
                var
                    l_recLeaseContractHeader: Record "Lease Contract Header";
                    l_PageLeaseContract: Page "Lease Contract";

                begin
                    If Rec."Contract No." <> '' then begin
                        l_recLeaseContractHeader.SetRange("No.", Rec."Contract No.");
                        If l_recLeaseContractHeader.FindFirst() then
                            page.run(page::"Lease Contract", l_recLeaseContractHeader);
                    end;
                End;

            }
        }
    }

}