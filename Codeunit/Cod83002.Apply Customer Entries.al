codeunit 82004 "Apply Customer Entries"
{
    procedure ApplyCustomerEntry(var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        CustEntryApplyPostEntries: Codeunit "CustEntry-Apply Posted Entries";
    begin
        //CustEntryApplyPostEntries.ApplyCustEntryFormEntry(CustLedgerEntry);  Phase 2
    end;



}
