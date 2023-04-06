report 82002 "Create Stripe Invoice"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    AdditionalSearchTerms = 'Create Stripe Invoice';
    UseRequestPage = true;
    ProcessingOnly = true;
    Caption = 'Create Stripe Invoice';
    dataset
    {
        // dataitem(; "")
        // {
        // }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(InvoiceNo; g_codInvoiceNo)
                    {
                        ApplicationArea = All;
                        TableRelation = "Sales Invoice Header"."No.";
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

        l_cuStripe: Codeunit Stripe;
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
        l_txtHostedInvoiceURL: text;

    begin

        //l_txtStripeCustID := l_cduStripePaymentAPI.CreateCustomer('Yuki Lam', 'yukil@acw-group.com.hk');
        // l_txtStripeCustID := 'cus_MENHhm2AcDMkaw';
        // l_txtStripeInvID := l_cduStripePaymentAPI.CreateInvoice(l_txtStripeCustID);
        // l_cduStripePaymentAPI.CreateInvoiceItem(l_txtStripeCustID, l_txtStripeInvID, 'Rent', 1, 3888800);
        // l_cduStripePaymentAPI.CreateInvoiceItem(l_txtStripeCustID, l_txtStripeInvID, 'Rent', 1, 888800);
        // l_txtHostedInvoiceURL := l_cduStripePaymentAPI.FinalizeInvoice(l_txtStripeInvID);
        // Hyperlink(l_txtHostedInvoiceURL);
        l_recSalesInvoiceHeader.get(g_codInvoiceNo);
        if l_cuStripe.SendSalesInvoiceToStripe(l_recSalesInvoiceHeader, l_txtHostedInvoiceURL) then
            Hyperlink(l_txtHostedInvoiceURL);

    end;

    var
        g_codInvoiceNo: Code[20];
}
