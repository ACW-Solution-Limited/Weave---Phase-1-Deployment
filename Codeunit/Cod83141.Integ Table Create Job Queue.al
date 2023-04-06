codeunit 83141 "Integ. Table Create Job Queue"
{
    procedure CreateCustomSyncJobQueueEntry(var TableMappingRec: Record "Integration Table Mapping")
    var
        JobQueueEntry: Record "Job Queue Entry";

    begin

        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Integration Synch. Job Runner");
        JobQueueEntry.SetRange("Record ID to Process", TableMappingRec.RecordId());
        JobQueueEntry.DeleteTasks();

        JobQueueEntry.InitRecurringJob(1);
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"Integration Synch. Job Runner";
        JobQueueEntry."Record ID to Process" := TableMappingRec.RecordId();
        JobQueueEntry."Run in User Session" := false;

        JobQueueEntry.Description := ' ' + TableMappingRec.Name + ' - Dataverse Synchronization Job';
        JobQueueEntry."Maximum No. of Attempts to Run" := 10;
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry."Rerun Delay (sec.)" := 30;
        JobQueueEntry."Inactivity Timeout Period" := 5;
        JobQueueEntry.Scheduled := true;
        JobQueueEntry."Recurring Job" := true;
        Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);

    end;

}
