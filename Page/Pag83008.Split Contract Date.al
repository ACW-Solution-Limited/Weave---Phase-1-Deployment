page 83008 "Split Contract Date"
{
    Caption = 'Split Contract Date';
    PageType = Card;
    // SourceTable = "";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Split Contract Date"; g_datSplitContractDate)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    // procedure SetContractDateRange(p_datFromDate: Date; p_datToDate: Date)
    // begin
    //     g_datContractFromDate := p_datFromDate;
    //     g_datContractToDate := p_datToDate;
    // end;
    procedure GetSplitContractDate(): Date
    begin
        exit(g_datSplitContractDate)
    end;

    var
        g_datSplitContractDate: Date;
    // g_datContractFromDate: Date;
    // g_datContractToDate: Date;
}
