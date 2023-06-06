enum 80004 "External Payment Gateway"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Stripe)
    {
        Caption = 'Stripe';
    }
    value(2; QFPay)
    {
        Caption = 'QFPay';
    }
}
