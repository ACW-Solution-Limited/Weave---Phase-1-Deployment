codeunit 83140 "Addi.Item Sales to Bill. Sch."
{

    trigger OnRun()
    var
        AdditionalService: Record "Additional Service";
        ExtraCharge: Record "Extra Charge";
        AdditionalAmenities: Record "Additional Amenities";
        CarPark: Record "Car Park";
        Locker: Record Locker;
        TenderTypeDiscount: Record "Tender Type Discount";
    begin

        CreateAdditionalService(AdditionalService);
        CreateAdditionalAmenities(AdditionalAmenities);
        CreateExtraCharge(ExtraCharge);
        CreateCarPark(CarPark);
        CreateLocker(Locker);

        InsertTenderTypeDiscount(TenderTypeDiscount, true);
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
    var
        l_recLeaseContractSetup: Record "Lease Contract Setup";
    begin
        CRMAdditionalService.SetRange("CRM Status", CRMAdditionalService."CRM Status"::Confirmed);
        CRMAdditionalService.SetRange("BC Status", CRMAdditionalService."BC Status"::Open);
        if CRMAdditionalService.FindFirst() then
            repeat
                l_recLeaseContractSetup.Get();
                if l_recLeaseContractSetup."Subscription Item No." = CRMAdditionalService."Item No." then
                    CreateSubscriptionServiceToBillingSchdeule(CRMAdditionalService."Contract No.",
                    CRMAdditionalService."Total Amount Inclu. VAT",
                    DT2DATE(CRMAdditionalService."Service Start Date"),
                    DT2DATE(CRMAdditionalService."Service End Date"),
                    'Additional Service',
                    CRMAdditionalService."Key",
                    "Subscription Service Type"::"Additional Service",
                    DT2DATE(CRMAdditionalService."Created On"))//#Posting Date
                else
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
        CRMAdditionalAmenities.SetRange("CRM Status", CRMAdditionalAmenities."CRM Status"::Confirmed);
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
                                                                      CRMExtraCharge."Service Start Date",
                                                                      CRMExtraCharge."Service End Date");
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
                                           DT2DATE(CRMExtraCharge."New Contract Start Date"),
                                           DT2DATE(CRMExtraCharge."New Contract End Date"));
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
                                            CRMExtraCharge."Service Start Date",
                                            CRMExtraCharge."Service End Date");

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

    procedure CreateCarPark(CarPark: Record "Car Park")
    var

    begin
        CarPark.SetRange("Bill. Sche. Creation Datetime", 0DT);
        if CarPark.FindFirst() then
            repeat

                CreateSubscriptionServiceToBillingSchdeule(CarPark."Contract No.", CarPark."Monthy Rent", DT2Date(CarPark."Start Date"), DT2Date(CarPark."End Date"),
                'CarPark ' + CarPark."Car Park Property No.", CarPark."Car Park ID", "Subscription Service Type"::"Car Park", DT2Date(CarPark."Created On"));
                CarPark."Bill. Sche. Creation Datetime" := CurrentDateTime;
                CarPark."Created to Billing Schedule" := true;
                CarPark.Modify();
            until CarPark.Next() = 0;

    end;

    procedure CreateLocker(Locker: Record Locker)
    var
    begin

        Locker.SetRange("Bill. Sche. Creation Datetime", 0DT);
        if Locker.FindFirst() then
            repeat
                if Locker."Bill. Sche. Creation Datetime" <> 0DT then
                    exit;

                CreateSubscriptionServiceToBillingSchdeule(Locker."Contract No.", Locker."Monthy Rent", DT2Date(Locker."Start Date"), DT2Date(Locker."End Date"),
                'Locker ' + Locker."Locker Property No.", Locker."Locker ID", "Subscription Service Type"::Locker, DT2Date(Locker."Created On"));
                Locker."Bill. Sche. Creation Datetime" := CurrentDateTime;
                Locker."Created to Billing Schedule" := true;
                Locker.Modify();
            until Locker.Next() = 0;

    end;




    procedure CreateSubscriptionServiceToBillingSchdeule(ContractNo: Code[250]; MonthlyRent: Decimal; ServiceStartDate: Date; ServiceEndDate: Date; Type: Text;
    SubscriptionReferenceID: Code[250]; SubscriptionServiceType: Enum "Subscription Service Type"; CreatedOn: Date)
    var
        l_dateCalculationStart: Date;
        l_recBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recPropertyUnit: Record "Property Unit";
        l_decServiceAmount: Decimal;
        l_dateServiceStartDate: Date;
        l_dateServiceEndDate: Date;
        l_intServiceDays: Integer;
        l_decSubscriptionAmount: Decimal;
    begin

        if (ServiceStartDate = 0D) or (ServiceEndDate = 0D) then
            exit;

        l_decServiceAmount := 0;
        l_dateCalculationStart := ServiceStartDate;
        l_decSubscriptionAmount := MonthlyRent;

        repeat
            l_recBillingSchedule.Reset();
            l_recBillingSchedule.SetCurrentKey("Contract Start Date");
            l_recBillingSchedule.SetAscending("Contract Start Date", true);
            l_recBillingSchedule.SetRange(l_recBillingSchedule.Type, l_recBillingSchedule.Type::Rent);
            l_recBillingSchedule.SetRange(l_recBillingSchedule."Sub-Type", '');
            l_recBillingSchedule.SetFilter(l_recBillingSchedule."Contract No.", ContractNo);
            l_recBillingSchedule.SetFilter("Contract Start Date", '..%1', l_dateCalculationStart);
            l_recBillingSchedule.SetFilter("Contract End Date", '>=%1', l_dateCalculationStart);

            if l_recBillingSchedule.Count = 0 then
                exit;

            if l_recBillingSchedule.FindLast() then begin

                if ServiceEndDate > l_recBillingSchedule."Contract End Date" then begin
                    l_decServiceAmount := l_decSubscriptionAmount / l_recBillingSchedule."No. of Days Current Month" *
                                     (l_recBillingSchedule."Contract End Date" - l_dateCalculationStart + 1);

                    l_dateServiceStartDate := l_dateCalculationStart; // Contract Start Date
                    l_dateServiceEndDate := l_recBillingSchedule."Contract End Date";// Contract End Date
                    l_intServiceDays := (l_recBillingSchedule."Contract End Date" - l_dateCalculationStart + 1);
                    l_dateCalculationStart := l_recBillingSchedule."Contract End Date" + 1;
                end else begin
                    l_decServiceAmount := l_decSubscriptionAmount / l_recBillingSchedule."No. of Days Current Month" *
                                                         (ServiceEndDate - l_dateCalculationStart + 1);

                    l_dateServiceStartDate := l_dateCalculationStart; // Contract Start Date
                    l_dateServiceEndDate := ServiceEndDate;// Contract End Date
                    l_intServiceDays := (ServiceEndDate - l_dateCalculationStart + 1);
                    l_dateCalculationStart := ServiceEndDate + 1;
                end;
                InsertSubscriptionBillingSchdeuleLine(l_recBillingSchedule, Type, l_decServiceAmount, SubscriptionReferenceID, SubscriptionServiceType, l_intServiceDays, l_dateServiceStartDate, l_dateServiceEndDate, CreatedOn);
            end;

        until l_dateCalculationStart >= ServiceEndDate;
        exit;
    end;

    procedure InsertSubscriptionBillingSchdeuleLine(RentalBillingScheduleLine: Record "Lease Contract Billing Sched."; SubType: Text[250]; ServiceAmount: Decimal; SubscriptionReferenceID: Code[250]; SubscriptionServiceType: Enum "Subscription Service Type"; NoOfDaysToBill: Integer; ContractStartDate: Date; ContractEndDate: Date; CreatedOn: Date)
    var
        l_recSubscriptionServiceBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recLeaseContractHeader: Record "Lease Contract Header";
    begin
        l_recLeaseContractHeader.Get(RentalBillingScheduleLine."Contract No.");
        l_recSubscriptionServiceBillingSchedule.Init();
        l_recSubscriptionServiceBillingSchedule.TransferFields(RentalBillingScheduleLine);
        l_recSubscriptionServiceBillingSchedule."Line No." := l_recSubscriptionServiceBillingSchedule.GetNextLineNo(l_recSubscriptionServiceBillingSchedule."Contract No.");
        l_recSubscriptionServiceBillingSchedule."Contract Start Date" := ContractStartDate;
        l_recSubscriptionServiceBillingSchedule."Contract End Date" := ContractEndDate;
        l_recSubscriptionServiceBillingSchedule.Amount := ServiceAmount;
        l_recSubscriptionServiceBillingSchedule."Sub-Type" := SubType;
        l_recSubscriptionServiceBillingSchedule."Subscription Service Type" := SubscriptionServiceType;
        l_recSubscriptionServiceBillingSchedule."Subscription Reference ID" := SubscriptionReferenceID;
        l_recSubscriptionServiceBillingSchedule."No. of Days to Bill" := NoOfDaysToBill;



        if l_recSubscriptionServiceBillingSchedule."Document No." <> '' then begin
            l_recSubscriptionServiceBillingSchedule."Posting Date" := GetPostingDate(l_recSubscriptionServiceBillingSchedule."Contract No.", CreatedOn);
            l_recSubscriptionServiceBillingSchedule."Due Date" := GetDueDate(l_recSubscriptionServiceBillingSchedule."Contract No.", CreatedOn);
            l_recSubscriptionServiceBillingSchedule."Document No." := '';
            l_recSubscriptionServiceBillingSchedule.Status := l_recSubscriptionServiceBillingSchedule.Status::" ";
            l_recSubscriptionServiceBillingSchedule."Stripe Invoice ID" := '';
            l_recSubscriptionServiceBillingSchedule."Sales Invoice Creation Date" := 0DT;
        end;

        if (l_recLeaseContractHeader."Payment Type" = l_recLeaseContractHeader."Payment Type"::"Pre-paid") then begin            // Update Posting Date + Due Date if Pre-paid case
            l_recSubscriptionServiceBillingSchedule."Due Date" := CalcDate('-1D', l_recSubscriptionServiceBillingSchedule."Contract Start Date");
            l_recSubscriptionServiceBillingSchedule."Posting Date" := CalcDate('-7D', l_recSubscriptionServiceBillingSchedule."Due Date");

        end;



        l_recSubscriptionServiceBillingSchedule.Insert();
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
            // Message('%1', TenderTypeDiscount."Credit Memo No.");
        end;
        TenderTypeDiscount.SetFilter(status, '<>%1', TenderTypeDiscount.Status::Inserted);
        //  Message('%1', TenderTypeDiscount."Sales Invoice No.");
        if TenderTypeDiscount.FindFirst() then
            repeat
                // Message('%1', TenderTypeDiscount."Sales Invoice No.");
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
        l_recLCBillingSchedule."Contract Start Date" := contractstartdate;
        l_recLCBillingSchedule."Contract End Date" := contractenddate;
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
        l_recLCBillingSchedule.SetRange(Type, l_recLCBillingSchedule.Type::Rent);
        l_recLCBillingSchedule.SetCurrentKey("Posting Date");
        l_recLCBillingSchedule.SetAscending("Posting Date", true);

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
        end else
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