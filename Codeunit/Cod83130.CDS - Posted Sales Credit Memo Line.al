codeunit 83130 "CDS Posted Sales Cr. Memo Line"
{
    local procedure LookupCRMPostedSalesCreditMemoLine(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMPostedSalesCreditMemoLine: Record "CDS acwapp_postedsalescmLine";
        OriginalCRMPostedSalesCreditMemoLine: Record "CDS acwapp_postedsalescmLine";
        OriginalCRMPostedSalesCreditMemoLineList: Page "CRMPostedSalesCreditMemoLine";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMPostedSalesCreditMemoLine.Get(CRMId) then
                OriginalCRMPostedSalesCreditMemoLineList.SetRecord(CRMPostedSalesCreditMemoLine);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMPostedSalesCreditMemoLine.Get(SavedCRMId) then
                    OriginalCRMPostedSalesCreditMemoLineList.SetCurrentlyCoupledCRMPostedSalesCreditMemoLine(OriginalCRMPostedSalesCreditMemoLine);
        end;

        CRMPostedSalesCreditMemoLine.SetView(IntTableFilter);
        OriginalCRMPostedSalesCreditMemoLineList.SetTableView(CRMPostedSalesCreditMemoLine);
        OriginalCRMPostedSalesCreditMemoLineList.LookupMode(true);
        if OriginalCRMPostedSalesCreditMemoLineList.RunModal = ACTION::LookupOK then begin
            OriginalCRMPostedSalesCreditMemoLineList.GetRecord(CRMPostedSalesCreditMemoLine);
            CRMId := CRMPostedSalesCreditMemoLine.acwapp_postedsalescreditmemolineId;
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
        if BCTableNo = DATABASE::"Sales Cr.Memo Line" then begin
            CDSTableNo := DATABASE::"CDS acwapp_postedsalescmLine";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_postedsalescmLine" then
            Handled := LookupCRMPostedSalesCreditMemoLine(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('BC to CRM PSCMHL', DATABASE::"CDS acwapp_postedsalescmLine", TempNameValueBuffer);
        AddEntityTableMapping('BC to CRM PSCMHL', DATABASE::"Sales Cr.Memo Line", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMPostedSalesCreditMemoLine: Record "CDS acwapp_postedsalescmLine";
        PostedSalesCreditMemoLine: Record "Sales Cr.Memo Line";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        FilterStr: OutStream;
        FilterText: Text;
    begin
        InsertIntegrationTableMapping(
      IntegrationTableMapping, 'BC to CRM PSCMHL',
      DATABASE::"Sales Cr.Memo Line", DATABASE::"CDS acwapp_postedsalescmLine", CRMPostedSalesCreditMemoLine.FieldNo(acwapp_postedsalescreditmemolineId), CRMPostedSalesCreditMemoLine.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Sales Credit Memo Guid for CRM"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_PostedSalesCreditMemo), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);

        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Document No."), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_PostedSalesCreditMemoName), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Company Guid for CRM"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Line No."), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_LineNo), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo(Description), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_Type), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Invoice Description"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_InvoiceDescription), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo(Quantity), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_Quantity), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Unit Price"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_UnitPriceExcludeVAT), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Line Amount"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_UnitPriceIncludeVAT), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Line Amount"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_TotalAmountExcludeVAT), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Amount Including VAT"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_TotalAmountIncludeVAT), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("VAT %"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_gst), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Lease From Date"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_invoiceperiodfrom), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMHL', PostedSalesCreditMemoLine.FieldNo("Lease To Date"), CRMPostedSalesCreditMemoLine.FieldNo(acwapp_invoiceperiodto), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);

        IntegrationTableMapping."Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field3,Field4) WHERE(Field83023=1(<>{00000000-0000-0000-0000-000000000000}))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'BC to CRM PSCMHL');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

}
