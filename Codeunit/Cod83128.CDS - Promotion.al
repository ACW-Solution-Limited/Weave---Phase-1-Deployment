codeunit 83128 CDSPromotion
{
    local procedure LookupCRMPromotion(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMPromotion: Record "CDS acwapp_promotioncode";
        OriginalCRMPromotion: Record "CDS acwapp_promotioncode";
        OriginalCRMPromotionList: Page "CRM Promotion";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMPromotion.Get(CRMId) then
                OriginalCRMPromotionList.SetRecord(CRMPromotion);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMPromotion.Get(SavedCRMId) then
                    OriginalCRMPromotionList.SetCurrentlyCoupledCRMPromotion(OriginalCRMPromotion);
        end;

        CRMPromotion.SetView(IntTableFilter);
        OriginalCRMPromotionList.SetTableView(CRMPromotion);
        OriginalCRMPromotionList.LookupMode(true);
        if OriginalCRMPromotionList.RunModal = ACTION::LookupOK then begin
            OriginalCRMPromotionList.GetRecord(CRMPromotion);
            CRMId := CRMPromotion.acwapp_promotioncodeId;
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
        if BCTableNo = DATABASE::"Promotion" then begin
            CDSTableNo := DATABASE::"CDS acwapp_promotioncode";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_promotioncode" then
            Handled := LookupCRMPromotion(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Promotion', DATABASE::"CDS acwapp_promotioncode", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Promotion', DATABASE::"Promotion", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMPromotion: Record "CDS acwapp_promotioncode";
        Promotion: Record "Promotion";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Promotion',
        DATABASE::"Promotion", DATABASE::"CDS acwapp_promotioncode", CRMPromotion.FieldNo(acwapp_promotioncodeId), CRMPromotion.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Promotion', Promotion.FieldNo("Key"), CRMPromotion.FieldNo(acwapp_promotioncodeId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Promotion', Promotion.FieldNo(Code), CRMPromotion.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Promotion', Promotion.FieldNo(Type), CRMPromotion.FieldNo(acwapp_promotioncodechargetype), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Promotion', Promotion.FieldNo(Description), CRMPromotion.FieldNo(acwapp_description), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);


        // IntegrationTableMapping.reset;
        // IntegrationTableMapping.SetFilter(Name, 'CRM to BC Promotion');
        // CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;
}
