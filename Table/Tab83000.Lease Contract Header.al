table 83000 "Lease Contract Header"
{
    Caption = 'Lease Contract Header';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Key"; Guid)
        {
            Caption = 'Key';
            DataClassification = SystemMetadata;
        }
        field(2; "No."; Code[100])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(3; "Contract Name"; Text[250])
        {
            Caption = 'Contract Name';
            DataClassification = SystemMetadata;
        }

        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = SystemMetadata;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                l_recCustomer: Record Customer;
            begin
                if l_recCustomer.get("Customer No.") then begin
                    "Customer Name" := l_recCustomer.Name;
                    "Customer Address" := l_recCustomer.Address;
                    "Customer Address 2" := l_recCustomer."Address 2";
                    "Customer City" := l_recCustomer.City;
                    "Customer Post Code" := l_recCustomer."Post Code";
                    "Customer Country/Region Code" := l_recCustomer."Country/Region Code";
                    l_recCustomer.Modify();
                end;
            end;

        }
        field(5; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(6; "Customer Address"; Text[100])
        {
            Caption = 'Customer Address';
            DataClassification = CustomerContent;
        }
        field(7; "Customer Address 2"; Text[100])
        {
            Caption = 'Customer Address 2';
            DataClassification = CustomerContent;
        }
        field(8; "Customer City"; Text[50])
        {
            DataClassification = ToBeClassified;

            TableRelation = IF ("Customer Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Customer Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Customer Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                l_txtCounty: Text;
            begin
                PostCode.LookupPostCode("Customer City", "Customer Post Code", l_txtCounty, "Customer Country/Region Code");
            end;

            trigger OnValidate()
            var
                l_txtCounty: Text;
            begin
                PostCode.ValidateCity("Customer City", "Customer Post Code", l_txtCounty, "Customer Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;

        }
        field(9; "Customer Post Code"; Code[20])
        {
            Caption = 'Customer Post Code';
            DataClassification = CustomerContent;
        }
        field(10; "Customer Country/Region Code"; Code[20])
        {
            Caption = 'Customer Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            var
                l_txtCounty: Text;
            begin
                PostCode.CheckClearPostCodeCityCounty("Customer City", "Customer Post Code", l_txtCounty, "Customer Country/Region Code", xRec."Customer Country/Region Code");
            end;
        }
        field(15; "Payment Terms Code"; Code[20])
        {
            Caption = 'Payment Terms Code';
            DataClassification = SystemMetadata;
        }
        field(18; "Automatically Extend"; Boolean)
        {
            Caption = 'Automatically Extend';
            DataClassification = SystemMetadata;
        }
        field(20; "Contract Start Date"; DateTime)
        {
            Caption = 'Contract Start Date';
            DataClassification = SystemMetadata;
        }
        field(22; "Contract End Date"; DateTime)
        {
            Caption = 'Contract End Date';
            DataClassification = SystemMetadata;
        }
        field(23; "Property CRMGuid"; Guid)
        {
            Caption = 'Property CRMGuid'; // Room Guid
            DataClassification = SystemMetadata;

            trigger OnValidate()
            var
                l_recPropertyRoomUnit: Record "Property Unit";
                l_recPropertyUnit: Record "Property Unit";
            begin
                l_recPropertyRoomUnit.Reset();
                l_recPropertyRoomUnit.SetRange("CRM GUID", "Property CRMGuid");
                If l_recPropertyRoomUnit.FindFirst() then begin
                    //Room Information >>
                    "Room No." := l_recPropertyRoomUnit."Room No.";
                    "Room Name" := l_recPropertyRoomUnit.Description;
                    "Room Type" := l_recPropertyRoomUnit."Room Type Name";
                    "Property No." := l_recPropertyRoomUnit."Property No.";
                    //Room Information <<

                    if l_recPropertyUnit.Get(l_recPropertyRoomUnit."Property No.") then
                        "Property Name" := l_recPropertyUnit.Description; // Building Information

                end;
            end;

        }
        field(25; "Property No."; Code[20])
        {
            Caption = 'Property No.';
            DataClassification = SystemMetadata;
            TableRelation = "Property Unit"."No.";
        }
        field(30; "Deposit Amount"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            DataClassification = SystemMetadata;
        }


        field(31; "New Contract Start Date"; Datetime) { DataClassification = ToBeClassified; Caption = 'New Contract Start Date'; }


        field(32; "New Contract End Date"; Datetime)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Contract End Date';
            trigger OnValidate()
            var
                l_recBillingSchedule: Record "Lease Contract Billing Sched.";
            begin
                l_recBillingSchedule.SetRange("Contract No.", Rec."No.");
                l_recBillingSchedule.setrange(Type, l_recBillingSchedule.Type::Deposit);
                l_recBillingSchedule.setrange(Status, l_recBillingSchedule.Status::" ");
                l_recBillingSchedule.setrange("Stripe Invoice ID", '');
                l_recBillingSchedule.SetFilter(Amount, '<%1', 0);
                If l_recBillingSchedule.Findset() then begin
                    repeat
                        l_recBillingSchedule."Posting Date" := CalcDate('+2D', DT2Date("New Contract End Date"));
                        l_recBillingSchedule.Modify();
                    until l_recBillingSchedule.next = 0;
                end;
            end;

        }

        field(35; "Contract Termination Date"; DateTime)
        {
            Caption = 'Contract Termination Date';
            DataClassification = ToBeClassified;
        }
        field(38; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(40; "Monthly Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }

        field(45; "One off Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }

        field(46; "Latest Deposit Amount"; Decimal)
        {


        }
        field(50; "Net Amount"; Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(51; "Promotion CRMGuid"; Guid)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                l_recCRMPropertybooking: Record "CDS acwapp_propertybooking";
            begin
                l_recCRMPropertybooking.setrange(acwapp_promotioncode, "Promotion CRMGuid");
                If l_recCRMPropertybooking.FindFirst() then
                    "Promotion Code" := l_recCRMPropertybooking.acwapp_promotioncodeName;
            end;
        }
        field(52; "Promotion Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Promotion Code type"; Option)
        {
            OptionMembers = " ",FirstMonth,Monthly;
            DataClassification = ToBeClassified;
        }

        field(56; "Promotion Deduction Type"; Option)
        {

            OptionMembers = " ",ByPercentage,ByExactDollarValue;
            DataClassification = ToBeClassified;
        }
        field(57; "Promotion Amount / %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(60; "Payment Type"; Option)
        {
            OptionMembers = " ","Pre-paid","One-off (ShortStay)",Monthly;
            DataClassification = ToBeClassified;
        }
        field(65; "Prepaid Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(74; "External Payment Gateway"; Enum "External Payment Gateway")
        {
            DataClassification = ToBeClassified;
        }
        field(75; "1st Payment Stripe Invoice ID"; Text[250])
        {
            Caption = '1st Payment Stripe/QFPay Invoice ID';
            DataClassification = ToBeClassified;
        }
        field(80; Price; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(82; "Net Amount include VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Unit".Description where("CRM GUID" = Field("Property CRMGuid"));
        }
        field(90; "Room Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Property Unit"."Room Type Name" where("CRM GUID" = Field("Property CRMGuid"));
        }
        field(95; "Room No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Property Unit"."Room No." where("CRM GUID" = Field("Property CRMGuid"));
        }
        field(100; "Room Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(105; "Run Terminated Billing Sched."; Datetime)
        {
            DataClassification = ToBeClassified;
        }
        field(106; "Car Park No."; Code[50])
        {
            trigger OnValidate()
            begin
                // CreateSubscriptionService('CarPark');
            end;

        }
        field(107; "Car Park Start Date"; DateTime)
        {
            trigger OnValidate()
            begin
                if "New Contract Start Date" <> 0DT then
                    if "Car Park Start Date" < "New Contract Start Date" then
                        Error('The Car Park Start Date cannot be earlier than the New Contract Start Date.')
                    else
                        exit;

                if "Contract Start Date" <> 0DT then
                    if "Car Park Start Date" < "Contract Start Date" then
                        Error('The Car Park Start Date cannot be earlier than the Contract Start Date.');
            end;
        }
        field(108; "Car Park End Date"; DateTime)
        {
            trigger OnValidate()
            begin
                if "New Contract End Date" <> 0DT then
                    if "Car Park End Date" > "New Contract End Date" then
                        Error('The Car Park End Date cannot be later than the New Contract End Date.')
                    else
                        exit;

                if "Contract End Date" <> 0DT then
                    if "Car Park End Date" > "Contract End Date" then
                        Error('The Car Park End Date cannot be later than the Contract End Date.');
            end;

        }

        field(110; "Property Unit"; Code[20])
        {
            Caption = 'Property Unit';
            DataClassification = ToBeClassified;
        }
        field(115; "Property Unit Name"; Code[100])
        {
            Caption = 'Property Unit Name';
            DataClassification = ToBeClassified;
        }

        field(116; "Locker No."; Code[50])
        {
            trigger OnValidate()
            begin
                // CreateSubscriptionService('Locker');
            end;

        }
        field(117; "Locker Start Date"; DateTime)
        {

            trigger OnValidate()
            begin
                if "New Contract Start Date" <> 0DT then
                    if "Locker Start Date" < "New Contract Start Date" then
                        Error('The Locker Start Date cannot be earlier than the New Contract Start Date.')
                    else
                        exit;

                if "Contract Start Date" <> 0DT then
                    if "Locker Start Date" < "Contract Start Date" then
                        Error('The Locker Start Date cannot be earlier than the Contract Start Date.');
            end;

        }
        field(118; "Locker End Date"; DateTime)
        {
            trigger OnValidate()
            begin
                if "New Contract End Date" <> 0DT then
                    if "Locker End Date" > "New Contract End Date" then
                        Error('The Car Park Start Date cannot be later than the New Contract Start Date.')
                    else
                        exit;


                if "Contract End Date" <> 0DT then
                    if "Locker End Date" > "Contract End Date" then
                        Error('The Car Park Start Date cannot be later than the Contract Start Date.');
            end;
        }

        field(120; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",ConfirmedWithRoomAllocated,"ReadyForCheck-in",Active,FinishedContract,Terminated,"Terminated(beforeMove-in)";
            OptionCaption = ' ,Confirmed With Room Allocated,Ready For Check-in,Active,Finished Contract,Terminated,Terminated (before Move-in)';
            DataClassification = SystemMetadata;
        }
        field(125; "Prepaid Discount"; Decimal)
        {
            Caption = 'Prepaid Discount';

            DataClassification = SystemMetadata;
        }


        field(130; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            DataClassification = SystemMetadata;
        }
        field(135; CompanyId; Guid)
        {
            Caption = 'Company ID';
            DataClassification = SystemMetadata;
        }
        field(140; "Daily Rent"; Decimal)
        {
            Caption = 'Daily Rent';
            DataClassification = SystemMetadata;
        }
        field(145; "Monthly Rent"; Decimal)
        {
            Caption = 'Monthly Rent';
            DataClassification = SystemMetadata;
        }
        field(150; "Final Amount"; Decimal)
        {
            Caption = 'Final Amount';
            DataClassification = SystemMetadata;
        }

        field(154; "Renewal Contract No."; code[100])
        {
            Editable = false;
            TableRelation = "Lease Contract Header"."No.";

        }

        field(155; "Deposit Returned"; Boolean)
        {
            Caption = 'Deposit Returned';
            DataClassification = SystemMetadata;
        }

        field(156; "Opening Contract"; Boolean)
        {
            Caption = 'Opening Contract';
            DataClassification = SystemMetadata;
        }


        field(157; "Renewal Contract"; Boolean) { }
        field(158; "Renewal Contract Datetime"; DateTime) { }
        field(159; "Original Contract No."; Code[100])
        {
            TableRelation = "Lease Contract Header"."No.";

        }

        field(160; "Billing Schedule Created"; Boolean)
        {
            Caption = 'Billing Scheduled Created';
            DataClassification = ToBeClassified;
        }

        field(165; "No. of Extra Charge"; Integer)
        {
            Caption = 'No. of Extra Charge';
            DataClassification = ToBeClassified;
        }
        field(170; "Tender Type Discount Amount"; Decimal)
        {
            Caption = 'Tender Type Discount Amount';
            DataClassification = ToBeClassified;
        }

        field(175; "Tender Type"; Code[20])
        {
            Caption = 'Tender Type';
            DataClassification = ToBeClassified;
        }

        field(180; "Commission Type"; Option)
        {
            Caption = 'Commission Type';
            OptionMembers = " ",DirectBooking,B2COutreach,B2BOutreach,B2CCompanyAssign,B2BRenewal,B2CRenewal,"B2CCompanyAssign-PropertyViewing(OperationTeam)","B2BOutreach-AgencyCommission";
            DataClassification = ToBeClassified;
        }
        field(185; "Salesperson Email"; Text[250])
        {
            Caption = 'Salesperson Email';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                l_recSalesperson: Record "Salesperson/Purchaser";
            begin
                l_recSalesperson.SetFilter("E-Mail", '%1', "Salesperson Email");
                If l_recSalesperson.FindFirst then begin
                    "Salesperson Code" := l_recSalesperson.Code;
                    "Salesperson Name" := l_recSalesperson.Name;
                end;
            end;
        }

        field(190; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(195; "Salesperson Name"; Text[50])
        {
            Caption = 'Salesperson Name';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Name;
        }
        //>> Add field for Commission
        field(200; "Viewing By"; Text[100])
        {
            Caption = 'Viewing By';
            DataClassification = ToBeClassified;
        }
        field(205; "Renewal By"; Text[100])
        {
            Caption = 'Renewal By';
            DataClassification = ToBeClassified;
        }

        //<< Add field for Commission





    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    var
        l_recLeaseContractSetup: Record "Lease Contract Setup";
        l_cduNoSeriesMgt: Codeunit NoSeriesManagement;
        l_cduRefreshBillingSched: Codeunit "Lease Contract Management";

    begin
        if "No." = '' then begin
            l_recLeaseContractSetup.get();
            l_recLeaseContractSetup.TestField("Contract No.");
            l_cduNoSeriesMgt.InitSeries(l_recLeaseContractSetup."Contract No.", xRec."No. Series", WorkDate(), "No.", "No. Series");
        end;
        //(Rec."Net Amount include VAT" - Rec."Final Amount")/;
        /*if (Status = Status::"ReadyForCheck-in") OR (Status = Status::ConfirmedWithRoomAllocated) OR (Status = Status::Active) then
            l_cduRefreshBillingSched.RefreshBillingSchedule(Rec, true);*/
    end;


    trigger OnDelete()
    var
        l_recBillingSchdeule: Record "Lease Contract Billing Sched.";
    begin
        l_recBillingSchdeule.Reset();
        l_recBillingSchdeule.SetFilter("Contract No.", "No.");
        l_recBillingSchdeule.SetFilter(Status, '<>%1', l_recBillingSchdeule.Status::" ");
        if l_recBillingSchdeule.Count > 0 then
            Error('Deletion of the contract is not permitted if an invoice has been created.');
    end;

    var
        PostCode: Record "Post Code";
}
