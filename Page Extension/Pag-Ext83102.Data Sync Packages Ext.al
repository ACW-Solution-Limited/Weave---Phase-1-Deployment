pageextension 83102 "Data Sync Packages Ext" extends "Data Sync Packages"
{


    actions
    {

        addlast(Processing)
        {

            action("Setup a Job Queue")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    JobQueueEntry: Record "Job Queue Entry";
                begin

                    if not Confirm('Do you want to create a job queue entry now?') then
                        exit;


                    JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
                    JobQueueEntry.SetRange("Object ID to Run", Report::"Data Sync Job Queue");
                    JobQueueEntry.DeleteTasks();

                    JobQueueEntry.InitRecurringJob(1);
                    JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Report;
                    JobQueueEntry."Object ID to Run" := Report::"Data Sync Job Queue";

                    JobQueueEntry."Report Output Type" := JobQueueEntry."Report Output Type"::"None (Processing only)";
                    JobQueueEntry.Description := 'Universal Data Sync';
                    JobQueueEntry."Maximum No. of Attempts to Run" := 10;
                    JobQueueEntry.Status := JobQueueEntry.Status::Ready;
                    JobQueueEntry."Rerun Delay (sec.)" := 30;
                    JobQueueEntry."Inactivity Timeout Period" := 5;
                    JobQueueEntry.Scheduled := true;
                    JobQueueEntry."Recurring Job" := true;
                    Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);

                end;

            }


        }
    }

}
