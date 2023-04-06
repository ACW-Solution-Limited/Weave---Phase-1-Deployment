report 83013 "Approve/Reject PO PowerApp"
{
    ApplicationArea = All;
    Caption = 'Approve/Reject PO PowerApp';
    UsageCategory = Tasks;
    ProcessingOnly = True;
    dataset
    {
        dataitem(ApprovalRecordforPowerApp; "Approval Record for PowerApp")
        {
            DataItemTableView = sorting("Purchase No.") where(Completed = filter(false));
            trigger OnAfterGetRecord()
            var
                l_recApprovalEntry: Record "Approval Entry";

                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            begin
                l_recApprovalEntry.reset;
                l_recApprovalEntry.SetRange("Workflow Step Instance ID", WorkingInstanceID);
                If l_recApprovalEntry.FindLast() then begin
                    If "Approve/Reject" = "Approve/Reject"::Approve then
                        ApprovalsMgmt.ApproveApprovalRequests(l_recApprovalEntry);
                    If "Approve/Reject" = "Approve/Reject"::Reject then
                        ApprovalsMgmt.RejectApprovalRequests(l_recApprovalEntry);
                    ApprovalRecordforPowerApp."Approved Date" := WorkDate();
                    ApprovalRecordforPowerApp."Record to Approve" := l_recApprovalEntry."Record ID to Approve";
                    ApprovalRecordforPowerApp.Completed := true;
                    ApprovalRecordforPowerApp.Modify();
                end;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
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
}
