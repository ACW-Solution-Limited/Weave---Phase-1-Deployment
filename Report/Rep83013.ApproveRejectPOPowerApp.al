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
            DataItemTableView = sorting("Line No") where(Completed = filter(false));
            trigger OnAfterGetRecord()
            var
                l_recApprovalEntry: Record "Approval Entry";
                l_recApprovalEntryApprove: Record "Approval Entry";
                l_recApprCommentLine: Record "Approval Comment Line";
                l_recPurchaseHeader: Record "Purchase Header";

                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                entryNo: Integer;
            begin
                Clear(entryNo);
                l_recApprovalEntry.reset;
                l_recApprovalEntry.SetRange("Workflow Step Instance ID", WorkingInstanceID);
                l_recApprovalEntry.SetRange(Status, l_recApprovalEntry.Status::Open);
                l_recApprovalEntry.SetRange("Sequence No.", "Sequence No.");
                If l_recApprovalEntry.Findfirst() then begin



                    If "Approve/Reject" = "Approve/Reject"::Approve then
                        ApprovalsMgmt.ApproveApprovalRequests(l_recApprovalEntry);

                    If "Approve/Reject" = "Approve/Reject"::Reject then begin
                        ApprovalsMgmt.RejectApprovalRequests(l_recApprovalEntry);
                        /* l_recPurchaseHeader.reset;
                         l_recPurchaseHeader.SetRange("Document Type", l_recPurchaseHeader."Document Type"::Order);
                         l_recPurchaseHeader.SetRange("No.", "Purchase No.");
                         l_recPurchaseHeader.FindFirst();
                         l_recPurchaseHeader."Request Approval" := false;
                         l_recPurchaseHeader.Modify();*/
                    end;

                    ApprovalRecordforPowerApp."Approved Date" := WorkDate();
                    ApprovalRecordforPowerApp."Record to Approve" := l_recApprovalEntry."Record ID to Approve";
                    ApprovalRecordforPowerApp.Completed := true;
                    ApprovalRecordforPowerApp.Modify();

                    l_recPurchaseHeader.reset;
                    l_recPurchaseHeader.SetRange("Document Type", l_recPurchaseHeader."Document Type"::Order);
                    l_recPurchaseHeader.SetRange("No.", "Purchase No.");
                    l_recPurchaseHeader.FindFirst();

                    l_recApprCommentLine.reset;
                    l_recApprCommentLine.FindLast();
                    entryNo := l_recApprCommentLine."Entry No.";
                    If Comment <> '' then begin
                        l_recApprCommentLine.reset;
                        l_recApprCommentLine."Entry No." := entryNo + 1;
                        l_recApprCommentLine."Table ID" := 38;
                        l_recApprCommentLine."Document Type" := l_recApprCommentLine."Document Type"::Quote;
                        l_recApprCommentLine."User ID" := "Approver ID";
                        l_recApprCommentLine."Record ID to Approve" := l_recPurchaseHeader.RecordId;
                        l_recApprCommentLine."Workflow Step Instance ID" := WorkingInstanceID;
                        l_recApprCommentLine.Comment := Comment;
                        l_recApprCommentLine.insert;
                    end;

                    If "Approve/Reject" = "Approve/Reject"::Reject then begin
                        If l_recPurchaseHeader."Request Approval" = true then
                            l_recPurchaseHeader."Request Approval" := false;
                        l_recPurchaseHeader.Modify();
                    end;
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
