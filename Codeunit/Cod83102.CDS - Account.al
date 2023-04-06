codeunit 83102 "CDS Customer"

{
    // ACWHK
    // #001 2022.07.22 LC - CRM Account 
    // #002 2022.07.22 LC - Add Job Queue Entry

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var handled: Boolean)
    begin
        if BCTableNo = DATABASE::"Customer" then begin
            CDSTableNo := DATABASE::"CRM Account";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', true, true)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        if CRMTableID = Database::"CRM Account" then
            Handled := LookupCDSCustomer(SavedCRMId, CRMId, IntTableFilter);
    end;

    local procedure LookupCDSCustomer(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CDSCustomer: Record "CRM Account";
        OriginalCDSCustomer: Record "CRM Account";
        OriginalCDSCustomerList: Page "CDS Account List";

    begin
        if not IsNullGuid(CRMId) then begin
            if CDSCustomer.Get(CRMId) then
                OriginalCDSCustomerList.SetRecord(CDSCustomer);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCDSCustomer.Get(SavedCRMId) then
                    OriginalCDSCustomerList.SetCurrentlyCoupledCRMAccount((OriginalCDSCustomer));
        end;
        CDSCustomer.SetView(IntTableFilter);
        OriginalCDSCustomerList.SetTableView(CDSCustomer);
        OriginalCDSCustomerList.LookupMode(true);
        if OriginalCDSCustomerList.RunModal = ACTION::LookupOK then begin
            OriginalCDSCustomerList.GetRecord(CDSCustomer);
            CRMId := CDSCustomer.AccountId;
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', true, true)]
    local procedure HandleOnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer" temporary);

    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;
        if (CompanyInformation."HK Master Company") then begin
            AddEntityTableMapping('CRM to BC Account', DATABASE::"CRM Account", TempNameValueBuffer);
            AddEntityTableMapping('CRM to BC Account', DATABASE::"Customer", TempNameValueBuffer);
        end;
    end;

    local procedure AddEntityTableMapping(CRMEntityTypeName: Text; TableID: Integer; var TempNameValueBuffer: Record "Name/Value Buffer" temporary)
    begin
        TempNameValueBuffer.Init();
        TempNameValueBuffer.ID := TempNameValueBuffer.Count + 1;
        TempNameValueBuffer.Name := CopyStr(CRMEntityTypeName, 1, MaxStrLen(TempNameValueBuffer.Name));
        TempNameValueBuffer.Value := Format(TableID);
        TempNameValueBuffer.Insert();
    end;

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    var
        l_cduCRMSetupDefaults: Codeunit "CRM Setup Defaults";
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::FromIntegrationTable, 'CDS');


    end;

    procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection,
        ConstValue, ValidateField, ValidateIntegrationTableField);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', true, true)]
    local procedure HandleOnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup")
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CDSCustomer: Record "CRM Account";
        Customer: Record "Customer";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;
        if (CompanyInformation."HK Master Company") then begin
            InsertIntegrationTableMapping(
            IntegrationTableMapping, 'CRM to BC Account',
            DATABASE::"Customer", DATABASE::"CRM Account", CDSCustomer.FieldNo(AccountId), CDSCustomer.FieldNo(ModifiedOn), '', '', false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("No."), CDSCustomer.FieldNo(acwapp_AccountID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo(Name), CDSCustomer.FieldNo(Name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("First Name"), CDSCustomer.FieldNo(acwapp_FirstName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("Last Name"), CDSCustomer.FieldNo(acwapp_LastName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("E-Mail"), CDSCustomer.FieldNo(acwapp_PrimaryEmail), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo(Address), CDSCustomer.FieldNo(Address1_Line1), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("Address 2"), CDSCustomer.FieldNo(Address1_Line2), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("Address 3"), CDSCustomer.FieldNo(Address1_Line3), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("CRM GUID"), CDSCustomer.FieldNo(accountId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            //Add field for CRM >>
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("Customer Posting Group"), CDSCustomer.FieldNo(acwapp_CustomerPostingGroup), IntegrationFieldMapping.Direction::FromIntegrationTable, '', false, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("Gen. Bus. Posting Group"), CDSCustomer.FieldNo(acwapp_GenBusPostingGroup), IntegrationFieldMapping.Direction::FromIntegrationTable, '', false, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("VAT Bus. Posting Group"), CDSCustomer.FieldNo(acwapp_VATBusPostingGroup), IntegrationFieldMapping.Direction::FromIntegrationTable, '', false, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("HK Customer"), CDSCustomer.FieldNo(acwapp_HKCustomer), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('CRM to BC Account', Customer.FieldNo("SG Customer"), CDSCustomer.FieldNo(acwapp_SGCustomer), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            //Add field for CRM <<
            IntegrationTableMapping.reset;
            IntegrationTableMapping.SetFilter(Name, 'CRM to BC Account');
            CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
        end;
    end;

    procedure CreateCustomSyncJobQueueEntry(TableMappingRec: Record "Integration Table Mapping")
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

