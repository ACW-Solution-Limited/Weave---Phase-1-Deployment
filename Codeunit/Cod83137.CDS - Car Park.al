codeunit 83137 CDSCarPark
{
    local procedure LookupCRMCarPark(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMCarPark: Record "CDS acwapp_CarPark";
        OriginalCRMCarPark: Record "CDS acwapp_CarPark";
        OriginalCRMCarParkList: Page "CRM - Cark Park";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMCarPark.Get(CRMId) then
                OriginalCRMCarParkList.SetRecord(CRMCarPark);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMCarPark.Get(SavedCRMId) then
                    OriginalCRMCarParkList.SetCurrentlyCoupledCRMCarPark(OriginalCRMCarPark);
        end;



        CRMCarPark.SetView(IntTableFilter);
        OriginalCRMCarParkList.SetTableView(CRMCarPark);
        OriginalCRMCarParkList.LookupMode(true);
        if OriginalCRMCarParkList.RunModal = ACTION::LookupOK then begin
            OriginalCRMCarParkList.GetRecord(CRMCarPark);
            CRMId := CRMCarPark.acwapp_CarParkId;
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
        if BCTableNo = DATABASE::"Car Park" then begin
            CDSTableNo := DATABASE::"CDS acwapp_CarPark";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_CarPark" then
            Handled := LookupCRMCarPark(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin


        AddEntityTableMapping('CRM to BC Car Park', DATABASE::"CDS acwapp_CarPark", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Car Park', DATABASE::"Car Park", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMCarPark: Record "CDS acwapp_CarPark";
        CarPark: Record "Car Park";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;

        InsertIntegrationTableMapping(
         IntegrationTableMapping, 'CRM to BC Car Park',
          DATABASE::"Car Park", DATABASE::"CDS acwapp_CarPark", CRMCarPark.FieldNo(acwapp_CarParkId), CRMCarPark.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("CRM Guid"), CRMCarPark.FieldNo(acwapp_carparkId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("Car Park ID"), CRMCarPark.FieldNo(acwapp_ID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("Car Park Type Name"), CRMCarPark.FieldNo(acwapp_CarparkTypeName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("Car Park Property Guid"), CRMCarPark.FieldNo(acwapp_ParkingLot), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("Contract No."), CRMCarPark.FieldNo(acwapp_ContractNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("Start Date"), CRMCarPark.FieldNo(acwapp_StartDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("End Date"), CRMCarPark.FieldNo(acwapp_EndDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo(Status), CRMCarPark.FieldNo(statecode), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("Created On"), CRMCarPark.FieldNo(CreatedOn), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("Modified On"), CRMCarPark.FieldNo(ModifiedOn), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Car Park', CarPark.FieldNo("Monthy Rent"), CRMCarPark.FieldNo(acwapp_MonthlyRent), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);


        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field40=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();


        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Car Park');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);

    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";
}
