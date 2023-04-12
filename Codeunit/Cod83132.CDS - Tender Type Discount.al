codeunit 83132 "CDS - Tender Type Discount"
{
    local procedure LookupCRMTenderTypeDiscount(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMTenderTypeDiscount: Record "CDS acwapp_TenderTypeDiscount";
        OriginalCRMTenderTypeDiscount: Record "CDS acwapp_TenderTypeDiscount";
        OriginalCRMTenderTypeDiscountList: Page "CRM - Tender Type Discount";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMTenderTypeDiscount.Get(CRMId) then
                OriginalCRMTenderTypeDiscountList.SetRecord(CRMTenderTypeDiscount);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMTenderTypeDiscount.Get(SavedCRMId) then
                    OriginalCRMTenderTypeDiscountList.SetCurrentlyCoupledCRMTenderTypeDiscount(OriginalCRMTenderTypeDiscount);
        end;

        CRMTenderTypeDiscount.SetView(IntTableFilter);
        OriginalCRMTenderTypeDiscountList.SetTableView(CRMTenderTypeDiscount);
        OriginalCRMTenderTypeDiscountList.LookupMode(true);
        if OriginalCRMTenderTypeDiscountList.RunModal = ACTION::LookupOK then begin
            OriginalCRMTenderTypeDiscountList.GetRecord(CRMTenderTypeDiscount);
            CRMId := CRMTenderTypeDiscount.acwapp_TenderTypeDiscountId;
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
        if BCTableNo = DATABASE::"Tender Type Discount" then begin
            CDSTableNo := DATABASE::"CDS acwapp_TenderTypeDiscount";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_TenderTypeDiscount" then
            Handled := LookupCRMTenderTypeDiscount(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC TendType', DATABASE::"CDS acwapp_TenderTypeDiscount", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC TendType', DATABASE::"Tender Type Discount", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMTenderTypeDiscount: Record "CDS acwapp_TenderTypeDiscount";
        TenderTypeDiscount: Record "Tender Type Discount";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC TendType',
        DATABASE::"Tender Type Discount", DATABASE::"CDS acwapp_TenderTypeDiscount", CRMTenderTypeDiscount.FieldNo(acwapp_TenderTypeDiscountId), CRMTenderTypeDiscount.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo(CompanyId), CRMTenderTypeDiscount.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("Key"), CRMTenderTypeDiscount.FieldNo(acwapp_TenderTypeDiscountId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo(CurrencyId), CRMTenderTypeDiscount.FieldNo(acwapp_Currency), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("Sales Invoice No."), CRMTenderTypeDiscount.FieldNo(acwapp_PostedSalesInvoiceName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("Tender Type"), CRMTenderTypeDiscount.FieldNo(acwapp_tendertypetext), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("Tender Discount Amount"), CRMTenderTypeDiscount.FieldNo(acwapp_DiscountAmount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("Payment Amount"), CRMTenderTypeDiscount.FieldNo(acwapp_PaymentAmount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("Payment Intent"), CRMTenderTypeDiscount.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("CompanyId"), CRMTenderTypeDiscount.FieldNo(acwapp_company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("Payment Reference Id"), CRMTenderTypeDiscount.FieldNo(acwapp_PaymentReferenceID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC TendType', TenderTypeDiscount.FieldNo("Stripe Invoice ID"), CRMTenderTypeDiscount.FieldNo(acwapp_PaymentReferenceID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field56=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();


        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC TendType');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";
}

