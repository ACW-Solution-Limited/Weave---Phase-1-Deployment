page 83027 "Sales Commission"
{
    ApplicationArea = All;
    Caption = 'Sales Commission';
    PageType = Worksheet;
    SourceTable = "Sales Commission Line";
    DelayedInsert = true;
    ShowFilter = False;
    SourceTableTemporary = True;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {


            field(MonthFilter; MonthFilter)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Month';
                ToolTip = 'Specifies a filter for which month to display.';

                trigger OnValidate()
                var

                begin
                    If MonthFilter.AsInteger() > 12 then
                        Error('%1', 'Month cannot be greater 12')
                    else
                        InsertCommissionline()
                end;
            }
            field(YearFilter; YearFilter)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Year';
                ToolTip = 'Specifies a filter for which year to display.';


                trigger OnValidate()
                begin
                    If Strlen(format(YearFilter)) <> 4 then begin
                        Error('%1', 'Not a valid year');
                    end else begin
                        InsertCommissionline()
                    end;

                end;

            }

            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Commission Type"; Rec."Commission Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field("Invoice Amount Including VAT"; Rec."Invoice Amount Including VAT")
                {
                    ToolTip = 'Specifies the value of the Invoice Amount Including VAT field.';
                }
                field("Commission Amount"; Rec."Commission Amount")
                {
                    ToolTip = 'Specifies the value of the Commission Amount field.';
                }
                field(Salesperson; Rec.Salesperson)
                {
                    ToolTip = 'Specifies the value of the Salesperson field.';
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesperson Name field.';
                }
            }
        }
    }
    actions
    {

        area(Processing)
        {
            action("&Search")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Search';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Shift+Enter';
                ToolTip = 'View information about the item.';
                trigger OnAction()
                begin
                    InsertCommissionline();
                end;
            }
            action("&Reset")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Reset';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Shift+Delete';
                ToolTip = 'Clear all filters.';
                trigger OnAction()
                begin
                    ClearAll();
                    Rec.DeleteAll();
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

                    l_recSalesInvoice: Record "Sales Invoice Header";
                    l_recSalesCreditMemo: Record "Sales Cr.Memo Header";
                begin

                    case rec."Document Type" of
                        rec."Document Type"::Invoice:
                            begin
                                if l_recSalesInvoice.get(rec."Document No.") then
                                    page.run(page::"Posted Sales Invoice", l_recSalesInvoice);
                            end;
                        rec."Document Type"::"Credit Memo":
                            begin
                                if l_recSalesCreditMemo.get(rec."Document No.") then
                                    page.run(page::"Posted Sales Credit Memo", l_recSalesCreditMemo);
                            end;
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


    procedure InsertCommissionline()
    var
        l_recCommissionTemp: Record "Sales Commission Line" temporary;
        l_reccustomerledgerentry: Record "Cust. Ledger Entry";
        l_recPostedSalesInvoice: Record "Sales Invoice Header";
        l_recPostedSalesInvoiceLine: Record "Sales Invoice Line";
        l_recPostedCreditMemo: Record "Sales Cr.Memo Header";
        l_recPostedCreditMemoLine: Record "Sales Cr.Memo Line";
        l_PostedDeferralLine: Record "Posted Deferral Line";
        l_recBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recSalesComissionSetup: Record "Sales Commission Setup";
        DateStartfilter: Date;
        DateEndfilter: Date;
        l_Commission: Decimal;
        l_calculationfactor: Decimal;
        l_sequence: Integer;

    begin
        Rec.DeleteAll();
        l_recCommissionTemp.DeleteAll();
        Clear(l_Commission);
        Clear(l_calculationfactor);
        l_recPostedSalesInvoice.reset;
        l_recPostedSalesInvoiceLine.reset;
        l_recPostedCreditMemo.reset;
        l_recPostedCreditMemoLine.reset;
        l_PostedDeferralLine.reset;


        If MonthFilter.AsInteger() <> 0 then begin
            DateStartfilter := DMY2DATE(1, MonthFilter.AsInteger(), Date2DMY(WorkDate(), 3));
            DateEndfilter := CalcDate('1M', DateStartfilter) - 1;
            //   Message('%1,%2', DateStartfilter, DateEndfilter);
        end;

        If YearFilter <> 0 then begin
            If MonthFilter.AsInteger() <> 0 then
                DateStartfilter := DMY2DATE(1, MonthFilter.AsInteger(), YearFilter)
            else
                DateStartfilter := DMY2DATE(1, Date2DMY(WorkDate(), 2), YearFilter);
            DateEndfilter := CalcDate('1M', DateStartfilter) - 1;
            //     Message('%1,%2', DateStartfilter, DateEndfilter);
        end;

        // Get Posted Sales Invoice >>
        //l_recPostedSalesInvoice.SetFilter("Posting Date", '%1..%2', DateStartfilter, DateEndfilter);
        l_recPostedSalesInvoice.SetFilter("Salesperson Code", '<>%1', '');
        If l_recPostedSalesInvoice.findset then
            repeat
                l_sequence := 0;
                case l_recPostedSalesInvoice."Calculation Type" of
                    l_recPostedSalesInvoice."Calculation Type"::ByPrecentage:
                        begin
                            l_Commission := l_recPostedSalesInvoice."Commission Amount" / 100;
                        END;
                    l_recPostedSalesInvoice."Calculation Type"::ByAmount:
                        begin
                            l_Commission := l_recPostedSalesInvoice."Commission Amount";
                        end;
                end;

                If l_recPostedSalesInvoice."Commission Type" <> l_recPostedSalesInvoice."Commission Type"::B2CRenewal then begin
                    l_PostedDeferralLine.reset;
                    l_PostedDeferralLine.SetRange("Document No.", l_recPostedSalesInvoice."No.");
                    l_PostedDeferralLine.SetFilter("Posting Date", '%1..%2', DateStartfilter, DateEndfilter);
                    l_PostedDeferralLine.SetFilter("Tender Type", '=%1', '');
                    //   l_PostedDeferralLine.SetRange("Billing Schedule Type", l_recPostedSalesInvoiceLine."Billing Schedule Type"::Rent);
                    If l_PostedDeferralLine.FindSet() then
                        repeat

                            l_recCommissionTemp."Contract No." := l_recPostedSalesInvoice."Lease Contract No.";
                            l_recCommissionTemp."Commission Type" := l_recPostedSalesInvoice."Commission Type";
                            l_recCommissionTemp."Document Type" := l_recCommissionTemp."Document Type"::Invoice;
                            l_recCommissionTemp."Document No." := l_recPostedSalesInvoice."No.";
                            l_recCommissionTemp.validate(Salesperson, l_recPostedSalesInvoice."Salesperson Code");

                            If l_recPostedSalesInvoice."Calculation Type" = l_recPostedSalesInvoice."Calculation Type"::ByPrecentage then
                                l_recCommissionTemp."Commission Amount" += l_PostedDeferralLine.Amount * l_Commission
                            else
                                l_recCommissionTemp."Commission Amount" += l_Commission;

                            l_recCommissionTemp.Date := l_PostedDeferralLine."Posting Date";
                            l_recCommissionTemp."invoice Amount" += l_PostedDeferralLine.Amount;

                            l_recPostedSalesInvoiceline.SetRange("Document No.", l_recPostedSalesInvoice."No.");
                            l_recPostedSalesInvoiceline.SetRange("Line No.", l_PostedDeferralLine."Line No.");
                            If l_recPostedSalesInvoiceline.FindFirst then
                                l_recCommissionTemp."Invoice Amount Including VAT" += l_PostedDeferralLine.Amount * (1 + l_recPostedSalesInvoiceline."VAT %" / 100);

                        until l_PostedDeferralLine.next = 0;

                end else begin
                    // >> For Renewal Commission Type - No need to refer to deferral schedule
                    If (l_recPostedSalesInvoice."Posting Date" >= DateStartfilter) And (l_recPostedSalesInvoice."Posting Date" <= DateEndfilter) then begin
                        // >> check whether the contract period more assigned period 
                        l_recSalesComissionSetup.reset;
                        l_recBillingSchedule.reset;
                        l_sequence := 0;
                        l_recSalesComissionSetup.Get(l_recPostedSalesInvoice."Commission Type");
                        l_recBillingSchedule.SetFilter("Contract No.", '%1', l_recPostedSalesInvoice."Lease Contract No.");
                        l_recBillingSchedule.SetRange(Type, l_recBillingSchedule.Type::Rent);
                        l_recBillingSchedule.setRange(l_recBillingSchedule."Sub-Type", '');
                        If l_recBillingSchedule.findset then
                            repeat
                                If l_recBillingSchedule."No. of Days Current Month" = l_recBillingSchedule."No. of Days to Bill" then
                                    l_sequence += 1;
                            until l_recBillingSchedule.Next = 0;
                        // <<check whether the contract period more assigned period 
                        If l_sequence >= l_recSalesComissionSetup."Minimum Contract Period" then begin

                            l_recPostedSalesInvoiceLine.Reset();
                            l_recPostedSalesInvoiceLine.setrange("Document No.", l_recPostedSalesInvoice."No.");
                            l_recPostedSalesInvoiceLine.SetFilter("Tender Type", '=%1', '');
                            If l_recPostedSalesInvoiceLine.Findset() then begin
                                repeat

                                    l_recCommissionTemp."invoice Amount" += l_recPostedSalesInvoiceLine."Line Amount";
                                    l_recCommissionTemp."Invoice Amount Including VAT" += l_recPostedSalesInvoiceLine."Amount Including VAT";
                                until l_recPostedSalesInvoiceLine.Next() = 0;
                            end;

                            l_recCommissionTemp."Contract No." := l_recPostedSalesInvoice."Lease Contract No.";
                            l_recCommissionTemp."Commission Type" := l_recPostedSalesInvoice."Commission Type";
                            l_recCommissionTemp."Document Type" := l_recCommissionTemp."Document Type"::Invoice;
                            l_recCommissionTemp."Document No." := l_recPostedSalesInvoice."No.";
                            l_recCommissionTemp.Date := l_recPostedSalesInvoice."Posting Date";
                            l_recCommissionTemp.validate(Salesperson, l_recPostedSalesInvoice."Salesperson Code");

                            l_recCommissionTemp."Commission Amount" := l_Commission;
                        end;
                    end;
                    // >> For Renewal Commission Type - No need to refer to deferral schedule
                end;


                If l_recCommissionTemp."Contract No." <> '' then begin
                    Rec.Init();
                    Rec.TransferFields(l_recCommissionTemp);
                    Rec.Insert();
                    Clear(l_recCommissionTemp);
                end;

            until l_recPostedSalesInvoice.next = 0;

        // Get Posted Sales Invoice <<
        // Get Posted Sales Credit Memo >>

        //l_recPostedCreditMemo.SetFilter("Posting Date", '%1..%2', DateStartfilter, DateEndfilter);
        l_recPostedCreditMemo.SetFilter("Salesperson Code", '<>%1', '');
        If l_recPostedCreditMemo.findset then
            repeat
                l_sequence := 0;
                case l_recPostedCreditMemo."Calculation Type" of
                    l_recPostedCreditMemo."Calculation Type"::ByPrecentage:
                        begin
                            l_Commission := l_recPostedCreditMemo."Commission Amount" / 100;
                        END;
                    l_recPostedCreditMemo."Calculation Type"::ByAmount:
                        begin
                            l_Commission := l_recPostedCreditMemo."Commission Amount";
                        end;
                end;

                If l_recPostedCreditMemo."Commission Type" <> l_recPostedCreditMemo."Commission Type"::B2CRenewal then begin
                    l_PostedDeferralLine.reset;
                    l_PostedDeferralLine.SetRange("Document No.", l_recPostedCreditMemo."No.");
                    l_PostedDeferralLine.SetFilter("Posting Date", '%1..%2', DateStartfilter, DateEndfilter);
                    l_PostedDeferralLine.SetFilter("Tender Type", '=%1', '');
                    If l_PostedDeferralLine.FindSet() then
                        repeat
                            l_recCommissionTemp."Contract No." := l_recPostedCreditMemo."Lease Contract No.";
                            l_recCommissionTemp."Commission Type" := l_recPostedCreditMemo."Commission Type";
                            l_recCommissionTemp."Document Type" := l_recCommissionTemp."Document Type"::"Credit Memo";
                            l_recCommissionTemp."Document No." := l_recPostedCreditMemo."No.";
                            l_recCommissionTemp.validate(Salesperson, l_recPostedCreditMemo."Salesperson Code");

                            If l_recPostedCreditMemo."Calculation Type" = l_recPostedCreditMemo."Calculation Type"::ByPrecentage then
                                l_recCommissionTemp."Commission Amount" -= l_PostedDeferralLine.Amount * l_Commission
                            else
                                l_recCommissionTemp."Commission Amount" -= l_Commission;
                            l_recCommissionTemp.Date := l_PostedDeferralLine."Posting Date";
                            l_recCommissionTemp."invoice Amount" += l_PostedDeferralLine.Amount;


                            l_recPostedCreditMemoline.SetRange("Document No.", l_recPostedCreditMemo."No.");
                            l_recPostedCreditMemoline.SetRange("Line No.", l_PostedDeferralLine."Line No.");
                            If l_recPostedCreditMemoline.FindFirst then
                                l_recCommissionTemp."Invoice Amount Including VAT" += l_PostedDeferralLine.Amount * (1 + l_recPostedCreditMemoline."VAT %" / 100);

                        until l_PostedDeferralLine.next = 0;
                end else begin

                    // >> For Renewal Commission Type - No need to refer to deferral schedule
                    If (l_recPostedCreditMemo."Posting Date" >= DateStartfilter) And (l_recPostedCreditMemo."Posting Date" <= DateEndfilter) then begin
                        // >> check whether the contract period more assigned period 
                        l_sequence := 0;
                        l_recSalesComissionSetup.reset;
                        l_recBillingSchedule.reset;
                        l_recSalesComissionSetup.Get(l_recPostedCreditMemo."Commission Type");
                        // l_recSalesComissionSetup.FindFirst();
                        l_recBillingSchedule.SetFilter("Contract No.", '%1', l_recPostedCreditMemo."Lease Contract No.");
                        l_recBillingSchedule.SetRange(Type, l_recBillingSchedule.Type::Rent);
                        l_recBillingSchedule.setRange(l_recBillingSchedule."Sub-Type", '');
                        If l_recBillingSchedule.findset then
                            repeat
                                If l_recBillingSchedule."No. of Days Current Month" = l_recBillingSchedule."No. of Days to Bill" then
                                    l_sequence += 1;
                            until l_recBillingSchedule.Next = 0;
                        // >> check whether the contract period more assigned period 
                        If l_sequence >= l_recSalesComissionSetup."Minimum Contract Period" then begin


                            l_recPostedCreditMemoLine.reset;
                            l_recPostedCreditMemoLine.setrange("Document No.", l_recPostedCreditMemo."No.");
                            l_recPostedCreditMemoLine.SetFilter("Tender Type", '=%1', '');
                            If l_recPostedCreditMemoLine.Findset() then begin
                                repeat

                                    l_recCommissionTemp."invoice Amount" += l_recPostedCreditMemoLine."Line Amount";
                                    l_recCommissionTemp."Invoice Amount Including VAT" += l_recPostedCreditMemoLine."Amount Including VAT";
                                until l_recPostedCreditMemoLine.Next() = 0;
                            end;
                            l_recCommissionTemp."Contract No." := l_recPostedCreditMemo."Lease Contract No.";
                            l_recCommissionTemp."Commission Type" := l_recPostedCreditMemo."Commission Type";
                            l_recCommissionTemp."Document Type" := l_recCommissionTemp."Document Type"::Invoice;
                            l_recCommissionTemp."Document No." := l_recPostedCreditMemo."No.";
                            l_recCommissionTemp.Date := l_recPostedCreditMemo."Posting Date";
                            l_recCommissionTemp.validate(Salesperson, l_recPostedCreditMemo."Salesperson Code");

                            l_recCommissionTemp."Commission Amount" := -l_Commission;
                            l_recCommissionTemp."invoice Amount" := l_recPostedCreditMemo."Amount Including VAT";
                            l_recCommissionTemp."Invoice Amount Including VAT" := l_recPostedCreditMemo."Amount Including VAT";
                            // >> For Renewal Commission Type - No need to refer to deferral schedule

                        end;
                    end;
                end;

                If l_recCommissionTemp."Contract No." <> '' then begin
                    Rec.Init();
                    Rec.TransferFields(l_recCommissionTemp);
                    Rec.Insert();
                    Clear(l_recCommissionTemp);
                end;
            until l_recPostedCreditMemo.next = 0;

        // Get Posted Sales Credit Memo <<


    end;

    trigger OnOpenPage()

    begin

        YearFilter := Date2DMY(WorkDate(), 3);

        MonthFilter := Enum::Month.FromInteger(Date2DMY(WorkDate(), 2));

    end;

    var
        MonthFilter: enum Month;

        YearFilter: Integer;


}
