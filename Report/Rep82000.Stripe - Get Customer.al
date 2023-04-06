report 82000 "Get Stripe Customer"
{
    ApplicationArea = All;
    Caption = 'Get Stripe Customers';
    UsageCategory = ReportsAndAnalysis;
    AdditionalSearchTerms = 'Stripe Customer';
    UseRequestPage = false;
    ProcessingOnly = true;
    dataset
    {
        // dataitem(; "")
        // {
        // }

    }
    requestpage
    {
        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(g_ReqDate; g_ReqDate)
                    {
                        Caption = 'Date';
                        ApplicationArea = All;
                    }
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

    trigger OnPreReport()
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;

        responseText: Text;

        APIEndpoint: Text;
        requestUri: Text;
        formattedDate: Text;

        l_result: Text;
        l_token: Text;

        responseJobject: JsonObject;
        l_jtoken: JsonToken;

        SalesOrderArray: JsonArray;
        SalesLineArray: JsonArray;
        PaymentArray: JsonArray;
        SalesOrderToken: JsonToken;
        SalesOrderLineToken: JsonToken;
        PaymentToken: JsonToken;

        l_txSalesHeaderId: Text;
        l_txSalesDetailId: Text;
        l_txPaymentId: Text;
        l_txtAuth: Text;
        l_txtTemp: Text;
        l_custToken: JsonToken;

        // l_TbTransHeader: Record "Transaction Header";
        // l_TbTransLine: Record "Transaction Line";
        // l_TbTransPayment: Record "Transaction Payment";

        l_TbDimVal: Record "Dimension Value";
        l_TbDimValChk: Record "Dimension Value";

    begin
        g_TbSalesSetup.Reset();
        if g_TbSalesSetup.Get() then;

        // APIEndpoint := 'https://api.stripe.com/v1/charges';
        APIEndpoint := 'https://api.stripe.com/v1/customers';
        l_txtAuth := 'Bearer sk_test_51LVFrWCU6aKal2twZxoGfg3ap8jqrgMhSlNEtmo5eqaSjy0SxWpY9UUvT9dW38HTMsir7iRk9UJHuKMQUjpwWT9700ndZFqljs';


        request.SetRequestUri(APIEndpoint);
        request.Method := 'GET';
        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', l_txtAuth);
        client.Send(request, response);

        // // Read the response content as json.
        response.Content().ReadAs(responseText);
        responseJobject.ReadFrom(responseText);
        responseJobject.SelectToken('data', l_jtoken);
        JArray := l_jtoken.AsArray();
        // Message((responseText));
        // l_txtTemp := GetValueAsText(responseText, 'data');
        // Message(l_txtTemp);
        // message(responseJobject.);
        // JArray.ReadFrom(responseText);
        // CurrReport.Skip();
        foreach l_custToken in JArray do begin

            l_txSalesHeaderId := GetValueAsText(l_custToken, 'id');
            Message(l_txSalesHeaderId);
            l_txSalesHeaderId := GetValueAsText(l_custToken, 'name');
            Message(l_txSalesHeaderId);


        end;
    end;

    procedure SelectJsonToken(JObject: JsonObject; Path: Text): Text
    var
        JToken: JsonToken;
    begin
        if JObject.SelectToken(Path, JToken) then
            if NOT JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsText());
    end;

    procedure GetValueAsText(JToken: JsonToken; ParamString: Text): Text
    var
        JObject: JsonObject;
    begin
        JObject := JToken.AsObject();
        exit(SelectJsonToken(JObject, ParamString));
    end;

    // procedure GetJsonToken(JsonObject: JsonObject; TokenKey: Text) JsonToken: JsonToken;
    // var
    //     myInt: Integer;
    // begin
    //     if not JsonObject.Get(TokenKey, JsonToken) then
    //         Error('Could not find a token with key %1', TokenKey);
    // end;

    var
        g_TbSalesSetup: Record "Sales & Receivables Setup";
        g_ReqDate: Date;
        JToken: JsonToken;
        JObject: JsonObject;
        JArray: JsonArray;
}