codeunit 83142 "Approval Entries"
{
    Permissions = TableData 454 = rimd;


    procedure UpdateApprovalEntry(var l_recApprovalEntries: record "Approval Entry")
    begin

        If l_recApprovalEntries.Status = l_recApprovalEntries.status::Created then begin
            l_recApprovalEntries.Status := l_recApprovalEntries.Status::Open;
            l_recApprovalEntries.Modify();
        end;
    end;


}
