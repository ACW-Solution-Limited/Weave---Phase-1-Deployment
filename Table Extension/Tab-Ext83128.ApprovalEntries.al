tableextension 83128 ApprovalEntries extends "Approval Entry"
{

    trigger OnAfterInsert()
    var
        l_cduApprovalEntries: codeunit "Approval Entries";
    begin
        //     l_cduApprovalEntries.UpdateApprovalEntry(Rec);
    end;
}
