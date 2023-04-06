codeunit 83110 CDSProduct
{
    local procedure LookupCRMProduct(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMProduct: Record "CDS acwapp_product";
        OriginalCRMProduct: Record "CDS acwapp_product";
        OriginalCRMProductList: Page "CRM Product";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMProduct.Get(CRMId) then
                OriginalCRMProductList.SetRecord(CRMProduct);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMProduct.Get(SavedCRMId) then
                    OriginalCRMProductList.SetCurrentlyCoupledCRMProduct(OriginalCRMProduct);
        end;



        CRMProduct.SetView(IntTableFilter);
        OriginalCRMProductList.SetTableView(CRMProduct);
        OriginalCRMProductList.LookupMode(true);
        if OriginalCRMProductList.RunModal = ACTION::LookupOK then begin
            OriginalCRMProductList.GetRecord(CRMProduct);
            CRMId := CRMProduct.acwapp_productId;
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
            CDSTableNo := DATABASE::"CDS acwapp_product";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_product" then
            Handled := LookupCRMProduct(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;
        if (CompanyInformation."SG Master Company") OR (CompanyInformation."HK Master Company") then begin
            AddEntityTableMapping('BC to CRM Product', DATABASE::"CDS acwapp_product", TempNameValueBuffer);
            AddEntityTableMapping('BC to CRM Product', DATABASE::Item, TempNameValueBuffer);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMProduct: Record "CDS acwapp_product";
        Item: Record Item;
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
        FilterStr: OutStream;
        FilterText: Text[250];
    begin
        CompanyInformation.Get;
        if (CompanyInformation."SG Master Company") OR (CompanyInformation."HK Master Company") then begin
            InsertIntegrationTableMapping(
             IntegrationTableMapping, 'BC to CRM Product',
              DATABASE::Item, DATABASE::"CDS acwapp_product", CRMProduct.FieldNo(acwapp_productId), CRMProduct.FieldNo(ModifiedOn), '', '', false);
            // InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Key"), CRMProduct.FieldNo(acwapp_productId), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("CRM Company Guid"), CRMProduct.FieldNo(acwapp_BCCompany), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("No."), CRMProduct.FieldNo(acwapp_ProductIDform), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo(Description), CRMProduct.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Product Type GUId for CRM"), CRMProduct.FieldNo(acwapp_ProductType), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("CRM Currency Guid"), CRMProduct.FieldNo(TransactionCurrencyId), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Base Unit of Measure"), CRMProduct.FieldNo(acwapp_UnitOfMeasure), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Unit Price"), CRMProduct.FieldNo(acwapp_UnitPrice), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Available On Booking Site"), CRMProduct.FieldNo(acwapp_AvailableOnBookingSite), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Inventory"), CRMProduct.FieldNo(acwapp_TotalStock), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Subscription/Immediate"), CRMProduct.FieldNo(acwapp_SubscriptionImmediate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Subscription Period Type"), CRMProduct.FieldNo(acwapp_SubscriptionPeriodType), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
            InsertIntegrationFieldMapping('BC to CRM Product', Item.FieldNo("Subscription Period"), CRMProduct.FieldNo(acwapp_SubscriptionPeriod), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);



            CompanyInformation.Get;
            IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
            FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field49=1(' + CompanyInformation."CRM Company Guid" + '))';
            FilterStr.Write(FilterText);
            IntegrationTableMapping.Modify();

            IntegrationTableMapping.reset;
            IntegrationTableMapping.SetFilter(Name, 'BC to CRM Product');
            CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);

        end;
    end;

}
