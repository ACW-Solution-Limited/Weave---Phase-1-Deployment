codeunit 82004 "PowerApp Po Approval"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCheckUserAsApprovalAdministrator', '', true, true)]
    local procedure OnBeforeCheckUserAsApprovalAdministrator(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        l_recCompanyInfo: Record "Company Information";
    begin
        //  Message('%1 / %2 / %3 OnBeforeCheckUserAsApprovalAdministrator', ApprovalEntry.count, ApprovalEntry.GetFilters, ApprovalEntry."Sequence No.");
        /*l_recCompanyInfo.Get;
        If (l_recCompanyInfo."HK Master Company") or (l_recCompanyInfo."SG Master Company") then
            IsHandled := true;*/
        //Message('%1 %2 %3 OnBeforeCheckUserAsApprovalAdministrator', ApprovalEntry.count, ApprovalEntry.FilterGroup, ApprovalEntry."Sequence No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApproveApprovalRequests', '', true, true)]
    local procedure OnBeforeApproveApprovalRequests(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    begin
        //Message('%1 %2 OnBeforeApproveApprovalRequests', ApprovalEntry.count, ApprovalEntry.GetFilters, ApprovalEntry."Sequence No.");

    end;

}
