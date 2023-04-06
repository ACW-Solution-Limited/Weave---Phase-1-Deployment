table 83019 "Tender Type Discount"
{
    Caption = 'Tender Type Discount';
    DataClassification = ToBeClassified;
    Permissions = tabledata "Sales Invoice Header" = rimd;


    fields
    {

        field(1; "Key"; Guid)
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }

        field(2; "Stripe Status"; Text[50])
        {
            Caption = 'Stripe Status';
            DataClassification = ToBeClassified;
        }
        field(3; "Available On"; Integer)
        {
            Caption = 'Available On';
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            Caption = 'Billing Schedule';
            OptionMembers = " ",Inserted;
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';
            DataClassification = ToBeClassified;
        }
        field(7; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     l_reccustomer: Record Customer;
            // begin
            //     l_reccustomer.reset;
            //     l_reccustomer.get("Customer No.");
            //     "Customer Name" := l_reccustomer.Name;
            // end;

        }
        field(8; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        field(11; "Payment Amount"; Decimal)
        {
            Caption = 'Payment Amount';
            DataClassification = ToBeClassified;
        }
        field(12; "Sales Document Type"; Option)
        {
            Caption = 'Sales Document Type';
            OptionMembers = "",Invoice;
            DataClassification = ToBeClassified;
        }
        // field(13; "Sales Document No."; Code[20])
        // {
        //     Caption = 'Sales Document No.';
        //       DataClassification = ToBeClassified;
        // }
        field(14; "Stripe/QFPay Invoice ID"; Text[250])
        {
            Caption = 'Stripe/QFPay Invoice ID';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                l_cuEventSubscriber: Codeunit EventSubscriber;
            begin
                l_cuEventSubscriber.UpdateStripeQFPayInvoiceToDocument("Stripe/QFPay Invoice ID", "Sales Invoice No.");
            end;
        }
        field(15; "Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Stripe/QFPay Fee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


        field(18; "Payment Intent"; Text[250]) { DataClassification = ToBeClassified; }
        field(19; "Charge Id"; Text[250]) { DataClassification = ToBeClassified; }
        field(20; "Tender Type"; Code[20]) { DataClassification = ToBeClassified; }
        field(21; "Tender Discount Amount"; Decimal) { DataClassification = ToBeClassified; }
        field(22; "Sales Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                l_recSalesInvoice: Record "Sales Invoice Header";
            begin
                l_recSalesInvoice.reset;
                l_recSalesInvoice.Get("Sales Invoice No.");
                "Customer No." := l_recSalesInvoice."Sell-to Customer No.";
                "Customer Name" := l_recSalesInvoice."Sell-to Customer Name";
            end;
        }
        field(23; "Credit Memo No."; Code[20]) { DataClassification = ToBeClassified; }

        field(24; "Credit Memo Created Date"; DateTime) { DataClassification = ToBeClassified; }
        field(25; Id; Text[50])
        {
            Caption = 'Id';
            DataClassification = ToBeClassified;
        }

        field(26; "Contract No."; Code[100])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(27; "CompanyId"; Guid)
        {
            Caption = 'Company Id';
            DataClassification = ToBeClassified;
        }
        field(28; "Payment Reference ID"; Text[100])
        {
            Caption = 'Payment Reference ID';
            DataClassification = ToBeClassified;
        }
        field(29; "CurrencyId"; Guid)
        {
            Caption = 'CurrencyId';
            DataClassification = ToBeClassified;
        }

    }


    keys
    {
        key(PK;
        "key")
        {
            Clustered = true;
        }
        key(Key1; "Posting Date")
        { }
    }
    trigger OnInsert()
    var
        l_RecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        l_RecGeneralLedgerSetup.Get();
        "Currency Code" := l_RecGeneralLedgerSetup."LCY Code";
        "Sales Document Type" := "Sales Document Type"::Invoice;
    end;

}
