report 83000 "Lease Contract Create Invoices"
{
    ApplicationArea = All;
    Caption = 'Lease Contract Create Sales Invoices';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    dataset
    {
        dataitem(LeaseContractHeader; "Lease Contract Header")
        {
            DataItemTableView = sorting("No.") where(Status = filter(ConfirmedWithRoomAllocated | Active | "ReadyForCheck-in"));
            RequestFilterFields = "No.", "Customer No.";
            trigger OnAfterGetRecord()
            var
                l_recBillingSchedule: Record "Lease Contract Billing Sched.";
                l_contractdate: Date;
            begin

                l_recBillingSchedule.reset;
                l_recBillingSchedule.SetRange("Contract No.", LeaseContractHeader."No.");
                l_recBillingSchedule.SetRange(Status, l_recBillingSchedule.Status::" ");
                l_recBillingSchedule.SetRange("Posting Date", 0D, g_datAsOfDate);
                //CurrReport.Skip();             
                InitBillingScheduleTempTable(l_recBillingSchedule);
                //Get Property Unit Value >>
                //l_contractdate := g_datAsOfDate + 8;
                l_contractdate := g_recLeaseBillingSchedule_Temp."Contract Start Date";

                if l_contractdate = 0D then
                    l_contractdate := g_datAsOfDate + 8;

                g_property_type := GetPropertyUnitInformation(LeaseContractHeader."No.", l_contractdate, 'RoomTypeName');
                g_property_rmno := GetPropertyUnitInformation(LeaseContractHeader."No.", l_contractdate, 'RoomUnit');
                g_property_description := GetPropertyUnitInformation(LeaseContractHeader."No.", l_contractdate, 'Description');
                //Get Property Unit Value <<
                // LeaseContractHeader.CalcFields("Customer No.");
                g_CustomerName := GetCustomerName("Customer No.");

                //  Define commission >>
                // If g_commissionamount = 0 then
                //     InsertCommission(LeaseContractHeader, l_contractdate);
                //  Define commission <<
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
                    field("As of Date"; g_datAsOfDate)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        trigger OnInit()
        begin
            if g_datAsOfDate = 0D then
                g_datAsOfDate := workdate;
        end;
    }

    trigger OnPostReport()
    var

        l_codCustomerNo: code[20];
        l_textPaymentReferenceID: Text[250];
        l_recSalesHeaderTemp: Record "Sales Header" temporary;
        l_recSalesLineTemp: Record "Sales Line" temporary;
        l_recSalesHeader: Record "Sales Header";
        l_recSalesLine: Record "Sales Line";
        l_intLineNo: Integer;
        l_codDocNo: Code[20];
        l_recTenderTypeSetup: Record "Tender Type Setup";
        l_decAmt: Decimal;
        l_recLeaseContractSetup: Record "Lease Contract Setup";
        l_recItem: Record Item;

    begin
        l_recLeaseContractSetup.Get();
        l_recSalesHeaderTemp.DeleteAll();
        l_recSalesLineTemp.DeleteAll();
        l_codDocNo := 'INV-0000001';
        l_textPaymentReferenceID := 'ANYTHING';
        g_recLeaseBillingSchedule_Temp.reset;
        g_recLeaseBillingSchedule_Temp.SetCurrentKey("Customer No.", "Posting Date", "Contract No.", "Line No.");

        If g_recLeaseBillingSchedule_Temp.FindSet() then
            repeat

                //Message('%1', g_recLeaseBillingSchedule_Temp."Customer No.");
                if (l_codCustomerNo <> g_recLeaseBillingSchedule_Temp."Customer No.") or (l_textPaymentReferenceID <> g_recLeaseBillingSchedule_Temp."Stripe/QFPay Invoice ID") then begin
                    l_codCustomerNo := g_recLeaseBillingSchedule_Temp."Customer No.";
                    //Message('Customer No: %1', g_recLeaseBillingSchedule_Temp."Customer No.");
                    //    if (l_textPaymentReferenceID <> g_recLeaseBillingSchedule_Temp."Stripe/QFPay Invoice ID") then begin

                    l_textPaymentReferenceID := g_recLeaseBillingSchedule_Temp."Stripe/QFPay Invoice ID";
                    l_recSalesHeaderTemp.init;
                    l_recSalesHeaderTemp."Document Type" := l_recSalesHeaderTemp."Document Type"::Invoice;
                    l_recSalesHeaderTemp."No." := l_codDocNo;
                    l_codDocNo := incstr(l_codDocNo);
                    l_recSalesHeaderTemp.insert(true);
                    l_recSalesHeaderTemp."Stripe/QFPay Invoice ID" := g_recLeaseBillingSchedule_Temp."Stripe/QFPay Invoice ID";
                    l_recSalesHeaderTemp.Validate("Sell-to Customer No.", l_codCustomerNo);
                    l_recSalesHeaderTemp.Validate("Posting Date", g_recLeaseBillingSchedule_Temp."Posting Date");
                    l_recSalesHeaderTemp."Lease Contract No." := LeaseContractHeader."No.";
                    l_recSalesHeaderTemp."Lease Contract Name" := LeaseContractHeader."Contract Name";
                    l_recSalesHeaderTemp."Lease Contract Creation Date" := WorkDate();
                    l_recSalesHeaderTemp."Contract Start Date" := DT2Date(LeaseContractHeader."Contract Start Date");
                    l_recSalesHeaderTemp."Contract End Date" := DT2Date(LeaseContractHeader."Contract End Date");
                    // Commission  >>
                    If l_recSalesHeaderTemp."Commission Amount" = 0 then begin
                        InsertCommission(LeaseContractHeader, g_recLeaseBillingSchedule_Temp."Contract Start Date");
                        l_recSalesHeaderTemp."Salesperson Code" := g_Salesperson;
                        l_recSalesHeaderTemp."Commission Type" := g_Commissiontype;
                        l_recSalesHeaderTemp."Calculation Type" := g_calculationtype;
                        l_recSalesHeaderTemp."Commission Amount" := g_commissionamount;
                    end;
                    // Comimssion  <<
                    If g_recLeaseBillingSchedule_Temp."Due Date" <> 0D THEN
                        l_recSalesHeaderTemp.Validate("Due Date", g_recLeaseBillingSchedule_Temp."Due Date");
                    if l_recSalesHeaderTemp.Modify() then;
                    l_intLineNo := 10000;
                    //Message('Sales Header %1', l_recSalesHeaderTemp."No.");
                end;

                l_recSalesLineTemp.Init();
                l_recSalesLineTemp."Document Type" := l_recSalesHeaderTemp."Document Type";
                l_recSalesLineTemp."Document No." := l_recSalesHeaderTemp."No.";
                l_recSalesLineTemp."Line No." := l_intLineNo;
                l_recSalesLineTemp."Contract No." := g_recLeaseBillingSchedule_Temp."Contract No.";
                l_recSalesLineTemp."Billing Schedule Line No." := g_recLeaseBillingSchedule_Temp."Line No.";
                if (g_recLeaseBillingSchedule_Temp."Contract Start Date" = 0D) or (g_recLeaseBillingSchedule_Temp."Contract End Date" = 0D) then begin // for credit memo
                    If g_recLeaseBillingSchedule_Temp."Sub-Type" <> 'EXTENSION' then begin
                        l_recSalesLineTemp."Lease From Date" := DT2Date(LeaseContractHeader."Contract Start Date");
                        l_recSalesLineTemp."Lease To Date" := DT2Date(LeaseContractHeader."Contract End Date");
                    end;
                end
                else begin
                    l_recSalesLineTemp."Lease From Date" := g_recLeaseBillingSchedule_Temp."Contract Start Date";
                    l_recSalesLineTemp."Lease To Date" := g_recLeaseBillingSchedule_Temp."Contract End Date";
                end;

                l_recSalesLineTemp."Additional Item Sales Date" := g_recLeaseBillingSchedule_Temp."Additional Item Sales Date";
                l_recSalesLineTemp."Additional Sales Item No." := g_recLeaseBillingSchedule_Temp."Additional Sales Item No.";

                l_intLineNo += 10000;
                if l_recSalesLineTemp.insert() then;
                l_recSalesLineTemp.Type := l_recSalesLineTemp.type::"G/L Account";
                //Message('Sales Line %1', l_recSalesLineTemp."Document No.");
                case g_recLeaseBillingSchedule_Temp.Type of
                    g_recLeaseBillingSchedule_Temp.Type::Deposit:
                        begin
                            l_recSalesLineTemp."Billing Schedule Type" := l_recSalesLineTemp."Billing Schedule Type"::Deposit;
                            l_recSalesLineTemp."No." := l_recLeaseContractSetup."Rental Deposit G/L Account No.";
                            If g_recLeaseBillingSchedule_Temp."Sub-Type" = '' then begin
                                l_recSalesLineTemp."Invoice Description" := StrSubstNo('%1 in %2 - (%3) (%4)',
                                // g_recLeaseBillingSchedule_Temp.Type,
                                g_property_type,
                                g_property_description,
                                g_property_rmno,
                                g_recLeaseBillingSchedule_Temp."Contract No.");
                                l_recSalesLineTemp.Quantity := 1;
                                l_recSalesLineTemp."Unit Price" := g_recLeaseBillingSchedule_Temp.Amount;

                            end else begin
                                l_recSalesLineTemp.type := l_recSalesLineTemp.type::Item;
                                l_recSalesLineTemp."No." := g_recLeaseBillingSchedule_Temp."Additional Sales Item No.";
                                If l_recItem.get(g_recLeaseBillingSchedule_Temp."Additional Sales Item No.") then;
                                l_recSalesLineTemp."Invoice Description" := StrSubstNo('%1 - %2 - %3', g_recLeaseBillingSchedule_Temp."Additional Item Sales Date", 'Extra Charges', l_recItem.Description);
                                if l_recItem.Type <> l_recItem.type::Service then begin
                                    l_recLeaseContractSetup.TestField("Item Sales Location");
                                    l_recSalesLineTemp."Location Code" := l_recLeaseContractSetup."Item Sales Location";
                                end;
                                l_recSalesLineTemp.Quantity := g_recLeaseBillingSchedule_Temp."Additional Sales Item Quantity";
                                l_recSalesLineTemp."Unit Price" := g_recLeaseBillingSchedule_Temp."Add. Sales Item Unit Price";

                            end;

                        end;
                    g_recLeaseBillingSchedule_Temp.type::Rent:
                        begin
                            If g_recLeaseBillingSchedule_Temp."Sub-Type" = '' then begin
                                l_recSalesLineTemp."Billing Schedule Type" := l_recSalesLineTemp."Billing Schedule Type"::Rent;
                                // l_recSalesLineTemp."No." := l_recLeaseContractSetup."Rental Income G/L Account No.";
                                l_recSalesLineTemp."No." := GetGLAccountByRoomType(LeaseContractHeader."Room Type");
                                l_recSalesLineTemp."No. of Days to Bill" := g_recLeaseBillingSchedule_Temp."No. of Days to Bill";
                                /* l_recSalesLineTemp."Invoice Description" := StrSubstNo('%1 - (#%2) - %3 - %4 in %5 - %6 from %7 to %8 (%9)',
                                                            g_CustomerName,
                                                            LeaseContractHeader."Customer No.",
                                                            g_recLeaseBillingSchedule_Temp.Type,
                                                            g_property_type,
                                                            g_property_description,
                                                            g_property_rmno,
                                                            format(g_recLeaseBillingSchedule_Temp."Contract Start Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                                            format(g_recLeaseBillingSchedule_Temp."Contract End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                                            g_recLeaseBillingSchedule_Temp."Contract No.");*/
                                l_recSalesLineTemp."Invoice Description" := StrSubstNo('%1 in %2 - (%3) (%4)',
                                //g_recLeaseBillingSchedule_Temp.Type,
                                g_property_type,
                                g_property_description,
                                g_property_rmno,
                                g_recLeaseBillingSchedule_Temp."Contract No.");
                                l_recSalesLineTemp.Quantity := 1;
                                l_recSalesLineTemp."Unit Price" := g_recLeaseBillingSchedule_Temp.Amount;

                            end else begin
                                l_recSalesLineTemp."Billing Schedule Type" := l_recSalesLineTemp."Billing Schedule Type"::Rent;
                                case g_recLeaseBillingSchedule_Temp."Sub-Type" of
                                    'Monthly Discount':
                                        begin
                                            l_recSalesLineTemp."No. of Days to Bill" := g_recLeaseBillingSchedule_Temp."No. of Days to Bill";
                                            l_recSalesLineTemp."No." := l_recLeaseContractSetup."Monthly Disc G/L Account No.";
                                            // l_recSalesLineTemp."Invoice Description" := StrSubstNo('Discount (%1) for %2 -(#%3) - %4 - %5 in %6 - %7 from %8 to %9 (%10)',
                                            //                      LeaseContractHeader."Promotion Code",
                                            //                      g_CustomerName,
                                            //                      LeaseContractHeader."Customer No.",
                                            //                      g_recLeaseBillingSchedule_Temp.Type,
                                            //                      g_property_type,
                                            //                      g_property_description,
                                            //                      g_property_rmno,
                                            //                      format(g_recLeaseBillingSchedule_Temp."Contract Start Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                            //                      format(g_recLeaseBillingSchedule_Temp."Contract End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                            //                      g_recLeaseBillingSchedule_Temp."Contract No.");
                                            l_recSalesLineTemp."Invoice Description" := StrSubstNo('Discount (%1) - %2 in %3 - %4 (%5)',
                                            LeaseContractHeader."Promotion Code",
                                             g_property_type,
                                            g_property_description,
                                            g_property_rmno,
                                             g_recLeaseBillingSchedule_Temp."Contract No.");
                                        end;
                                    'One-off Discount':
                                        begin
                                            l_recSalesLineTemp."No. of Days to Bill" := g_recLeaseBillingSchedule_Temp."No. of Days to Bill";
                                            l_recSalesLineTemp."No." := l_recLeaseContractSetup."One-Off Disc G/L Account No.";
                                            // l_recSalesLineTemp."Invoice Description" := StrSubstNo('Discount (%1) for %2 -(#%3) - %4 - %5 in %6 - %7 from %8 to %9 (%10)',
                                            //                        LeaseContractHeader."Promotion Code",
                                            //                        g_CustomerName,
                                            //                        LeaseContractHeader."Customer No.",
                                            //                        g_recLeaseBillingSchedule_Temp.Type,
                                            //                        g_property_type,
                                            //                        g_property_description,
                                            //                        g_property_rmno,
                                            //                        format(g_recLeaseBillingSchedule_Temp."Contract Start Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                            //                        format(g_recLeaseBillingSchedule_Temp."Contract End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                            //                        g_recLeaseBillingSchedule_Temp."Contract No.");
                                            l_recSalesLineTemp."Invoice Description" := StrSubstNo('Discount (%1) - %2 in %3 - %4 (%5)',
                                            LeaseContractHeader."Promotion Code",
                                            g_property_type,
                                            g_property_description,
                                            g_property_rmno,
                                            g_recLeaseBillingSchedule_Temp."Contract No.");
                                        end;
                                    'Prepaid Discount':
                                        begin
                                            l_recSalesLineTemp."No. of Days to Bill" := g_recLeaseBillingSchedule_Temp."No. of Days to Bill";
                                            l_recSalesLineTemp."No." := l_recLeaseContractSetup."Prepaid Disc G/L Account No.";
                                            l_recSalesLineTemp."Invoice Description" := StrSubstNo('Prepaid Discount - %1 in %2 (%3) (%4)',
                                            g_property_type,
                                            g_property_description,
                                            g_property_rmno,
                                            g_recLeaseBillingSchedule_Temp."Contract No.");
                                        end;
                                    // >> Tender Type 
                                    'Tender Type Discount':
                                        begin

                                            l_recTenderTypeSetup.SetRange("Tender Type", g_recLeaseBillingSchedule_Temp."Tender Type");
                                            If l_recTenderTypeSetup.FindFirst() then begin
                                                l_recSalesLineTemp."No." := l_recTenderTypeSetup."G/L Account";
                                                l_recSalesLineTemp."Invoice Description" := l_recTenderTypeSetup."Invoice Description";
                                                l_recSalesLineTemp."Tender Type" := l_recTenderTypeSetup."Tender Type";
                                            end;
                                        end;

                                    // Tender Type  <<  
                                    // Extension >>
                                    'Extension':
                                        begin
                                            l_recSalesLineTemp."Billing Schedule Type" := l_recSalesLineTemp."Billing Schedule Type"::Rent;
                                            // l_recSalesLineTemp."No." := l_recLeaseContractSetup."Rental Income G/L Account No.";
                                            l_recSalesLineTemp."No." := GetGLAccountByRoomType(LeaseContractHeader."Room Type");
                                            l_recSalesLineTemp."No. of Days to Bill" := g_recLeaseBillingSchedule_Temp."No. of Days to Bill";
                                            l_recSalesLineTemp."Invoice Description" := StrSubstNo('%1 - %2 in %3 - (%4)',
                                                                          'Extension Fee',
                                                                          g_property_type,
                                                                          g_property_description,
                                                                          g_property_rmno
                                                                          );
                                            l_recSalesLineTemp.Quantity := 1;
                                            l_recSalesLineTemp."Unit Price" := g_recLeaseBillingSchedule_Temp.Amount;


                                        end;
                                // Extension <<
                                end;
                                l_recSalesLineTemp.Quantity := 1;
                                l_recSalesLineTemp."Unit Price" := g_recLeaseBillingSchedule_Temp.Amount;


                            end;

                        end;
                    g_recLeaseBillingSchedule_Temp.type::Item:
                        begin
                            l_recSalesLineTemp."Billing Schedule Type" := l_recSalesLineTemp."Billing Schedule Type"::Item;
                            l_recSalesLineTemp.type := l_recSalesLineTemp.type::Item;
                            l_recSalesLineTemp."No." := g_recLeaseBillingSchedule_Temp."Additional Sales Item No.";
                            If l_recItem.get(g_recLeaseBillingSchedule_Temp."Additional Sales Item No.") then;

                            case g_recLeaseBillingSchedule_Temp."Sub-Type" of
                                'EXTRA CHARGE':
                                    l_recSalesLineTemp."Invoice Description" := StrSubstNo('%1: Extra Charge - %2 ', g_recLeaseBillingSchedule_Temp."Additional Sales Item No.", l_recItem.Description);
                                'EVENT FEE':
                                    begin
                                        l_recLeaseContractSetup.TestField("Event Fee G/L Account No.");
                                        l_recSalesLineTemp.Type := l_recSalesLineTemp.Type::"G/L Account";
                                        l_recSalesLineTemp."No." := l_recLeaseContractSetup."Event Fee G/L Account No.";
                                        l_recSalesLineTemp."Invoice Description" := StrSubstNo('Event Fee - %1 - in %2 (%3)',
                                        GetEventFeeNo(LeaseContractHeader."No.", g_recLeaseBillingSchedule_Temp."Line No."),
                                        LeaseContractHeader."Property No.",
                                        g_recLeaseBillingSchedule_Temp."Contract No."
                                        );

                                        l_recSalesLineTemp.Quantity := 1;
                                    end;
                                else
                                    l_recSalesLineTemp."Invoice Description" := StrSubstNo('%1', l_recItem.Description);
                            end;


                            // l_recSalesLineTemp."Invoice Description" := StrSubstNo('%1: %2', Format(l_recSalesLineTemp."Additional Item Sales Date"), l_recItem.Description);
                            if l_recItem.Type <> l_recItem.type::Service then begin
                                l_recLeaseContractSetup.TestField("Item Sales Location");
                                l_recSalesLineTemp."Location Code" := l_recLeaseContractSetup."Item Sales Location";
                            end;

                            l_recSalesLineTemp.Quantity := g_recLeaseBillingSchedule_Temp."Additional Sales Item Quantity";
                            l_recSalesLineTemp."Unit Price" := g_recLeaseBillingSchedule_Temp."Add. Sales Item Unit Price";
                            l_recSalesLineTemp.Amount := g_recLeaseBillingSchedule_Temp.Amount;
                            //Message('Item No %1', l_recItem."No.");
                        end;
                end;
                if l_recSalesLineTemp.Modify() then;
            until g_recLeaseBillingSchedule_Temp.next = 0;




        // Message('%1', l_recSalesHeaderTemp.Count);
        l_recSalesHeaderTemp.reset;
        if l_recSalesHeaderTemp.findset then
            repeat

                l_decAmt := 0;
                l_recSalesLineTemp.reset;
                l_recSalesLineTemp.SetRange("Document No.", l_recSalesHeaderTemp."No.");
                if l_recSalesLineTemp.findset then
                    repeat
                        l_decAmt += l_recSalesLineTemp."Unit Price";
                    until l_recSalesLineTemp.next = 0;

                if l_decAmt >= 0 then begin
                    l_recSalesHeader.init;
                    CreateSalesHeader(l_recSalesHeader, l_recSalesHeaderTemp, l_recSalesHeaderTemp."Document Type");


                    l_recSalesLineTemp.reset;
                    l_recSalesLineTemp.SetRange("Document No.", l_recSalesHeaderTemp."No.");
                    if l_recSalesLineTemp.findset then
                        repeat
                            l_recSalesLine.init;
                            InitSalesLine(l_recSalesLine, l_recSalesLineTemp, l_recSalesHeader);


                            if (l_recSalesLine.type = l_recSalesLine.type::item) then
                                InsertAssemblyOrder(l_recSalesHeader, l_recSalesLine);

                            if l_recSalesLine."Billing Schedule Type" = l_recSalesLine."Billing Schedule Type"::Rent then
                                InsertDeferral(l_recSalesLine, l_recSalesHeader);

                            l_recSalesLine.Modify(True);

                            ModifyBillingScheduleDocumentTypeNo(l_recSalesLine."Contract No.", l_recSalesLine."Billing Schedule Line No.", g_optBillingScheudleDocumentType::Invoice, l_recSalesHeader."No.");

                        until l_recSalesLineTemp.next = 0;

                end else begin
                    l_recSalesHeader.init;
                    CreateSalesHeader(l_recSalesHeader, l_recSalesHeaderTemp, l_recSalesHeader."Document Type"::"Credit Memo");
                    l_recSalesLineTemp.reset;
                    l_recSalesLineTemp.SetRange("Document No.", l_recSalesHeaderTemp."No.");
                    if l_recSalesLineTemp.findset then
                        repeat
                            l_recSalesLine.init;
                            InitSalesLine(l_recSalesLine, l_recSalesLineTemp, l_recSalesHeader);


                            if l_recSalesLine."Billing Schedule Type" = l_recSalesLine."Billing Schedule Type"::Rent then
                                InsertDeferral(l_recSalesLine, l_recSalesHeader);
                            // Tender Type >>
                            // If l_recSalesLineTemp."Tender Type" <> '' then
                            //  ApplyEntriesforTenderType(LeaseContractHeader, l_recSalesHeader."No.", l_recSalesLineTemp."Tender Type", l_recSalesLineTemp."Unit Price");

                            // Tender Type <<
                            l_recSalesLine.Modify(True);
                            ModifyBillingScheduleDocumentTypeNo(l_recSalesLine."Contract No.", l_recSalesLine."Billing Schedule Line No.", g_optBillingScheudleDocumentType::"Credit Memo", l_recSalesHeader."No.");

                        until l_recSalesLineTemp.next = 0;
                end;
            until l_recSalesHeaderTemp.next = 0;
    end;


    trigger OnInitReport()
    begin

        g_recLeaseBillingSchedule_Temp.DeleteAll();
        Clear(g_property_type);
        Clear(g_property_rmno);
        Clear(g_property_description);
        Clear(g_calculationtype);
        Clear(g_commissionamount);
        Clear(g_Salesperson);
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
        l_recDeferralLineChecking: Record "Deferral Line";
    begin

        l_recDeferralLineChecking.Reset();
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
        end;
    end;


    procedure GetPropertyUnitInformation(PropertyBookID: Code[50]; ContractDate: Date; Type: Text[250]): Text
    var
        l_recLeaseContractLine: Record "Lease Contract Line";
        l_recPropertyUnit: Record "Property Unit";
    begin


        l_recLeaseContractLine.Reset();
        l_recLeaseContractLine.SetFilter("Lease From Date", '<=%1', ContractDate);
        // l_recLeaseContractLine.SetRange("Contract No.", LeaseContractHeader."No.");
        l_recLeaseContractLine.SetRange(Key2, LeaseContractHeader."Key");

        if (l_recLeaseContractLine.FindLast()) and (l_recLeaseContractLine.Count > 0) then begin

            l_recPropertyUnit.SetRange("No.", l_recLeaseContractLine."Property Unit No.");
            If l_recPropertyUnit.FindLast() then begin
                case Type of
                    'RoomTypeName':
                        exit(l_recPropertyUnit."Room Type Name");//To be updated , delete comment after revised
                    'RoomUnit':
                        exit(l_recPropertyUnit."No.");//To be updated , delete comment after revised
                    'Description':
                        exit(l_recPropertyUnit."Property Unit Name");
                end;
            end
        end;
        exit('');

    end;



    procedure GetCustomerName(CustomerNo: Code[30]): Text
    var
        l_recCustomer: Record Customer;
    begin
        If l_recCustomer.Get(CustomerNo) then
            exit(l_recCustomer.name)
        else
            exit('')

    End;


    procedure GetEventFeeNo(ContactNo: Code[100]; BillingScheduleLineNo: Integer): Code[100]
    var
        l_recEventFee: Record "Event Fee";
    begin

        l_recEventFee.Reset();
        l_recEventFee.SetFilter("Contract No.", ContactNo);
        l_recEventFee.SetRange("Billing Schedule Line No.", BillingScheduleLineNo);
        if l_recEventFee.FindFirst() then
            exit(l_recEventFee."Event")
        else
            exit('');

    End;

    procedure InitBillingScheduleTempTable(var BillingSchedule: Record "Lease Contract Billing Sched.")
    begin
        if BillingSchedule.findset then
            repeat
                g_recLeaseBillingSchedule_Temp := BillingSchedule;
                g_recLeaseBillingSchedule_Temp.insert;
            //   Message('Contract No %1', g_recLeaseBillingSchedule_Temp."Contract No.");
            until BillingSchedule.next = 0;
    end;

    procedure ModifyBillingScheduleDocumentTypeNo(ContractNo: Code[100]; ContractLineNo: Integer; DocumentType: Option Invoice,"Credit Memo"; DocumentNo: Code[100])
    var
        l_recLeaseBillingSchedule: Record "Lease Contract Billing Sched.";
    begin

        if l_recLeaseBillingSchedule.Get(ContractNo, ContractLineNo) then begin
            l_recLeaseBillingSchedule.Status := l_recLeaseBillingSchedule.Status::Created;
            l_recLeaseBillingSchedule."Document Type" := DocumentType;
            l_recLeaseBillingSchedule."Document No." := DocumentNo;
            l_recLeaseBillingSchedule."Sales Invoice Creation Date" := CurrentDateTime;
            if l_recLeaseBillingSchedule.Modify() then;
        end;


    end;


    procedure CreateSalesHeader(var SalesHeader: record "Sales Header"; var SalesHeaderTemp: Record "Sales Header" temporary; DocumentType: Enum "Sales Document Type")
    var
        l_recSalesHeader: Record "Sales Header";
    begin
        SalesHeader := SalesHeaderTemp;
        SalesHeader."Document Type" := DocumentType;
        If SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
            SalesHeader."Contract Termination Date" := DT2Date(LeaseContractHeader."Contract Termination Date");
        SalesHeader."No." := '';
        SalesHeader.insert(true);


    end;

    procedure InitSalesLine(var SalesLine: record "Sales Line"; var SalesLineTemp: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        SalesLine := SalesLineTemp;
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine.insert(true);
        SalesLine.validate(type, SalesLineTemp.type);
        SalesLine.validate("No.", SalesLineTemp."No.");
        SalesLine.Validate("Location Code", SalesLineTemp."Location Code");
        SalesLine.validate(Quantity, SalesLineTemp.Quantity);
        // Check Document Type if it is credit memo deposit also return positive amount >>
        If (SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo") And (SalesLineTemp."Billing Schedule Type" = SalesLineTemp."Billing Schedule Type"::Deposit) AND (SalesLineTemp.type = SalesLineTemp.type::"G/L Account") then begin
            SalesLineTemp."Invoice Description" := StrSubstNo('%1', 'Rental Deposit');
            SalesLineTemp.Description := StrSubstNo('%1', 'Rental Deposit');
            /*   SalesLine.validate("Unit Price", -SalesLineTemp."Unit Price");
             end else begin
                 SalesLine.validate("Unit Price", SalesLineTemp."Unit Price");
             end;
             // Rent Refund when early Termination 
             If (SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo") And (SalesLineTemp."Billing Schedule Type" = SalesLineTemp."Billing Schedule Type"::Rent) AND (SalesLineTemp.type = SalesLineTemp.type::"G/L Account") then
                 SalesLine.validate("Unit Price", -SalesLineTemp."Unit Price");
             // Check Document Type if it is credit memo deposit also return positive amount <<
             If (SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo") And (SalesLineTemp."Billing Schedule Type" = SalesLineTemp."Billing Schedule Type"::Deposit) AND (SalesLineTemp.type = SalesLineTemp.type::"Item") then
                 SalesLine.validate("Unit Price", -SalesLineTemp."Unit Price");
     */
        end;

        if SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo" then
            SalesLine.validate("Unit Price", -SalesLineTemp."Unit Price")
        else
            SalesLine.validate("Unit Price", SalesLineTemp."Unit Price");

        SalesLine.validate("Invoice Description", SalesLineTemp."Invoice Description");
        SalesLine."Contract No." := SalesLineTemp."Contract No.";
        SalesLine."Billing Schedule Line No." := SalesLineTemp."Billing Schedule Line No.";
        SalesLine."Lease From Date" := SalesLineTemp."Lease From Date";
        SalesLine."Lease To Date" := SalesLineTemp."Lease To Date";
        SalesLine."Billing Schedule Type" := SalesLineTemp."Billing Schedule Type";
        SalesLine."No. of Days to Bill" := SalesLineTemp."No. of Days to Bill";
        //>> Tender Type
        SalesLine."Tender Type" := SalesLineTemp."Tender Type";
        // Tender Type<<
    end;


    procedure InsertDeferral(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    var
        l_recLeaseContractSetup: Record "Lease Contract Setup";
        l_recGeneralLedgerSetup: Record "General Ledger Setup";
        l_recLeaseContractHeader: Record "Lease Contract Header";
        l_intNoOfPeriod: Integer;
        l_intTotalDays: Integer;
        l_intNoOfDay: Integer;
        l_intNoOfLeaseFromDay: Integer;
        l_intNoOfDeferralDay: Integer;
        l_decDayRate: Decimal;
        l_decTotalDeferralAmount: Decimal;
        l_decDeferralAmount: Decimal;
        l_decDeferralAmount2: Decimal;
        l_dateOfLeaseFrom: Date;
        l_dateOfNextLeaseFrom: Date;
        l_dateOfLeaseTo: Date;
        l_dateOfNextLeaseTo: Date;
        l_boolFirstDeferralLine: Boolean;

    begin
        l_decTotalDeferralAmount := 0;
        l_recLeaseContractSetup.Get();
        l_recGeneralLedgerSetup.Get();


        SalesLine."Deferral Code" := l_recLeaseContractSetup."Rental Income Deferral Templ.";

        if SalesLine."Deferral Code" = '' then
            exit;

        l_intNoOfPeriod := (Date2DMY(SalesLine."Lease To Date", 3) - Date2DMY(SalesLine."Lease From Date", 3)) * 12
                                              + (Date2DMY(SalesLine."Lease To Date", 2) - Date2DMY(SalesLine."Lease From Date", 2)) + 1;

        l_intTotalDays := SalesLine."Lease To Date" - SalesLine."Lease From Date" + 1;
        l_decDayRate := SalesLine."Line Amount" / l_intTotalDays;


        InsertDeferralHeader('', '', SalesLine."Document Type".AsInteger(), SalesHeader."No.",
                            SalesLine."Line No.", SalesLine."Lease From Date", l_intNoOfPeriod, SalesLine."Deferral Code",
                            SalesLine."Line Amount", SalesLine."Line Amount");



        l_recLeaseContractHeader.Reset();
        l_recLeaseContractHeader.SetFilter("No.", SalesLine."Contract No.");
        if l_recLeaseContractHeader.FindFirst() then;

        l_dateOfLeaseFrom := SalesLine."Lease From Date";
        l_dateOfLeaseTo := SalesLine."Lease To Date";

        if (Date2DMY(l_dateOfLeaseFrom, 2) = Date2DMY(l_dateOfLeaseTo, 2)) ANd
           (Date2DMY(l_dateOfLeaseFrom, 3) = Date2DMY(l_dateOfLeaseTo, 3)) then begin

            l_decDeferralAmount := l_decDayRate * (l_dateOfLeaseTo - l_dateOfLeaseFrom + 1);
            InsertDeferralLine('', '', SalesLine."Document Type".AsInteger(), SalesHeader."No.", SalesLine."Line No.",
                    l_dateOfLeaseFrom,
                    StrSubstNo('Rental Income for %1', format(l_dateOfLeaseFrom, 0, '<Month Text,3> <Year4>')),
                    l_decDeferralAmount,
                    l_decDeferralAmount, SalesLine."Tender Type");


        end else begin


            l_decDeferralAmount := l_decDayRate * (CalcDate('CM', l_dateOfLeaseFrom) - l_dateOfLeaseFrom + 1);
            InsertDeferralLine('', '', SalesLine."Document Type".AsInteger(), SalesHeader."No.", SalesLine."Line No.",
                    l_dateOfLeaseFrom,
                    StrSubstNo('Rental Income for %1', format(l_dateOfLeaseFrom, 0, '<Month Text,3> <Year4>')),
                    l_decDeferralAmount,
                    l_decDeferralAmount, SalesLine."Tender Type");



            l_decDeferralAmount2 := l_decDayRate * Date2DMY(l_dateOfLeaseTo, 1);

            l_decDeferralAmount2 += SalesLine.Amount - (l_decDeferralAmount + l_decDeferralAmount2);


            InsertDeferralLine('', '', SalesLine."Document Type".AsInteger(), SalesHeader."No.", SalesLine."Line No.",
            CalcDate('-CM', l_dateOfLeaseTo),
            StrSubstNo('Rental Income for %1', format(l_dateOfLeaseTo, 0, '<Month Text,3> <Year4>')),
            l_decDeferralAmount2,
            l_decDeferralAmount2, SalesLine."Tender Type");

        end;




    end;



    procedure InsertAssemblyOrder(var
                                      SalesHeader: Record "Sales Header";

    var
        SalesLine: Record "Sales Line")
    var
        l_recAsmOrderHeader: Record "Assembly Header";
        l_recItem: Record Item;
    begin
        if l_recItem.get(SalesLine."No.") then begin
            if l_recItem.IsAssemblyItem() then begin
                l_recAsmOrderHeader.init;
                l_recAsmOrderHeader."Document Type" := l_recAsmOrderHeader."Document Type"::Order;
                l_recAsmOrderHeader."No." := '';
                if l_recAsmOrderHeader.insert(true) then;
                l_recAsmOrderHeader.Validate("Posting Date", SalesHeader."Posting Date");
                l_recAsmOrderHeader.validate("Item No.", SalesLine."No.");
                l_recAsmOrderHeader.validate("Location Code", SalesLine."Location Code");
                l_recAsmOrderHeader.validate(Quantity, SalesLine.Quantity);
                l_recAsmOrderHeader.validate("Quantity to Assemble", SalesLine.Quantity);
                if l_recAsmOrderHeader.modify(true) then;
                SalesLine."Linked Assembly Order No." := l_recAsmOrderHeader."No.";
            end;

        end;

    end;

    procedure GetGLAccountByRoomType(RoomType: Code[100]): Code[50]
    var
        l_recPropertyUnitRoomType: Record "Property Unit Room Type";
    begin
        l_recPropertyUnitRoomType.Reset();
        l_recPropertyUnitRoomType.SetFilter(Code, RoomType);
        if l_recPropertyUnitRoomType.FindFirst() then begin
            l_recPropertyUnitRoomType.TestField("G/L Account");
            exit(l_recPropertyUnitRoomType."G/L Account")
        end;


        Error('No related G/L Account of romm type : ' + RoomType);



    end;


    procedure SetAsOfDate(AsOfDate: Date)
    begin
        //   g_datAsOfDate := AsOfDate;
        g_datAsOfDate := WorkDate();
    end;


    procedure InsertCommission(Var LeaseContractHeader: Record "Lease Contract Header"; BillingDate: Date)
    var
        l_recCommissionSetup: Record "Sales Commission Setup";
    begin

        l_recCommissionSetup.reset;
        //   Message('%1', BillingDate);

        If LeaseContractHeader."Commission Type" <> LeaseContractHeader."Commission Type"::" " then begin
            l_recCommissionSetup.Setrange(Type, LeaseContractHeader."Commission Type");
            If (LeaseContractHeader."Commission Type" = LeaseContractHeader."Commission Type"::B2BRenewal) or (LeaseContractHeader."Commission Type" = LeaseContractHeader."Commission Type"::B2CRenewal) then begin
                If DT2DATE(LeaseContractHeader."Contract Start Date") = BillingDate then begin
                    l_recCommissionSetup.findfirst;
                    g_Salesperson := Getsalesperson(LeaseContractHeader);
                end;
            end else begin
                l_recCommissionSetup.findfirst;
                g_Salesperson := Getsalesperson(LeaseContractHeader);
            end;
            g_Commissiontype := l_recCommissionSetup.Type;
            g_calculationtype := l_recCommissionSetup."Calculation Type";
            g_commissionamount := l_recCommissionSetup.Amount;
            //  Message('%1, %2, %3', l_recCommissionSetup.Type, l_recCommissionSetup."Calculation Type", l_recCommissionSetup.Amount);
        end;
    end;

    procedure Getsalesperson(Var LeaseContractHeader: Record "Lease Contract Header"): code[20]
    var
        l_recSalesperson: Record "Salesperson/Purchaser";

    begin
        l_recSalesperson.reset;
        l_recSalesperson.SetRange(Code, LeaseContractHeader."Salesperson Code");
        If l_recSalesperson.FindFirst then begin
            exit(l_recSalesperson.Code)

        end else begin
            l_recSalesperson.reset;
            l_recSalesperson.SetRange("E-Mail", LeaseContractHeader."Salesperson Email");
            If l_recSalesperson.FindFirst then
                exit(l_recSalesperson.Code);
        end;
    end;

    procedure ApplyEntriesforTenderType(Var LeaseContractHeader: Record "Lease Contract Header"; SalesHeaderNo: Code[20]; TenderType: code[20]; DiscountAmt: Decimal)
    var
        l_recLeaseBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recCustLedgEntry: Record "Cust. Ledger Entry";

    begin
        Message('%1', SalesHeaderNo);
        l_recLeaseBillingSchedule.reset;
        l_recCustLedgEntry.reset;
        l_recLeaseBillingSchedule.setrange("Contract No.", LeaseContractHeader."No.");
        l_recLeaseBillingSchedule.setrange(Type, l_recLeaseBillingSchedule.Type::Rent);
        l_recLeaseBillingSchedule.setrange("Tender Type", TenderType);
        l_recLeaseBillingSchedule.setrange(Amount, -DiscountAmt);
        l_recLeaseBillingSchedule.SetFilter(status, '<>%1', l_recLeaseBillingSchedule.Status::" ");
        If l_recLeaseBillingSchedule.findlast then begin
            l_recCustLedgEntry.SetFilter("Document No.", l_recLeaseBillingSchedule."Document No.");
            If l_recCustLedgEntry.Findlast then begin
                l_recCustLedgEntry.validate("Applies-to ID", SalesHeaderNo);
                l_recCustLedgEntry.Modify();
                Message('%1', l_recLeaseBillingSchedule."Document No.");
            end;
        end

    end;



    var

        g_datAsOfDate: Date;
        g_optGroupBy: Option Customer,Contract;
        g_recLeaseBillingSchedule_Temp: Record "Lease Contract Billing Sched." temporary;

        g_property_type: Text[100];

        g_property_rmno: Text[100];

        g_property_description: text[100];
        g_CustomerName: Text;

        g_Commissiontype: Option;
        g_calculationtype: Enum "Calculation Type";

        g_commissionamount: Decimal;

        g_Salesperson: Code[20];
        g_optBillingScheudleDocumentType: Option Invoice,"Credit Memo";



}
