codeunit 83126 "CDS Posted Sales Invoice"
{
    Permissions = tabledata "Sales Invoice Header" = rimd;
    local procedure LookupCRMPostedSalesInvoice(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMPostedSalesInvoice: Record "CDS acwapp_salesinvoice";
        OriginalCRMPostedSalesInvoice: Record "CDS acwapp_salesinvoice";
        OriginalCRMPostedSalesInvoiceList: Page "CRM Posted Sales Invoice";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMPostedSalesInvoice.Get(CRMId) then
                OriginalCRMPostedSalesInvoiceList.SetRecord(CRMPostedSalesInvoice);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMPostedSalesInvoice.Get(SavedCRMId) then
                    OriginalCRMPostedSalesInvoiceList.SetCurrentlyCoupledCRMPostedSalesInvoice(OriginalCRMPostedSalesInvoice);
        end;

        CRMPostedSalesInvoice.SetView(IntTableFilter);
        OriginalCRMPostedSalesInvoiceList.SetTableView(CRMPostedSalesInvoice);
        OriginalCRMPostedSalesInvoiceList.LookupMode(true);
        if OriginalCRMPostedSalesInvoiceList.RunModal = ACTION::LookupOK then begin
            OriginalCRMPostedSalesInvoiceList.GetRecord(CRMPostedSalesInvoice);
            CRMId := CRMPostedSalesInvoice.acwapp_salesinvoiceId;
            ;
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
        if BCTableNo = DATABASE::"Sales Invoice Header" then begin
            CDSTableNo := DATABASE::"CDS acwapp_salesinvoice";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_salesinvoice" then
            Handled := LookupCRMPostedSalesInvoice(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('BC to CRM PSH', DATABASE::"CDS acwapp_salesinvoice", TempNameValueBuffer);
        AddEntityTableMapping('BC to CRM PSH', DATABASE::"Sales Invoice Header", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMPostedSalesInvoice: Record "CDS acwapp_salesinvoice";
        PostedSalesInvoiceHeader: Record "Sales Invoice Header";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'BC to CRM PSH',
        DATABASE::"Sales Invoice Header", DATABASE::"CDS acwapp_salesinvoice", CRMPostedSalesInvoice.FieldNo(acwapp_salesinvoiceId), CRMPostedSalesInvoice.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("No."), CRMPostedSalesInvoice.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Company Guid for CRM"), CRMPostedSalesInvoice.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Bill-to Customer No."), CRMPostedSalesInvoice.FieldNo(acwapp_CustomerID), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Customer Guid for CRM"), CRMPostedSalesInvoice.FieldNo(acwapp_Customer), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Property Booking Guid for CRM"), CRMPostedSalesInvoice.FieldNo(acwapp_PropertyBooking), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Lease Contract No."), CRMPostedSalesInvoice.FieldNo(acwapp_ContractNo), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Contract Start Date"), CRMPostedSalesInvoice.FieldNo(acwapp_ContractStartDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Contract End Date"), CRMPostedSalesInvoice.FieldNo(acwapp_ContractEndDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Posting Date"), CRMPostedSalesInvoice.FieldNo(acwapp_PostingDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Due Date"), CRMPostedSalesInvoice.FieldNo(acwapp_DueDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo(Amount), CRMPostedSalesInvoice.FieldNo(acwapp_AmountExcludingVAT), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Amount Including VAT"), CRMPostedSalesInvoice.FieldNo(acwapp_Amount), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Payment Status"), CRMPostedSalesInvoice.FieldNo(acwapp_PaymentStatus), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Stripe Payment Link"), CRMPostedSalesInvoice.FieldNo(acwapp_PaymentLink), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo(BlobURL), CRMPostedSalesInvoice.FieldNo(acwapp_BlobURL), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSH', PostedSalesInvoiceHeader.FieldNo("Stripe Invoice ID"), CRMPostedSalesInvoice.FieldNo(acwapp_PaymentReferenceID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'BC to CRM PSH');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

}
