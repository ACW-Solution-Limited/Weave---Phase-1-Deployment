codeunit 83140 "Addi.Item Sales to Bill. Sch."
{

    trigger OnRun()
    var
        CRMAdditionalService: Record "Additional Service";
        CRMExtraCharge: Record "Extra Charge";
        CRMAdditionalAmenities: Record "Additional Amenities";
    begin

        CreateAdditionalService(CRMAdditionalService);
        CreateAdditionalAmenities(CRMAdditionalAmenities);
        CreateExtraCharge(CRMExtraCharge);
    end;


    //procedure CreateWelcomeAmentities(var CRMWelcomeAmentities: Record "CDS acwapp_welcomeamenities"; LineNo: Integer; PostingDate: Date; DueDate: Date; PaymentReferenceID: Text[250]): Integer
    procedure CreateWelcomeAmentities(var CRMWelcomeAmentities: Record "Welcome Amenities"; ContractNo: Text[100]; LineNo: Integer; PostingDate: Date; DueDate: Date; PaymentReferenceID: Text[250]): Integer
    var
    begin
        CRMWelcomeAmentities.SetRange("BC Status", CRMWelcomeAmentities."BC Status"::Open);
        CRMWelcomeAmentities.SetRange("Contract No.", ContractNo);
        if CRMWelcomeAmentities.FindFirst() then
            repeat
                LineNo += 10000;
                InsertLCBillingSchedule(g_OptBillingType::Item,
                                        'Welcome Amentities',
                                        CRMWelcomeAmentities."Customer No.",
                                        CRMWelcomeAmentities."Contract No.",
                                        LineNo,
                                        PostingDate,//#Posting Date
                                        DueDate,//#Due Date
                                        DT2Date(CRMWelcomeAmentities."Created On"),//#Item Sales Date
                                        CRMWelcomeAmentities."Item No.",
                                        CRMWelcomeAmentities.Quantity,
                                        CRMWelcomeAmentities.Price,
                                        CRMWelcomeAmentities."Total Amount",
                                        CRMWelcomeAmentities."Total Amount Inclu. VAT",
                                        PaymentReferenceID,
                                        '',
                                        '',
                                        0,
                                        0,
                                        0D,
                                        0D);
                CRMWelcomeAmentities."BC Status" := CRMWelcomeAmentities."BC Status"::Created;
                CRMWelcomeAmentities.Modify;
            until CRMWelcomeAmentities.Next() = 0;

        exit(LineNo);
    end;



    procedure CreateAdditionalService(var CRMAdditionalService: Record "Additional Service")
    begin
        CRMAdditionalService.SetRange("BC Status", CRMAdditionalService."BC Status"::Open);
        if CRMAdditionalService.FindFirst() then
            repeat
                InsertLCBillingSchedule(g_OptBillingType::Item,
                                       'Additional Service',
                                       CRMAdditionalService."Customer No.",
                                       CRMAdditionalService."Contract No.",
                                       GetLineNo(CRMAdditionalService."Contract No."),
                                       DT2DATE(CRMAdditionalService."Created On"),//#Posting Date
                                       GetDueDate(CRMAdditionalService."Contract No.", DT2DATE(CRMAdditionalService."Created On")),//#Due Date
                                       DT2DATE(CRMAdditionalService."Created On"), //#Item Sales Date
                                       CRMAdditionalService."Item No.",
                                       CRMAdditionalService.Quantity,
                                       CRMAdditionalService.Price,
                                       CRMAdditionalService."Total Amount",
                                       CRMAdditionalService."Total Amount Inclu. VAT",
                                       CRMAdditionalService."Stripe Invoice ID",
                                       '',
                                       '',
                                       0,
                                       0,
                                       0D,
                                       0D);

                CRMAdditionalService."BC Status" := CRMAdditionalService."BC Status"::Created;
                CRMAdditionalService."Payment Status" := CRMAdditionalService."Payment Status"::Paid;
                CRMAdditionalService.Modify;
            until CRMAdditionalService.Next() = 0;
    end;



    procedure CreateAdditionalAmenities(var CRMAdditionalAmenities: Record "Additional Amenities")
    begin
        CRMAdditionalAmenities.SetRange("BC Status", CRMAdditionalAmenities."BC Status"::Open);
        if CRMAdditionalAmenities.FindFirst() then
            repeat
                InsertLCBillingSchedule(g_OptBillingType::Item,
                                      'Additional Amenities',
                                       CRMAdditionalAmenities."Customer No.",
                                       CRMAdditionalAmenities."Contract No.",
                                       GetLineNo(CRMAdditionalAmenities."Contract No."),
                                       DT2DATE(CRMAdditionalAmenities."Created On"),//#Posting Date
                                       GetDueDate(CRMAdditionalAmenities."Contract No.", DT2DATE(CRMAdditionalAmenities."Created On")),//#Due Date
                                       DT2DATE(CRMAdditionalAmenities."Created On"),//#Item Sales Date
                                       CRMAdditionalAmenities."Item No.",
                                       CRMAdditionalAmenities.Quantity,
                                       CRMAdditionalAmenities.Price,
                                       CRMAdditionalAmenities."Total Amount",
                                       CRMAdditionalAmenities."Total Amount Inclu. VAT",
                                       CRMAdditionalAmenities."Stripe Invoice ID",
                                       '',
                                       '',
                                       0,
                                       0,
                                       0D,
                                       0D);

                CRMAdditionalAmenities."BC Status" := CRMAdditionalAmenities."BC Status"::Created;
                CRMAdditionalAmenities."Payment Status" := CRMAdditionalAmenities."Payment Status"::Paid;
                CRMAdditionalAmenities.Modify;
            until CRMAdditionalAmenities.Next() = 0;
    end;


    procedure CreateEventFee(var CRMEventFee: Record "Event Fee")
    var
        l_intLineNo: Integer;
    begin
        CRMEventFee.SetRange("BC Status", CRMEventFee."BC Status"::Open);

        if CRMEventFee.FindFirst() then
            repeat
                l_intLineNo := GetLineNo(CRMEventFee."Contract No.");
                InsertLCBillingSchedule(g_OptBillingType::Item,
                                      'Event Fee',
                                       CRMEventFee."Customer Code",
                                       CRMEventFee."Contract No.",
                                       l_intLineNo,
                                       CRMEventFee.Date,//#Posting Date
                                       GetDueDate(CRMEventFee."Contract No.", CRMEventFee.Date),//#Due Date
                                        CRMEventFee.Date,//#Item Sales Date
                                       CRMEventFee."Event",
                                       1,
                                       CRMEventFee.Amount,
                                       CRMEventFee.Amount,
                                       CRMEventFee."Amount Including VAT",
                                       CRMEventFee."Payment Reference ID",
                                       '',
                                       '',
                                       0,
                                       0,
                                       0D,
                                       0D);
                CRMEventFee."Billing Schedule Line No." := l_intLineNo;
                CRMEventFee."BC Status" := CRMEventFee."BC Status"::Created;
                CRMEventFee.Modify;
            until CRMEventFee.Next() = 0;
    end;

    procedure CreateExtraCharge(var CRMExtraCharge: Record "Extra Charge")
    var

        LineNo: Integer;
        Subtype: Text;
    begin

        CRMExtraCharge.SetRange("BC Status", CRMExtraCharge."BC Status"::Open);
        CRMExtraCharge.SetRange("CRM Status", CRMExtraCharge."CRM Status"::Confirmed);
        if CRMExtraCharge.FindFirst() then
            repeat
                LineNo := GetLineNo(CRMExtraCharge."Contract No.");
                // To identify Charges Type >>
                Case CRMExtraCharge."Charges Type" of
                    CRMExtraCharge."Charges Type"::Deposit:
                        begin
                            InsertLCBillingSchedule(g_OptBillingType::Deposit,
                                                                       'Extra Charge',
                                                                       CRMExtraCharge."Customer No.",
                                                                       CRMExtraCharge."Contract No.",
                                                                       LineNo,
                                                                       GetLastRenetalPostingDate(CRMExtraCharge."Contract No."),//#Posting Date
                                                                       GetLastRenetalDueDate(CRMExtraCharge."Contract No."),//#Due Date
                                                                       DT2DATE(CRMExtraCharge."Created On"),//#Item Sales Date
                                                                       CRMExtraCharge."Item No.",
                                                                       1,
                                                                        CRMExtraCharge."Total Amount",
                                                                       CRMExtraCharge."Total Amount",
                                                                       CRMExtraCharge."Total Amount Inclu. VAT",
                                                                       CRMExtraCharge."Stripe Invoice ID",
                                                                       '',
                                                                       '',
                                                                       0,
                                                                       0,
                                                                       0D,
                                                                       0D)
                        end;
                    CRMExtraCharge."Charges Type"::AdHoc, CRMExtraCharge."Charges Type"::" ":
                        begin
                            InsertLCBillingSchedule(g_OptBillingType::Item,
                                                  CRMExtraCharge."Item Type",
                                                  CRMExtraCharge."Customer No.",
                                                  CRMExtraCharge."Contract No.",
                                                  LineNo,
                                                  GetPostingDate(CRMExtraCharge."Contract No.", DT2DATE(CRMExtraCharge."Created On")),//#Posting Date
                                                  GetPostingDate(CRMExtraCharge."Contract No.", DT2DATE(CRMExtraCharge."Created On")),//#Due Date
                                                  DT2DATE(CRMExtraCharge."Created On"),//#Item Sales Date
                                                  CRMExtraCharge."Item No.",
                                                  1,
                                                CRMExtraCharge."Total Amount",
                                                  CRMExtraCharge."Total Amount",
                                                  CRMExtraCharge."Total Amount",
                                                  CRMExtraCharge."Stripe Invoice ID",
                                                  '',
                                                  '',
                                                  0,
                                                  0,
                                                  0D,
                                                  0D);
                        end;
                    //  CRMExtraCharge."Charges Type"::"EarlyMove-in", CRMExtraCharge."Charges Type"::"LateMove-out":
                    CRMExtraCharge."Charges Type"::"EarlyMove-in":
                        begin
                            If CRMExtraCharge."Charges Type" = CRMExtraCharge."Charges Type"::"EarlyMove-in" then
                                Subtype := 'Early Move-in'
                            else
                                Subtype := 'Late Move-out';
                            InsertLCBillingSchedule(g_OptBillingType::Rent,
                                           Subtype,
                                           CRMExtraCharge."Customer No.",
                                           CRMExtraCharge."Contract No.",
                                           LineNo,
                                           DT2DATE(CRMExtraCharge."Created On"),//#Posting Date
                                           DT2DATE(CRMExtraCharge."Created On"),//#Due Date
                                           DT2DATE(CRMExtraCharge."Created On"),//#Item Sales Date
                                           CRMExtraCharge."Item No.",
                                           1,
                                          CRMExtraCharge."Total Amount",
                                          CRMExtraCharge."Total Amount",
                                          CRMExtraCharge."Total Amount",
                                           CRMExtraCharge."Stripe Invoice ID",
                                           '',
                                           '',
                                           0,
                                           0,
                                           0D,
                                           0D);
                        end;
                    // >> For extension P2
                    CRMExtraCharge."Charges Type"::Extension:
                        begin
                            Subtype := 'Extension';
                            InsertLCBillingSchedule(g_OptBillingType::Rent,
                                             Subtype,
                                             CRMExtraCharge."Customer No.",
                                             CRMExtraCharge."Contract No.",
                                             LineNo,
                                             DT2DATE(CRMExtraCharge."Created On"),//#Posting Date
                                             DT2DATE(CRMExtraCharge."Created On"),//#Due Date
                                             DT2DATE(CRMExtraCharge."Created On"),//#Item Sales Date
                                             CRMExtraCharge."Item No.",
                                             1,
                                            CRMExtraCharge."Total Amount",
                                            CRMExtraCharge."Total Amount",
                                            CRMExtraCharge."Total Amount",
                                             CRMExtraCharge."Stripe Invoice ID",
                                             '',
                                             '',
                                             0,
                                             0,
                                             0D,
                                             0D);

                        end;
                // << For extension P2
                end;
                // To identify Charges Type <<
                CRMExtraCharge."BC Status" := CRMExtraCharge."BC Status"::Created;
                CRMExtraCharge."Payment Status" := CRMExtraCharge."Payment Status"::Pending;
                CRMExtraCharge."Billing Schedule Line No." := LineNo;
                CRMExtraCharge.Modify();
            until CRMExtraCharge.Next() = 0;

    end;
    // >> Insert Tender Type Discount 
    procedure InsertTenderTypeDiscount(var TenderTypeDiscount: Record "Tender Type Discount"; JobQueue: Boolean)
    var
        l_recLCBillingSchedule: Record "Lease Contract Billing Sched.";
    begin
        l_recLCBillingSchedule.reset;
        If JobQueue = false then begin
            If TenderTypeDiscount."Credit Memo No." = '' then
                Error('%1', 'Please create credit memo before insert into billing schedule');
        end else begin

            TenderTypeDiscount.SetFilter("Credit Memo No.", '<>%1', '');
            Message('%1', TenderTypeDiscount."Credit Memo No.");
        end;
        TenderTypeDiscount.SetFilter(status, '<>%1', TenderTypeDiscount.Status::Inserted);
        Message('%1', TenderTypeDiscount."Sales Invoice No.");
        if TenderTypeDiscount.FindFirst() then
            repeat
                Message('%1', TenderTypeDiscount."Sales Invoice No.");
                l_recLCBillingSchedule.setrange("Document No.", TenderTypeDiscount."Sales Invoice No.");
                l_recLCBillingSchedule.setrange(Type, l_recLCBillingSchedule.Type::Rent);
                If l_recLCBillingSchedule.FindFirst() then begin
                    InsertLCBillingSchedule(g_OptBillingType::Rent,
                                          'Tender Type Discount',
                                           l_recLCBillingSchedule."Customer No.",
                                           l_recLCBillingSchedule."Contract No.",
                                           GetLineNo(l_recLCBillingSchedule."Contract No."),
                                          l_recLCBillingSchedule."Posting Date",//#Posting Date
                                          l_recLCBillingSchedule."Due Date",//#Due Date
                                          0D,//#Item Sales Date
                                          '',
                                         0,
                                           0,
                                         TenderTypeDiscount."Tender Discount Amount",
                                          TenderTypeDiscount."Tender Discount Amount",
                                        TenderTypeDiscount.Id,
                                        TenderTypeDiscount."Credit Memo No.",
                                        TenderTypeDiscount."Tender Type",
                                        l_recLCBillingSchedule."No. of Days to Bill",
                                        l_recLCBillingSchedule."No. of Days Current Month",
                                        l_recLCBillingSchedule."Contract Start Date",
                                        l_recLCBillingSchedule."Contract End Date");
                    //Message('%1', l_recLCBillingSchedule."Contract No.");
                    TenderTypeDiscount."Status" := TenderTypeDiscount.Status::Inserted;
                    TenderTypeDiscount."Contract No." := l_recLCBillingSchedule."Contract No.";
                    TenderTypeDiscount."Customer No." := l_recLCBillingSchedule."Customer No.";
                    TenderTypeDiscount.Modify;
                end;
            until TenderTypeDiscount.Next() = 0;
    end;

    // << Insert Tender Type Discount

    procedure InsertLCBillingSchedule(BillingType: Option Deposit,Rent,Item; SubType: Code[100]; CustomerNo: Code[50]; ContractNo: Code[50]; LineNo: Integer; PostingDate: Date; DueDate: Date; AdditionalItemSalesDate: Date; SalesItemNo: Code[50]; SalesQuantity: Decimal; SalesUnitPrice: Decimal; TotalAmount: Decimal; TotalVATAmount: Decimal; PaymentReferenceID: Text[250]; CreditMemoNo: Code[20]; TenderType: Code[20]; billingdays: Integer; currentMonth: Integer; contractstartdate: Date; ContractEndDate: Date)
    var
        l_recLCBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recCreditMemo: Record "Sales Cr.Memo Header";
    begin

        l_recLCBillingSchedule.init;
        l_recLCBillingSchedule.Type := BillingType;
        l_recLCBillingSchedule."Line No." := LineNo;
        l_recLCBillingSchedule."Sub-Type" := SubType;
        l_recLCBillingSchedule."Customer No." := CustomerNo;
        l_recLCBillingSchedule."Contract No." := ContractNo;
        l_recLCBillingSchedule."Line No." := LineNo;
        l_recLCBillingSchedule."Posting Date" := PostingDate;
        l_recLCBillingSchedule."Due Date" := DueDate;
        l_recLCBillingSchedule."Additional Item Sales Date" := AdditionalItemSalesDate;
        l_recLCBillingSchedule."Additional Sales Item No." := SalesItemNo;
        l_recLCBillingSchedule."Additional Sales Item Quantity" := SalesQuantity;
        l_recLCBillingSchedule."Add. Sales Item Unit Price" := SalesUnitPrice;
        l_recLCBillingSchedule.Amount := TotalAmount;
        l_recLCBillingSchedule."Stripe Invoice ID" := PaymentReferenceID;
        // For Tender Type only >>
        If CreditMemoNo <> '' then begin
            l_recCreditMemo.Setrange("No.", CreditMemoNo);
            If l_recCreditMemo.FindFirst() then
                l_recLCBillingSchedule.Status := l_recLCBillingSchedule.Status::Posted
            else
                l_recLCBillingSchedule.Status := l_recLCBillingSchedule.Status::Created;
            l_recLCBillingSchedule."Document Type" := l_recLCBillingSchedule."Document Type"::"Credit Memo";
            l_recLCBillingSchedule."Document No." := CreditMemoNo;
            l_recLCBillingSchedule."Tender Type" := TenderType;
            l_recLCBillingSchedule."No. of Days to Bill" := billingdays;
            l_recLCBillingSchedule."No. of Days Current Month" := currentMonth;
            l_recLCBillingSchedule."Sales Invoice Creation Date" := CurrentDateTime;
            l_recLCBillingSchedule."Contract Start Date" := contractstartdate;
            l_recLCBillingSchedule."Contract End Date" := contractenddate;
        end;
        // For Tender Type only <<
        l_recLCBillingSchedule.insert;

    end;


    procedure GetLineNo(CurrentContractNo: Code[50]): Integer
    var
        l_recLCBillingSchedule: Record "Lease Contract Billing Sched.";
    begin

        l_recLCBillingSchedule.reset;
        l_recLCBillingSchedule.SetRange("Contract No.", CurrentContractNo);
        if l_recLCBillingSchedule.find('+') then
            exit(l_recLCBillingSchedule."Line No." + 10000)
        else
            exit(10000);
    end;



    procedure GetDueDate(ContractNo: Code[50]; PostingDate: Date): Date
    var
        l_recLCBillingSchedule: Record "Lease Contract Billing Sched.";
    begin
        l_recLCBillingSchedule.reset;
        l_recLCBillingSchedule.SetRange("Contract No.", ContractNo);
        l_recLCBillingSchedule.SetRange("Posting Date", PostingDate, 99991231D);
        l_recLCBillingSchedule.SetRange(Status, l_recLCBillingSchedule.Status::" ");
        l_recLCBillingSchedule.SetCurrentKey("Due Date");
        l_recLCBillingSchedule.SetAscending("Due Date", true);

        if l_recLCBillingSchedule.FindFirst() then
            exit(l_recLCBillingSchedule."Due Date")
        else
            exit(PostingDate);
    end;


    procedure GetPostingDate(ContractNo: Code[50]; Date: Date): Date
    var
        l_recLCBillingSchedule: Record "Lease Contract Billing Sched.";
    begin
        l_recLCBillingSchedule.reset;
        l_recLCBillingSchedule.SetRange("Contract No.", ContractNo);
        l_recLCBillingSchedule.SetCurrentKey("Posting Date");
        l_recLCBillingSchedule.SetAscending("Posting Date", true);
        l_recLCBillingSchedule.SetRange("Posting Date", Date, 99991231D);
        if l_recLCBillingSchedule.FindFirst() then begin
            if l_recLCBillingSchedule.Type = l_recLCBillingSchedule.Type::Deposit then
                exit(Date)
            else
                exit(l_recLCBillingSchedule."Posting Date")
        end
        else
            exit(Date)

    end;


    procedure GetLastRenetalPostingDate(ContractNo: Code[50]): Date
    var
        l_recLCBillingSchedule: Record "Lease Contract Billing Sched.";
    begin
        l_recLCBillingSchedule.Reset();
        l_recLCBillingSchedule.SetCurrentKey("Contract No.", "Posting Date");
        l_recLCBillingSchedule.Setrange("Contract No.", ContractNo);
        l_recLCBillingSchedule.SetAscending("Posting Date", true);
        if l_recLCBillingSchedule.FindLast() then
            exit(l_recLCBillingSchedule."Posting Date");

    end;

    procedure GetLastRenetalDueDate(ContractNo: Code[50]): Date
    var
        l_recLCBillingSchedule: Record "Lease Contract Billing Sched.";
    begin
        l_recLCBillingSchedule.Reset();
        l_recLCBillingSchedule.SetCurrentKey("Contract No.", "Posting Date");
        l_recLCBillingSchedule.Setrange("Contract No.", ContractNo);
        l_recLCBillingSchedule.SetAscending("Posting Date", true);
        if l_recLCBillingSchedule.FindLast() then
            exit(l_recLCBillingSchedule."Due Date");

    end;


    var
        g_OptBillingType: Option Deposit,Rent,Item;

}