codeunit 83122 "CDS Welcome Amentities"
{
    local procedure LookupCRMWelcomeAmenities(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMWelcomeAmenities: Record "CDS acwapp_welcomeamenities";
        OriginalCRMWelcomeAmenities: Record "CDS acwapp_welcomeamenities";
        OriginalCRMWelcomeAmenitiesList: Page "CRM Welcome Amentities";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMWelcomeAmenities.Get(CRMId) then
                OriginalCRMWelcomeAmenitiesList.SetRecord(CRMWelcomeAmenities);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMWelcomeAmenities.Get(SavedCRMId) then
                    OriginalCRMWelcomeAmenitiesList.SetCurrentlyCoupledCRMWelcomeAmenities(OriginalCRMWelcomeAmenities);
        end;



        CRMWelcomeAmenities.SetView(IntTableFilter);
        OriginalCRMWelcomeAmenitiesList.SetTableView(CRMWelcomeAmenities);
        OriginalCRMWelcomeAmenitiesList.LookupMode(true);
        if OriginalCRMWelcomeAmenitiesList.RunModal = ACTION::LookupOK then begin
            OriginalCRMWelcomeAmenitiesList.GetRecord(CRMWelcomeAmenities);
            CRMId := CRMWelcomeAmenities.acwapp_WelcomeamenitiesId;
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
            CDSTableNo := DATABASE::"CDS acwapp_welcomeamenities";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_welcomeamenities" then
            Handled := LookupCRMWelcomeAmenities(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Wel. Amen.', DATABASE::"CDS acwapp_welcomeamenities", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Wel. Amen.', DATABASE::"Welcome Amenities", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMWelcomeAmenities: Record "CDS acwapp_welcomeamenities";
        WelcomeItemSales: Record "Welcome Amenities";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
         IntegrationTableMapping, 'CRM to BC Wel. Amen.',
          DATABASE::"Welcome Amenities", DATABASE::"CDS acwapp_welcomeamenities", CRMWelcomeAmenities.FieldNo(acwapp_WelcomeamenitiesId), CRMWelcomeAmenities.FieldNo(ModifiedOn), '', '', false);
        //InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Property No."),CRMWelcomeAmenities.FieldNo(acwapp_propertyno), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("CompanyId"), CRMWelcomeAmenities.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Key"), CRMWelcomeAmenities.FieldNo(acwapp_welcomeamenitiesId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Contract No."), CRMWelcomeAmenities.FieldNo(acwapp_contractno), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Item No."), CRMWelcomeAmenities.FieldNo(acwapp_productid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        //InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Item Description"), CRMWelcomeAmenities.FieldNo(acwapp_ProdcutName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Customer Name"), CRMWelcomeAmenities.FieldNo(acwapp_account), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Customer No."), CRMWelcomeAmenities.FieldNo(acwapp_accountid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo(Price), CRMWelcomeAmenities.FieldNo(acwapp_unitprice), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Price Inclu. VAT"), CRMWelcomeAmenities.FieldNo(acwapp_NetAmountIncludingVAT), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Total Amount Inclu. VAT"), CRMWelcomeAmenities.FieldNo(acwapp_TotalAmountIncludeVAT), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Total Amount"), CRMWelcomeAmenities.FieldNo(acwapp_TotalExcludeVAT), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Unit Of Measure"), CRMWelcomeAmenities.FieldNo(acwapp_unitofmeasure), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Quantity"), CRMWelcomeAmenities.FieldNo(acwapp_quantity), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Date"), CRMWelcomeAmenities.FieldNo(acwapp_date), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Created On"), CRMWelcomeAmenities.FieldNo(createdon), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Payment Status"), CRMWelcomeAmenities.FieldNo(acwapp_paymentstatus), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("BC Status"), CRMWelcomeAmenities.FieldNo(acwapp_bcstatus), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Posted Sales Invoice No."), CRMWelcomeAmenities.FieldNo(acwapp_postedsalesinvoices), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Stripe/QFPay Invoice ID"), CRMWelcomeAmenities.FieldNo(acwapp_stripeinvoiceid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Wel. Amen.', WelcomeItemSales.FieldNo("Payment Link"), CRMWelcomeAmenities.FieldNo(acwapp_paymentlink), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field90=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Wel. Amen.');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";

}
