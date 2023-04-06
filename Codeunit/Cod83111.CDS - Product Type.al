codeunit 83111 CDSProductTypeType
{
    local procedure LookupCRMProductType(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMProductType: Record "CDS acwapp_producttype";
        OriginalCRMProductType: Record "CDS acwapp_producttype";
        OriginalCRMProductTypeList: Page "CRM Product Type";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMProductType.Get(CRMId) then
                OriginalCRMProductTypeList.SetRecord(CRMProductType);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMProductType.Get(SavedCRMId) then
                    OriginalCRMProductTypeList.SetCurrentlyCoupledCRMProductType(OriginalCRMProductType);
        end;



        CRMProductType.SetView(IntTableFilter);
        OriginalCRMProductTypeList.SetTableView(CRMProductType);
        OriginalCRMProductTypeList.LookupMode(true);
        if OriginalCRMProductTypeList.RunModal = ACTION::LookupOK then begin
            OriginalCRMProductTypeList.GetRecord(CRMProductType);
            CRMId := CRMProductType.acwapp_ProductTypeId;
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
        if BCTableNo = DATABASE::"Product Type" then begin
            CDSTableNo := DATABASE::"CDS acwapp_producttype";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_producttype" then
            Handled := LookupCRMProductType(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Prod. Type', DATABASE::"CDS acwapp_producttype", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Prod. Type', DATABASE::"Product Type", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMProductType: Record "CDS acwapp_producttype";
        ProductType: Record "Product Type";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
         IntegrationTableMapping, 'CRM to BC Prod. Type',
          DATABASE::"Product Type", DATABASE::"CDS acwapp_producttype", CRMProductType.FieldNo(acwapp_ProductTypeId), CRMProductType.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Prod. Type', ProductType.FieldNo(Code), CRMProductType.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Prod. Type', ProductType.FieldNo(Name), CRMProductType.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Prod. Type', ProductType.FieldNo("CRM GUID"), CRMProductType.FieldNo(acwapp_producttypeId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);


        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Prod. Type');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

}
