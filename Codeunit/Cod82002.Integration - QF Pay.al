codeunit 82002 "Integration - QFPay"
{

    procedure GetTransactionQuery()
    var
        l_payoutToken: JsonToken;
        contentHeaders: HttpHeaders;
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        l_responseJsonObject: JsonObject;
        l_txtrequestUri: Text;
        l_txtresponseText: Text;
        l_jtoken: JsonToken;
        l_jArray: JsonArray;

        CryptographyManagement: Codeunit "Cryptography Management";
        HashAlgorithmType: Option MD5,SHA1,SHA256,SHA384,SHA512;
        l_txttoMD5: Text;
        l_txtHash: Text;

        l_txtStartTime: Text;
        l_txtEndTime: Text;

        l_recQFPaySetup: Record "QFPay Setup";
        l_recQFPayment: Record "QFPay Payment";

    begin

        l_recQFPaySetup.FindFirst();


        l_txtStartTime := format(CreateDateTime(CalcDate('-CM', WorkDate), 000000T), 0, '<Year4>-<Month,2>-<Day,2> <Hours24,2>:<Minutes,2>:<Seconds,2>');
        l_txtEndTime := format(CreateDateTime(CalcDate('CM', WorkDate), 235959T), 0, '<Year4>-<Month,2>-<Day,2> <Hours24,2>:<Minutes,2>:<Seconds,2>');


        l_txttoMD5 := 'end_time=' + l_txtEndTime + '&page_size=100' + '&start_time=' + l_txtStartTime + l_recQFPaySetup."API Key";
        l_txtHash := CryptographyManagement.GenerateHash(l_txttoMD5, HashAlgorithmType::MD5);


        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('X-QF-APPCODE', l_recQFPaySetup."API Code");
        contentHeaders.Add('X-QF-SIGN', l_txtHash);


        l_txtrequestUri := 'https://test-openapi-hk.qfapi.com/trade/v1/query?start_time=' + l_txtStartTime + '&end_time=' + l_txtEndTime + '&page_size=100';


        request.SetRequestUri(l_txtrequestUri);
        request.Method := 'POST';

        client.Send(request, response);
        response.Content().ReadAs(l_txtresponseText);
        l_responseJsonObject.ReadFrom(l_txtresponseText);

        l_responseJsonObject.SelectToken('data', l_jtoken);
        l_jArray := l_jtoken.AsArray();
        foreach l_payoutToken In l_jArray do begin

            if (GetValueAsText(l_payoutToken, 'errmsg') = '交易成功') then
                if (GetValueAsText(l_payoutToken, 'order_type') = 'payment') then
                    InitQFPaymentLine(GetValueAsText(l_payoutToken, 'out_trade_no'),
                                      GetValueAsText(l_payoutToken, 'syssn'),
                                      GetValueAsDateTime(l_payoutToken, 'sysdtm'),
                                      GetValueAsDateTime(l_payoutToken, 'paydtm'),
                                      GetValueAsText(l_payoutToken, 'txcurrcd'),
                                      GetValueAsDecimal(l_payoutToken, 'txamt'),
                                      GetValueAsText(l_payoutToken, 'errmsg'),
                                      GetValueAsText(l_payoutToken, 'pay_type'),
                                      GetValueAsText(l_payoutToken, 'clisn'),
                                      GetValueAsDateTime(l_payoutToken, 'txdtm'))
                else
                    InitQFPayRefundLine(GetValueAsText(l_payoutToken, 'out_trade_no'),
                                              GetValueAsText(l_payoutToken, 'syssn'),
                                              GetValueAsDateTime(l_payoutToken, 'sysdtm'),
                                              GetValueAsDateTime(l_payoutToken, 'paydtm'),
                                              GetValueAsText(l_payoutToken, 'txcurrcd'),
                                              GetValueAsDecimal(l_payoutToken, 'txamt'),
                                              GetValueAsText(l_payoutToken, 'errmsg'),
                                              GetValueAsText(l_payoutToken, 'pay_type'),
                                              GetValueAsText(l_payoutToken, 'clisn'),
                                              GetValueAsDateTime(l_payoutToken, 'txdtm'),
                                              GetValueAsText(l_payoutToken, 'origssn'));

        end;
        Message('QFPay payment has been generated sucessfully!');

    end;

    procedure InitQFPaymentLine(OutTradeNo: Text; Syssn: Text; Sysdtm: DateTime; Paydtm: DateTime; Txcurrcd: Text; Txamt: Decimal; Errmsg: Text; PayType: Text; Clisn: Text; Txdtm: DateTime)
    var
        l_recQFPayment: Record "QFPay Payment";
    begin

        if IsExistQFPaymentLine(OutTradeNo) then exit;

        l_recQFPayment.Init();
        l_recQFPayment.id := OutTradeNo;
        l_recQFPayment.out_trade_no := OutTradeNo;
        l_recQFPayment.syssn := Syssn;
        l_recQFPayment.sysdtm := Sysdtm;
        l_recQFPayment.paydtm := Paydtm;
        l_recQFPayment.txcurrcd := Txcurrcd;
        l_recQFPayment.txamt := Txamt / 100;
        l_recQFPayment.errmsg := Errmsg;
        l_recQFPayment.pay_type := PayType;
        l_recQFPayment.clisn := Clisn;
        l_recQFPayment.txdtm := Txdtm;
        l_recQFPayment."Service Charge" := CalculateServiceChargeByTenderType(PayType, l_recQFPayment.txamt);
        MapDocumentNo(l_recQFPayment, OutTradeNo);
        l_recQFPayment.Insert();
    end;

    procedure InitQFPayRefundLine(OutTradeNo: Text; Syssn: Text; Sysdtm: DateTime; Paydtm: DateTime; Txcurrcd: Text; Txamt: Decimal; Errmsg: Text; PayType: Text; Clisn: Text; Txdtm: DateTime; Origssn: Text)
    var
        l_recQFPayRefund: Record "QFPay Refund";
    begin

        if IsExistQFPayRefundLine(OutTradeNo) then exit;

        l_recQFPayRefund.Init();
        l_recQFPayRefund.id := OutTradeNo;
        l_recQFPayRefund.out_trade_no := OutTradeNo;
        l_recQFPayRefund.syssn := Syssn;
        l_recQFPayRefund.sysdtm := Sysdtm;
        l_recQFPayRefund.paydtm := Paydtm;
        l_recQFPayRefund.txcurrcd := Txcurrcd;
        l_recQFPayRefund.txamt := Txamt / 100;
        l_recQFPayRefund.errmsg := Errmsg;
        l_recQFPayRefund.pay_type := PayType;
        l_recQFPayRefund.clisn := Clisn;
        l_recQFPayRefund.txdtm := Txdtm;
        l_recQFPayRefund.Origssn := Origssn;
        MapRefundDocumentNoAndCheckRefund(l_recQFPayRefund, Origssn);

        l_recQFPayRefund.Insert();
    end;


    procedure MapDocumentNo(var QFPayment: Record "QFPay Payment"; OutTradeNo: Code[250])
    var
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        l_recSalesInvoiceHeader.Reset();
        l_recSalesInvoiceHeader.SetFilter("Stripe Invoice ID", OutTradeNo);
        if l_recSalesInvoiceHeader.FindFirst() then begin
            QFPayment."Sales Document No." := l_recSalesInvoiceHeader."No.";
            QFPayment."Sales Document Type" := QFPayment."Sales Document Type"::Invoice;
            QFPayment."Customer No." := l_recSalesInvoiceHeader."Bill-to Customer No.";
        end;
    end;

    procedure MapRefundDocumentNoAndCheckRefund(var QFPayRefund: Record "QFPay Refund"; Origssn: Text)
    var
        l_recQFPayPayment: Record "QFPay Payment";
        l_recQFPayServiceCharge: Record "QFPay Service Charge";
    begin
        l_recQFPayPayment.Reset();
        l_recQFPayPayment.SetFilter(syssn, Origssn);
        if l_recQFPayPayment.FindFirst() then begin
            if DT2Date(l_recQFPayPayment.sysdtm) <> DT2Date(QFPayRefund.sysdtm) then
                if l_recQFPayServiceCharge.Get(QFPayRefund.pay_type) then
                    if l_recQFPayServiceCharge."Refund Fee" then
                        QFPayRefund."Refund Fee" := 15;

            QFPayRefund."Customer No." := l_recQFPayPayment."Customer No.";
        end;
    end;




    procedure CalculateServiceChargeByTenderType(TenderType: Code[50]; Amount: Decimal): Decimal
    var
        l_recQFPayServiceCharge: Record "QFPay Service Charge";
    begin
        if l_recQFPayServiceCharge.Get(TenderType) then
            exit((Amount * l_recQFPayServiceCharge.Percentage / 100) + l_recQFPayServiceCharge."Plus Fixed Amount")
        else
            exit(0);
    end;


    procedure IsExistQFPaymentLine(OutTradeNo: Text): Boolean
    var
        l_recQFPayment: Record "QFPay Payment";
    begin
        if l_recQFPayment.Get(OutTradeNo) then
            exit(true)
        else
            exit(false)
    end;

    procedure IsExistQFPayRefundLine(OutTradeNo: Text): Boolean
    var
        l_recQFPayRefund: Record "QFPay Refund";
    begin
        if l_recQFPayRefund.Get(OutTradeNo) then
            exit(true)
        else
            exit(false)
    end;



    procedure CreateQFPayPayoutJournal()
    var
        l_recQFPaySetup: Record "QFPay Setup";
        l_recQFPayment: Record "QFPay Payment";
        l_recJnlBatch: Record "Gen. Journal Batch";
        l_recGenJournalLine: Record "Gen. Journal Line";
        l_codDocNo: code[20];
        l_intLineNo: Integer;
        l_cduNoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        l_recQFPaySetup.FindFirst();
        l_intLineNo := l_recGenJournalLine.GetNewLineNo(l_recQFPaySetup."QF Pay Payment Jnl. Template", l_recQFPaySetup."QF Pay Payment Jnl. Batch");
        l_recJnlBatch.get(l_recQFPaySetup."QF Pay Payment Jnl. Template", l_recQFPaySetup."QF Pay Payment Jnl. Batch");
        l_codDocNo := l_cduNoSeriesMgt.TryGetNextNo(l_recJnlBatch."No. Series", DT2Date(l_recQFPayment.paydtm));



        l_recQFPayment.Reset();
        l_recQFPayment.SetRange(Status, l_recQFPayment.Status::Open);
        if l_recQFPayment.FindSet() then
            repeat

                InitGenJournalLine(l_recQFPaySetup."QF Pay Payment Jnl. Template",
                                   l_recQFPaySetup."QF Pay Payment Jnl. Batch",
                                   l_intLineNo,
                                   DT2Date(l_recQFPayment.paydtm),
                                   l_codDocNo,
                                   "Gen. Journal Account Type"::"Bank Account",
                                   l_recQFPaySetup."Receiving Bank Account",
                                   l_recQFPayment.txamt - l_recQFPayment."Service Charge"
                                   , '');



                InitGenJournalLine(l_recQFPaySetup."QF Pay Payment Jnl. Template",
                                    l_recQFPaySetup."QF Pay Payment Jnl. Batch",
                                    l_intLineNo,
                                    DT2Date(l_recQFPayment.paydtm),
                                    l_codDocNo,
                                    "Gen. Journal Account Type"::Customer,
                                    l_recQFPayment."Customer No.",
                                    l_recQFPayment.txamt * -1,
                                    l_recQFPayment."Sales Document No.");


                if l_recQFPayment."Service Charge" <> 0 then
                    InitGenJournalLine(l_recQFPaySetup."QF Pay Payment Jnl. Template",
                                        l_recQFPaySetup."QF Pay Payment Jnl. Batch",
                                        l_intLineNo,
                                        DT2Date(l_recQFPayment.paydtm),
                                        l_codDocNo,
                                        "Gen. Journal Account Type"::"G/L Account",
                                        l_recQFPaySetup."QF Pay Processing Fee G/L Acc.",
                                        l_recQFPayment."Service Charge",
                                        '');


                l_recQFPayment."General Journal Document Type" := l_recQFPayment."General Journal Document Type"::Payment;
                l_recQFPayment."General Journal Document No." := l_codDocNo;
                l_recQFPayment.Status := l_recQFPayment.Status::Created;
                l_recQFPayment.Modify();
            until l_recQFPayment.Next() = 0;

        Message('The QFPay payment journal has been created sucessfully!');

    end;


    procedure CreateQFPayRefundJournal()
    var
        l_recQFPaySetup: Record "QFPay Setup";
        l_recQFPayRefund: Record "QFPay Refund";
        l_recJnlBatch: Record "Gen. Journal Batch";
        l_recGenJournalLine: Record "Gen. Journal Line";
        l_codDocNo: code[20];
        l_intLineNo: Integer;
        l_cduNoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        l_recQFPaySetup.FindFirst();
        l_intLineNo := l_recGenJournalLine.GetNewLineNo(l_recQFPaySetup."QFPay Refund Jnl. Template", l_recQFPaySetup."QFPay Refund Jnl. Batch");
        l_recJnlBatch.get(l_recQFPaySetup."QFPay Refund Jnl. Template", l_recQFPaySetup."QFPay Refund Jnl. Batch");
        l_codDocNo := l_cduNoSeriesMgt.TryGetNextNo(l_recJnlBatch."No. Series", DT2Date(l_recQFPayRefund.paydtm));



        l_recQFPayRefund.Reset();
        l_recQFPayRefund.SetRange(Status, l_recQFPayRefund.Status::Open);
        if l_recQFPayRefund.FindSet() then
            repeat

                InitRefundGenJournalLine(l_recQFPaySetup."QFPay Refund Jnl. Template",
                                   l_recQFPaySetup."QFPay Refund Jnl. Batch",
                                   l_intLineNo,
                                   DT2Date(l_recQFPayRefund.paydtm),
                                   l_codDocNo,
                                   "Gen. Journal Account Type"::"Bank Account",
                                   l_recQFPaySetup."Receiving Bank Account",
                                   l_recQFPayRefund.txamt * -1
                                   , '');



                InitRefundGenJournalLine(l_recQFPaySetup."QFPay Refund Jnl. Template",
                                   l_recQFPaySetup."QFPay Refund Jnl. Batch",
                                    l_intLineNo,
                                    DT2Date(l_recQFPayRefund.paydtm),
                                    l_codDocNo,
                                    "Gen. Journal Account Type"::Customer,
                                    l_recQFPayRefund."Customer No.",
                                    l_recQFPayRefund.txamt,
                                    l_recQFPayRefund."Sales Document No.");

                if l_recQFPayRefund."Refund Fee" <> 0 then
                    InitRefundFeeGenJournalLine(l_recQFPaySetup."QFPay Refund Jnl. Template",
                    l_recQFPaySetup."QFPay Refund Jnl. Batch",
                    l_intLineNo,
                    DT2Date(l_recQFPayRefund.paydtm),
                    l_codDocNo,
                    "Gen. Journal Account Type"::"G/L Account",
                    l_recQFPaySetup."QF Pay Processing Fee G/L Acc.",
                    l_recQFPayRefund."Refund Fee",
                    "Gen. Journal Account Type"::"G/L Account",
                    l_recQFPaySetup."Receiving Bank Account");





                l_recQFPayRefund."General Journal Document Type" := l_recQFPayRefund."General Journal Document Type"::Refund;
                l_recQFPayRefund."General Journal Document No." := l_codDocNo;
                l_recQFPayRefund.Status := l_recQFPayRefund.Status::Created;
                l_recQFPayRefund.Modify();
            until l_recQFPayRefund.Next() = 0;

        Message('The QFPay payment journal has been created sucessfully!');

    end;



    procedure InitGenJournalLine(JournalTemplate: Code[50]; JournalBatchCode: Code[50]; var LineNo: Integer; PostingDate: Date; DocumentNo: Code[100]; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; Amount: Decimal; SalesInvoiceNo: Code[100])
    var
        l_recGenJournalLine: Record "Gen. Journal Line";
    begin
        l_recGenJournalLine.init;
        l_recGenJournalLine."Journal Template Name" := JournalTemplate;
        l_recGenJournalLine."Journal Batch Name" := JournalBatchCode;
        l_recGenJournalLine."Line No." := LineNo;
        if l_recGenJournalLine.insert then;
        l_recGenJournalLine."Posting Date" := PostingDate;
        l_recGenJournalLine."Document Type" := l_recGenJournalLine."Document Type"::Payment;
        l_recGenJournalLine."Document No." := DocumentNo;
        l_recGenJournalLine."Account Type" := AccountType;
        l_recGenJournalLine.validate("Account No.", AccountNo);
        l_recGenJournalLine.validate(Amount, Amount);
        if SalesInvoiceNo <> '' then
            l_recGenJournalLine."Applies-to Doc. Type" := l_recGenJournalLine."Applies-to Doc. Type"::Invoice;
        l_recGenJournalLine."Applies-to Doc. No." := SalesInvoiceNo;
        if l_recGenJournalLine.Modify() then;
        LineNo += 10000;

    end;

    procedure InitRefundGenJournalLine(JournalTemplate: Code[50]; JournalBatchCode: Code[50]; var LineNo: Integer; PostingDate: Date; DocumentNo: Code[100]; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; Amount: Decimal; SalesInvoiceNo: Code[100])
    var
        l_recGenJournalLine: Record "Gen. Journal Line";
    begin
        l_recGenJournalLine.init;
        l_recGenJournalLine."Journal Template Name" := JournalTemplate;
        l_recGenJournalLine."Journal Batch Name" := JournalBatchCode;
        l_recGenJournalLine."Line No." := LineNo;
        if l_recGenJournalLine.insert then;
        l_recGenJournalLine."Posting Date" := PostingDate;
        l_recGenJournalLine."Document Type" := l_recGenJournalLine."Document Type"::Refund;
        l_recGenJournalLine."Document No." := DocumentNo;
        l_recGenJournalLine."Account Type" := AccountType;
        l_recGenJournalLine.validate("Account No.", AccountNo);
        l_recGenJournalLine.validate(Amount, Amount);
        if l_recGenJournalLine.Modify() then;
        LineNo += 10000;

    end;



    procedure InitRefundFeeGenJournalLine(JournalTemplate: Code[50]; JournalBatchCode: Code[50]; var LineNo: Integer; PostingDate: Date; DocumentNo: Code[100]; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; Amount: Decimal; BalAccountType: Enum "Gen. Journal Account Type"; BalAccountNo: Code[50])
    var
        l_recGenJournalLine: Record "Gen. Journal Line";
    begin
        l_recGenJournalLine.init;
        l_recGenJournalLine."Journal Template Name" := JournalTemplate;
        l_recGenJournalLine."Journal Batch Name" := JournalBatchCode;
        l_recGenJournalLine."Line No." := LineNo;
        if l_recGenJournalLine.insert then;
        l_recGenJournalLine."Posting Date" := PostingDate;
        l_recGenJournalLine."Document Type" := l_recGenJournalLine."Document Type"::Refund;
        l_recGenJournalLine."Document No." := DocumentNo;
        l_recGenJournalLine."Account Type" := AccountType;
        l_recGenJournalLine.validate("Account No.", AccountNo);
        l_recGenJournalLine.validate(Amount, Amount);
        l_recGenJournalLine."Bal. Account Type" := BalAccountType;
        l_recGenJournalLine.validate("Bal. Account No.", BalAccountNo);

        if l_recGenJournalLine.Modify() then;
        LineNo += 10000;

    end;



    procedure GetValueAsText(JToken: JsonToken; ParamString: Text): Text
    var
        JObject: JsonObject;
    begin
        JObject := JToken.AsObject();

        if JObject.SelectToken(ParamString, JToken) then
            if NOT JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsText());

    end;

    procedure GetValueAsDecimal(JToken: JsonToken; ParamString: Text): Decimal
    var
        JObject: JsonObject;
    begin
        JObject := JToken.AsObject();

        if JObject.SelectToken(ParamString, JToken) then
            if NOT JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsDecimal());

    end;

    procedure GetValueAsDateTime(JToken: JsonToken; ParamString: Text): DateTime
    var
        JObject: JsonObject;
        l_dtConvert: DateTime;

    begin
        JObject := JToken.AsObject();

        if JObject.SelectToken(ParamString, JToken) then
            if NOT JToken.AsValue().IsNull() then
                if Evaluate(l_dtConvert, JToken.AsValue().AsText()) then
                    exit(l_dtConvert);

    end;

}
