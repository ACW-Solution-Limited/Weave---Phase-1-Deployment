codeunit 83115 CDSPropertyUnit

{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var handled: Boolean)
    begin
        if BCTableNo = DATABASE::"Property Unit" then begin
            CDSTableNo := DATABASE::"CDS acwapp_propertyunit";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', true, true)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        if CRMTableID = Database::"CDS acwapp_propertyunit" then
            Handled := LookupCDSPropertyUnit(SavedCRMId, CRMId, IntTableFilter);
    end;

    local procedure LookupCDSPropertyUnit(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CDSPropertyUnit: Record "CDS acwapp_propertyunit";
        OriginalCDSPropertyUnit: Record "CDS acwapp_propertyunit";
        OriginalCDSPropertyUnitList: Page "CRM Property Unit List";

    begin
        if not IsNullGuid(CRMId) then begin
            if CDSPropertyUnit.Get(CRMId) then
                OriginalCDSPropertyUnitList.SetRecord(CDSPropertyUnit);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCDSPropertyUnit.Get(SavedCRMId) then
                    OriginalCDSPropertyUnitList.SetCurrentlyCoupledCRMPropertyUnit((OriginalCDSPropertyUnit));
        end;
        CDSPropertyUnit.SetView(IntTableFilter);
        OriginalCDSPropertyUnitList.SetTableView(CDSPropertyUnit);
        OriginalCDSPropertyUnitList.LookupMode(true);
        if OriginalCDSPropertyUnitList.RunModal = ACTION::LookupOK then begin
            OriginalCDSPropertyUnitList.GetRecord(CDSPropertyUnit);
            CRMId := CDSPropertyUnit.acwapp_propertyunitId;
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', true, true)]
    local procedure HandleOnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer" temporary);
    begin
        AddEntityTableMapping('CRM to BC Pro. Unit', DATABASE::"CDS acwapp_propertyunit", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Pro. Unit', DATABASE::"Property Unit", TempNameValueBuffer);
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
        CDSPropertyUnit: Record "CDS acwapp_propertyunit";
        PropertyUnit: Record "Property Unit";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
        FilterStr: OutStream;
        FilterText: Text[250];
    begin



        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Pro. Unit',
        DATABASE::"Property Unit", DATABASE::"CDS acwapp_propertyunit", CDSPropertyUnit.FieldNo(acwapp_propertyunitId), CDSPropertyUnit.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("No."), CDSPropertyUnit.FieldNo(acwapp_PropertyID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo(Description), CDSPropertyUnit.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo(Address), CDSPropertyUnit.FieldNo(acwapp_AddressLine1), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Address 2"), CDSPropertyUnit.FieldNo(acwapp_AddressLine2), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Sort Order"), CDSPropertyUnit.FieldNo(acwapp_SortOrder), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Property No."), CDSPropertyUnit.FieldNo(acwapp_PropertyNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Property Unit Name"), CDSPropertyUnit.FieldNo(acwapp_PropertiesName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Property Unit Group"), CDSPropertyUnit.FieldNo(acwapp_PropertyUnitName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Room Type Name"), CDSPropertyUnit.FieldNo(acwapp_RoomTypeName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Sub Type Name"), CDSPropertyUnit.FieldNo(acwapp_SubtypeName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo(Type), CDSPropertyUnit.FieldNo(acwapp_Type), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo(Floor), CDSPropertyUnit.FieldNo(acwapp_Floor), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Company Guid for CRM"), CDSPropertyUnit.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("CRM GUID"), CDSPropertyUnit.FieldNo(acwapp_propertyunitId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Unit', PropertyUnit.FieldNo("Room No."), CDSPropertyUnit.FieldNo(acwapp_PropertyID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field122=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();




        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Pro. Unit');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;


}
