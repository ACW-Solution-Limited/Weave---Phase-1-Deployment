codeunit 83131 "CDS - Tender Type"
{
    local procedure LookupCRMTenderType(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMTenderType: Record "CDS acwapp_tendertype";
        OriginalCRMTenderType: Record "CDS acwapp_tendertype";
        OriginalCRMTenderTypeList: Page "CRM - Tender Type";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMTenderType.Get(CRMId) then
                OriginalCRMTenderTypeList.SetRecord(CRMTenderType);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMTenderType.Get(SavedCRMId) then
                    OriginalCRMTenderTypeList.SetCurrentlyCoupledCRMTenderType(OriginalCRMTenderType);
        end;

        CRMTenderType.SetView(IntTableFilter);
        OriginalCRMTenderTypeList.SetTableView(CRMTenderType);
        OriginalCRMTenderTypeList.LookupMode(true);
        if OriginalCRMTenderTypeList.RunModal = ACTION::LookupOK then begin
            OriginalCRMTenderTypeList.GetRecord(CRMTenderType);
            CRMId := CRMTenderType.acwapp_tendertypeId;
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
        if BCTableNo = DATABASE::"Tender Type Setup" then begin
            CDSTableNo := DATABASE::"CDS acwapp_tendertype";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_tendertype" then
            Handled := LookupCRMTenderType(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Tender', DATABASE::"CDS acwapp_tendertype", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Tender', DATABASE::"Tender Type Setup", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMTenderType: Record "CDS acwapp_tendertype";
        TenderTypeSetup: Record "Tender Type Setup";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        l_GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Tender',
        DATABASE::"Tender Type Setup", DATABASE::"CDS acwapp_tendertype", CRMTenderType.FieldNo(acwapp_tendertypeId), CRMTenderType.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Tender', TenderTypeSetup.FieldNo("Key"), CRMTenderType.FieldNo(acwapp_tendertypeId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Tender', TenderTypeSetup.FieldNo("Tender Type"), CRMTenderType.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Tender', TenderTypeSetup.FieldNo(Currencyid), CRMTenderType.FieldNo(transactioncurrencyid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Tender', TenderTypeSetup.FieldNo(Percentage), CRMTenderType.FieldNo(acwapp_PercentageDeduction), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Tender', TenderTypeSetup.FieldNo("Effective Start Date"), CRMTenderType.FieldNo(acwapp_EffectiveStartDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Tender', TenderTypeSetup.FieldNo("Effective End Date"), CRMTenderType.FieldNo(acwapp_EffectiveEndDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Tender', TenderTypeSetup.FieldNo(Currency), CRMTenderType.FieldNo(acwapp_CurrencyText), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);

        l_GeneralLedgerSetup.Get;
        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field40=1(' + CompanyInformation."CRM Currency Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();


        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Tender');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";
}
