enum 82000 "Payment Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Pending)
    {
        Caption = 'Pending';
    }
    value(2; Overdue)
    {
        Caption = 'Overdue';
    }
    value(3; Paid)
    {
        Caption = 'Paid';
    }


}
