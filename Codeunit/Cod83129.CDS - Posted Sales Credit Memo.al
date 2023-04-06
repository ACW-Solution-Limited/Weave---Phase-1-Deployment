codeunit 83129 "CDS Posted Sales Credit Memo"
{
    local procedure LookupCRMPostedSalesCreditMemo(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMPostedSalesCreditMemo: Record "CDS acwapp_postedsalescreditmemo";
        OriginalCRMPostedSalesCreditMemo: Record "CDS acwapp_postedsalescreditmemo";
        OriginalCRMPostedSalesCreditMemoList: Page "CRMPostedSalesCreditMemo";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMPostedSalesCreditMemo.Get(CRMId) then
                OriginalCRMPostedSalesCreditMemoList.SetRecord(CRMPostedSalesCreditMemo);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMPostedSalesCreditMemo.Get(SavedCRMId) then
                    OriginalCRMPostedSalesCreditMemoList.SetCurrentlyCoupledCRMPostedSalesCreditMemo(OriginalCRMPostedSalesCreditMemo);
        end;

        CRMPostedSalesCreditMemo.SetView(IntTableFilter);
        OriginalCRMPostedSalesCreditMemoList.SetTableView(CRMPostedSalesCreditMemo);
        OriginalCRMPostedSalesCreditMemoList.LookupMode(true);
        if OriginalCRMPostedSalesCreditMemoList.RunModal = ACTION::LookupOK then begin
            OriginalCRMPostedSalesCreditMemoList.GetRecord(CRMPostedSalesCreditMemo);
            CRMId := CRMPostedSalesCreditMemo.acwapp_postedsalescreditmemoId;
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
        if BCTableNo = DATABASE::"Sales Cr.Memo Header" then begin
            CDSTableNo := DATABASe::"CDS acwapp_postedsalescreditmemo";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_postedsalescreditmemo" then
            Handled := LookupCRMPostedSalesCreditMemo(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('BC to CRM PSCMH', DATABASE::"CDS acwapp_postedsalescreditmemo", TempNameValueBuffer);
        AddEntityTableMapping('BC to CRM PSCMH', DATABASE::"Sales Cr.Memo Header", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMPostedSalesCreditMemo: Record "CDS acwapp_postedsalescreditmemo";
        PostedSalesCreditMemoHeader: Record "Sales Cr.Memo Header";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'BC to CRM PSCMH',
        DATABASE::"Sales Cr.Memo Header", DATABASE::"CDS acwapp_postedsalescreditmemo", CRMPostedSalesCreditMemo.FieldNo(acwapp_postedsalescreditmemoId), CRMPostedSalesCreditMemo.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("No."), CRMPostedSalesCreditMemo.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("No."), CRMPostedSalesCreditMemo.FieldNo(acwapp_salescreditmemono), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Company Guid for CRM"), CRMPostedSalesCreditMemo.FieldNo(acwapp_company), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Bill-to Customer No."), CRMPostedSalesCreditMemo.FieldNo(acwapp_customerid), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Customer Guid for CRM"), CRMPostedSalesCreditMemo.FieldNo(acwapp_Customer), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Property Booking Guid for CRM"), CRMPostedSalesCreditMemo.FieldNo(acwapp_propertybooking), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Lease Contract No."), CRMPostedSalesCreditMemo.FieldNo(acwapp_ContractNo), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Contract Start Date"), CRMPostedSalesCreditMemo.FieldNo(acwapp_ContractStartDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Contract End Date"), CRMPostedSalesCreditMemo.FieldNo(acwapp_ContractEndDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Posting Date"), CRMPostedSalesCreditMemo.FieldNo(acwapp_postingdate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Due Date"), CRMPostedSalesCreditMemo.FieldNo(acwapp_duedate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo(Amount), CRMPostedSalesCreditMemo.FieldNo(acwapp_AmountExcludingVAT), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Amount Including VAT"), CRMPostedSalesCreditMemo.FieldNo(acwapp_amountincludingvat), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Payment Status"), CRMPostedSalesCreditMemo.FieldNo(acwapp_paymentstatus), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo("Stripe Payment Link"), CRMPostedSalesCreditMemo.FieldNo(acwapp_PaymentLink), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM PSCMH', PostedSalesCreditMemoHeader.FieldNo(BlobURL), CRMPostedSalesCreditMemo.FieldNo(acwapp_BlobURL), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'BC to CRM PSCMH');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

}
