report 83002 "Post IC Trans Buffer"
{
    ApplicationArea = All;
    Caption = 'Post IC Trans Buffer';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    dataset
    {
        dataitem(ICTransactionBuffer; "IC Transaction Buffer")
        {
            DataItemTableView = sorting(SystemCreatedAt) order(ascending) where(Status = const(Open));

            trigger OnPreDataItem()
            var
                l_cduNoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                clear(g_codDocNo);
                clear(g_codLastDocNo);
                clear(g_recJournalBatch);
                clear(g_recICSetup);
                g_recICSetup.get;
                g_recICSetup.TestField("Default IC Gen. Jnl. Template");
                g_recICSetup.TestField("Default IC Gen. Jnl. Batch");
                g_recJournalBatch.get(g_recICSetup."Default IC Gen. Jnl. Template", g_recICSetup."Default IC Gen. Jnl. Batch");
                g_recGenJnlLine.reset;
                g_recGenJnlLine.setrange("Journal Template Name", g_recICSetup."Default IC Gen. Jnl. Template");
                g_recGenJnlLine.SetRange("Journal Batch Name", g_recICSetup."Default IC Gen. Jnl. Batch");
                if g_recGenJnlLine.find('+') then
                    g_intLineNo := g_recGenJnlLine."Line No." + 10000
                else
                    g_intLineNo := 10000;

                commit;

                g_codDocNo := l_cduNoSeriesMgt.GetNextNo(g_recJournalBatch."No. Series", ICTransactionBuffer."Posting Date", true);

            end;

            trigger OnAfterGetRecord()
            var
                l_cduNoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if ICTransactionBuffer.status = ICTransactionBuffer.Status::Open then begin
                    g_recGenJnlLine.init;
                    g_recGenJnlLine."Journal Template Name" := g_recICSetup."Default IC Gen. Jnl. Template";
                    g_recGenJnlLine."Journal Batch Name" := g_recICSetup."Default IC Gen. Jnl. Batch";
                    g_recGenJnlLine."Line No." := g_intLineNo;
                    if g_recGenJnlLine.insert then;

                    if (g_codLastDocNo <> '') AND (ICTransactionBuffer."Document No." <> g_codLastDocNo) then begin
                        g_codDocNo := IncStr(g_codDocNo);

                    end;
                    g_codLastDocNo := ICTransactionBuffer."Document No.";
                    g_recGenJnlLine."Document No." := g_codDocNo;

                    g_recGenJnlLine.Validate("Posting Date", ICTransactionBuffer."Posting Date");
                    g_recGenJnlLine.validate("Account Type", ICTransactionBuffer."Account Type");
                    g_recGenJnlLine.validate("Account No.", ICTransactionBuffer."Account No.");
                    g_recGenJnlLine.validate("External Document No.", ICTransactionBuffer."Document No.");
                    g_recGenJnlLine.validate("Currency Code", ICTransactionBuffer."Currency Code");
                    g_recGenJnlLine.validate(Amount, ICTransactionBuffer.Amount);
                    if ICTransactionBuffer."Bal. Account No." <> '' then begin
                        g_recGenJnlLine.validate("Bal. Account Type", ICTransactionBuffer."Bal. Account Type");
                        g_recGenJnlLine.validate("Bal. Account No.", ICTransactionBuffer."Bal. Account No.");
                    end;
                    g_recGenJnlLine.Modify();
                    ICTransactionBuffer."Journal Template" := g_recGenJnlLine."Journal Template Name";
                    ICTransactionBuffer."Journal Batch Name" := g_recGenJnlLine."Journal Batch Name";
                    ICTransactionBuffer."Journal Line No." := g_recGenJnlLine."Line No.";
                    ICTransactionBuffer.Status := ICTransactionBuffer.Status::Created;
                    ICTransactionBuffer.Modify();
                    g_intLineNo += 10000;

                end;

            end;

            trigger OnPostDataItem()
            var
                l_cduGenBatchPost: Codeunit "Gen. Jnl.-Post Batch";
                l_recICTransBuffer: Record "IC Transaction Buffer";
                l_recICTransBuffer2: Record "IC Transaction Buffer";

            begin
                g_recGenJnlLine.reset;
                g_recGenJnlLine.setrange("Journal Template Name", g_recICSetup."Default IC Gen. Jnl. Template");
                g_recGenJnlLine.SetRange("Journal Batch Name", g_recICSetup."Default IC Gen. Jnl. Batch");
                if g_recGenJnlLine.findset then begin
                    Commit();
                    if l_cduGenBatchPost.run(g_recGenJnlLine) then begin
                        l_recICTransBuffer.reset;
                        l_recICTransBuffer.SetRange(status, l_recICTransBuffer.Status::Created);
                        l_recICTransBuffer.SetRange("Journal Template", g_recICSetup."Default IC Gen. Jnl. Template");
                        l_recICTransBuffer.SetRange("Journal Batch Name", g_recICSetup."Default IC Gen. Jnl. Batch");
                        if l_recICTransBuffer.findset then
                            repeat
                                if l_recICTransBuffer2.get(l_recICTransBuffer."Id") then begin
                                    l_recICTransBuffer2.status := l_recICTransBuffer2.Status::Posted;
                                    l_recICTransBuffer2.Modify();
                                end;
                            until l_recICTransBuffer.next = 0;

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
    var
        g_recICSetup: Record "IC Setup";
        g_intLineNo: Integer;
        g_recGenJnlLine: Record "Gen. Journal Line";
        g_codLastDocNo: Code[20];
        g_codDocNo: code[20];
        g_recJournalBatch: Record "Gen. Journal Batch";

}
