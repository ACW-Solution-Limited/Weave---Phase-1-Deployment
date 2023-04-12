codeunit 83136 CDSProductInventory
{
    local procedure LookupCRMProduct(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMProductInventory: Record "CDS acwapp_productinventory";
        OriginalCRMProductInventory: Record "CDS acwapp_productinventory";
        OriginalCRMProductInventoryList: Page "CRM - Product Inventory Line";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMProductInventory.Get(CRMId) then
                OriginalCRMProductInventoryList.SetRecord(CRMProductInventory);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMProductInventory.Get(SavedCRMId) then
                    OriginalCRMProductInventoryList.SetCurrentlyCoupledCRMProductInventory(OriginalCRMProductInventory);
        end;



        CRMProductInventory.SetView(IntTableFilter);
        OriginalCRMProductInventoryList.SetTableView(CRMProductInventory);
        OriginalCRMProductInventoryList.LookupMode(true);
        if OriginalCRMProductInventoryList.RunModal = ACTION::LookupOK then begin
            OriginalCRMProductInventoryList.GetRecord(CRMProductInventory);
            CRMId := CRMProductInventory.acwapp_productinventoryId;
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
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::ToIntegrationTable, 'CDS');
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
        if BCTableNo = DATABASE::Item then begin
            CDSTableNo := DATABASE::"CDS acwapp_productinventory";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_productinventory" then
            Handled := LookupCRMProduct(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;
        if (CompanyInformation."SG Master Company") = false AND (CompanyInformation."HK Master Company") = false then begin
            AddEntityTableMapping('BC to CRM ProdLine', DATABASE::"CDS acwapp_productinventory", TempNameValueBuffer);
            AddEntityTableMapping('BC to CRM ProdLine', DATABASE::Item, TempNameValueBuffer);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMProduct: Record "CDS acwapp_productinventory";
        Item: Record Item;
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;
        if (CompanyInformation."SG Master Company") = false AND (CompanyInformation."HK Master Company") = false then begin
            InsertIntegrationTableMapping(
             IntegrationTableMapping, 'BC to CRM ProdLine',
              DATABASE::Item, DATABASE::"CDS acwapp_productinventory", CRMProduct.FieldNo(acwapp_productinventoryId), CRMProduct.FieldNo(ModifiedOn), '', '', false);
            InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("CRM Company Guid"), CRMProduct.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("No."), CRMProduct.FieldNo(acwapp_ProductID), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo(Description), CRMProduct.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            //InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("Product Type GUId for CRM"), CRMProduct.FieldNo(acwapp_ProductType), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            // InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("Base Unit of Measure"), CRMProduct.FieldNo(acwapp_UnitOfMeasure), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            // InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("Unit Price"), CRMProduct.FieldNo(acwapp_UnitPrice), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            // InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("Available On Booking Site"), CRMProduct.FieldNo(acwapp_AvailableOnBookingSite), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("Inventory"), CRMProduct.FieldNo(acwapp_inventory), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            // InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("Subscription/Immediate"), CRMProduct.FieldNo(acwapp_SubscriptionImmediate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            // InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("Subscription Period Type"), CRMProduct.FieldNo(acwapp_SubscriptionPeriodType), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
            //InsertIntegrationFieldMapping('BC to CRM ProdLine', Item.FieldNo("Subscription Period"), CRMProduct.FieldNo(acwapp_SubscriptionPeriod), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);

            IntegrationTableMapping.reset;
            IntegrationTableMapping.SetFilter(Name, 'BC to CRM ProdLine');
            CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
        end;
    end;

}
