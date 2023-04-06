report 83009 "Data Sync Job Queue"
{
    ApplicationArea = All;
    Caption = 'Data Sync Job Queue';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Data Sync Package"; "Data Sync Package")
        {
            DataItemTableView = where(Enabled = filter(true));

            trigger OnAfterGetRecord()

            var
                l_cduDataSyncJobQueue: Codeunit "Data Sync Job Queue";
            begin
                clear(l_cduDataSyncJobQueue);
                l_cduDataSyncJobQueue.SyncData(code);
            end;

        }
    }

}
