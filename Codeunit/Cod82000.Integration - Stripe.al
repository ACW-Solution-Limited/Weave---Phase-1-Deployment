codeunit 82000 Stripe
{
    Permissions = tabledata "Sales Invoice Header" = rimd,
                  tabledata "Sales Cr.Memo Header" = rimd;

    TableNo = "Payment Reporting Argument";

    trigger OnRun()
    var
        DocumentRecordRef: RecordRef;
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
        l_txtTargetURL: Text;
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
    begin
        if l_recStripePaymentSetup.get and l_recStripePaymentSetup.Enabled then begin
            DocumentRecordRef.get(rec."Document Record ID");

            l_recSalesInvoiceHeader.SetPosition(DocumentRecordRef.GetPosition());
            if l_recSalesInvoiceHeader.find('=') then begin
                if l_recSalesInvoiceHeader."Stripe Payment Link" = '' THEN begin
                    SendSalesInvoiceToStripe(l_recSalesInvoiceHeader, l_txtTargetURL);
                    rec.SetTargetURL(l_txtTargetURL);
                end else
                    rec.SetTargetURL(l_recSalesInvoiceHeader."Stripe Payment Link");
                rec.Logo := l_recStripePaymentSetup.Logo
            end;
        end;
    end;

    procedure CreateCustomer(p_txtName: Text; p_txtEmail: Text) r_txtStripeCustID: Text;

    var
        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_jtoken: JsonToken;

    begin
        GetAuth();
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', g_txtAuth);
        l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'customers';
        l_txtrequestUri := StrSubstNo('%1?name=%2&email=%3', l_txtAPIEndPoint, p_txtName, p_txtEmail);
        request.SetRequestUri(l_txtrequestUri);

        request.Method := 'POST';
        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);
        l_responseJsonObject.SelectToken('id', l_jtoken);
        r_txtStripeCustID := l_jtoken.AsValue().AsText();
        Exit(r_txtStripeCustID);
    end;

    procedure CreateInvoice(p_txtStripeCustID: Text; p_codCurrency: Code[10]): Text;
    var

        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;

        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;

        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_jtoken: JsonToken;

        l_txtStripeInvoiceID: Text;
    begin
        GetAuth();
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', g_txtAuth);
        l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'invoices';
        l_txtrequestUri := StrSubstNo('%1?customer=%2&currency=%3', l_txtAPIEndPoint, p_txtStripeCustID, p_codCurrency);
        request.SetRequestUri(l_txtrequestUri);
        request.Method := 'POST';
        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);
        l_responseJsonObject.SelectToken('id', l_jtoken);
        l_txtStripeInvoiceID := l_jtoken.AsValue().AsText();
        exit(l_txtStripeInvoiceID);
    end;

    procedure CreateInvoiceItem(p_txtStripeCustID: Text; p_txtStripeInvID: Text; p_txtDesc: Text; p_intQty: Integer; p_decUnitAmount: Decimal; p_initLine: Boolean)
    var

        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;

        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;

        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_jtoken: JsonToken;

        l_txtStripeInvoiceID: Text;
    begin
        GetAuth();
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', g_txtAuth);
        l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'invoiceitems';
        if p_initLine then
            l_txtrequestUri := StrSubstNo('%1?customer=%2&currency=%3&description=%4&quantity=%5&unit_amount_decimal=%6', l_txtAPIEndpoint, p_txtStripeCustID, p_txtStripeInvID, p_txtDesc, p_intQty, format(0 * 100, 0, 9))
        else
            l_txtrequestUri := StrSubstNo('%1?customer=%2&invoice=%3&description=%4&quantity=%5&unit_amount_decimal=%6', l_txtAPIEndpoint, p_txtStripeCustID, p_txtStripeInvID, p_txtDesc, p_intQty, format(p_decUnitAmount * 100, 0, 9));

        request.SetRequestUri(l_txtrequestUri);
        request.Method := 'POST';
        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);
        l_responseJsonObject.SelectToken('id', l_jtoken);
        l_txtStripeInvoiceID := l_jtoken.AsValue().AsText();
    end;

    procedure FinalizeInvoice(p_txtStripeInvID: Text): Text;
    var

        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;

        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;

        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_jtoken: JsonToken;

        l_txtHostedInvoiceURL: Text;

    begin
        GetAuth();
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', g_txtAuth);
        l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'invoices/%1/finalize';
        l_txtrequestUri := StrSubstNo(l_txtAPIEndpoint, p_txtStripeInvID);
        request.SetRequestUri(l_txtrequestUri);
        request.Method := 'POST';
        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);
        l_responseJsonObject.SelectToken('hosted_invoice_url', l_jtoken);
        l_txtHostedInvoiceURL := l_jtoken.AsValue().AsText();
        exit(l_txtHostedInvoiceURL);
    end;

    procedure SendSalesInvoiceToStripe(var p_recSalesInvoice: Record "Sales Invoice Header"; var p_txtStripeInvoiceURL: Text): Boolean
    var
        l_recCustomer: Record Customer;
        l_recStripeCustomer: Record "Stripe Customer";
        l_txtStripeCustomerID: Text;
        l_txtStripeInvoiceID: Text;
        l_recSalesInvoiceLine: Record "Sales Invoice Line";
        l_txtStripeURL: Text;
        l_recGLSetup: Record "General Ledger Setup";
        l_codCurrency: Code[10];
    begin
        if l_recGLSetup.get then;
        if p_recSalesInvoice."Currency Code" <> '' then
            l_codCurrency := p_recSalesInvoice."Currency Code"
        else
            l_codCurrency := l_recGLSetup."LCY Code";
        l_recCustomer.reset;
        if l_recCustomer.get(p_recSalesInvoice."Bill-to Customer No.") then begin
            l_recStripeCustomer.reset;
            l_recStripeCustomer.setrange("Customer No.", p_recSalesInvoice."Bill-to Customer No.");
            if l_recStripeCustomer.Findset() then begin
                l_txtStripeCustomerID := l_recStripeCustomer."Stripe Customer ID";
            end;
            if l_txtStripeCustomerID = '' then begin
                l_txtStripeCustomerID := CreateCustomer(p_recSalesInvoice."Bill-to Name", l_recCustomer."E-Mail");
                l_recStripeCustomer.init;
                l_recStripeCustomer."Stripe Customer ID" := l_txtStripeCustomerID;
                l_recStripeCustomer."Customer No." := l_recCustomer."No.";
                l_recStripeCustomer.Name := l_recCustomer.name;
                l_recStripeCustomer.Currency := p_recSalesInvoice."Currency Code";
                l_recStripeCustomer.Email := l_recCustomer."E-Mail";
                if l_recStripeCustomer.insert then;
                CreateInvoiceItem(l_txtStripeCustomerID, 'hkd', 'Init Line', 1, 0, true);
            end;
        end;
        if l_txtStripeCustomerID <> '' then begin
            l_txtStripeInvoiceID := CreateInvoice(l_txtStripeCustomerID, l_codCurrency);
        end;
        if l_txtStripeInvoiceID <> '' then begin
            l_recSalesInvoiceLine.reset;
            l_recSalesInvoiceLine.setrange("Document No.", p_recSalesInvoice."No.");
            if l_recSalesInvoiceLine.findset then
                repeat
                    CreateInvoiceItem(l_txtStripeCustomerID, l_txtStripeInvoiceID, l_recSalesInvoiceLine.Description, 1, (l_recSalesInvoiceLine."Amount Including VAT" - l_recSalesInvoiceLine."Inv. Discount Amount"), false);

                until l_recSalesInvoiceLine.next = 0;


            p_txtStripeInvoiceURL := FinalizeInvoice(l_txtStripeInvoiceID);

            if p_txtStripeInvoiceURL <> '' then begin
                p_recSalesInvoice."Stripe Payment Link" := p_txtStripeInvoiceURL;
                p_recSalesInvoice."External Payment Gateway" := p_recSalesInvoice."External Payment Gateway"::Stripe;
                p_recSalesInvoice."Stripe Invoice ID" := l_txtStripeInvoiceID;
                p_recSalesInvoice.Modify();
                exit(true);
            end;

        end;
        exit(false);

    end;

    procedure GetCharge(p_datCreatedDate: Date; p_txtInvoiceId: Text[50]; var p_txtBalanceTxnId: Text[50])
    var
        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;

        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;

        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_jtoken: JsonToken;

        l_txtStripeInvoiceID: Text;
        l_jArray: JsonArray;
        l_chargeToken: JsonToken;
    begin
        GetAuth();
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', g_txtAuth);
        l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'charges';
        l_txtrequestUri := StrSubstNo('%1?paid=true', l_txtAPIEndpoint);
        request.SetRequestUri(l_txtrequestUri);

        request.Method := 'GET';
        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);
        if NOT (l_responseJsonObject.SelectToken('data', l_jtoken)) then
            exit;

        l_jArray := l_jtoken.AsArray();
        foreach l_chargeToken In l_jArray do begin
            if GetValueAsText(l_chargeToken, 'paid') = 'true' then begin
                p_txtBalanceTxnId := GetValueAsText(l_chargeToken, 'balance_transaction');
            end;

        end;
    end;

    procedure GetRefund(p_txtInvoiceId: Text[50])
    var
        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_jtoken: JsonToken;
        l_jArray: JsonArray;
        l_decRefundAmount: Decimal;
        l_intCreated: Integer;
        l_datCreated: Date;
    begin
        GetAuth();
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', g_txtAuth);
        l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'refunds';
        l_txtrequestUri := StrSubstNo('%1', l_txtAPIEndpoint);
        request.SetRequestUri(l_txtrequestUri);
        request.Method := 'GET';
        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);


        l_responseJsonObject.SelectToken('data', l_jtoken);
        l_jArray := l_jtoken.AsArray();



        foreach l_jtoken In l_jArray do begin
            if GetValueAsText(l_jtoken, 'object') = 'refund' then begin

                Evaluate(l_decRefundAmount, GetValueAsText(l_jtoken, 'amount'));
                l_decRefundAmount := l_decRefundAmount / 100;


                Evaluate(l_intCreated, GetValueAsText(l_jtoken, 'created'));

                l_datCreated := DT2Date(CalcUnixDateTime(19700101D, 000000T, l_intCreated));


                InsertStripePaymentRefundLine(GetValueAsText(l_jtoken, 'id'),
                                            GetValueAsText(l_jtoken, 'reason'),
                                            GetValueAsText(l_jtoken, 'currency'),
                                            l_decRefundAmount,
                                            GetValueAsText(l_jtoken, 'payment_intent'),
                                            GetValueAsText(l_jtoken, 'status'),
                                            l_datCreated);


            end;
        end;
    end;

    procedure GetPaymentbyPaymentIntents()
    var
        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_responseJsonObject2: JsonObject;
        l_responseJsonObject3: JsonObject;
        l_jtokenHasMore: JsonToken;
        l_jtoken: JsonToken;
        l_jtoken2: JsonToken;
        l_jtoken3: JsonToken;
        l_jtoken4: JsonToken;
        l_txtStripeInvoiceID: Text;
        l_jArray: JsonArray;
        l_jArray2: JsonArray;
        l_chargeToken: JsonToken;
        l_txtBalanceTxnId: Text;
        l_decPaidAmount: Decimal;
        l_intCreated: Integer;
        l_datCreated: Date;
        l_txtChargeID: Text;
        TenderType: Text;
        l_txtLastID: Text;
        DialogBox: Dialog;
        NumberOfRecords: Integer;
    begin
        DialogBox.Open('Progress from Stripe Payment Intent: #1', NumberOfRecords);
        repeat
            Clear(request);
            Clear(response);
            Clear(g_txtAuth);
            GetAuth();
            contentHeaders.Clear();
            contentHeaders := client.DefaultRequestHeaders;
            contentHeaders.Add('Authorization', g_txtAuth);

            if l_txtLastID = '' then
                l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'payment_intents?limit=100'
            else
                l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'payment_intents?limit=100&starting_after=' + l_txtLastID;

            l_txtrequestUri := StrSubstNo('%1', l_txtAPIEndpoint);
            request.SetRequestUri(l_txtrequestUri);
            request.Method := 'GET';
            client.Send(request, response);
            response.Content().ReadAs(l_txtresponseText);
            l_responseJsonObject.ReadFrom(l_txtresponseText);
            l_responseJsonObject.SelectToken('data', l_jtoken);
            l_responseJsonObject.SelectToken('has_more', l_jtokenHasMore);
            l_jArray := l_jtoken.AsArray();
            foreach l_jtoken In l_jArray do begin

                NumberOfRecords += 1;
                DialogBox.UPDATE();

                l_txtLastID := GetValueAsText(l_jtoken, 'id');
                if (GetValueAsText(l_jtoken, 'invoice') = '') then begin
                    Evaluate(l_decPaidAmount, GetValueAsText(l_jtoken, 'amount'));
                    l_decPaidAmount := l_decPaidAmount / 100;
                    Evaluate(l_intCreated, GetValueAsText(l_jtoken, 'created'));
                    l_datCreated := DT2Date(CalcUnixDateTime(19700101D, 000000T, l_intCreated));
                    l_responseJsonObject2 := l_jtoken.AsObject();
                    l_responseJsonObject2.SelectToken('charges', l_jtoken2);
                    l_responseJsonObject3 := l_jtoken2.AsObject();
                    l_responseJsonObject3.SelectToken('data', l_jtoken3);
                    l_jArray2 := l_jtoken3.AsArray();
                    foreach l_jtoken3 In l_jArray2 do
                        l_txtChargeID := GetValueAsText(l_jtoken3, 'id');
                    InsertStripePaymentLine('',
                                            '',
                                            '',
                                             GetValueAsText(l_jtoken, 'currency'),
                                             l_decPaidAmount,
                                             'Null',
                                             GetValueAsText(l_jtoken, 'status'),
                                             l_datCreated,
                                             GetValueAsText(l_jtoken, 'id'),
                                             TenderType,
                                             l_txtChargeID,
                                             'PaymentIntent');
                end;
            end;
        until l_jtokenHasMore.AsValue().AsBoolean() = false;

        SLEEP(1000);
        DialogBox.CLOSE();


    end;

    procedure GetPaymentbyInvoice()
    var
        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_responseJsonObject2: JsonObject;
        l_responseJsonObject3: JsonObject;
        l_jtoken: JsonToken;
        l_jtoken2: JsonToken;
        l_jtoken3: JsonToken;
        l_jtokenHasMore: JsonToken;
        l_txtStripeInvoiceID: Text;
        l_jArray: JsonArray;
        l_chargeToken: JsonToken;
        l_txtBalanceTxnId: Text;
        l_decPaidAmount: Decimal;
        l_intCreated: Integer;
        l_datCreated: Date;
        TenderType: Text;
        l_txtLastID: Text;
        DialogBox: Dialog;
        NumberOfRecords: Integer;
    begin


        DialogBox.Open('Progress from Stripe Payment Invoice: #1', NumberOfRecords);
        repeat
            Clear(request);
            Clear(response);
            Clear(g_txtAuth);
            GetAuth();
            contentHeaders.Clear();
            contentHeaders := client.DefaultRequestHeaders;
            contentHeaders.Add('Authorization', g_txtAuth);

            if l_txtLastID = '' then
                l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'invoices?paid=true&limit=100'
            else
                l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'invoices?paid=true&limit=100&starting_after=' + l_txtLastID;

            l_txtrequestUri := StrSubstNo('%1', l_txtAPIEndpoint);
            request.SetRequestUri(l_txtrequestUri);
            request.Method := 'GET';
            client.Send(request, response);
            response.Content().ReadAs(l_txtresponseText);
            l_responseJsonObject.ReadFrom(l_txtresponseText);
            l_responseJsonObject.SelectToken('data', l_jtoken);
            l_responseJsonObject.SelectToken('has_more', l_jtokenHasMore);
            l_jArray := l_jtoken.AsArray();

            foreach l_jtoken In l_jArray do begin

                NumberOfRecords += 1;
                DialogBox.UPDATE();
                l_txtLastID := GetValueAsText(l_jtoken, 'id');
                Evaluate(l_decPaidAmount, GetValueAsText(l_jtoken, 'amount_paid'));
                l_decPaidAmount := l_decPaidAmount / 100;

                Evaluate(l_intCreated, GetValueAsText(l_jtoken, 'created'));
                l_datCreated := DT2Date(CalcUnixDateTime(19700101D, 000000T, l_intCreated));

                if (GetValueAsText(l_jtoken, 'status') = 'paid') then
                    InsertStripePaymentLine(GetValueAsText(l_jtoken, 'id'),
                                            GetValueAsText(l_jtoken, 'object'),
                                               '',
                                                GetValueAsText(l_jtoken, 'currency'),
                                                l_decPaidAmount,
                                                GetValueAsText(l_jtoken, 'id'),
                                                GetValueAsText(l_jtoken, 'status'),
                                                l_datCreated,
                                                GetValueAsText(l_jtoken, 'payment_intent'),
                                                TenderType,
                                                '',
                                                'StripeInvoiceID');

            end;
        until l_jtokenHasMore.AsValue().AsBoolean() = false;

        SLEEP(1000);
        DialogBox.CLOSE();

    end;

    procedure GetChargeDetailByInvoiceId(InvoiceId: Text; ChargeID: Text; var StripePayments: Record "Stripe Payment")
    var
        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_responseJsonObject2: JsonObject;
        l_responseJsonObject3: JsonObject;
        TempJObject: JsonObject;
        l_jtoken: JsonToken;
        l_jtoken2: JsonToken;
        l_jtoken3: JsonToken;
        l_txtStripeInvoiceID: Text;
        l_jArray: JsonArray;
        l_chargeToken: JsonToken;
        l_txtbalanceTxnID: Text;
        TenderType: Text;
        l_JpaymentArray: JsonArray;
        l_decAmount: Decimal;
        l_datCreated: Date;
        l_intCreated: Integer;
    begin
        GetAuth();
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', g_txtAuth);
        l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'charges';

        if ChargeID <> '' then
            l_txtrequestUri := StrSubstNo('%1/%2', l_txtAPIEndpoint, ChargeID)
        else
            l_txtrequestUri := StrSubstNo('%1?paid=true&invoice=%2', l_txtAPIEndpoint, InvoiceId);
        request.SetRequestUri(l_txtrequestUri);

        request.Method := 'GET';
        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);
        if (l_responseJsonObject.SelectToken('data', l_jtoken)) then begin
            l_jArray := l_jtoken.AsArray();
            foreach l_chargeToken In l_jArray do begin

                StripePayments."Payment Intent" := GetValueAsText(l_chargeToken, 'payment_intent');
                StripePayments."Charge Id" := GetValueAsText(l_chargeToken, 'id');

                l_responseJsonObject2 := l_chargeToken.AsObject();
                l_responseJsonObject2.SelectToken('payment_method_details', l_jtoken2);
                l_responseJsonObject3 := l_jtoken2.AsObject();
                if l_responseJsonObject3.SelectToken('card', l_jtoken3) = true then begin

                    if GetValueAsText(l_jtoken3, 'network') <> '' then
                        StripePayments."Tender Type" := GetValueAsText(l_jtoken3, 'network');

                end;
            end
        end else begin

            l_responseJsonObject.SelectToken('payment_method_details', l_jtoken);
            l_responseJsonObject2 := l_jtoken.AsObject();
            if l_responseJsonObject2.SelectToken('card', l_jtoken2) = true then begin
                if GetValueAsText(l_jtoken2, 'network') <> '' then
                    StripePayments."Tender Type" := GetValueAsText(l_jtoken2, 'network');
            end;
        end;
    end;

    procedure GetBalanceTransaction(ChargeId: Text; var StripePayment: Record "Stripe Payment")
    var
        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;

        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;

        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_jtoken: JsonToken;

        l_txtStripeInvoiceID: Text;
        l_jArray: JsonArray;
        l_balTxnToken: JsonToken;
        l_dtDateTime: DateTime;
        l_duration: Duration;
        l_decFeeAmount: Decimal;
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
        l_recLeaseContractBillingSched: Record "Lease Contract Billing Sched.";
    begin
        GetAuth();
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', g_txtAuth);
        l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'balance_transactions';
        l_txtrequestUri := StrSubstNo('%1?source=%2', l_txtAPIEndpoint, ChargeId);
        request.SetRequestUri(l_txtrequestUri);
        request.Method := 'GET';

        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);


        if not (l_responseJsonObject.SelectToken('data', l_jtoken)) then exit;

        l_jArray := l_jtoken.AsArray();

        foreach l_jtoken In l_jArray do begin
            StripePayment.Description := GetValueAsText(l_jtoken, 'description');
            Evaluate(l_decFeeAmount, GetValueAsText(l_jtoken, 'fee'));
            l_decFeeAmount := l_decFeeAmount / 100;
            StripePayment."Stripe Fee Amount" := -l_decFeeAmount;
        end;

    end;

    procedure GetPayouts(p_datArrivalDate: Date)
    var
        l_txtAPIEndPoint: Text;
        l_txtrequestUri: Text;

        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;

        l_txtresponseText: Text;
        l_responseJsonObject: JsonObject;
        l_jtoken: JsonToken;

        l_txtStripeInvoiceID: Text;
        l_jArray: JsonArray;
        l_payoutToken: JsonToken;
        l_recStripePayouts: Record "Stripe Payout";
        l_intDateTime: Integer;

        DialogBox: Dialog;
        NumberOfRecords: Integer;
        l_txtLastID: Text;
        l_jtokenHasMore: JsonToken;
    begin

        DialogBox.Open('Progress from Stripe Payout: #1', NumberOfRecords);
        repeat

            Clear(request);
            Clear(response);
            Clear(g_txtAuth);
            GetAuth();
            contentHeaders.Clear();
            contentHeaders := client.DefaultRequestHeaders;
            contentHeaders.Add('Authorization', g_txtAuth);
            if l_txtLastID = '' then
                l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'payouts?limit=100'
            else
                l_txtAPIEndPoint := g_txtStripeAPIBaseURL + 'payouts?limit=100&starting_after=' + l_txtLastID;


            l_txtrequestUri := l_txtAPIEndpoint;

            request.SetRequestUri(l_txtrequestUri);
            request.Method := 'GET';
            client.Send(request, response);
            response.Content().ReadAs(l_txtresponseText);
            l_responseJsonObject.ReadFrom(l_txtresponseText);
            l_responseJsonObject.SelectToken('data', l_jtoken);
            l_responseJsonObject.SelectToken('has_more', l_jtokenHasMore);

            l_jArray := l_jtoken.AsArray();
            foreach l_payoutToken In l_jArray do begin
                NumberOfRecords += 1;
                DialogBox.UPDATE();
                l_txtLastID := GetValueAsText(l_payoutToken, 'id');
                if not l_recStripePayouts.get(GetValueAsText(l_payoutToken, 'id')) then begin
                    l_recStripePayouts.init;
                    l_recStripePayouts.Id := GetValueAsText(l_payoutToken, 'id');
                    l_recStripePayouts.Description := GetValueAsText(l_payoutToken, 'description');
                    Evaluate(l_intDateTime, GetValueAsText(l_payoutToken, 'arrival_date'));
                    l_recStripePayouts."Arrival Date" := CalcUnixDateTime(19700101D, 000000T, l_intDateTime);
                    Evaluate(l_intDateTime, GetValueAsText(l_payoutToken, 'created'));
                    l_recStripePayouts.Created := CalcUnixDateTime(19700101D, 000000T, l_intDateTime);
                    l_recStripePayouts."Currency Code" := GetValueAsText(l_payoutToken, 'currency');
                    Evaluate(l_recStripePayouts.Amount, GetValueAsText(l_payoutToken, 'amount'));
                    l_recStripePayouts."Posting Date" := DT2Date(l_recStripePayouts."Arrival Date");
                    l_recStripePayouts.Amount := l_recStripePayouts.Amount / 100;
                    l_recStripePayouts.Status := l_recStripePayouts.Status::Open;
                    if l_recStripePayouts.insert then;
                end;
            end;
        until l_jtokenHasMore.AsValue().AsBoolean() = false;
        SLEEP(1000);
        DialogBox.CLOSE();
    end;

    procedure GetUnixTimeStamp(FromDateTime: DateTime): BigInteger
    var
        TypeHelper: Codeunit "Type Helper";
        OriginDateTime: DateTime;
        TimeZoneOffset: Duration;
    begin
        TypeHelper.GetUserTimezoneOffset(TimeZoneOffset);

        OriginDateTime := System.CreateDateTime(DMY2Date(1, 1, 1970), 0T);
        OriginDateTime := OriginDateTime + TimeZoneOffset;
        exit(FromDateTime - OriginDateTime);
    end;

    local procedure CalcUnixDateTime(StartDate: Date; StartTime: Time; Duration: Integer): DateTime
    var
        NoOfDays: Integer;
        RemDur: Duration;
        EndDate: Date;
        EndTime: Time;
        hoursDiff: Integer;
        DurationDelta: Duration;
        l_dtDateTime: DateTime;
    begin
        IF Duration = 0 THEN BEGIN
            EndDate := StartDate;
            EndTime := StartTime;
            Exit(CreateDateTime(EndDate, EndTime));
        END;

        NoOfDays := Duration DIV 86400;
        RemDur := Duration - (NoOfDays * 86400);

        EndTime := StartTime + (RemDur * 1000);
        EndDate := StartDate + NoOfDays;

        IF EndTime < StartTime THEN
            EndDate := EndDate + 1;


        l_dtDateTime := CreateDateTime(EndDate, EndTime);
        l_dtDateTime += 3600000 * 8;

        Exit(l_dtDateTime); // UTC time converted to Local Time!
    end;

    procedure GetAuth()
    var
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
    begin

        if l_recStripePaymentSetup.get then begin
            g_txtAuth := 'Bearer ' + l_recStripePaymentSetup."Stripe Secret Key";
            g_txtStripeAPIBaseURL := l_recStripePaymentSetup."Target URL";
        end;
    end;

    procedure GetValueAsText(JToken: JsonToken; ParamString: Text): Text
    var
        JObject: JsonObject;
    begin
        JObject := JToken.AsObject();
        exit(SelectJsonToken(JObject, ParamString));
    end;

    procedure SelectJsonToken(JObject: JsonObject; Path: Text): Text
    var
        JToken: JsonToken;
    begin
        if JObject.SelectToken(Path, JToken) then
            if NOT JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsText());
    end;

    procedure UpdateBillingScheduleStripeInvoiceID(SalesInvoiceNo: Code[100]; StripePaymentID: Text[250])
    var
        l_recLeaseContractBillingSched: Record "Lease Contract Billing Sched.";
    begin
        l_recLeaseContractBillingSched.Reset();
        l_recLeaseContractBillingSched.SetFilter("Document No.", SalesInvoiceNo);
        if l_recLeaseContractBillingSched.FindFirst() then
            repeat
                l_recLeaseContractBillingSched."Stripe Invoice ID" := StripePaymentID;
                l_recLeaseContractBillingSched.Status := l_recLeaseContractBillingSched.Status::Paid;
                l_recLeaseContractBillingSched.Modify();
            until l_recLeaseContractBillingSched.Next() = 0;


    end;

    procedure UpdateExtraChargePaymentStatus(SalesInvoiceNo: Code[100])
    var
        l_recExtraCharge: Record "Extra Charge";
    begin
        l_recExtraCharge.Reset();
        l_recExtraCharge.SetFilter("Posted Sales Invoice No.", SalesInvoiceNo);
        if l_recExtraCharge.FindFirst() then
            repeat
                l_recExtraCharge."Payment Status" := l_recExtraCharge."Payment Status"::Paid;
                l_recExtraCharge.Modify();
            until l_recExtraCharge.Next() = 0;


    end;

    procedure InsertStripePaymentRefundLine(Id: Text; Description: Text; CurrencyCode: Text; Amount: Decimal; PaymentIntent: Text; Reason: Text[250]; CreatedDate: Date)
    var
        l_recStripeRefund: Record "Stripe Refund";
        l_recStripeRefundLookup: Record "Stripe Refund";
        l_recStripePayment: Record "Stripe Payment";
    begin

        l_recStripeRefundLookup.Reset();
        l_recStripeRefundLookup.SetFilter(Id, Id);
        if l_recStripeRefundLookup.Count > 0 then exit;


        l_recStripeRefund.init;
        l_recStripeRefund.Id := Id;
        l_recStripeRefund.Description := Description;
        l_recStripeRefund."Currency Code" := CurrencyCode;
        l_recStripeRefund."Amount" := -Amount;
        l_recStripeRefund."Posting Date" := CreatedDate;
        l_recStripeRefund."Payment Intent" := PaymentIntent;

        l_recStripePayment.Reset();
        l_recStripePayment.SetFilter("Payment Intent", PaymentIntent);
        if l_recStripePayment.FindFirst() then
            l_recStripeRefund."Customer No." := l_recStripePayment."Customer No.";


        l_recStripeRefund.insert;

    end;

    procedure InsertStripePaymentLine(Id: Text; object: Text; Description: Text; CurrencyCode: Text; Amount: Decimal; StripeInvoiceID: Text; Reason: Text[250]; CreatedDate: Date; PaymentIntent: Text; TenderType: Text; ChargeID: Text; CheckType: Text)
    var
        l_recStripePayments: Record "Stripe Payment";
        l_recStripePaymentsLookup: Record "Stripe Payment";
        l_recSalesInvoice: Record "Sales Invoice Header";
        l_recLeaseContractBillingSchedule: Record "Lease Contract Billing Sched.";


    begin

        if CheckType = 'StripeInvoiceID' then
            if IsExistingStripePaymentLineByInvoiceId(StripeInvoiceID) then
                exit;

        if CheckType = 'PaymentIntent' then
            if IsExistingStripePaymentLineByPaymentIntent(PaymentIntent) then
                exit;


        l_recStripePayments.init;
        l_recStripePayments.Id := Format(l_recStripePayments.Count + 1);
        l_recStripePayments.Description := Description;

        l_recStripePayments."Currency Code" := CurrencyCode;
        l_recStripePayments."Amount" := -Amount;
        l_recStripePayments."Stripe Status" := Reason;
        l_recStripePayments."Posting Date" := CreatedDate;
        l_recStripePayments."Stripe Invoice ID" := StripeInvoiceID;
        l_recStripePayments."Payment Intent" := PaymentIntent;
        l_recStripePayments."Tender Type" := TenderType;
        l_recStripePayments."Sales Document Type" := l_recStripePayments."Sales Document Type"::Invoice;
        l_recStripePayments."Charge Id" := ChargeID;

        GetChargeDetailByInvoiceId(StripeInvoiceID, ChargeID, l_recStripePayments);
        GetBalanceTransaction(l_recStripePayments."Charge Id", l_recStripePayments);
        l_recStripePayments."Net Amount" := l_recStripePayments.Amount - l_recStripePayments."Stripe Fee Amount";


        l_recSalesInvoice.Reset();
        l_recSalesInvoice.SetFilter("Stripe Invoice ID", Id);
        if l_recSalesInvoice.FindFirst() then begin
            l_recStripePayments."Customer No." := l_recSalesInvoice."Bill-to Customer No.";
            l_recStripePayments."Customer Name" := l_recSalesInvoice."Bill-to Name";
            l_recStripePayments."Sales Document Type" := l_recStripePayments."Sales Document Type"::Invoice;
            l_recStripePayments."Sales Document No." := l_recSalesInvoice."No.";
            l_recStripePayments."Stripe Invoice ID" := l_recSalesInvoice."Stripe Invoice ID";

            l_recSalesInvoice."Stripe Paid" := true;
            l_recSalesInvoice."Payment Status" := l_recSalesInvoice."Payment Status"::Paid;
            UpdateBillingScheduleStripeInvoiceID(l_recSalesInvoice."No.", l_recSalesInvoice."Stripe Invoice ID");
            UpdateExtraChargePaymentStatus(l_recSalesInvoice."No.");

            l_recSalesInvoice.Modify();
        end;


        l_recSalesInvoice.Reset();
        l_recSalesInvoice.SetFilter("Stripe Invoice ID", PaymentIntent);
        if l_recSalesInvoice.FindFirst() then begin
            l_recStripePayments."Customer No." := l_recSalesInvoice."Bill-to Customer No.";
            l_recStripePayments."Customer Name" := l_recSalesInvoice."Bill-to Name";
            l_recStripePayments."Sales Document Type" := l_recStripePayments."Sales Document Type"::Invoice;
            l_recStripePayments."Sales Document No." := l_recSalesInvoice."No.";

            l_recSalesInvoice."Stripe Paid" := true;
            l_recSalesInvoice."Payment Status" := l_recSalesInvoice."Payment Status"::Paid;
            UpdateBillingScheduleStripeInvoiceID(l_recSalesInvoice."No.", l_recSalesInvoice."Stripe Invoice ID");
            UpdateExtraChargePaymentStatus(l_recSalesInvoice."No.");

            l_recSalesInvoice.Modify();
        end;




        if l_recStripePayments.insert then;

    end;

    procedure IsExistingStripePaymentLineByInvoiceId(StripeInvoiceid: Text): Boolean
    var
        l_recStripePayments: Record "Stripe Payment";
    begin
        l_recStripePayments.Reset();
        l_recStripePayments.SetFilter("Stripe Invoice ID", StripeInvoiceid);
        if l_recStripePayments.FindFirst() then
            exit(true)
        else
            exit(false)

    end;

    procedure IsExistingStripePaymentLineByPaymentIntent(PaymentIntent: Text): Boolean
    var
        l_recStripePayments: Record "Stripe Payment";
    begin
        l_recStripePayments.Reset();
        l_recStripePayments.SetFilter("Payment Intent", PaymentIntent);
        if l_recStripePayments.FindFirst() then
            exit(true)
        else
            exit(false)

    end;




    [EventSubscriber(ObjectType::Table, DATABASE::"Payment Service Setup", 'OnRegisterPaymentServiceProviders', '', true, true)]
    procedure T1060_OnRegisterPaymentServiceProviders(var PaymentServiceSetup: Record "Payment Service Setup")
    var
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
        OutStream: OutStream;
    begin
        if not l_recStripePaymentSetup.get then begin
            l_recStripePaymentSetup.Init;
            l_recStripePaymentSetup.Name := 'Stripe Payment Service';
            l_recStripePaymentSetup.Description := 'Stripe Payment Service';
            l_recStripePaymentSetup."Target URL" := 'https://api.stripe.com/v1/';
            l_recStripePaymentSetup."Terms of Service" := 'https://stripe.com/connect-account/legal';
            l_recStripePaymentSetup.Insert;
        end;

        PaymentServiceSetup.init;
        PaymentServiceSetup."No." := format(l_recStripePaymentSetup.RecordId);
        PaymentServiceSetup.Name := 'Stripe Payment Service';
        PaymentServiceSetup.Description := 'Stripe Payment Service';
        PaymentServiceSetup."Setup Record ID" := l_recStripePaymentSetup.RecordId;
        PaymentServiceSetup."Terms of Service" := l_recStripePaymentSetup."Terms of Service";
        PaymentServiceSetup."Management Codeunit ID" := Codeunit::Stripe;
        PaymentServiceSetup.Enabled := l_recStripePaymentSetup.Enabled;
        PaymentServiceSetup."Always Include on Documents" := l_recStripePaymentSetup."Always Include on Documents";
        PaymentServiceSetup.insert;
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Payment Service Setup", 'OnRegisterPaymentServices', '', true, true)]
    procedure T1060_OnRegisterPaymentServices(var PaymentServiceSetup: Record "Payment Service Setup")
    var
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
    begin
        if l_recStripePaymentSetup.get then begin
            PaymentServiceSetup.init;
            PaymentServiceSetup."No." := format(l_recStripePaymentSetup.RecordId);
            PaymentServiceSetup.Name := 'Stripe Payment Service';
            PaymentServiceSetup.Description := 'Stripe Payment Service';
            PaymentServiceSetup."Setup Record ID" := l_recStripePaymentSetup.RecordId;
            PaymentServiceSetup."Terms of Service" := l_recStripePaymentSetup."Terms of Service";
            PaymentServiceSetup."Management Codeunit ID" := Codeunit::Stripe;
            PaymentServiceSetup.Enabled := l_recStripePaymentSetup.Enabled;
            PaymentServiceSetup."Always Include on Documents" := l_recStripePaymentSetup."Always Include on Documents";
            PaymentServiceSetup.insert;
        end;
    end;



    procedure CreateStripeJournal(StripeJournalType: Text)
    var
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
        l_recStripePayment: Record "Stripe Payment";
        l_recStripePayout: Record "Stripe Payout";
        l_recStripeRefund: Record "Stripe Refund";
        l_recGenJournalLine: Record "Gen. Journal Line";
        l_recJnlBatch: Record "Gen. Journal Batch";
        l_intLineNo: Integer;

    begin
        l_recStripePaymentSetup.Get;
        case StripeJournalType of
            'Payment':
                begin
                    l_recJnlBatch.get(l_recStripePaymentSetup."Stripe Payment Jnl. Template", l_recStripePaymentSetup."Stripe Payment Jnl. Batch");
                    l_intLineNo := l_recGenJournalLine.GetNewLineNo(l_recStripePaymentSetup."Stripe Payment Jnl. Template", l_recStripePaymentSetup."Stripe Payment Jnl. Batch");
                    l_recStripePayment.Reset;
                    l_recStripePayment.Setrange(Status, l_recStripePayment.status::Open);
                    CreateStripePaymentJournalLine(l_recStripePayment, l_intLineNo, l_recJnlBatch);
                end;

            'Payout':
                begin
                    l_recJnlBatch.get(l_recStripePaymentSetup."Stripe Payout Jnl. Template", l_recStripePaymentSetup."Stripe Payout Jnl. Batch");
                    l_intLineNo := l_recGenJournalLine.GetNewLineNo(l_recStripePaymentSetup."Stripe Payout Jnl. Template", l_recStripePaymentSetup."Stripe Payout Jnl. Batch");
                    l_recStripePayout.Reset;
                    l_recStripePayout.Setrange(Status, l_recStripePayout.status::Open);
                    CreateStripePayoutJournalLine(l_recStripePayout, l_intLineNo, l_recJnlBatch);
                end;

            'Refund':
                begin
                    l_recJnlBatch.get(l_recStripePaymentSetup."Stripe Refund Jnl. Template", l_recStripePaymentSetup."Stripe Refund Jnl. Batch");
                    l_intLineNo := l_recGenJournalLine.GetNewLineNo(l_recStripePaymentSetup."Stripe Refund Jnl. Template", l_recStripePaymentSetup."Stripe Refund Jnl. Batch");
                    l_recStripeRefund.Reset;
                    l_recStripeRefund.Setrange(Status, l_recStripeRefund.status::Open);
                    CreateStripeRefundJournalLine(l_recStripeRefund, l_intLineNo, l_recJnlBatch);
                end;
        end;

    end;

    procedure CreateStripePaymentJournalLine(var StripePayment: Record "Stripe Payment"; var LineNo: Integer; var JournalBatch: Record "Gen. Journal Batch")
    var
        l_codDocNo: code[20];
        l_cduNoSeriesMgt: Codeunit NoSeriesManagement;
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
    begin
        l_recStripePaymentSetup.Get;

        if StripePayment.FindSet() then
            repeat
                l_codDocNo := l_cduNoSeriesMgt.GetNextNo(JournalBatch."No. Series", StripePayment."Posting Date", true); //<Try this new method


                InsertGenJournalLine(JournalBatch."Journal Template Name", JournalBatch.Name, LineNo,
                StripePayment."Posting Date", "Gen. Journal Document Type"::Payment, l_codDocNo, "Gen. Journal Account Type"::Customer, StripePayment."Customer No.",
                StripePayment.Amount, "Gen. Journal Document Type"::Invoice, StripePayment."Sales Document No.");


                InsertGenJournalLine(JournalBatch."Journal Template Name", JournalBatch.Name, LineNo, StripePayment."Posting Date", "Gen. Journal Document Type"::Payment, l_codDocNo,
                 "Gen. Journal Account Type"::"Bank Account", l_recStripePaymentSetup."Stripe Bank Account", StripePayment."Net Amount" * -1,
                 "Gen. Journal Document Type"::Invoice, StripePayment."Sales Document No.");


                if StripePayment."Stripe Fee Amount" <> 0 then  // Stripe Service Fee Amount 
                    InsertGenJournalLine(JournalBatch."Journal Template Name", JournalBatch.Name, LineNo, StripePayment."Posting Date", "Gen. Journal Document Type"::Payment, l_codDocNo,
                   "Gen. Journal Account Type"::"G/L Account", l_recStripePaymentSetup."Stripe Processing Fee G/L Acc.", StripePayment."Stripe Fee Amount",
                   "Gen. Journal Document Type"::Invoice, StripePayment."Sales Document No.");



                StripePayment.Status := StripePayment.status::Created;
                StripePayment."General Journal Document Type" := "Gen. Journal Document Type"::Payment;
                StripePayment."General Journal Document No." := l_codDocNo;
                StripePayment.Modify();

            // l_codDocNo := IncStr(l_codDocNo);
            until StripePayment.next = 0;
    end;



    procedure CreateStripePayoutJournalLine(var StripePayout: Record "Stripe Payout"; var LineNo: Integer; var JournalBatch: Record "Gen. Journal Batch")
    var
        l_codDocNo: code[20];
        l_cduNoSeriesMgt: Codeunit NoSeriesManagement;
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
    begin
        l_recStripePaymentSetup.Get();
        if StripePayout.FindSet() then
            repeat
                l_codDocNo := l_cduNoSeriesMgt.GetNextNo(JournalBatch."No. Series", StripePayout."Posting Date", true); //<Try this new method

                InsertGenJournalLine(JournalBatch."Journal Template Name", JournalBatch.Name, LineNo,
                StripePayout."Posting Date", "Gen. Journal Document Type"::Payment, l_codDocNo, "Gen. Journal Account Type"::"Bank Account", l_recStripePaymentSetup."Stripe Bank Account",
                StripePayout.Amount * -1, "Gen. Journal Document Type"::" ", '');


                InsertGenJournalLine(JournalBatch."Journal Template Name", JournalBatch.Name, LineNo,
                 StripePayout."Posting Date", "Gen. Journal Document Type"::Payment, l_codDocNo, "Gen. Journal Account Type"::"Bank Account", l_recStripePaymentSetup."Receiving Bank Account",
                 StripePayout.Amount, "Gen. Journal Document Type"::" ", '');


                StripePayout."General Journal Document Type" := "Gen. Journal Document Type"::" ";
                StripePayout."General Journal Document No." := l_codDocNo;
                StripePayout.Status := StripePayout.status::Created;
                StripePayout.Modify();


            // l_codDocNo := IncStr(l_codDocNo);
            until StripePayout.next = 0;
    end;



    procedure CreateStripeRefundJournalLine(var StripeRefund: Record "Stripe Refund"; var LineNo: Integer; JournalBatch: Record "Gen. Journal Batch")
    var
        l_codDocNo: code[20];
        l_cduNoSeriesMgt: Codeunit NoSeriesManagement;
        l_recStripePaymentSetup: Record "Stripe Payment Setup";
    begin
        l_recStripePaymentSetup.Get;
        if StripeRefund.FindSet() then
            repeat
                l_codDocNo := l_cduNoSeriesMgt.GetNextNo(JournalBatch."No. Series", StripeRefund."Posting Date", false); //<Try this new method

                InsertGenJournalLine(JournalBatch."Journal Template Name", JournalBatch.Name, LineNo,
                StripeRefund."Posting Date", "Gen. Journal Document Type"::"Refund", l_codDocNo, "Gen. Journal Account Type"::"Bank Account", l_recStripePaymentSetup."Receiving Bank Account",
                StripeRefund.Amount, "Gen. Journal Document Type"::" ", '');

                InsertGenJournalLine(JournalBatch."Journal Template Name", JournalBatch.Name, LineNo, StripeRefund."Posting Date", "Gen. Journal Document Type"::Refund, l_codDocNo,
                 "Gen. Journal Account Type"::Customer, StripeRefund."Customer No.", StripeRefund."Amount" * -1,
                 "Gen. Journal Document Type"::Invoice, '');

                StripeRefund.Status := StripeRefund.status::Created;
                StripeRefund."General Journal Document Type" := "Gen. Journal Document Type"::Refund;
                StripeRefund."General Journal Document No." := l_codDocNo;
                StripeRefund.Modify();

            // l_codDocNo := IncStr(l_codDocNo);
            until StripeRefund.next = 0;
    end;



    procedure InsertGenJournalLine(JournalTemplateName: Code[50]; JournalBatchName: Code[50]; var LineNo: Integer; PostingDate: Date; DocumentType: Enum "Gen. Journal Document Type"; DocumentNo: Code[50];
    AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; Amount: Decimal; ApplyToDocumentType: Enum "Gen. Journal Document Type"; ApplyToDocumentNo: code[100])
    var
        l_recGenJournalLine: Record "Gen. Journal Line";
    begin
        l_recGenJournalLine.Init;
        l_recGenJournalLine."Journal Template Name" := JournalTemplateName;
        l_recGenJournalLine."Journal Batch Name" := JournalBatchName;
        l_recGenJournalLine."Line No." := LineNo;
        //if l_recGenJournalLine.insert then;
        l_recGenJournalLine.insert;
        l_recGenJournalLine."Posting Date" := PostingDate;
        l_recGenJournalLine."Document Type" := DocumentType;
        l_recGenJournalLine."Document No." := DocumentNo;
        l_recGenJournalLine."Account Type" := AccountType;
        l_recGenJournalLine.validate("Account No.", AccountNo);
        l_recGenJournalLine.validate(Amount, Amount);
        l_recGenJournalLine."Applies-to Doc. Type" := ApplyToDocumentType;
        l_recGenJournalLine."Applies-to Doc. No." := ApplyToDocumentNo;
        //  if l_recGenJournalLine.Modify() then;
        l_recGenJournalLine.Modify();
        LineNo += 10000;
    end;


    var
        g_txtAuth: Text;
        g_txtStripeAPIBaseURL: Text;

}
