report 82001 "Create Stripe Customer"
{
    ApplicationArea = All;
    Caption = 'Create Stripe Customer';
    UsageCategory = ReportsAndAnalysis;
    AdditionalSearchTerms = 'Create Stripe Customer';
    UseRequestPage = true;
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
                    field(g_TxtCustDesc; g_TxtCustDesc)
                    {
                        Caption = 'Customer Name';
                        ApplicationArea = All;
                    }

                    field(g_TxtCustEmail; g_TxtCustEmail)
                    {
                        Caption = 'Customer Email';
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


        // g_TbSalesSetup.TestField("Sales API Endpoint");
        // g_TbSalesSetup.TestField("Sales API Token");
        // g_TbSalesSetup.TestField("Shop Dimension");
        // g_TbSalesSetup.TestField("Section Dimension");

        // if g_ReqDate = 0D then
        //     g_ReqDate := Today;

        // formattedDate := StrSubstNo('%1-%2-%3', Date2DMY(g_ReqDate, 3), Date2DMY(g_ReqDate, 2), Date2DMY(g_ReqDate, 1));

        // APIEndpoint := g_TbSalesSetup."Sales API Endpoint";
        requestUri := StrSubstNo('%1?name=%2&email=%3', APIEndpoint, g_TxtCustDesc, g_TxtCustEmail);
        Message(requestUri);
        //CurrReport.Skip();
        request.SetRequestUri(requestUri);
        request.Method := 'POST';

        contentHeaders := client.DefaultRequestHeaders;
        contentHeaders.Add('Authorization', l_txtAuth);
        client.Send(request, response);

        // // Read the response content as json.
        response.Content().ReadAs(responseText);
        Message(responseText);
        responseJobject.ReadFrom(responseText);
        responseJobject.SelectToken('name', l_jtoken);
        Message(l_jtoken.AsValue().AsText());
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

        g_TxtCustDesc: Text;

        g_TxtCustEmail: Text;

        gtxtCreatedCustDesc: Text;
        JToken: JsonToken;
        JObject: JsonObject;
        JArray: JsonArray;
}