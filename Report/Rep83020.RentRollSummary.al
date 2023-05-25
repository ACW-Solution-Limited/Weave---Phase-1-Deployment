report 83020 "Rent Roll Summary"
{
    ApplicationArea = All;
    Caption = 'Rent Roll Summary';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layout/Rep83020.RentRollSummary.rdlc';


    dataset
    {
        dataitem(LeaseContractHeader; "Lease Contract Header")
        {
            column(StartDate; g_datStartDate) { }
            column(EndDate; g_datEndDate) { }
            column(GenerationDate; g_datGenerationDate) { }
            column(Building; g_txtBuildingName) { }
            column(Bedroom; "Room No.") { }
            column(BedroomType; "Room Type") { }
            column(RatePlan; g_txtRatePlan) { }
            column(BookingReference; "No.") { }
            column(BookingCreatedBy; "Salesperson Name") { }
            column(BookingAccountCode; "Customer No.") { }
            column(BookingAccount; "Customer Name") { }
            column(BookingAccountType; g_txtBookingAccountType) { }
            column(PaymentType; "Payment Type") { }
            column(CheckInDay; g_datCheckInDay) { }
            column(CheckOutDay; g_datCheckOutDay) { }
            column(Status; Status) { }
            column(TotalStayPeriodPerLicenseAgreement; g_decTotalStayPeriodPerLicenseAgreement) { }
            column(RemainingStay; g_decRemainingStay) { }
            column(MonthlyRent; g_decMonthlyRent) { }
            column(ActualRent; g_decActualRent) { }
            column(OccupancyinPeriodDays; g_decOccupancyinPeriodDays) { }
            column(OccupancyDaysAdjusted; g_decOccupancyDaysAdjusted) { }
            column(GrossRevenueToBeRecognised; g_decGrossRevenueToBeRecognised) { }
            trigger OnPreDataItem()
            begin
                //    LeaseContractHeader.SetFilter("No.", '20221118-00002/6660');
            end;

            trigger OnAfterGetRecord()
            begin

                if LeaseContractHeader."Contract Start Date" > LeaseContractHeader."Contract End Date" then
                    CurrReport.Skip();

                g_datCheckInDay := GetCheckInDay();
                g_datCheckOutDay := GetChecOutDay();

                if (g_datCheckInDay = 0D) or (g_datCheckOutDay = 0D) then
                    CurrReport.Skip();

                if not RentalPeriodIsWithinStartEndDate(g_datCheckInDay, g_datCheckOutDay) then
                    CurrReport.Skip();


                g_txtBuildingName := GetBuildingName();
                g_txtRatePlan := '';

                g_txtBookingAccountType := GetCustomerPostingGroup("Customer No.");
                g_decTotalStayPeriodPerLicenseAgreement := CalcTotalStaryPeriodPerLicenseAgreement();
                g_decRemainingStay := CalcRemainingStay();

                g_decOccupancyinPeriodDays := CalcOccupancyInPeriod(g_datCheckInDay, g_datCheckOutDay);
                if g_decOccupancyinPeriodDays < 0 then
                    g_decOccupancyinPeriodDays := 0;

                if (g_decOccupancyinPeriodDays > g_datEndDate - g_datStartDate + 1) then
                    g_decOccupancyinPeriodDays := g_datEndDate - g_datStartDate + 1;

                g_decMonthlyRent := CalcMonthyRent();
                g_decActualRent := CalcActualRent(LeaseContractHeader, g_decOccupancyinPeriodDays);
                g_decOccupancyDaysAdjusted := g_decOccupancyinPeriodDays;
                g_decGrossRevenueToBeRecognised := g_decMonthlyRent * g_decOccupancyinPeriodDays / (g_datEndDate - g_datStartDate + 1);
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
                    field("Start Date"; g_datStartDate)
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            g_datEndDate := CalcDate('+1M', g_datStartDate);
                        end;
                    }
                    field("End Date"; g_datEndDate) { ApplicationArea = all; }
                }
            }

        }
        trigger OnOpenPage()
        begin

            g_datStartDate := WorkDate();
            g_datEndDate := CalcDate('+1M', g_datStartDate);
            g_datGenerationDate := WorkDate();

        end;

    }

    procedure RentalPeriodIsWithinStartEndDate(CheckInDate: Date; CheckOutDate: Date): Boolean
    begin

        if (CheckInDate >= g_datStartDate) AND (CheckOutDate <= g_datEndDate) then
            exit(true);

        if (CheckInDate <= g_datStartDate) AND (CheckOutDate >= g_datEndDate) then
            exit(true);

        if (CheckInDate >= g_datStartDate) and (CheckInDate <= g_datEndDate) then
            exit(true);

        if (CheckOutDate <= g_datEndDate) and (CheckOutDate >= g_datStartDate) then
            exit(true);

        exit(False);
    end;

    procedure GetBuildingName(): Text
    var
        l_recCompanyInformation: Record "Company Information";
    begin
        l_recCompanyInformation.Get;
        l_recCompanyInformation.TestField("Building Name");
        exit(l_recCompanyInformation."Building Name");



    end;

    procedure GetCheckInDay(): Date;
    begin
        if LeaseContractHeader."New Contract Start Date" <> 0DT then
            exit(DT2Date(LeaseContractHeader."New Contract Start Date"))
        else
            exit(DT2Date(LeaseContractHeader."Contract Start Date"))
    end;

    procedure GetChecOutDay(): Date;
    begin
        if LeaseContractHeader."Contract Termination Date" <> 0DT then
            exit(DT2Date(LeaseContractHeader."Contract Termination Date"));

        if LeaseContractHeader."New Contract End Date" <> 0DT then
            exit(DT2Date(LeaseContractHeader."New Contract End Date"));

        exit(DT2Date(LeaseContractHeader."Contract End Date"))
    end;

    procedure CalcOccupancyInPeriod(CheckInDate: Date; CheckOutDate: Date): Decimal
    begin
        if (CheckInDate >= g_datStartDate) AND (CheckOutDate <= g_datEndDate) then
            exit(CheckOutDate - CheckInDate + 1);

        if (CheckInDate <= g_datStartDate) AND (CheckOutDate >= g_datEndDate) then
            exit(CheckOutDate - CheckInDate + 1);

        if (CheckInDate >= g_datStartDate) and (CheckInDate <= g_datEndDate) then
            exit(g_datEndDate - CheckInDate + 1);

        if (CheckOutDate <= g_datEndDate) and (CheckOutDate >= g_datStartDate) then
            exit(CheckOutDate - g_datStartDate + 1);

        exit(0);

    end;




    procedure CalcTotalStaryPeriodPerLicenseAgreement(): Decimal
    begin
        if LeaseContractHeader."Payment Type" = LeaseContractHeader."Payment Type"::"One-off (ShortStay)" then
            exit(g_datCheckOutDay - g_datCheckInDay)
        else
            exit(g_datCheckOutDay - g_datCheckInDay + 1);
    end;

    procedure CalcRemainingStay(): Decimal
    begin
        if (g_datCheckOutDay - g_datEndDate) > 0 then
            exit(g_datCheckOutDay - g_datEndDate)
        else
            exit(0)
    end;


    procedure GetCustomerPostingGroup(CustomerNo: Code[50]): Text
    var
        l_recCustomer: Record Customer;
    begin
        if l_recCustomer.Get(CustomerNo) then
            exit(l_recCustomer."Customer Posting Group")
        else
            exit('');
    end;

    procedure CalcMonthyRent(): Decimal
    begin

        if (LeaseContractHeader."Payment Type" = LeaseContractHeader."Payment Type"::Monthly) or
         (LeaseContractHeader."Payment Type" = LeaseContractHeader."Payment Type"::"Pre-paid") then
            exit(LeaseContractHeader."Monthly Rent")
        else
            exit(LeaseContractHeader."Daily Rent" * Date2DMY(CalcDate('CM', g_datStartDate), 1));

    end;

    procedure CalcActualRent(LeaseContractHeader: Record "Lease Contract Header"; OccupancyinPeriodDays: Decimal): Decimal
    var
        l_recBillingSchedule: Record "Lease Contract Billing Sched.";
        l_dateCalculationStart: Date;
        l_decActualRent: Decimal;
    begin
        if LeaseContractHeader."Payment Type" = LeaseContractHeader."Payment Type"::"One-off (ShortStay)" then
            exit(LeaseContractHeader."Net Amount" / (DT2Date(LeaseContractHeader."Contract End Date") - DT2Date(LeaseContractHeader."Contract Start Date") + 1) * OccupancyinPeriodDays);


        l_decActualRent := 0;
        if g_datStartDate > DT2Date(LeaseContractHeader."Contract Start Date") then
            l_dateCalculationStart := g_datStartDate
        else
            l_dateCalculationStart := DT2Date(LeaseContractHeader."Contract Start Date");

        repeat
            l_recBillingSchedule.Reset();
            l_recBillingSchedule.SetCurrentKey("Contract Start Date");
            l_recBillingSchedule.SetAscending("Contract Start Date", true);
            l_recBillingSchedule.SetRange(l_recBillingSchedule.Type, l_recBillingSchedule.Type::Rent);
            l_recBillingSchedule.SetFilter(l_recBillingSchedule."Contract No.", LeaseContractHeader."No.");
            // l_recBillingSchedule.SetFilter("Contract Start Date", '..%1', l_dateCalculationStart);
            l_recBillingSchedule.SetFilter("Contract End Date", '>%1', l_dateCalculationStart);

            if l_recBillingSchedule.Count = 0 then
                exit(l_decActualRent);

            if l_recBillingSchedule.FindFirst() then begin

                if g_datEndDate > l_recBillingSchedule."Contract End Date" then begin
                    if LeaseContractHeader."Monthly Rent" <> 0 then
                        l_decActualRent += (LeaseContractHeader."Monthly Rent" - LeaseContractHeader."Monthly Discount") / l_recBillingSchedule."No. of Days Current Month" *
                                         (l_recBillingSchedule."Contract End Date" - l_dateCalculationStart + 1);
                    l_dateCalculationStart := l_recBillingSchedule."Contract End Date" + 1;

                end else begin
                    if LeaseContractHeader."Monthly Rent" <> 0 then
                        l_decActualRent += (LeaseContractHeader."Monthly Rent" - LeaseContractHeader."Monthly Discount") / l_recBillingSchedule."No. of Days Current Month" *
                                                             (g_datEndDate - l_dateCalculationStart + 1);
                    l_dateCalculationStart := g_datEndDate + 1;

                end;

            end;

        until l_dateCalculationStart >= g_datEndDate;
        exit(l_decActualRent);
    end;



    var

        g_datStartDate: Date;
        g_datEndDate: Date;
        g_datGenerationDate: Date;
        g_txtBuildingName: Text;
        g_txtRatePlan: Text;
        g_txtPaymentType: Text;
        g_txtBookingAccountType: Text;
        g_datCheckInDay: Date;
        g_datCheckOutDay: Date;
        g_decTotalStayPeriodPerLicenseAgreement: Decimal;
        g_decRemainingStay: Decimal;
        g_decMonthlyRent: Decimal;
        g_decActualRent: Decimal;
        g_decOccupancyinPeriodDays: Decimal;
        g_decOccupancyDaysAdjusted: Decimal;
        g_decGrossRevenueToBeRecognised: Decimal;


}
