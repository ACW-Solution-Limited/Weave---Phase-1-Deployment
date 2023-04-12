codeunit 83119 "CDS Additional Amenities"
{
    local procedure LookupCRMAdditionalAmenities(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMAdditionalAmenities: Record "CDS acwapp_additionalamenities";
        OriginalCRMAdditionalAmenities: Record "CDS acwapp_additionalamenities";
        OriginalCRMAdditionalAmenitiesList: Page "CRM Additional Amentities";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMAdditionalAmenities.Get(CRMId) then
                OriginalCRMAdditionalAmenitiesList.SetRecord(CRMAdditionalAmenities);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMAdditionalAmenities.Get(SavedCRMId) then
                    OriginalCRMAdditionalAmenitiesList.SetCurrentlyCoupledCRMAdditionalAmenities(OriginalCRMAdditionalAmenities);
        end;



        CRMAdditionalAmenities.SetView(IntTableFilter);
        OriginalCRMAdditionalAmenitiesList.SetTableView(CRMAdditionalAmenities);
        OriginalCRMAdditionalAmenitiesList.LookupMode(true);
        if OriginalCRMAdditionalAmenitiesList.RunModal = ACTION::LookupOK then begin
            OriginalCRMAdditionalAmenitiesList.GetRecord(CRMAdditionalAmenities);
            CRMId := CRMAdditionalAmenities.acwapp_additionalamenitiesId;
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
        if BCTableNo = DATABASE::"Additional Amenities" then begin
            CDSTableNo := DATABASE::"CDS acwapp_additionalamenities";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_additionalamenities" then
            Handled := LookupCRMAdditionalAmenities(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Add. Amen.', DATABASE::"CDS acwapp_additionalamenities", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Add. Amen.', DATABASE::"Additional Amenities", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMAdditionalAmenities: Record "CDS acwapp_additionalamenities";
        AdditionalItemSales: Record "Additional Amenities";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
    begin
        InsertIntegrationTableMapping(
         IntegrationTableMapping, 'CRM to BC Add. Amen.',
          DATABASE::"Additional Amenities", DATABASE::"CDS acwapp_additionalamenities", CRMAdditionalAmenities.FieldNo(acwapp_additionalamenitiesId), CRMAdditionalAmenities.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Key"), CRMAdditionalAmenities.FieldNo(acwapp_additionalamenitiesId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Contract No."), CRMAdditionalAmenities.FieldNo(acwapp_ContractNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Customer No."), CRMAdditionalAmenities.FieldNo(acwapp_AccountID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Item No."), CRMAdditionalAmenities.FieldNo(acwapp_ProductID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        //InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Item Description"), CRMAdditionalAmenities.FieldNo(acwapp_ProductName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo(Quantity), CRMAdditionalAmenities.FieldNo(acwapp_Quantity), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo(Price), CRMAdditionalAmenities.FieldNo(acwapp_Price), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Price Inclu. VAT"), CRMAdditionalAmenities.FieldNo(acwapp_NetAmountIncludingVAT), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Start Date"), CRMAdditionalAmenities.FieldNo(acwapp_Date), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("End Date"), CRMAdditionalAmenities.FieldNo(acwapp_EndDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Created On"), CRMAdditionalAmenities.FieldNo(createdon), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Payment Status"), CRMAdditionalAmenities.FieldNo(acwapp_PaymentStatus), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("BC Status"), CRMAdditionalAmenities.FieldNo(acwapp_BCStatus), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Total Amount"), CRMAdditionalAmenities.FieldNo(acwapp_TotalAmountExcludeVAT), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Total Amount Inclu. VAT"), CRMAdditionalAmenities.FieldNo(acwapp_TotalAmount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Stripe Invoice ID"), CRMAdditionalAmenities.FieldNo(acwapp_stripeinvoiceid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Add. Amen.', AdditionalItemSales.FieldNo("Payment Link"), CRMAdditionalAmenities.FieldNo(acwapp_paymentlink), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field92=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();




        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Add. Amen.');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";


}

