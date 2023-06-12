codeunit 83138 CDSLocker
{
    local procedure LookupCRMLocker(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMLocker: Record "CDS acwapp_Locker";
        OriginalCRMLocker: Record "CDS acwapp_Locker";
        OriginalCRMLockerList: Page "CRM Locker";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMLocker.Get(CRMId) then
                OriginalCRMLockerList.SetRecord(CRMLocker);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMLocker.Get(SavedCRMId) then
                    OriginalCRMLockerList.SetCurrentlyCoupledCRMLocker(OriginalCRMLocker);
        end;



        CRMLocker.SetView(IntTableFilter);
        OriginalCRMLockerList.SetTableView(CRMLocker);
        OriginalCRMLockerList.LookupMode(true);
        if OriginalCRMLockerList.RunModal = ACTION::LookupOK then begin
            OriginalCRMLockerList.GetRecord(CRMLocker);
            CRMId := CRMLocker.acwapp_LockerId;
            exit(true);
        end;
        exit(false);
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]

    local procedure OnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var handled: Boolean);
    begin
        if BCTableNo = DATABASE::"Locker" then begin
            CDSTableNo := DATABASE::"CDS acwapp_Locker";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_Locker" then
            Handled := LookupCRMLocker(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin


        AddEntityTableMapping('CRM to BC Locker', DATABASE::"CDS acwapp_Locker", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Locker', DATABASE::"Locker", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMLocker: Record "CDS acwapp_Locker";
        Locker: Record "Locker";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;

        InsertIntegrationTableMapping(
         IntegrationTableMapping, 'CRM to BC Locker',
          DATABASE::"Locker", DATABASE::"CDS acwapp_Locker", CRMLocker.FieldNo(acwapp_LockerId), CRMLocker.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("CRM Guid"), CRMLocker.FieldNo(acwapp_LockerId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("Locker ID"), CRMLocker.FieldNo(acwapp_ID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("Locker Type Name"), CRMLocker.FieldNo(acwapp_LockerTypeName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("Locker Property Guid"), CRMLocker.FieldNo(acwapp_Locker), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("Contract No."), CRMLocker.FieldNo(acwapp_ContractNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("Start Date"), CRMLocker.FieldNo(acwapp_StartDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("End Date"), CRMLocker.FieldNo(acwapp_EndDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo(Status), CRMLocker.FieldNo(statecode), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("Created On"), CRMLocker.FieldNo(CreatedOn), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("Modified On"), CRMLocker.FieldNo(ModifiedOn), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Locker', Locker.FieldNo("Monthy Rent"), CRMLocker.FieldNo(acwapp_MonthlyRent), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);

        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field35=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();


        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Locker');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);

    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";
}
