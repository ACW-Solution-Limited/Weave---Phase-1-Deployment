codeunit 83001 "Lease Contract Management"
{
    procedure RefreshBillingSchedule(p_recLeaseContractHeader: Record "Lease Contract Header"; JobQueue: Boolean);
    var
        l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.";
        l_recLeaseContractLine: Record "Lease Contract Line";
        l_recLeaseContractLineTemp: Record "Lease Contract Line" temporary;
        p_recLeaseContractHeaderTemp: Record "Lease Contract Header" temporary;
        l_recCRMWelcomeAmentities: Record "Welcome Amenities";
        l_recVATPosting: Record "VAT Posting Setup";
        l_CodAddItem: Codeunit "Addi.Item Sales to Bill. Sch.";
        l_datDate: Date;
        l_datDate2: Date;
        LeapYear: Boolean;
        l_Day: Integer;
        l_Month: Integer;
        l_Year: Integer;
        l_intNoOfMonth: Integer;
        l_intNoOfDaysLastMth: Integer;
        l_intTotalNoOfDaysLastMth: Integer;
        l_textConfirmMessage: Text;
        l_nextContractStartDate: Date;
        l_firstday: integer;
        l_daysinmonth: integer;
        l_unitprice: Decimal;
    begin

        if p_recLeaseContractHeader."No." = 'PB-230223-005' then exit;

        l_intLineNo := 0;
        g_deposit := 0;
        g_vatpercentage := 0;
        Clear(l_Day);
        Clear(l_Month);
        Clear(l_Year);
        Clear(l_firstday);
        l_recVATPosting.reset;
        If (p_recLeaseContractHeader.Status = p_recLeaseContractHeader.Status::FinishedContract) or (p_recLeaseContractHeader.Status = p_recLeaseContractHeader.Status::Terminated) then
            Error('%1', 'You cannot refresh the billing schedule when the contract was finished.');

        If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::"One-off (ShortStay)" then
            l_unitprice := p_recLeaseContractHeader."Daily Rent"
        else
            l_unitprice := p_recLeaseContractHeader."Monthly Rent";
        l_textConfirmMessage := 'Are you sure to refresh Billing Schedule? \'
                              + '-----------------------------------------------------------------'
                              + '\Payment Type : ' + format(p_recLeaseContractHeader."Payment Type")
                              + '\Deposit Amount: ' + Format(p_recLeaseContractHeader."Deposit Amount", 0, '$<Sign><Integer Thousand><Decimals>')
                              + '\Unit Price: ' + Format(l_unitprice, 0, '$<Sign><Integer Thousand><Decimals>')
                              + '\\Promotion Code:'
                              + '\ One-Off Discount: ' + Format(p_recLeaseContractHeader."One off Discount", 0, '$<Sign><Integer Thousand><Decimals>')
                              + '\ Monthly Discount: ' + Format(p_recLeaseContractHeader."Monthly Discount", 0, '$<Sign><Integer Thousand><Decimals>')
                              + '\----------------------------------------------------------------\';
        If JobQueue = false then begin
            if not confirm(l_textConfirmMessage, false) then
                exit;
        end;
        l_recLeaseContractBillingSchedule.LockTable();
        l_recLeaseContractBillingSchedule.reset;
        l_recLeaseContractBillingSchedule2.reset;
        l_recLeaseContractBillingSchedule.setrange("Contract No.", p_recLeaseContractHeader."No.");
        l_recLeaseContractBillingSchedule.SetRange(type, l_recLeaseContractBillingSchedule.type::Deposit, l_recLeaseContractBillingSchedule.type::Rent);
        l_recLeaseContractBillingSchedule.SetRange(Status, l_recLeaseContractBillingSchedule.Status::Created, l_recLeaseContractBillingSchedule.Status::Posted);
        if l_recLeaseContractBillingSchedule.findset then begin
            Error('Refresh Billing Schedule cannot be done when there is sales invoice created or posted.');
        end else begin
            l_recLeaseContractBillingSchedule.SetRange(Status);
            l_recLeaseContractBillingSchedule.DeleteAll();
        end;
        l_recLeaseContractBillingSchedule.reset;
        l_recLeaseContractBillingSchedule.SetRange("Contract No.", p_recLeaseContractHeader."No.");
        if l_recLeaseContractBillingSchedule.findlast then
            l_intLineNo := l_recLeaseContractBillingSchedule."Line No." + 10000
        else
            l_intLineNo := 10000;

        if p_recLeaseContractHeader."Deposit Amount" <> 0 then begin
            l_recLeaseContractBillingSchedule.reset;

            l_recLeaseContractBillingSchedule.setrange("Contract No.", p_recLeaseContractHeader."No.");
            l_recLeaseContractBillingSchedule.SetRange(Type, l_recLeaseContractBillingSchedule.type::Deposit);
            l_recLeaseContractBillingSchedule.CalcSums(Amount);
            if l_recLeaseContractBillingSchedule.Amount <> p_recLeaseContractHeader."Deposit Amount" then begin
                l_recLeaseContractBillingSchedule.init;
                l_recLeaseContractBillingSchedule."Contract No." := p_recLeaseContractHeader."No.";
                l_recLeaseContractBillingSchedule."Customer No." := p_recLeaseContractHeader."Customer No.";
                l_recLeaseContractBillingSchedule.Type := l_recLeaseContractBillingSchedule.type::Deposit;
                l_recLeaseContractBillingSchedule."Contract Start Date" := DT2date(p_recLeaseContractHeader."Contract Start Date");
                //l_recLeaseContractBillingSchedule."Due Date" := CalcDate('-1D', l_recLeaseContractBillingSchedule."Contract Start Date");
                // l_recLeaseContractBillingSchedule."Posting Date" := CalcDate('-7D', l_recLeaseContractBillingSchedule."Due Date");
                l_recLeaseContractBillingSchedule."Due Date" := DT2Date(p_recLeaseContractHeader.SystemCreatedAt);
                l_recLeaseContractBillingSchedule."Posting Date" := l_recLeaseContractBillingSchedule."Due Date";
                l_recLeaseContractBillingSchedule."Contract End Date" := DT2DATE(p_recLeaseContractHeader."Contract End Date");
                l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader."Deposit Amount" - l_recLeaseContractBillingSchedule.amount;
                g_deposit := l_recLeaseContractBillingSchedule.Amount;
                l_recLeaseContractBillingSchedule."Line No." := l_intLineNo;
                If p_recLeaseContractHeader."1st Payment Stripe Invoice ID" <> '' then begin
                    l_recLeaseContractBillingSchedule."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";
                end;
                l_intLineNo += 10000;
                l_recLeaseContractBillingSchedule.insert;
            end;
        end;

        l_recLeaseContractLineTemp := l_recLeaseContractLine;
        p_recLeaseContractHeaderTemp := p_recLeaseContractHeader;
        p_recLeaseContractHeaderTemp.insert;
        l_firstday := DATE2DMY(DT2DATE(p_recLeaseContractHeader."Contract Start Date"), 1);
        case p_recLeaseContractHeader."Payment Type" of
            p_recLeaseContractHeader."Payment Type"::Monthly, p_recLeaseContractHeader."Payment Type"::"Pre-paid", p_recLeaseContractHeader."Payment Type"::"One-off (ShortStay)":
                begin
                    while (DT2date(p_recLeaseContractHeaderTemp."Contract Start Date") <= DT2date(p_recLeaseContractHeaderTemp."Contract End Date")) do begin

                        l_recLeaseContractBillingSchedule.init;
                        l_recLeaseContractBillingSchedule."Customer No." := p_recLeaseContractHeader."Customer No.";
                        l_recLeaseContractBillingSchedule."Contract No." := p_recLeaseContractHeader."No.";
                        l_recLeaseContractBillingSchedule.Type := l_recLeaseContractBillingSchedule.type::Rent;
                        l_recLeaseContractBillingSchedule."Contract Start Date" := DT2date(p_recLeaseContractHeaderTemp."Contract Start Date");
                        If l_recLeaseContractBillingSchedule."Contract Start Date" = DT2Date(p_recLeaseContractHeader."Contract Start Date") then begin
                            l_recLeaseContractBillingSchedule."Posting Date" := DT2Date(p_recLeaseContractHeader.SystemCreatedAt);
                            l_recLeaseContractBillingSchedule."Due Date" := l_recLeaseContractBillingSchedule."Posting Date";
                        end else begin
                            If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly then begin
                                l_recLeaseContractBillingSchedule."Due Date" := CalcDate('-1D', l_recLeaseContractBillingSchedule."Contract Start Date");
                                l_recLeaseContractBillingSchedule."Posting Date" := CalcDate('-7D', l_recLeaseContractBillingSchedule."Due Date");
                            end else begin
                                l_recLeaseContractBillingSchedule."Posting Date" := DT2Date(p_recLeaseContractHeader.SystemCreatedAt);
                                l_recLeaseContractBillingSchedule."Due Date" := l_recLeaseContractBillingSchedule."Posting Date";

                            end;
                        end;

                        //Next Contract Start Date//
                        p_recLeaseContractHeaderTemp."Contract Start Date" := CreateDateTime(calcDate('+1M', l_recLeaseContractBillingSchedule."Contract Start Date"), 000000T);
                        //l_recLeaseContractBillingSchedule."Contract End Date" := calcDate('1M-1D', l_recLeaseContractBillingSchedule."Contract Start Date");
                        l_recLeaseContractBillingSchedule."Contract End Date" := calcDate('-1D', DT2Date(p_recLeaseContractHeaderTemp."Contract Start Date"));
                        l_recLeaseContractBillingSchedule."No. of Days Current Month" := l_recLeaseContractBillingSchedule."Contract End Date" - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;

                        l_recLeaseContractBillingSchedule."Line No." := l_intLineNo;
                        //>>>
                        l_Day := DATE2DMY(l_recLeaseContractBillingSchedule."Contract Start Date", 1);
                        l_Month := DATE2DMY(l_recLeaseContractBillingSchedule."Contract Start Date", 2);
                        l_Year := DATE2DMY(l_recLeaseContractBillingSchedule."Contract Start Date", 3);
                        //Check Leap Year
                        IF DATE2DMY(CALCDATE('<CM>', DMY2DATE(1, 2, l_Year)), 1) = 29 THEN
                            LeapYear := true
                        else
                            LeapYear := false;
                        //Check Leap Year
                        // To handle Feb case >>
                        If LeapYear = false then begin
                            If (l_firstday > 28) And (l_Month = 2) then begin
                                p_recLeaseContractHeaderTemp."Contract Start Date" := CreateDateTime(DMY2DATE(l_firstday, 3, l_Year), 000000T);
                                l_recLeaseContractBillingSchedule."Contract End Date" := CalcDate('-1D', DT2DATE(p_recLeaseContractHeaderTemp."Contract Start Date"));
                                // l_recLeaseContractBillingSchedule."No. of Days Current Month" := l_recLeaseContractBillingSchedule."Contract End Date" - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;
                            end;
                        end else begin
                            If (l_firstday > 29) And (l_Month = 2) then
                                p_recLeaseContractHeaderTemp."Contract Start Date" := CreateDateTime(DMY2DATE(l_firstday, 3, l_Year), 000000T);
                            l_recLeaseContractBillingSchedule."Contract End Date" := CalcDate('-1D', DT2DATE(p_recLeaseContractHeaderTemp."Contract Start Date"));
                            // l_recLeaseContractBillingSchedule."No. of Days Current Month" := l_recLeaseContractBillingSchedule."Contract End Date" - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;
                        end;
                        // To handle Feb case <<
                        // To handle 30 31th case >>
                        If (l_firstday > 29) And (l_Month <> 2) And (l_Month <> 1) then begin
                            l_Month := DATE2DMY(DT2DATE(p_recLeaseContractHeaderTemp."Contract Start Date"), 2);
                            l_Year := DATE2DMY(DT2DATE(p_recLeaseContractHeaderTemp."Contract Start Date"), 3);
                            l_daysinmonth := DATE2DMY(CALCDATE('<CM>', DMY2DATE(1, l_Month, l_Year)), 1);
                            IF l_daysinmonth < 31 THEN begin
                                p_recLeaseContractHeaderTemp."Contract Start Date" := CreateDateTime(DMY2DATE(30, l_Month, l_Year), 000000T);

                            end else begin
                                p_recLeaseContractHeaderTemp."Contract Start Date" := CreateDateTime(DMY2DATE(l_firstday, l_Month, l_Year), 000000T);

                            end;
                            l_recLeaseContractBillingSchedule."Contract End Date" := Calcdate('-1D', DT2DATE(p_recLeaseContractHeaderTemp."Contract Start Date"));
                        end;
                        // To handle 30 31th case <<

                        l_recLeaseContractBillingSchedule."No. of Days Current Month" := l_recLeaseContractBillingSchedule."Contract End Date" - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;

                        if l_recLeaseContractBillingSchedule."Contract End Date" < DT2date(p_recLeaseContractHeaderTemp."Contract End Date") then begin
                            l_recLeaseContractBillingSchedule."No. of Days to Bill" := l_recLeaseContractBillingSchedule."Contract End Date" - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;
                            //p_recLeaseContractHeaderTemp."Contract Start Date" := CreateDateTime(calcdate('1D', l_recLeaseContractBillingSchedule."Contract End Date"), 000000T);
                            p_recLeaseContractHeaderTemp.modify;
                            // Rent Amount >>
                            case p_recLeaseContractHeader."Payment Type" of
                                p_recLeaseContractHeader."Payment Type"::Monthly:
                                    begin
                                        l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader."Monthly Rent" * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month"
                                    end;
                                p_recLeaseContractHeader."Payment Type"::"Pre-paid":
                                    begin
                                        l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader."Monthly Rent" * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month";
                                    end;
                                p_recLeaseContractHeader."Payment Type"::"One-off (ShortStay)":
                                    begin
                                        l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader."Daily Rent" * l_recLeaseContractBillingSchedule."No. of Days to Bill";
                                    end;
                            end;
                            // Rent Amount <<
                        end else begin
                            l_recLeaseContractBillingSchedule."No. of Days to Bill" := DT2date(p_recLeaseContractHeaderTemp."Contract End Date") - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;
                            l_recLeaseContractBillingSchedule."Contract End Date" := DT2date(p_recLeaseContractHeaderTemp."Contract End Date");
                            //If last period fall into the same month
                            If DATE2DMY(l_recLeaseContractBillingSchedule."Contract Start Date", 2) = DATE2DMY(l_recLeaseContractBillingSchedule."Contract End Date", 2) then
                                l_recLeaseContractBillingSchedule."No. of Days Current Month" := DATE2DMY(CALCDATE('<CM>', DMY2DATE(1, DATE2DMY(l_recLeaseContractBillingSchedule."Contract Start Date", 2), DATE2DMY(l_recLeaseContractBillingSchedule."Contract Start Date", 3))), 1);
                            //If last period fall into the same month
                            // p_recLeaseContractHeaderTemp."Contract Start Date" := CreateDateTime(calcdate('1D', DT2date(p_recLeaseContractHeaderTemp."Contract End Date")), 000000T);
                            // Rent Amount >>
                            case p_recLeaseContractHeader."Payment Type" of
                                p_recLeaseContractHeader."Payment Type"::Monthly:
                                    begin
                                        l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader."Monthly Rent" * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month"
                                    end;
                                p_recLeaseContractHeader."Payment Type"::"Pre-paid":
                                    begin
                                        l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader."Monthly Rent" * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month";
                                    end;
                                p_recLeaseContractHeader."Payment Type"::"One-off (ShortStay)":
                                    begin
                                        l_recLeaseContractBillingSchedule."No. of Days to Bill" := l_recLeaseContractBillingSchedule."No. of Days to Bill" - 1;
                                        l_recLeaseContractBillingSchedule."No. of Days Current Month" := l_recLeaseContractBillingSchedule."No. of Days Current Month";
                                        l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader."Daily Rent" * l_recLeaseContractBillingSchedule."No. of Days to Bill";
                                    end;
                            end;
                            // Rent Amount <<

                        end;


                        If p_recLeaseContractHeader."1st Payment Stripe Invoice ID" <> '' then begin
                            // Prepayment >>
                            If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly then begin
                                If l_recLeaseContractBillingSchedule."Contract Start Date" = DT2date(p_recLeaseContractHeader."Contract Start Date") then begin
                                    l_recLeaseContractBillingSchedule."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";
                                end;
                            end else begin
                                l_recLeaseContractBillingSchedule."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";
                            end;
                        end;

                        l_recLeaseContractBillingSchedule.Insert;
                        If l_recLeaseContractBillingSchedule."Contract Start Date" = DT2date(p_recLeaseContractHeader."Contract Start Date") then begin
                            l_intLineNo := l_CodAddItem.CreateWelcomeAmentities(l_recCRMWelcomeAmentities, p_recLeaseContractHeader."No.", l_recLeaseContractBillingSchedule."Line No.", l_recLeaseContractBillingSchedule."Posting Date", l_recLeaseContractBillingSchedule."Due Date", p_recLeaseContractHeader."1st Payment Stripe Invoice ID");
                        end;
                        Oneoffdiscount(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);
                        Monthlydiscount(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);
                        InsertTenderType(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);
                        If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::"Pre-paid" then
                            PrepaidDiscount(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);
                        l_intLineNo += 10000;
                    end;
                end;
        /*p_recLeaseContractHeader."Payment Type"::"One-off (ShortStay)":
            begin
                l_recLeaseContractBillingSchedule.init;
                l_recLeaseContractBillingSchedule."Customer No." := p_recLeaseContractHeader."Customer No.";
                l_recLeaseContractBillingSchedule."Contract No." := p_recLeaseContractHeader."No.";
                l_recLeaseContractBillingSchedule.Type := l_recLeaseContractBillingSchedule.type::Rent;
                l_recLeaseContractBillingSchedule."Contract Start Date" := DT2date(p_recLeaseContractHeaderTemp."Contract Start Date");
                l_recLeaseContractBillingSchedule."Due Date" := CalcDate('-1D', l_recLeaseContractBillingSchedule."Contract Start Date");
                l_recLeaseContractBillingSchedule."Posting Date" := CalcDate('-7D', l_recLeaseContractBillingSchedule."Due Date");
                l_recLeaseContractBillingSchedule."Contract End Date" := DT2date(p_recLeaseContractHeaderTemp."Contract End Date");

                l_recLeaseContractBillingSchedule."Line No." := l_intLineNo;
                l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader.Price;

                If p_recLeaseContractHeader."1st Payment Stripe Invoice ID" <> '' then
                    l_recLeaseContractBillingSchedule."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";

                l_recLeaseContractBillingSchedule.insert;
                If l_recLeaseContractBillingSchedule."Contract Start Date" = DT2date(p_recLeaseContractHeader."Contract Start Date") then begin
                    l_intLineNo := l_CodAddItem.CreateWelcomeAmentities(l_recCRMWelcomeAmentities, p_recLeaseContractHeader."No.", l_recLeaseContractBillingSchedule."Line No.", l_recLeaseContractBillingSchedule."Posting Date", l_recLeaseContractBillingSchedule."Due Date", p_recLeaseContractHeader."1st Payment Stripe Invoice ID");
                end;
                Oneoffdiscount(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);


                l_intLineNo += 10000;
            end;*/
        /*p_recLeaseContractHeader."Payment Type"::"Pre-paid":
            begin
                l_recLeaseContractBillingSchedule.init;
                l_recLeaseContractBillingSchedule."Customer No." := p_recLeaseContractHeader."Customer No.";
                l_recLeaseContractBillingSchedule."Contract No." := p_recLeaseContractHeader."No.";
                l_recLeaseContractBillingSchedule.Type := l_recLeaseContractBillingSchedule.type::Rent;
                l_recLeaseContractBillingSchedule."Contract Start Date" := DT2date(p_recLeaseContractHeaderTemp."Contract Start Date");
                l_recLeaseContractBillingSchedule."Due Date" := CalcDate('-1D', l_recLeaseContractBillingSchedule."Contract Start Date");
                l_recLeaseContractBillingSchedule."Posting Date" := CalcDate('-7D', l_recLeaseContractBillingSchedule."Due Date");
                l_recLeaseContractBillingSchedule."Contract End Date" := DT2date(p_recLeaseContractHeaderTemp."Contract End Date");
                l_recLeaseContractBillingSchedule."Line No." := l_intLineNo;
                l_recLeaseContractBillingSchedule.Amount := p_recLeaseContractHeader.Price;

                If l_recLeaseContractBillingSchedule."Contract Start Date" = DT2date(p_recLeaseContractHeader."Contract Start Date") then
                    l_intLineNo := l_CodAddItem.CreateWelcomeAmentities(l_recCRMWelcomeAmentities, p_recLeaseContractHeader."No.", l_recLeaseContractBillingSchedule."Line No.", l_recLeaseContractBillingSchedule."Posting Date", l_recLeaseContractBillingSchedule."Due Date", p_recLeaseContractHeader."1st Payment Stripe Invoice ID");

                If p_recLeaseContractHeader."1st Payment Stripe Invoice ID" <> '' then
                    l_recLeaseContractBillingSchedule."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";

                l_recLeaseContractBillingSchedule.insert;
                Oneoffdiscount(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);
                Monthlydiscount(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);
                PrepaidDiscount(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);
                l_intLineNo += 10000;
            end;*/
        end;
        InsertRefundDeposit(p_recLeaseContractHeader, g_deposit);
    end;
    //end;

    // end;

    //>> Termination >>
    procedure TerminateContract(var p_recLeaseContractHeader: Record "Lease Contract Header"; JobQueue: Boolean);
    var
        l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.";
        l_recLeaseContractBillingScheduleInsert: Record "Lease Contract Billing Sched.";
        l_recLeaseContractBillingScheduleinsertTemp: Record "Lease Contract Billing Sched." temporary;
        l_recLeaseContractLine: Record "Lease Contract Line";
        l_recExtraCharges: Record "Extra Charge";

    //l_intLineNo: Integer;
    begin
        l_recExtraCharges.reset;
        Clear(l_recLeaseContractBillingScheduleinsertTemp);
        l_intLineNo := 0;
        g_intoriginalLineNo := 0;
        p_recLeaseContractHeader.TestField("Contract Termination Date");
        l_recExtraCharges.SetFilter("Contract No.", p_recLeaseContractHeader."No.");

        //Check Contract Termination Date
        If /* (p_recLeaseContractHeader."Contract Termination Date" < p_recLeaseContractHeader."Contract Start Date") Or */(p_recLeaseContractHeader."Contract Termination Date" > p_recLeaseContractHeader."Contract End Date") then begin
            If JobQueue = false then
                Error('%1', 'The Termination Date is not within the contract period.')
            else
                exit;
        end;
        If JobQueue = false then
            If not Confirm('Are you sure to terminate the contract on %1?', false, DT2date(p_recLeaseContractHeader."Contract Termination Date")) then
                exit;
        // Delete the billing schedule line which sales invocie not created 
        /* If (p_recLeaseContractHeader.Status = p_recLeaseContractHeader.Status::FinishedContract) or (p_recLeaseContractHeader.Status = p_recLeaseContractHeader.Status::Terminated) then
             If JobQueue = false then
                 Error('%1', 'You cannot terminate the lease contract when the contract is not confirmed.')
             else
                 exit;*/
        //Delete the future Billing Schedule after the termination date 
        l_recLeaseContractBillingSchedule.reset;
        l_recLeaseContractBillingSchedule.setrange("Contract No.", p_recLeaseContractHeader."No.");
        l_recLeaseContractBillingSchedule.SetRange(Status, l_recLeaseContractBillingSchedule.Status::" ");
        l_recLeaseContractBillingSchedule.SetRange("Contract Start Date", calcdate('1D', DT2date(p_recLeaseContractHeader."Contract Termination Date")), 99991231D);
        l_recLeaseContractBillingSchedule.SetRange(Type, l_recLeaseContractBillingSchedule.type::Deposit, l_recLeaseContractBillingSchedule.type::Rent);
        l_recLeaseContractBillingSchedule.SetRange("Stripe Invoice ID", '');
        l_recLeaseContractBillingSchedule.DeleteAll();

        // Get Line Number 
        l_recLeaseContractBillingSchedule.reset;
        l_recLeaseContractBillingSchedule.setrange("Contract No.", p_recLeaseContractHeader."No.");
        if l_recLeaseContractBillingSchedule.FindLast() then
            l_intLineNo := l_recLeaseContractBillingSchedule."Line No."
        else
            l_intLineNo := 10000;
        g_intoriginalLineNo := l_intLineNo;
        //Message('%1', l_intLineNo);
        If p_recLeaseContractHeader."Contract Termination Date" >= p_recLeaseContractHeader."Contract Start Date" then begin
            l_recLeaseContractBillingSchedule.reset;
            l_recLeaseContractBillingSchedule.setrange("Contract No.", p_recLeaseContractHeader."No.");
            l_recLeaseContractBillingSchedule.SetRange("Contract Start Date", DT2date(p_recLeaseContractHeader."Contract Start Date"), DT2DATE(p_recLeaseContractHeader."Contract End Date"));
            l_recLeaseContractBillingSchedule.SetRange(Type, l_recLeaseContractBillingSchedule.type::Rent);
            l_recLeaseContractBillingSchedule.SetRange("Sub-Type", '');
            l_recLeaseContractBillingSchedule.SetFilter("Contract End Date", '>%1', DT2date(p_recLeaseContractHeader."Contract Termination Date"));
            If l_recLeaseContractBillingSchedule.Findset then begin
                repeat
                    If l_recLeaseContractBillingSchedule."Contract Start Date" > DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
                        // Refund the period not yet started
                        If l_intLineNo <> 10000 then
                            l_intLineNo += 10000;
                        l_recLeaseContractBillingScheduleinsertTemp.init;
                        l_recLeaseContractBillingScheduleinsertTemp."Line No." := l_intLineNo;
                        // if DT2DATE(p_recLeaseContractHeader."Contract End Date") > WorkDate() then
                        // Adjusting Positing Date >>
                        If WorkDate() < DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
                            l_recLeaseContractBillingScheduleinsertTemp."Due Date" := l_recLeaseContractBillingSchedule."Due Date";
                            l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := l_recLeaseContractBillingSchedule."Posting Date";
                        end else begin
                            l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
                            l_recLeaseContractBillingScheduleinsertTemp."Due Date" := 0D;
                        end;
                        // Adjusting Positing Date <<

                        l_recLeaseContractBillingScheduleinsertTemp."Customer No." := p_recLeaseContractHeader."Customer No.";
                        l_recLeaseContractBillingScheduleinsertTemp."Contract Start Date" := l_recLeaseContractBillingSchedule."Contract Start Date";
                        l_recLeaseContractBillingScheduleinsertTemp."Contract End Date" := l_recLeaseContractBillingSchedule."Contract End Date";
                        l_recLeaseContractBillingScheduleinsertTemp."Due Date" := 0D;
                        l_recLeaseContractBillingScheduleinsertTemp."Contract Line No." := l_recLeaseContractBillingSchedule."Contract Line No.";
                        l_recLeaseContractBillingScheduleinsertTemp."Contract No." := l_recLeaseContractBillingSchedule."Contract No.";
                        l_recLeaseContractBillingScheduleinsertTemp.Amount := -l_recLeaseContractBillingSchedule.Amount;
                        //  l_recLeaseContractBillingScheduleinsertTemp."Amount Excluding VAT" := -l_recLeaseContractBillingSchedule."Amount Excluding VAT";
                        l_recLeaseContractBillingScheduleinsertTemp."No. of Days Current Month" := l_recLeaseContractBillingSchedule."No. of Days Current Month";
                        l_recLeaseContractBillingScheduleinsertTemp."No. of Days to Bill" := l_recLeaseContractBillingSchedule."No. of Days to Bill";
                        l_recLeaseContractBillingScheduleinsertTemp."Document No." := '';
                        l_recLeaseContractBillingScheduleinsertTemp.Status := l_recLeaseContractBillingSchedule.Status::" ";
                        l_recLeaseContractBillingScheduleinsertTemp.Type := l_recLeaseContractBillingSchedule.Type::Rent;
                        l_recLeaseContractBillingScheduleinsertTemp.insert;
                    end else begin
                        // Refund current month which the period not yet ended
                        If l_recLeaseContractBillingSchedule."Contract End Date" > DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
                            If (l_recLeaseContractBillingSchedule.status <> l_recLeaseContractBillingSchedule.status::" ") OR (l_recLeaseContractBillingSchedule."Stripe Invoice ID" <> '') then begin
                                // Message('%1 %2', l_recLeaseContractBillingSchedule."Contract Line No.", l_recLeaseContractBillingSchedule.status);
                                If l_intLineNo <> 10000 then
                                    l_intLineNo += 10000;
                                l_recLeaseContractBillingScheduleinsertTemp.Init();
                                l_recLeaseContractBillingScheduleinsertTemp."Document No." := '';
                                l_recLeaseContractBillingScheduleinsertTemp."Line No." := l_intLineNo;
                                // Adjusting Positing Date >>
                                If WorkDate() < DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
                                    l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := l_recLeaseContractBillingSchedule."Posting Date";
                                    l_recLeaseContractBillingScheduleinsertTemp."Due Date" := l_recLeaseContractBillingSchedule."Due Date";
                                end else begin
                                    l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
                                    l_recLeaseContractBillingScheduleinsertTemp."Due Date" := 0D;
                                end;
                                // Adjusting Positing Date <<
                                // l_recLeaseContractBillingScheduleinsertTemp."Contract End Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
                                l_recLeaseContractBillingScheduleinsertTemp."Contract End Date" := l_recLeaseContractBillingSchedule."Contract End Date";
                                //To handle short day And Prepaid case
                                //To handle short day And Prepaid case
                                l_recLeaseContractBillingScheduleinsertTemp."No. of Days Current Month" := calcDate('1M-1D', l_recLeaseContractBillingSchedule."Contract Start Date") - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;
                                l_recLeaseContractBillingScheduleinsertTemp."Contract Start Date" := l_recLeaseContractBillingSchedule."Contract Start Date";
                                l_recLeaseContractBillingScheduleinsertTemp."Contract Line No." := l_recLeaseContractBillingSchedule."Contract Line No.";
                                l_recLeaseContractBillingScheduleinsertTemp."Contract No." := l_recLeaseContractBillingSchedule."Contract No.";
                                l_recLeaseContractBillingScheduleinsertTemp."No. of Days to Bill" := l_recLeaseContractBillingSchedule."No. of Days to Bill";
                                l_recLeaseContractBillingScheduleinsertTemp.Amount := -l_recLeaseContractBillingSchedule.Amount;
                                // l_recLeaseContractBillingScheduleinsertTemp."Amount Excluding VAT" := -l_recLeaseContractBillingSchedule."Amount Excluding VAT";
                                l_recLeaseContractBillingScheduleinsertTemp.Status := l_recLeaseContractBillingScheduleinsertTemp.Status::" ";
                                l_recLeaseContractBillingScheduleinsertTemp.Type := l_recLeaseContractBillingSchedule.Type::Rent;
                                l_recLeaseContractBillingScheduleinsertTemp."Customer No." := p_recLeaseContractHeader."Customer No.";
                                l_recLeaseContractBillingScheduleinsertTemp.insert;
                            end;
                            //If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly then
                            Recalculatebillingperiod(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule);
                        end;
                    end;
                until l_recLeaseContractBillingSchedule.next = 0;

            end;
            RefundOneoffdiscount(p_recLeaseContractHeader);
            DeletetheOriginalTermSched(p_recLeaseContractHeader);
            //  p_recLeaseContractHeader."Terminated" := True;
            //  p_recLeaseContractHeader.Modify();
        end else begin
            l_recLeaseContractBillingSchedule.reset;
            l_recLeaseContractBillingSchedule.setrange("Contract No.", p_recLeaseContractHeader."No.");
            // l_recLeaseContractBillingSchedule.setrange(Type,l_recLeaseContractBillingSchedule.Type::Deposit);
            l_recLeaseContractBillingSchedule.SetRange(Type, l_recLeaseContractBillingSchedule.Type::Rent);
            If l_recLeaseContractBillingSchedule.Findset then
                repeat
                    If l_intLineNo <> 10000 then
                        l_intLineNo += 10000;
                    l_recLeaseContractBillingScheduleinsertTemp.Init();
                    l_recLeaseContractBillingScheduleinsertTemp."Document No." := '';
                    l_recLeaseContractBillingScheduleinsertTemp."Line No." := l_intLineNo;
                    //if DT2date(p_recLeaseContractHeader."Contract Termination Date") > WorkDate() then
                    l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
                    //else
                    // l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := workdate;
                    l_recLeaseContractBillingScheduleinsertTemp."Due Date" := 0D;
                    l_recLeaseContractBillingScheduleinsertTemp."Contract End Date" := l_recLeaseContractBillingSchedule."Contract End Date";
                    l_recLeaseContractBillingScheduleinsertTemp."No. of Days Current Month" := l_recLeaseContractBillingSchedule."No. of Days Current Month";
                    l_recLeaseContractBillingScheduleinsertTemp."Contract Start Date" := l_recLeaseContractBillingSchedule."Contract Start Date";
                    l_recLeaseContractBillingScheduleinsertTemp."Contract Line No." := l_recLeaseContractBillingSchedule."Contract Line No.";
                    l_recLeaseContractBillingScheduleinsertTemp."Contract No." := l_recLeaseContractBillingSchedule."Contract No.";
                    l_recLeaseContractBillingScheduleinsertTemp."No. of Days to Bill" := l_recLeaseContractBillingSchedule."No. of Days to Bill";
                    l_recLeaseContractBillingScheduleinsertTemp.Amount := -l_recLeaseContractBillingSchedule.Amount;
                    // l_recLeaseContractBillingScheduleinsertTemp."Amount Excluding VAT" := -l_recLeaseContractBillingSchedule."Amount Excluding VAT";
                    l_recLeaseContractBillingScheduleinsertTemp.Status := l_recLeaseContractBillingScheduleinsertTemp.Status::" ";
                    l_recLeaseContractBillingScheduleinsertTemp.Type := l_recLeaseContractBillingSchedule.Type;
                    l_recLeaseContractBillingScheduleinsertTemp."Sub-Type" := l_recLeaseContractBillingSchedule."Sub-Type";
                    l_recLeaseContractBillingScheduleinsertTemp."Tender Type" := l_recLeaseContractBillingSchedule."Tender Type";
                    l_recLeaseContractBillingScheduleinsertTemp."Customer No." := p_recLeaseContractHeader."Customer No.";
                    l_recLeaseContractBillingScheduleinsertTemp.insert;
                until l_recLeaseContractBillingSchedule.next = 0;
        end;
        // If p_recLeaseContractHeader."Deposit Amount" <> 0 then begin
        //     If l_intLineNo <> 10000 then
        //         l_intLineNo += 10000;
        //     l_recLeaseContractBillingScheduleinsertTemp.Init();
        //     l_recLeaseContractBillingScheduleinsertTemp."Document No." := '';
        //     l_recLeaseContractBillingScheduleinsertTemp."Line No." := l_intLineNo;
        //     if DT2date(p_recLeaseContractHeader."Contract Termination Date") > WorkDate() then
        //         l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date")
        //     else
        //         l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := workdate;
        //     l_recLeaseContractBillingScheduleinsertTemp."Due Date" := 0D;
        //     l_recLeaseContractBillingScheduleinsertTemp."Contract End Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
        //     l_recLeaseContractBillingScheduleinsertTemp."Contract No." := p_recLeaseContractHeader."No.";
        //     l_recLeaseContractBillingScheduleinsertTemp.Amount := -p_recLeaseContractHeader."Deposit Amount";
        //     // l_recLeaseContractBillingScheduleinsertTemp."Amount Excluding VAT" := -l_recLeaseContractBillingSchedule."Amount Excluding VAT";
        //     l_recLeaseContractBillingScheduleinsertTemp.Status := l_recLeaseContractBillingScheduleinsertTemp.Status::" ";
        //     l_recLeaseContractBillingScheduleinsertTemp.Type := l_recLeaseContractBillingSchedule.Type::Deposit;
        //     //l_recLeaseContractBillingScheduleinsertTemp."Document Type" := l_recLeaseContractBillingSchedule."Document Type"::"Credit Memo";
        //     l_recLeaseContractBillingScheduleinsertTemp."Customer No." := p_recLeaseContractHeader."Customer No.";
        //     l_recLeaseContractBillingScheduleinsertTemp.insert;

        // end;
        l_recLeaseContractBillingScheduleinsertTemp.SetRange("Contract No.", p_recLeaseContractHeader."No.");
        If l_recLeaseContractBillingScheduleinsertTemp.FindSet then begin
            repeat
                l_recLeaseContractBillingScheduleInsert.copy(l_recLeaseContractBillingScheduleinsertTemp);
                l_recLeaseContractBillingScheduleInsert.insert;
            until l_recLeaseContractBillingScheduleinsertTemp.next = 0;
        end;
        l_recLeaseContractBillingSchedule.reset;
        l_recLeaseContractBillingSchedule.setrange("Contract No.", p_recLeaseContractHeader."No.");
        l_recLeaseContractBillingSchedule.setrange(Type, l_recLeaseContractBillingSchedule.Type::Deposit);
        l_recLeaseContractBillingSchedule.setrange(Status, l_recLeaseContractBillingSchedule.Status::" ");
        //l_recLeaseContractBillingSchedule.SetFilter(Amount, '<%1', 0);
        If l_recLeaseContractBillingSchedule.FindSet() then begin
            repeat
                l_recLeaseContractBillingSchedule."Posting Date" := CalcDate('2D', DT2DATE(p_recLeaseContractHeader."Contract Termination Date"));
                l_recLeaseContractBillingSchedule.Modify();
            until l_recLeaseContractBillingSchedule.next = 0;
        end;
        p_recLeaseContractHeader."Run Terminated Billing Sched." := CurrentDateTime;
        p_recLeaseContractHeader.Modify;
    end;
    // >> Termination <<

    // ** One off Discount
    procedure Oneoffdiscount(p_recLeaseContractHeader: Record "Lease Contract Header"; l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.")
    Var
        l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.";
    begin
        l_recLeaseContractBillingSchedule2.reset;
        If l_recLeaseContractBillingSchedule."Contract Start Date" = DT2date(p_recLeaseContractHeader."Contract Start Date") then begin
            //If p_recLeaseContractHeader."One off Discount" <> 0 then begin
            If p_recLeaseContractHeader."Promotion Code type" = p_recLeaseContractHeader."Promotion Code type"::FirstMonth then begin
                l_recLeaseContractBillingSchedule2.Reset;
                l_recLeaseContractBillingSchedule2.init;
                l_intLineNo += 10000;
                l_recLeaseContractBillingSchedule2."Customer No." := p_recLeaseContractHeader."Customer No.";
                l_recLeaseContractBillingSchedule2."Contract No." := p_recLeaseContractHeader."No.";
                l_recLeaseContractBillingSchedule2.Type := l_recLeaseContractBillingSchedule2.Type::Rent;
                l_recLeaseContractBillingSchedule2."Sub-Type" := 'One-off Discount';
                l_recLeaseContractBillingSchedule2."Contract Start Date" := l_recLeaseContractBillingSchedule."Contract Start Date";
                l_recLeaseContractBillingSchedule2."Due Date" := CalcDate('-1D', l_recLeaseContractBillingSchedule."Contract Start Date");
                l_recLeaseContractBillingSchedule2."Posting Date" := l_recLeaseContractBillingSchedule."Posting Date";
                If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly then
                    l_recLeaseContractBillingSchedule2."Due Date" := CalcDate('-1D', l_recLeaseContractBillingSchedule."Contract Start Date")
                else
                    l_recLeaseContractBillingSchedule2."Due Date" := l_recLeaseContractBillingSchedule."Posting Date";

                l_recLeaseContractBillingSchedule2."Contract End Date" := l_recLeaseContractBillingSchedule."Contract End Date";
                l_recLeaseContractBillingSchedule2."No. of Days Current Month" := l_recLeaseContractBillingSchedule."No. of Days Current Month";
                l_recLeaseContractBillingSchedule2."No. of Days to Bill" := l_recLeaseContractBillingSchedule."No. of Days to Bill";
                Case p_recLeaseContractHeader."Promotion Deduction Type" of
                    p_recLeaseContractHeader."Promotion Deduction Type"::ByExactDollarValue:
                        begin
                            l_recLeaseContractBillingSchedule2.Amount := -(p_recLeaseContractHeader."Promotion Amount / %") * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month";
                        End;
                    p_recLeaseContractHeader."Promotion Deduction Type"::ByPercentage:
                        begin
                            If (p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly) OR (p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::"Pre-paid") then
                                l_recLeaseContractBillingSchedule2.Amount := -(p_recLeaseContractHeader."Monthly Rent" * p_recLeaseContractHeader."Promotion Amount / %" / 100) * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month"
                            else
                                l_recLeaseContractBillingSchedule2.Amount := -(p_recLeaseContractHeader."Daily Rent" * p_recLeaseContractHeader."Promotion Amount / %" / 100) * l_recLeaseContractBillingSchedule."No. of Days to Bill";
                        end;

                end;
                l_recLeaseContractBillingSchedule2."Line No." := l_intLineNo;
                If p_recLeaseContractHeader."1st Payment Stripe Invoice ID" <> '' then
                    l_recLeaseContractBillingSchedule2."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";

                l_recLeaseContractBillingSchedule2.insert;
            end;
        end;
    end;
    // ** One off Discount <<
    // ** Monthly Discount >>
    procedure Monthlydiscount(p_recLeaseContractHeader: Record "Lease Contract Header"; l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.")
    Var
        l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.";
    begin
        l_recLeaseContractBillingSchedule2.reset;
        // If p_recLeaseContractHeader."Monthly Discount" <> 0 then begin
        If p_recLeaseContractHeader."Promotion Code type" = p_recLeaseContractHeader."Promotion Code type"::Monthly then begin
            l_recLeaseContractBillingSchedule2.reset;
            l_recLeaseContractBillingSchedule2.init;
            l_intLineNo += 10000;
            l_recLeaseContractBillingSchedule2."Customer No." := p_recLeaseContractHeader."Customer No.";
            l_recLeaseContractBillingSchedule2."Contract No." := p_recLeaseContractHeader."No.";
            l_recLeaseContractBillingSchedule2.Type := l_recLeaseContractBillingSchedule2.Type::Rent;
            l_recLeaseContractBillingSchedule2."Sub-Type" := 'Monthly Discount';
            l_recLeaseContractBillingSchedule2."Contract Start Date" := l_recLeaseContractBillingSchedule."Contract Start Date";
            l_recLeaseContractBillingSchedule2."Posting Date" := l_recLeaseContractBillingSchedule."Posting Date";
            If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly then
                l_recLeaseContractBillingSchedule2."Due Date" := CalcDate('-1D', l_recLeaseContractBillingSchedule."Contract Start Date")
            else
                l_recLeaseContractBillingSchedule2."Due Date" := l_recLeaseContractBillingSchedule."Posting Date";

            l_recLeaseContractBillingSchedule2."Contract End Date" := l_recLeaseContractBillingSchedule."Contract End Date";
            l_recLeaseContractBillingSchedule2."No. of Days Current Month" := l_recLeaseContractBillingSchedule."No. of Days Current Month";
            l_recLeaseContractBillingSchedule2."No. of Days to Bill" := l_recLeaseContractBillingSchedule."No. of Days to Bill";

            /*  If (p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::"Pre-paid") then
                  l_recLeaseContractBillingSchedule2.Amount := -p_recLeaseContractHeader."Monthly Discount"
              else*/
            // l_recLeaseContractBillingSchedule2.Amount := -(p_recLeaseContractHeader."Monthly Discount" * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month");
            Case p_recLeaseContractHeader."Promotion Deduction Type" of
                p_recLeaseContractHeader."Promotion Deduction Type"::ByExactDollarValue:
                    begin
                        l_recLeaseContractBillingSchedule2.Amount := -(p_recLeaseContractHeader."Promotion Amount / %") * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month";
                    End;
                p_recLeaseContractHeader."Promotion Deduction Type"::ByPercentage:
                    begin
                        If (p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly) OR (p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::"Pre-paid") then
                            l_recLeaseContractBillingSchedule2.Amount := -(p_recLeaseContractHeader."Monthly Rent" * p_recLeaseContractHeader."Promotion Amount / %" / 100) * l_recLeaseContractBillingSchedule."No. of Days to Bill" / l_recLeaseContractBillingSchedule."No. of Days Current Month"
                        else
                            l_recLeaseContractBillingSchedule2.Amount := -(p_recLeaseContractHeader."Daily Rent" * p_recLeaseContractHeader."Promotion Amount / %" / 100) * l_recLeaseContractBillingSchedule."No. of Days to Bill";
                    end;

            end;

            l_recLeaseContractBillingSchedule2."Line No." := l_intLineNo;
            If p_recLeaseContractHeader."1st Payment Stripe Invoice ID" <> '' then begin
                If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly then begin
                    If l_recLeaseContractBillingSchedule2."Contract Start Date" = DT2date(p_recLeaseContractHeader."Contract Start Date") then
                        l_recLeaseContractBillingSchedule2."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";
                end else begin
                    l_recLeaseContractBillingSchedule2."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";
                end;
            end;
            l_recLeaseContractBillingSchedule2.insert;
        end;
    end;
    // ** Monthly Discount <<

    // ** Prepaid Discount >>
    procedure PrepaidDiscount(p_recLeaseContractHeader: Record "Lease Contract Header"; l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.")
    Var
        l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.";
    begin
        l_recLeaseContractBillingSchedule2.reset;
        If l_recLeaseContractBillingSchedule."Contract Start Date" = DT2date(p_recLeaseContractHeader."Contract Start Date") then begin
            If p_recLeaseContractHeader."Prepaid Amount" <> 0 then begin
                l_recLeaseContractBillingSchedule2.Reset;
                l_recLeaseContractBillingSchedule2.init;
                l_intLineNo += 10000;
                l_recLeaseContractBillingSchedule2."Customer No." := p_recLeaseContractHeader."Customer No.";
                l_recLeaseContractBillingSchedule2."Contract No." := p_recLeaseContractHeader."No.";
                l_recLeaseContractBillingSchedule2.Type := l_recLeaseContractBillingSchedule2.Type::Rent;
                l_recLeaseContractBillingSchedule2."Sub-Type" := 'Prepaid Discount';
                l_recLeaseContractBillingSchedule2."Contract Start Date" := l_recLeaseContractBillingSchedule."Contract Start Date";
                l_recLeaseContractBillingSchedule2."Posting Date" := l_recLeaseContractBillingSchedule."Posting Date";
                //l_recLeaseContractBillingSchedule2."Due Date" := CalcDate('-1D', l_recLeaseContractBillingSchedule."Contract Start Date");
                l_recLeaseContractBillingSchedule2."Due Date" := l_recLeaseContractBillingSchedule."Posting Date";
                l_recLeaseContractBillingSchedule2."Contract End Date" := l_recLeaseContractBillingSchedule."Contract End Date";
                l_recLeaseContractBillingSchedule2."No. of Days Current Month" := l_recLeaseContractBillingSchedule."No. of Days Current Month";
                l_recLeaseContractBillingSchedule2."No. of Days to Bill" := l_recLeaseContractBillingSchedule."No. of Days to Bill";
                l_recLeaseContractBillingSchedule2.Amount := -p_recLeaseContractHeader."Prepaid Amount";
                l_recLeaseContractBillingSchedule2."Line No." := l_intLineNo;
                If p_recLeaseContractHeader."1st Payment Stripe Invoice ID" <> '' then
                    l_recLeaseContractBillingSchedule2."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";
                l_recLeaseContractBillingSchedule2.insert;
            end;
        end;
    end;
    // ** Prepaid Discount <<


    // Refund Discount >>
    procedure RefundOneoffdiscount(p_recLeaseContractHeader: Record "Lease Contract Header")
    var
        l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.";
        l_recLeaseContractBillingScheduleInsert2: Record "Lease Contract Billing Sched.";
        l_recLeaseContractBillingScheduleinsertTemp: Record "Lease Contract Billing Sched." temporary;
    begin
        Clear(l_recLeaseContractBillingScheduleinsertTemp);
        l_recLeaseContractBillingSchedule2.Reset;
        l_recLeaseContractBillingScheduleInsert2.reset;
        l_recLeaseContractBillingSchedule2.SetRange("Contract No.", p_recLeaseContractHeader."No.");
        l_recLeaseContractBillingSchedule2.SetRange(Type, l_recLeaseContractBillingSchedule2.type::Rent);
        l_recLeaseContractBillingSchedule2.SetFilter("Contract End Date", '>%1', DT2date(p_recLeaseContractHeader."Contract Termination Date"));
        l_recLeaseContractBillingSchedule2.SetFilter("Sub-Type", '<>%1', '');
        l_recLeaseContractBillingSchedule2.SetFilter("Tender type", '=%1', '');

        If l_recLeaseContractBillingSchedule2.findset then begin
            repeat
                If l_recLeaseContractBillingSchedule2."Contract Start Date" > DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
                    l_intLineNo += 10000;
                    l_recLeaseContractBillingScheduleinsertTemp.init;
                    l_recLeaseContractBillingScheduleinsertTemp."Line No." := l_intLineNo;
                    // Adjusting Positing Date >>
                    If WorkDate() < DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
                        l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := l_recLeaseContractBillingSchedule2."Posting Date";
                        l_recLeaseContractBillingScheduleinsertTemp."Due Date" := l_recLeaseContractBillingSchedule2."Due Date";
                    end else begin
                        l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
                        l_recLeaseContractBillingScheduleinsertTemp."Due Date" := 0D;
                    end;
                    // Adjusting Positing Date <<
                    l_recLeaseContractBillingScheduleinsertTemp."Contract Start Date" := l_recLeaseContractBillingSchedule2."Contract Start Date";
                    l_recLeaseContractBillingScheduleinsertTemp."Contract End Date" := l_recLeaseContractBillingSchedule2."Contract End Date";
                    l_recLeaseContractBillingScheduleinsertTemp."Due Date" := 0D;
                    l_recLeaseContractBillingScheduleinsertTemp."Contract Line No." := l_recLeaseContractBillingSchedule2."Contract Line No.";
                    l_recLeaseContractBillingScheduleinsertTemp."Contract No." := l_recLeaseContractBillingSchedule2."Contract No.";
                    l_recLeaseContractBillingScheduleinsertTemp."No. of Days Current Month" := l_recLeaseContractBillingSchedule2."No. of Days Current Month";
                    l_recLeaseContractBillingScheduleinsertTemp."No. of Days to Bill" := l_recLeaseContractBillingSchedule2."No. of Days to Bill";
                    l_recLeaseContractBillingScheduleinsertTemp.Amount := -(l_recLeaseContractBillingSchedule2.Amount);
                    //l_recLeaseContractBillingScheduleinsertTemp."Amount Excluding VAT" := -(l_recLeaseContractBillingSchedule2."Amount Excluding VAT");
                    l_recLeaseContractBillingScheduleinsertTemp."Document No." := '';
                    l_recLeaseContractBillingScheduleinsertTemp."Customer No." := p_recLeaseContractHeader."Customer No.";
                    l_recLeaseContractBillingScheduleinsertTemp.Status := l_recLeaseContractBillingSchedule2.Status::" ";
                    l_recLeaseContractBillingScheduleinsertTemp.Type := l_recLeaseContractBillingSchedule2.Type::Rent;
                    l_recLeaseContractBillingScheduleInsertTemp."Sub-Type" := l_recLeaseContractBillingSchedule2."Sub-Type";
                    l_recLeaseContractBillingScheduleinsertTemp."Tender Type" := l_recLeaseContractBillingSchedule2."Tender Type";
                    l_recLeaseContractBillingScheduleinsertTemp.insert;
                end else begin
                    // If the Sales invoice has already been created, reverse the schedule >>
                    If (l_recLeaseContractBillingSchedule2.Status <> l_recLeaseContractBillingSchedule2.Status::" ") OR (l_recLeaseContractBillingSchedule2."Stripe Invoice ID" <> '') then begin
                        l_intLineNo += 10000;
                        l_recLeaseContractBillingScheduleinsertTemp.init;
                        // Adjusting Positing Date >>
                        If WorkDate() < DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
                            l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := l_recLeaseContractBillingSchedule2."Posting Date";
                            l_recLeaseContractBillingScheduleinsertTemp."Due Date" := l_recLeaseContractBillingSchedule2."Due Date";
                        end else begin
                            l_recLeaseContractBillingScheduleinsertTemp."Posting Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
                            l_recLeaseContractBillingScheduleinsertTemp."Due Date" := 0D;
                        end;
                        // Adjusting Positing Date <<
                        l_recLeaseContractBillingScheduleinsertTemp."Line No." := l_intLineNo;
                        // l_recLeaseContractBillingScheduleinsertTemp."Contract End Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
                        l_recLeaseContractBillingScheduleinsertTemp."Contract End Date" := l_recLeaseContractBillingSchedule2."Contract End Date";
                        l_recLeaseContractBillingScheduleinsertTemp."No. of Days Current Month" := calcDate('1M-1D', l_recLeaseContractBillingSchedule2."Contract Start Date") - l_recLeaseContractBillingSchedule2."Contract Start Date" + 1;
                        l_recLeaseContractBillingScheduleinsertTemp."Contract Start Date" := l_recLeaseContractBillingSchedule2."Contract Start Date";
                        l_recLeaseContractBillingScheduleinsertTemp."Contract Line No." := 0;
                        l_recLeaseContractBillingScheduleinsertTemp."Contract No." := p_recLeaseContractHeader."No.";
                        l_recLeaseContractBillingScheduleinsertTemp."No. of Days to Bill" := l_recLeaseContractBillingSchedule2."No. of Days to Bill";
                        l_recLeaseContractBillingScheduleinsertTemp.Amount := -(l_recLeaseContractBillingSchedule2.Amount);
                        //l_recLeaseContractBillingScheduleinsertTemp."Amount Excluding VAT" := -(l_recLeaseContractBillingSchedule2."Amount Excluding VAT");
                        l_recLeaseContractBillingScheduleinsertTemp.Status := l_recLeaseContractBillingScheduleinsertTemp.Status::" ";
                        l_recLeaseContractBillingScheduleinsertTemp.Type := l_recLeaseContractBillingSchedule2.Type::Rent;
                        l_recLeaseContractBillingScheduleinsertTemp."Customer No." := p_recLeaseContractHeader."Customer No.";
                        l_recLeaseContractBillingScheduleinsertTemp."Sub-Type" := l_recLeaseContractBillingSchedule2."Sub-Type";
                        l_recLeaseContractBillingScheduleinsertTemp."Tender Type" := l_recLeaseContractBillingSchedule2."Tender Type";
                        l_recLeaseContractBillingScheduleinsertTemp.insert;
                    end;
                    // If the Sales invoice has already been created, reverse the schedule <<
                    Recalculatediscountbillingperiod(p_recLeaseContractHeader, l_recLeaseContractBillingSchedule2)
                end;
            until l_recLeaseContractBillingSchedule2.next = 0;
            l_recLeaseContractBillingScheduleinsertTemp.SetRange("Contract No.", p_recLeaseContractHeader."No.");
            If l_recLeaseContractBillingScheduleinsertTemp.FindSet then begin
                repeat
                    l_recLeaseContractBillingScheduleInsert2.copy(l_recLeaseContractBillingScheduleinsertTemp);
                    l_recLeaseContractBillingScheduleInsert2.insert;
                until l_recLeaseContractBillingScheduleinsertTemp.next = 0;
            end;
        end;
    end;

    procedure Recalculatebillingperiod(p_recLeaseContractHeader: Record "Lease Contract Header"; l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.")
    var
        l_recLeaseContractBillingScheduleinsertTemp2: Record "Lease Contract Billing Sched." temporary;
        l_recLeaseContractBillingScheduleInsert2: Record "Lease Contract Billing Sched.";
    begin
        // Message('%1', l_recLeaseContractBillingSchedule."Line No.");
        Clear(l_recLeaseContractBillingScheduleinsertTemp2);
        l_recLeaseContractBillingScheduleInsert2.reset;
        l_intLineNo += 10000;
        l_recLeaseContractBillingScheduleinsertTemp2.Init();
        l_recLeaseContractBillingScheduleinsertTemp2."Document No." := '';
        l_recLeaseContractBillingScheduleinsertTemp2."Line No." := l_intLineNo;
        // Adjusting Positing Date >>
        If WorkDate() < DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
            l_recLeaseContractBillingScheduleinsertTemp2."Posting Date" := l_recLeaseContractBillingSchedule."Posting Date";
            l_recLeaseContractBillingScheduleinsertTemp2."Due Date" := l_recLeaseContractBillingSchedule."Due Date";
        end else begin
            l_recLeaseContractBillingScheduleinsertTemp2."Posting Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
            l_recLeaseContractBillingScheduleinsertTemp2."Due Date" := 0D;
        end;
        // Adjusting Positing Date <<

        l_recLeaseContractBillingScheduleinsertTemp2."Tender Type" := l_recLeaseContractBillingSchedule."Tender Type";
        l_recLeaseContractBillingScheduleinsertTemp2."Customer No." := p_recLeaseContractHeader."Customer No.";
        l_recLeaseContractBillingScheduleinsertTemp2."Contract End Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
        l_recLeaseContractBillingScheduleinsertTemp2."No. of Days Current Month" := calcDate('1M-1D', l_recLeaseContractBillingSchedule."Contract Start Date") - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;
        l_recLeaseContractBillingScheduleinsertTemp2."Contract Start Date" := l_recLeaseContractBillingSchedule."Contract Start Date";
        l_recLeaseContractBillingScheduleinsertTemp2."Contract Line No." := l_recLeaseContractBillingSchedule."Contract Line No.";
        l_recLeaseContractBillingScheduleinsertTemp2."Contract No." := l_recLeaseContractBillingSchedule."Contract No.";
        l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill" := DT2date(p_recLeaseContractHeader."Contract Termination Date") - l_recLeaseContractBillingSchedule."Contract Start Date" + 1;
        // Rent Amount >>
        case p_recLeaseContractHeader."Payment Type" of
            p_recLeaseContractHeader."Payment Type"::Monthly:
                begin
                    l_recLeaseContractBillingScheduleinsertTemp2.Amount := (p_recLeaseContractHeader."Monthly Rent" * l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill" / l_recLeaseContractBillingScheduleinsertTemp2."No. of Days Current Month");
                end;
            p_recLeaseContractHeader."Payment Type"::"Pre-paid":
                begin
                    l_recLeaseContractBillingScheduleinsertTemp2.Amount := (p_recLeaseContractHeader."Monthly Rent" * l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill" / l_recLeaseContractBillingScheduleinsertTemp2."No. of Days Current Month");
                end;
            p_recLeaseContractHeader."Payment Type"::"One-off (ShortStay)":
                begin
                    //Message('%1', 'shortstay');
                    l_recLeaseContractBillingScheduleinsertTemp2.Amount := p_recLeaseContractHeader."Daily Rent" * l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill";
                end;
        end;
        //<<
        // l_recLeaseContractBillingScheduleinsertTemp2."Amount Excluding VAT" := (p_recLeaseContractHeader.Price * l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill" / l_recLeaseContractBillingScheduleinsertTemp2."No. of Days Current Month");
        l_recLeaseContractBillingScheduleinsertTemp2.Status := l_recLeaseContractBillingScheduleinsertTemp2.Status::" ";
        l_recLeaseContractBillingScheduleinsertTemp2.Type := l_recLeaseContractBillingSchedule.Type::Rent;
        l_recLeaseContractBillingScheduleinsertTemp2.insert;

        l_recLeaseContractBillingScheduleinsertTemp2.SetRange("Contract No.", p_recLeaseContractHeader."No.");
        If l_recLeaseContractBillingScheduleinsertTemp2.FindSet then begin
            repeat
                l_recLeaseContractBillingScheduleInsert2.copy(l_recLeaseContractBillingScheduleinsertTemp2);
                l_recLeaseContractBillingScheduleInsert2.insert;
            until l_recLeaseContractBillingScheduleinsertTemp2.next = 0;
        end;

    end;

    procedure Recalculatediscountbillingperiod(p_recLeaseContractHeader: Record "Lease Contract Header"; l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.")
    var
        l_recLeaseContractBillingScheduleinsertTemp2: Record "Lease Contract Billing Sched.";
    begin
        Clear(l_recLeaseContractBillingScheduleinsertTemp2);
        l_intLineNo += 10000;
        // Adjusting Positing Date >>
        If WorkDate() < DT2date(p_recLeaseContractHeader."Contract Termination Date") then begin
            l_recLeaseContractBillingScheduleinsertTemp2."Posting Date" := l_recLeaseContractBillingSchedule2."Posting Date";
            l_recLeaseContractBillingScheduleinsertTemp2."Due Date" := l_recLeaseContractBillingSchedule2."Due Date";
        end else begin
            l_recLeaseContractBillingScheduleinsertTemp2."Posting Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
            l_recLeaseContractBillingScheduleinsertTemp2."Due Date" := 0D;
        end;
        // Adjusting Positing Date >>

        l_recLeaseContractBillingScheduleinsertTemp2."Customer No." := p_recLeaseContractHeader."Customer No.";
        l_recLeaseContractBillingScheduleinsertTemp2."Line No." := l_intLineNo;
        l_recLeaseContractBillingScheduleinsertTemp2."Contract End Date" := DT2date(p_recLeaseContractHeader."Contract Termination Date");
        l_recLeaseContractBillingScheduleinsertTemp2."No. of Days Current Month" := l_recLeaseContractBillingSchedule2."No. of Days Current Month";
        l_recLeaseContractBillingScheduleinsertTemp2."Contract Start Date" := l_recLeaseContractBillingSchedule2."Contract Start Date";
        l_recLeaseContractBillingScheduleinsertTemp2."Contract Line No." := 0;
        l_recLeaseContractBillingScheduleinsertTemp2."Contract No." := p_recLeaseContractHeader."No.";
        l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill" := DT2date(p_recLeaseContractHeader."Contract Termination Date") - l_recLeaseContractBillingSchedule2."Contract Start Date" + 1;
        If l_recLeaseContractBillingSchedule2."Sub-Type" = 'MONTHLY DISCOUNT' then
            l_recLeaseContractBillingScheduleinsertTemp2.Amount := -(p_recLeaseContractHeader."Monthly Discount" * l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill" / l_recLeaseContractBillingScheduleinsertTemp2."No. of Days Current Month")
        else
            l_recLeaseContractBillingScheduleinsertTemp2.Amount := -(l_recLeaseContractBillingSchedule2.Amount * l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill" / l_recLeaseContractBillingScheduleinsertTemp2."No. of Days Current Month");

        // l_recLeaseContractBillingScheduleinsertTemp2."Amount Excluding VAT" := -(l_recLeaseContractBillingScheduleinsertTemp."Amount Excluding VAT" * l_recLeaseContractBillingScheduleinsertTemp2."No. of Days to Bill" / l_recLeaseContractBillingScheduleinsertTemp2."No. of Days Current Month");
        l_recLeaseContractBillingScheduleinsertTemp2.Status := l_recLeaseContractBillingScheduleinsertTemp2.Status::" ";
        l_recLeaseContractBillingScheduleinsertTemp2.Type := l_recLeaseContractBillingScheduleinsertTemp2.Type::Rent;
        l_recLeaseContractBillingScheduleinsertTemp2."Sub-Type" := l_recLeaseContractBillingSchedule2."Sub-Type";
        l_recLeaseContractBillingScheduleinsertTemp2.insert;

    end;


    //>> Refund Discount (to be deleted)>>
    procedure RefundOneoffdiscount2(p_recLeaseContractHeader: Record "Lease Contract Header"; l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched."; l_recLeaseContractBillingScheduleinsert: Record "Lease Contract Billing Sched.")
    var
        l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.";
        l_recLeaseContractBillingScheduleinsert2: Record "Lease Contract Billing Sched.";
    begin
        l_intLineNo := l_recLeaseContractBillingScheduleinsert."Line No.";

        l_recLeaseContractBillingSchedule2.Reset();
        l_recLeaseContractBillingSchedule2.SetRange("Contract No.", l_recLeaseContractBillingScheduleinsert."Contract No.");
        l_recLeaseContractBillingSchedule2.SetRange(Type, l_recLeaseContractBillingSchedule2.type::Rent);
        l_recLeaseContractBillingSchedule2.SetRange("Contract Start Date", l_recLeaseContractBillingScheduleinsert."Contract Start Date");
        //l_recLeaseContractBillingSchedule2.SetRange("Contract End Date", l_recLeaseContractBillingScheduleinsert."Contract End Date");
        l_recLeaseContractBillingSchedule2.SetFilter("Sub-Type", '<>%1', '');
        If l_recLeaseContractBillingSchedule2.findset then
            repeat
                l_intLineNo += 10000;
                // Message('%1', l_intLineNo);
                l_recLeaseContractBillingScheduleInsert2.init;
                l_recLeaseContractBillingScheduleInsert2."Customer No." := p_recLeaseContractHeader."Customer No.";
                l_recLeaseContractBillingScheduleInsert2."Line No." := l_intLineNo;
                l_recLeaseContractBillingScheduleInsert2."Posting Date" := l_recLeaseContractBillingSchedule2."Posting Date";
                l_recLeaseContractBillingScheduleInsert2."Contract Start Date" := l_recLeaseContractBillingSchedule2."Contract Start Date";
                l_recLeaseContractBillingScheduleInsert2."Contract End Date" := l_recLeaseContractBillingSchedule2."Contract End Date";
                l_recLeaseContractBillingScheduleInsert2."Due Date" := 0D;
                l_recLeaseContractBillingScheduleInsert2."Contract Line No." := l_recLeaseContractBillingScheduleinsert."Contract Line No.";
                l_recLeaseContractBillingScheduleInsert2."Contract No." := l_recLeaseContractBillingScheduleinsert."Contract No.";
                l_recLeaseContractBillingScheduleInsert2."No. of Days Current Month" := l_recLeaseContractBillingScheduleinsert."No. of Days Current Month";
                l_recLeaseContractBillingScheduleInsert2."No. of Days to Bill" := l_recLeaseContractBillingScheduleinsert."No. of Days to Bill";
                l_recLeaseContractBillingScheduleInsert2.Amount := Abs(l_recLeaseContractBillingSchedule2.Amount * l_recLeaseContractBillingScheduleinsert."No. of Days to Bill" / l_recLeaseContractBillingScheduleinsert."No. of Days Current Month");
                // l_recLeaseContractBillingScheduleInsert2."Amount Excluding VAT" := Abs(l_recLeaseContractBillingSchedule2."Amount Excluding VAT" * l_recLeaseContractBillingScheduleinsert."No. of Days to Bill" / l_recLeaseContractBillingScheduleinsert."No. of Days Current Month");
                l_recLeaseContractBillingScheduleInsert2."Document No." := '';
                l_recLeaseContractBillingScheduleInsert2.Status := l_recLeaseContractBillingSchedule2.Status::" ";
                l_recLeaseContractBillingScheduleInsert2.Type := l_recLeaseContractBillingSchedule2.Type::Rent;
                l_recLeaseContractBillingScheduleInsert2."Sub-Type" := l_recLeaseContractBillingSchedule2."Sub-Type";
                l_recLeaseContractBillingScheduleInsert2.insert;
            until l_recLeaseContractBillingSchedule2.next = 0;
    end;
    //(to be deleted) <<

    Procedure InsertRefundDeposit(p_recLeaseContractHeader: Record "Lease Contract Header"; g_deposit: Decimal)
    var
        l_recLeaseContractBillingScheduleTemp: Record "Lease Contract Billing Sched." temporary;
        l_recLeaseContractBillingScheduleInsert: Record "Lease Contract Billing Sched.";
    begin
        Clear(l_recLeaseContractBillingScheduleTemp);
        l_recLeaseContractBillingScheduleInsert.reset;
        If g_deposit <> 0 then begin
            l_intLineNo += 10000;
            l_recLeaseContractBillingScheduleTemp.init;
            l_recLeaseContractBillingScheduleTemp."Contract No." := p_recLeaseContractHeader."No.";
            l_recLeaseContractBillingScheduleTemp."Customer No." := p_recLeaseContractHeader."Customer No.";
            l_recLeaseContractBillingScheduleTemp.Type := l_recLeaseContractBillingScheduleTemp.type::Deposit;
            l_recLeaseContractBillingScheduleTemp."Posting Date" := CalcDate('+2D', DT2DATE(p_recLeaseContractHeader."Contract End Date"));
            l_recLeaseContractBillingScheduleTemp.Amount := -g_deposit;
            //l_recLeaseContractBillingScheduleTemp."Amount Excluding VAT" := -g_deposit;
            l_recLeaseContractBillingScheduleTemp."Line No." := l_intLineNo;
            l_recLeaseContractBillingScheduleTemp.insert;
            l_recLeaseContractBillingScheduleInsert.copy(l_recLeaseContractBillingScheduleTemp);
            l_recLeaseContractBillingScheduleInsert.insert;
        end
    end;


    Procedure DeletetheOriginalTermSched(p_recLeaseContractHeader: Record "Lease Contract Header")
    l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.";

    begin
        //Delete the Billing Schedule which the termination date with the period 
        If p_recLeaseContractHeader."Payment Type" = p_recLeaseContractHeader."Payment Type"::Monthly then begin
            l_recLeaseContractBillingSchedule.reset;
            l_recLeaseContractBillingSchedule.setrange("Contract No.", p_recLeaseContractHeader."No.");
            l_recLeaseContractBillingSchedule.SetRange(Status, l_recLeaseContractBillingSchedule.Status::" ");
            l_recLeaseContractBillingSchedule.SetFilter("Contract Start Date", '<=%1', DT2DATE(p_recLeaseContractHeader."Contract Termination Date"));
            l_recLeaseContractBillingSchedule.SetFilter("Contract End Date", '>%1', DT2DATE(p_recLeaseContractHeader."Contract Termination Date"));
            l_recLeaseContractBillingSchedule.SetRange(Type, l_recLeaseContractBillingSchedule.type::Rent);
            l_recLeaseContractBillingSchedule.SetRange("Stripe Invoice ID", ' ');
            l_recLeaseContractBillingSchedule.SetFilter("Line No.", '<=%1', g_intoriginalLineNo);
            l_recLeaseContractBillingSchedule.DeleteAll();
        end;
    end;

    Procedure InsertVATAmount(p_recLeaseContractHeader: Record "Lease Contract Header"): Decimal
    var
        l_recCustomer: Record "Customer";
        l_recVatPostingSetup: Record "VAT Posting Setup";
    begin
        l_recCustomer.reset;
        l_recVatPostingSetup.reset;
        l_recCustomer.setrange("No.", p_recLeaseContractHeader."Customer No.");
        If l_recCustomer.FindFirst then begin
            If l_recCustomer."VAT Bus. Posting Group" <> '' then begin
                l_recVatPostingSetup.SetRange("VAT Bus. Posting Group", l_recCustomer."VAT Bus. Posting Group");
                l_recVatPostingSetup.Findfirst;
                Exit(l_recVatPostingSetup."VAT %");
            end;
        end
    end;


    Procedure InsertTenderType(p_recLeaseContractHeader: Record "Lease Contract Header"; l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.")
    var
        l_recLeaseContractBillingSchedule2: Record "Lease Contract Billing Sched.";
    begin
        l_recLeaseContractBillingSchedule2.reset;
        If l_recLeaseContractBillingSchedule."Contract Start Date" = DT2date(p_recLeaseContractHeader."Contract Start Date") then begin
            If (p_recLeaseContractHeader."Tender Type" <> '') and (p_recLeaseContractHeader."Tender Type Discount Amount" <> 0) then begin
                l_recLeaseContractBillingSchedule2.init;
                l_intLineNo += 10000;
                l_recLeaseContractBillingSchedule2."Customer No." := p_recLeaseContractHeader."Customer No.";
                l_recLeaseContractBillingSchedule2."Contract No." := p_recLeaseContractHeader."No.";
                l_recLeaseContractBillingSchedule2.Type := l_recLeaseContractBillingSchedule2.Type::Rent;
                l_recLeaseContractBillingSchedule2."Sub-Type" := 'Tender Type Discount';
                l_recLeaseContractBillingSchedule2."Contract Start Date" := l_recLeaseContractBillingSchedule."Contract Start Date";
                l_recLeaseContractBillingSchedule2."Due Date" := l_recLeaseContractBillingSchedule."Due Date";
                l_recLeaseContractBillingSchedule2."Posting Date" := l_recLeaseContractBillingSchedule."Posting Date";
                l_recLeaseContractBillingSchedule2."Contract End Date" := l_recLeaseContractBillingSchedule."Contract End Date";
                l_recLeaseContractBillingSchedule2."No. of Days Current Month" := l_recLeaseContractBillingSchedule."No. of Days Current Month";
                l_recLeaseContractBillingSchedule2."No. of Days to Bill" := l_recLeaseContractBillingSchedule."No. of Days to Bill";
                l_recLeaseContractBillingSchedule2."Tender Type" := p_recLeaseContractHeader."Tender Type";
                l_recLeaseContractBillingSchedule2.Amount := -p_recLeaseContractHeader."Tender Type Discount Amount";
                l_recLeaseContractBillingSchedule2."Stripe Invoice ID" := p_recLeaseContractHeader."1st Payment Stripe Invoice ID";
                l_recLeaseContractBillingSchedule2."Line No." := l_intLineNo;
                l_recLeaseContractBillingSchedule2.Insert();

            end;

        end;
    end;

    var
        l_intLineNo: Integer;
        g_deposit: Decimal;

        g_vatpercentage: Decimal;

        g_intoriginalLineNo: Integer;




}
