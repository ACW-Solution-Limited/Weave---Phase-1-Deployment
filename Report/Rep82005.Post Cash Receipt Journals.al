report 82005 "Post Cash Receipt Journals"
{
    ApplicationArea = All;
    Caption = 'Post Cash Receipt Journals';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = True;
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Posting Date") WHERE("Journal Batch Name" = filter('STRIPE'), "Document No." = CONST('GJ2210-0009'));
            trigger OnPostDataItem()
            var
                PostedGenPost: Codeunit "Gen. Jnl.-Post";
            begin

                SendToPosting(Codeunit::"Gen. Jnl.-Post");
                //  CurrentJnlBatchName := GetRangeMax("Journal Batch Name");
                // SetJobQueueVisibility();
                //  CurrPage.Update(false);
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
