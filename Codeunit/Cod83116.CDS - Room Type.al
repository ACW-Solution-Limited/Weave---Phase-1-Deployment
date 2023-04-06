codeunit 83116 CDSRoomType

{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var handled: Boolean)
    begin
        if BCTableNo = DATABASE::"Property Unit Room Type" then begin
            CDSTableNo := DATABASE::"CDS acwapp_roomtype";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', true, true)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        if CRMTableID = Database::"CDS acwapp_roomtype" then
            Handled := LookupCDSRoomtype(SavedCRMId, CRMId, IntTableFilter);
    end;

    local procedure LookupCDSRoomtype(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CDSRoomtype: Record "CDS acwapp_roomtype";
        OriginalCDSRoomtype: Record "CDS acwapp_roomtype";
        OriginalCDSRoomtypeList: Page "CRM Room Type";

    begin
        if not IsNullGuid(CRMId) then begin
            if CDSRoomtype.Get(CRMId) then
                OriginalCDSRoomtypeList.SetRecord(CDSRoomtype);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCDSRoomtype.Get(SavedCRMId) then
                    OriginalCDSRoomtypeList.SetCurrentlyCoupledCRMRoomtype((OriginalCDSRoomtype));
        end;
        CDSRoomtype.SetView(IntTableFilter);
        OriginalCDSRoomtypeList.SetTableView(CDSRoomtype);
        OriginalCDSRoomtypeList.LookupMode(true);
        if OriginalCDSRoomtypeList.RunModal = ACTION::LookupOK then begin
            OriginalCDSRoomtypeList.GetRecord(CDSRoomtype);
            CRMId := CDSRoomtype.acwapp_roomtypeId;
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', true, true)]
    local procedure HandleOnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer" temporary);
    begin
        AddEntityTableMapping('CRM to BC Room Type', DATABASE::"CDS acwapp_roomtype", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Room Type', DATABASE::"Property Unit Room Type", TempNameValueBuffer);
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
        CDSRoomtype: Record "CDS acwapp_roomtype";
        Roomtype: Record "Property Unit Room Type";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
        FilterStr: OutStream;
        FilterText: Text[250];
    begin



        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Room Type',
        DATABASE::"Property Unit Room Type", DATABASE::"CDS acwapp_roomtype", CDSRoomtype.FieldNo(acwapp_roomtypeId), CDSRoomtype.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Room Type', Roomtype.FieldNo("Key"), CDSRoomtype.FieldNo(acwapp_roomtypeId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Room Type', Roomtype.FieldNo("Company Guid for CRM"), CDSRoomtype.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Room Type', Roomtype.FieldNo(Description), CDSRoomtype.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Room Type', Roomtype.FieldNo("Property No."), CDSRoomtype.FieldNo(acwapp_PropertyName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Room Type', Roomtype.FieldNo(Code), CDSRoomtype.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);


        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field89=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();




        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Room Type');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;


}
