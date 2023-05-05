codeunit 83127 "CDS Posted Sales Invoice Line"
{

    local procedure LookupCRMPostedSalesInvoiceLine(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMPostedSalesInvoiceLine: Record "CDS acwapp_postedsalesinvoiceline";
        OriginalCRMPostedSalesInvoiceLine: Record "CDS acwapp_postedsalesinvoiceline";
        OriginalCRMPostedSalesInvoiceLineList: Page "CRM Posted Sales Invoice Line";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMPostedSalesInvoiceLine.Get(CRMId) then
                OriginalCRMPostedSalesInvoiceLineList.SetRecord(CRMPostedSalesInvoiceLine);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMPostedSalesInvoiceLine.Get(SavedCRMId) then
                    OriginalCRMPostedSalesInvoiceLineList.SetCurrentlyCoupledCRMPostedSalesInvoiceLine(OriginalCRMPostedSalesInvoiceLine);
        end;

        CRMPostedSalesInvoiceLine.SetView(IntTableFilter);
        OriginalCRMPostedSalesInvoiceLineList.SetTableView(CRMPostedSalesInvoiceLine);
        OriginalCRMPostedSalesInvoiceLineList.LookupMode(true);
        if OriginalCRMPostedSalesInvoiceLineList.RunModal = ACTION::LookupOK then begin
            OriginalCRMPostedSalesInvoiceLineList.GetRecord(CRMPostedSalesInvoiceLine);
            CRMId := CRMPostedSalesInvoiceLine.acwapp_postedsalesinvoicelineId;

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
        if BCTableNo = DATABASE::"Sales Invoice Line" then begin
            CDSTableNo := DATABASE::"CDS acwapp_postedsalesinvoiceline";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_postedsalesinvoiceline" then
            Handled := LookupCRMPostedSalesInvoiceLine(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('BC to CRM PSHL', DATABASE::"CDS acwapp_postedsalesinvoiceline", TempNameValueBuffer);
        AddEntityTableMapping('BC to CRM PSHL', DATABASE::"Sales Invoice Line", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMPostedSalesInvoiceLine: Record "CDS acwapp_postedsalesinvoiceline";
        PostedSalesInvoiceLine: Record "Posted Sales Inv. Line for CRM";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        FilterStr: OutStream;
        FilterText: Text;
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'BC to CRM PSHL',
        DATABASE::"Posted Sales Inv. Line for CRM", DATABASE::"CDS acwapp_postedsalesinvoiceline", CRMPostedSalesInvoiceLine.FieldNo(acwapp_postedsalesinvoicelineId), CRMPostedSalesInvoiceLine.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Document No."), CRMPostedSalesInvoiceLine.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Sales Invoice Guid for CRM"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_InvoiceNo), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Document No."), CRMPostedSalesInvoiceLine.FieldNo(acwapp_InvoiceNoName), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Company Guid for CRM"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Line No."), CRMPostedSalesInvoiceLine.FieldNo(acwapp_LineNo), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo(Description), CRMPostedSalesInvoiceLine.FieldNo(acwapp_Type), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Invoice Description"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_InvoiceDescription), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo(Quantity), CRMPostedSalesInvoiceLine.FieldNo(acwapp_Quantity), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Unit Price"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_UnitPrice), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Line Amount"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_TotalAmountExcludeVAT), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Amount Including VAT"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_TotalAmount), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("VAT %"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_gst), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Lease From Date"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_invoiceperiodfrom), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Lease To Date"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_invoiceperiodto), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Billing Schedule Type"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_BillingScheduleType), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Billing Schedule Sub-Type"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_BillingScheduleSubType), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Extension Start Date"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_ExtensionStartDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSHL', PostedSalesInvoiceLine.FieldNo("Extension End Date"), CRMPostedSalesInvoiceLine.FieldNo(acwapp_ExtensionEndDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);

        IntegrationTableMapping."Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field3,Field4) WHERE(Field83023=1(<>{00000000-0000-0000-0000-000000000000}))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();


        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'BC to CRM PSHL');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

}
