pageextension 83080 "Companies Ext" extends Companies
{

    Procedure GetRecords(VAR Company: Record Company)
    begin
        CurrPage.SETSELECTIONFILTER(Rec);

        Company.COPY(Rec);
        Company.MARKEDONLY(TRUE);
        IF Company.COUNT = 0 THEN BEGIN
            Company.COPY(Rec);
            Company.MARK(TRUE);
        END;
        Company.MARKEDONLY(FALSE);
    end;
}
