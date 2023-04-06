codeunit 83121 CDSPropertyBookingLine
{
    local procedure LookupCRMPropertybookingLine(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMPropertybookingLine: Record "CDS acwapp_bookingline";
        OriginalCRMPropertybookingLine: Record "CDS acwapp_bookingline";
        OriginalCRMPropertybookingLineList: Page "CRM Lease Contract Subform";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMPropertybookingLine.Get(CRMId) then
                OriginalCRMPropertybookingLineList.SetRecord(CRMPropertybookingLine);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMPropertybookingLine.Get(SavedCRMId) then
                    OriginalCRMPropertybookingLineList.SetCurrentlyCoupledCRMPropertybookingLine(OriginalCRMPropertybookingLine);
        end;

        CRMPropertybookingLine.SetView(IntTableFilter);
        OriginalCRMPropertybookingLineList.SetTableView(CRMPropertybookingLine);
        OriginalCRMPropertybookingLineList.LookupMode(true);
        if OriginalCRMPropertybookingLineList.RunModal = ACTION::LookupOK then begin
            OriginalCRMPropertybookingLineList.GetRecord(CRMPropertybookingLine);
            CRMId := CRMPropertybookingLine.acwapp_bookinglineId;
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
        if BCTableNo = DATABASE::"Lease Contract Line" then begin
            CDSTableNo := DATABASE::"CDS acwapp_bookingline";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_bookingline" then
            Handled := LookupCRMPropertybookingLine(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Pro. Line', DATABASE::"CDS acwapp_bookingline", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Pro. Line', DATABASE::"Lease Contract Line", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMPropertybookingLine: Record "CDS acwapp_bookingline";
        LeaseContractLine: Record "Lease Contract Line";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Pro. Line',
        DATABASE::"Lease Contract Line", DATABASE::"CDS acwapp_bookingline", CRMPropertybookingLine.FieldNo(acwapp_bookinglineId), CRMPropertybookingLine.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Line', LeaseContractLine.FieldNo("Key"), CRMPropertybookingLine.FieldNo(acwapp_bookinglineId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Line', LeaseContractLine.FieldNo("Key2"), CRMPropertybookingLine.FieldNo(acwapp_PropertyBooking), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Line', LeaseContractLine.FieldNo(CompanyId), CRMPropertybookingLine.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Line', LeaseContractLine.FieldNo("Contract Name"), CRMPropertybookingLine.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Line', LeaseContractLine.FieldNo("Property Unit No."), CRMPropertybookingLine.FieldNo(acwapp_PropertyID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Line', LeaseContractLine.FieldNo("Lease From Date"), CRMPropertybookingLine.FieldNo(acwapp_startdate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Line', LeaseContractLine.FieldNo("Lease To Date"), CRMPropertybookingLine.FieldNo(acwapp_enddate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Pro. Line', LeaseContractLine.FieldNo(Price), CRMPropertybookingLine.FieldNo(acwapp_price), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field53=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Pro. Line');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);

    end;

    var
        FilterStr: OutStream;

        FilterText: Text;
        CompanyInformation: Record "Company Information";


}
