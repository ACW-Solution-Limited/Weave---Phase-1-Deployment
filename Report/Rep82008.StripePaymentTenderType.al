report 82008 "Stripe Payment - Tender Type"
{
    Caption = 'Stripe Payment - Tender Type';
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = True;
    dataset
    {
        dataitem("Tender Type Discount"; "Tender Type Discount")
        {
            DataItemTableView = sorting("Posting Date") where("Credit Memo Created Date" = Filter(0DT));
            RequestFilterFields = "Sales Invoice No.";
            trigger OnAfterGetRecord()
            var
                l_RecPostedSalesInv: Record "Sales Invoice Header";
                l_SalesHeader: Record "Sales Header";
                l_SalesLine: Record "Sales Line";
                l_TenderTypeSetup: Record "Tender Type Setup";
                l_recLeaseContractSetup: Record "Lease Contract Setup";
                l_CodNoseriesManagement: Codeunit NoSeriesManagement;
                l_CodAddItemSalestoBillSch: Codeunit "Addi.Item Sales to Bill. Sch.";
                l_RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
                l_RecBillingSchedule: Record "Lease Contract Billing Sched.";


            begin
                If "Tender Discount Amount" = 0 then
                    CurrReport.Skip();
                l_RecSalesReceivablesSetup.Get;
                l_recLeaseContractSetup.Get;
                l_RecPostedSalesInv.reset;
                l_TenderTypeSetup.reset;
                l_TenderTypeSetup.SetFilter("Tender Type", "Tender Type");
                l_TenderTypeSetup.Findfirst();
                If "Sales Invoice No." <> '' then
                    l_RecPostedSalesInv.Get("Sales Invoice No.");
                l_SalesHeader.Init();
                l_SalesHeader.Validate("Document Type", l_SalesHeader."Document Type"::"Credit Memo");

                l_SalesHeader."No." := l_CodNoseriesManagement.GetNextNo(l_RecSalesReceivablesSetup."Credit Memo Nos.", WorkDate(), true);
                l_SalesHeader.Validate("Sell-to Customer No.", l_RecPostedSalesInv."Bill-to Customer No.");
                l_SalesHeader.Validate("Bill-to Customer No.", l_RecPostedSalesInv."Bill-to Customer No.");
                l_SalesHeader."Lease Contract No." := l_RecPostedSalesInv."Lease Contract No.";
                l_SalesHeader."Lease Contract Name" := l_RecPostedSalesInv."Lease Contract Name";
                l_SalesHeader."Lease Contract Creation Date" := l_RecPostedSalesInv."Lease Contract Creation Date";

                l_SalesHeader.Insert();

                l_SalesLine.init;
                l_SalesLine."Document Type" := l_SalesHeader."Document Type";
                l_SalesLine."Document No." := l_SalesHeader."No.";
                l_SalesLine."Tender Type" := "Tender Type Discount"."Tender Type";
                l_SalesLine."type" := l_SalesLine."type"::"G/L Account";
                l_SalesLine."Line No." := GetLineNo(l_SalesHeader);
                l_SalesLine.Validate("No.", l_TenderTypeSetup."G/L Account");
                l_SalesLine."Billing Schedule Type" := l_SalesLine."Billing Schedule Type"::Rent;
                l_SalesLine."Invoice Description" := l_TenderTypeSetup."Invoice Description";
                l_SalesLine."Location Code" := l_recLeaseContractSetup."Item Sales Location";
                l_SalesLine.Validate(Quantity, 1);
                l_SalesLine.Validate("Unit price", "Tender Discount Amount");
                l_SalesLine."Deferral Code" := l_recLeaseContractSetup."Rental Income Deferral Templ.";
                l_SalesLine.Insert();

                "Credit Memo No." := l_SalesHeader."No.";
                "Credit Memo Created Date" := CurrentDateTime;
                Modify();

                ApplyEntriesforTenderTypeDisc(l_RecPostedSalesInv."Lease Contract No.", "Sales Invoice No.", l_SalesHeader."No.", "Tender Type", "Tender Discount Amount");
                InsertDeferral(l_SalesLine, l_SalesHeader, "Sales Invoice No.");

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
        "Tender Type Discount".SetFilter("Tender Discount Amount", '<>%1', 0);
    end;

    var
        g_lineNo: Integer;

    procedure GetLineNo(var SalesHeader: Record "Sales Header"): Integer
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.reset;
        SalesLine.setrange("Document Type", SalesHeader."Document Type");
        SalesLine.setrange("Document No.", SalesHeader."No.");
        If SalesLine.FindFirst() then
            g_lineNo := SalesLine."Line No."
        else
            g_lineNo := 10000;
        exit(g_lineNo);
    end;

    procedure ApplyEntriesforTenderTypeDisc(Var LeaseContractHeaderNo: Code[20]; SalesInvHeaderNo: Code[20]; CreditMemoNo: Code[20]; TenderType: code[20]; DiscountAmt: Decimal)
    var
        l_recLeaseBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recCustLedgEntry: Record "Cust. Ledger Entry";

    begin
        Message('%1', SalesInvHeaderNo);
        // l_recLeaseBillingSchedule.reset;
        l_recCustLedgEntry.reset;
        // l_recLeaseBillingSchedule.setrange("Contract No.", LeaseContractHeader."No.");
        // l_recLeaseBillingSchedule.setrange(Type, l_recLeaseBillingSchedule.Type::Rent);
        // l_recLeaseBillingSchedule.setrange("Tender Type", TenderType);
        // l_recLeaseBillingSchedule.setrange(Amount, -DiscountAmt);
        // l_recLeaseBillingSchedule.SetFilter(status, '<>%1', l_recLeaseBillingSchedule.Status::" ");
        // If l_recLeaseBillingSchedule.findlast then begin
        l_recCustLedgEntry.SetFilter("Document No.", SalesInvHeaderNo);
        If l_recCustLedgEntry.Findlast then begin
            l_recCustLedgEntry.validate("Applies-to ID", CreditMemoNo);
            l_recCustLedgEntry.Modify();
            Message('%1', l_recCustLedgEntry."Document No.");
        end;
    end;

    procedure InsertDeferral(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var SalesInvoiceNo: code[20])
    var
        l_recLeaseContractSetup: Record "Lease Contract Setup";
        l_recGeneralLedgerSetup: Record "General Ledger Setup";
        l_recLeaseContractHeader: Record "Lease Contract Header";
        l_recPostedDeferralHeader: Record "Posted Deferral Header";
        l_recPostedDeferralLine: Record "Posted Deferral Line";
        l_recPostedSalesInvoiceLine: Record "Sales Invoice Line";
        l_intNoOfPeriod: Integer;
        l_decTotalDeferralAmount: Decimal;
        l_decDeferralAmount: Decimal;


    begin

        l_decTotalDeferralAmount := 0;
        l_decDeferralAmount := 0;
        l_intNoOfPeriod := 0;
        l_recLeaseContractSetup.Get();
        // l_recGeneralLedgerSetup.Get();
        l_recPostedDeferralHeader.reset;
        l_recPostedDeferralLine.reset;
        l_recPostedSalesInvoiceLine.reset;


        if SalesLine."Deferral Code" = '' then
            exit;
        // Get Posted Sales Invoice Line >>    
        l_recPostedSalesInvoiceLine.SetRange("Document No.", SalesInvoiceNo);
        l_recPostedSalesInvoiceLine.SetRange("Billing Schedule Type", l_recPostedSalesInvoiceLine."Billing Schedule Type"::Rent);
        l_recPostedSalesInvoiceLine.FindFirst();
        // Get Posted Sales Invoice Line <<

        l_recPostedDeferralHeader.setfilter("Document No.", SalesInvoiceNo);
        l_recPostedDeferralHeader.setrange("Line No.", l_recPostedSalesInvoiceLine."Line No.");

        If l_recPostedDeferralHeader.FindFirst() then begin

            InsertDeferralHeader('', '', SalesHeader."Document Type".AsInteger(), SalesHeader."No.",
                                     SalesLine."Line No.", l_recPostedDeferralHeader."Start Date", l_recPostedDeferralHeader."No. of Periods", SalesLine."Deferral Code",
                                     SalesLine."Line Amount", SalesLine."Line Amount");


            l_recPostedDeferralLine.SetRange("Document No.", SalesInvoiceNo);
            l_recPostedDeferralLine.SetRange("Line No.", l_recPostedDeferralHeader."Line No.");
            If l_recPostedDeferralLine.FindSet() then begin
                repeat


                    l_decDeferralAmount := SalesLine.Amount * l_recPostedDeferralLine.Amount / l_recPostedDeferralHeader."Amount to Defer";


                    InsertDeferralLine('', '', SalesHeader."Document Type".AsInteger(), SalesHeader."No.", SalesLine."Line No.",
                                 l_recPostedDeferralLine."Posting Date",
                                 StrSubstNo('Tender Type Discount (%1) for %2', SalesLine."Tender Type", format(l_recPostedDeferralLine."Posting Date", 0, '<Month Text,3> <Year4>')),
                                 l_decDeferralAmount,
                                 l_decDeferralAmount, SalesLine."Tender Type");
                until l_recPostedDeferralLine.next = 0;
            end;

        end;









    end;

    procedure InsertDeferralHeader(GenJnlTemplateName: Code[50]; GenJnlBatchName: Code[50]; DocumentType: Option; DocumentNo: Code[50]; LineNo: Integer; StartDate: Date; NoOfPeriod: Integer; DefferalCode: Code[50]; AmountToDefer: Decimal; AmountToDeferLCY: Decimal)
    var
        l_recDeferralHeader: Record "Deferral Header";
    begin

        l_recDeferralHeader.init;
        l_recDeferralHeader."Deferral Doc. Type" := l_recDeferralHeader."Deferral Doc. Type"::Sales;
        l_recDeferralHeader."Gen. Jnl. Template Name" := GenJnlTemplateName;
        l_recDeferralHeader."Gen. Jnl. Batch Name" := GenJnlBatchName;
        l_recDeferralHeader."Document Type" := DocumentType;
        l_recDeferralHeader."Document No." := DocumentNo;
        l_recDeferralHeader."Line No." := LineNo;
        l_recDeferralHeader."Start Date" := StartDate;
        l_recDeferralHeader."Calc. Method" := l_recDeferralHeader."Calc. Method"::"User-Defined";
        l_recDeferralHeader."No. of Periods" := NoOfPeriod;
        l_recDeferralHeader."Deferral Code" := DefferalCode;
        l_recDeferralHeader."Amount to Defer" := AmountToDefer;
        l_recDeferralHeader."Amount to Defer (LCY)" := AmountToDeferLCY; //#999
        if not l_recDeferralHeader.insert then l_recDeferralHeader.Modify();

    end;




    procedure InsertDeferralLine(GenJnlTemplateName: Code[50]; GenJnlBatchName: Code[50]; DocumentType: Option; DocumentNo: Code[50]; LineNo: Integer; PostingDate: Date; Description: Text[250]; Amount: Decimal; AmountLCY: Decimal; TenderType: Code[20])
    var
        l_recDeferralLine: Record "Deferral Line";
    //l_recDeferralLineChecking: Record "Deferral Line";
    begin

        /*   l_recDeferralLineChecking.Reset();
           l_recDeferralLineChecking.SetRange("Deferral Doc. Type", l_recDeferralLineChecking."Deferral Doc. Type"::Sales);
           l_recDeferralLineChecking.SetFilter("Gen. Jnl. Template Name", GenJnlTemplateName);
           l_recDeferralLineChecking.SetFilter("Gen. Jnl. Batch Name", GenJnlBatchName);
           l_recDeferralLineChecking.SetRange("Document Type", DocumentType);
           l_recDeferralLineChecking.SetFilter("Document No.", DocumentNo);
           l_recDeferralLineChecking.SetRange("Posting Date", PostingDate);
           l_recDeferralLineChecking.SetRange("Line No.", LineNo);
           if l_recDeferralLineChecking.FindFirst() then begin
               l_recDeferralLineChecking.Amount += Amount;
               l_recDeferralLineChecking."Amount (LCY)" += AmountLCY;
               l_recDeferralLineChecking.Modify();
           end
           else begin
   */

        l_recDeferralLine.init;
        l_recDeferralLine."Deferral Doc. Type" := l_recDeferralLine."Deferral Doc. Type"::Sales;
        l_recDeferralLine."Gen. Jnl. Template Name" := GenJnlTemplateName;
        l_recDeferralLine."Gen. Jnl. Batch Name" := GenJnlBatchName;
        l_recDeferralLine."Document Type" := DocumentType;
        l_recDeferralLine."Document No." := DocumentNo;
        l_recDeferralLine."Line No." := LineNo;
        l_recDeferralLine."Posting Date" := PostingDate;
        l_recDeferralLine.Description := Description;
        l_recDeferralLine.Amount := Amount;
        l_recDeferralLine."Amount (LCY)" := AmountLCY;
        l_recDeferralLine."Tender Type" := TenderType;
        if l_recDeferralLine.insert then;
        // end;
    end;
}
