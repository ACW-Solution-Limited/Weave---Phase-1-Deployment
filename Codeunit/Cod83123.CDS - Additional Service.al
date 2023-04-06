codeunit 83123 "CDS Additional Service"
{
    local procedure LookupCRMAdditionalServices(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMAdditionalServices: Record "CDS acwapp_additionalservice";
        OriginalCRMAdditionalServices: Record "CDS acwapp_additionalservice";
        OriginalCRMAdditionalServicesList: Page "CRM Additional Service";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMAdditionalServices.Get(CRMId) then
                OriginalCRMAdditionalServicesList.SetRecord(CRMAdditionalServices);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMAdditionalServices.Get(SavedCRMId) then
                    OriginalCRMAdditionalServicesList.SetCurrentlyCoupledCRMAdditionalservice(OriginalCRMAdditionalServices);
        end;



        CRMAdditionalServices.SetView(IntTableFilter);
        OriginalCRMAdditionalServicesList.SetTableView(CRMAdditionalServices);
        OriginalCRMAdditionalServicesList.LookupMode(true);
        if OriginalCRMAdditionalServicesList.RunModal = ACTION::LookupOK then begin
            OriginalCRMAdditionalServicesList.GetRecord(CRMAdditionalServices);
            CRMId := CRMAdditionalServices.acwapp_additionalserviceId;
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
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::Bidirectional, 'CDS');
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
        if BCTableNo = DATABASE::"Welcome Amenities" then begin
            CDSTableNo := DATABASE::"CDS acwapp_additionalservice";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_additionalservice" then
            Handled := LookupCRMAdditionalServices(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Add. Ser', DATABASE::"CDS acwapp_additionalservice", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Add. Ser', DATABASE::"Additional Service", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMAdditionalServices: Record "CDS acwapp_additionalservice";
        AdditionalService: Record "Additional Service";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
         IntegrationTableMapping, 'CRM to BC Add. Ser',
          DATABASE::"Additional Service", DATABASE::"CDS acwapp_additionalservice", CRMAdditionalServices.FieldNo(acwapp_additionalserviceId), CRMAdditionalServices.FieldNo(ModifiedOn), '', '', false);
        //InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Property No."),CRMAdditionalServices.FieldNo(acwapp_propertyno), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo(CompanyId), CRMAdditionalServices.FieldNo(acwapp_company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Key"), CRMAdditionalServices.FieldNo(acwapp_additionalserviceId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Contract No."), CRMAdditionalServices.FieldNo(acwapp_contractno), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Item No."), CRMAdditionalServices.FieldNo(acwapp_productid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        //InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Item Description"), CRMAdditionalServices.FieldNo(acwapp_ProductName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Customer Name"), CRMAdditionalServices.FieldNo(acwapp_account), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Customer No."), CRMAdditionalServices.FieldNo(acwapp_accountid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo(Price), CRMAdditionalServices.FieldNo(acwapp_price), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Price Inclu. VAT"), CRMAdditionalServices.FieldNo(acwapp_netamountincludingvat), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Unit Of Measure"), CRMAdditionalServices.FieldNo(acwapp_unitofmeasure), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Quantity"), CRMAdditionalServices.FieldNo(acwapp_quantity), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Total Amount"), CRMAdditionalServices.FieldNo(acwapp_totalamountexcludevat), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Total Amount Inclu. VAT"), CRMAdditionalServices.FieldNo(acwapp_TotalAmountIncludeVAT), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Service Start Date"), CRMAdditionalServices.FieldNo(acwapp_servicestartdate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Service End Date"), CRMAdditionalServices.FieldNo(acwapp_serviceenddate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Created On"), CRMAdditionalServices.FieldNo(createdon), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Payment Status"), CRMAdditionalServices.FieldNo(acwapp_paymentstatus), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("BC Status"), CRMAdditionalServices.FieldNo(acwapp_bcstatus), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Posted Sales Invoice No."), CRMAdditionalServices.FieldNo(acwapp_postedsalesinvoices), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Stripe/QFPay Invoice ID"), CRMAdditionalServices.FieldNo(acwapp_stripeinvoiceid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Ser', AdditionalService.FieldNo("Payment Link"), CRMAdditionalServices.FieldNo(acwapp_paymentlink), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);

        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field95=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Add. Ser');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";

}
