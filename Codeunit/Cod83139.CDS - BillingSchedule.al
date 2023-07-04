codeunit 83139 CDSBillingSchedule
{
    local procedure LookupCRMBillingSchedule(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMBillingSchedule: Record "CDS acwapp_BillingSchedule";
        OriginalCRMBillingSchedule: Record "CDS acwapp_BillingSchedule";
        OriginalCRMBillingScheduleList: Page "CRM Billing Schedule";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMBillingSchedule.Get(CRMId) then
                OriginalCRMBillingScheduleList.SetRecord(CRMBillingSchedule);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMBillingSchedule.Get(SavedCRMId) then
                    OriginalCRMBillingScheduleList.SetCurrentlyCoupledCRMBillingSchedule(OriginalCRMBillingSchedule);
        end;



        CRMBillingSchedule.SetView(IntTableFilter);
        OriginalCRMBillingScheduleList.SetTableView(CRMBillingSchedule);
        OriginalCRMBillingScheduleList.LookupMode(true);
        if OriginalCRMBillingScheduleList.RunModal = ACTION::LookupOK then begin
            OriginalCRMBillingScheduleList.GetRecord(CRMBillingSchedule);
            CRMId := CRMBillingSchedule.acwapp_BillingScheduleId;
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
        if BCTableNo = DATABASE::"Lease Contract Billing Sched." then begin
            CDSTableNo := DATABASE::"CDS acwapp_BillingSchedule";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_BillingSchedule" then
            Handled := LookupCRMBillingSchedule(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin


        AddEntityTableMapping('BC to CRM Bil. Sch.', DATABASE::"CDS acwapp_BillingSchedule", TempNameValueBuffer);
        AddEntityTableMapping('BC to CRM Bil. Sch.', DATABASE::"Lease Contract Billing Sched.", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMBillingSchedule: Record "CDS acwapp_BillingSchedule";
        BillingSchedule: Record "Lease Contract Billing Sched.";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
        CompanyInformation: Record "Company Information";
    begin


        CompanyInformation.Get;

        InsertIntegrationTableMapping(
         IntegrationTableMapping, 'BC to CRM Bil. Sch.',
          DATABASE::"Lease Contract Billing Sched.", DATABASE::"CDS acwapp_BillingSchedule", CRMBillingSchedule.FieldNo(acwapp_BillingScheduleId), CRMBillingSchedule.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo(Type), CRMBillingSchedule.FieldNo(acwapp_Type), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Sub-Type"), CRMBillingSchedule.FieldNo(acwapp_SubType), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Posting Date"), CRMBillingSchedule.FieldNo(acwapp_PostingDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Due Date"), CRMBillingSchedule.FieldNo(acwapp_DueDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Contract Start Date"), CRMBillingSchedule.FieldNo(acwapp_ContractStartDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Contract End Date"), CRMBillingSchedule.FieldNo(acwapp_ContractEndDate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo(Amount), CRMBillingSchedule.FieldNo(acwapp_AmountExcludingVAT), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("No. of Days to Bill"), CRMBillingSchedule.FieldNo(acwapp_NoofDaystoBill), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("No. of Days Current Month"), CRMBillingSchedule.FieldNo(acwapp_NoofDaysCurrentMonth), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Additional Item Sales Date"), CRMBillingSchedule.FieldNo(acwapp_additionalitemsalesdate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Additional Sales Item No."), CRMBillingSchedule.FieldNo(acwapp_additionalsalesitemno), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Additional Sales Item Quantity"), CRMBillingSchedule.FieldNo(acwapp_additionalsalesitemquantity), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Add. Sales Item Unit Price"), CRMBillingSchedule.FieldNo(acwapp_additionalsalesitemunitprice), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Document Type"), CRMBillingSchedule.FieldNo(acwapp_documenttype), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Document No."), CRMBillingSchedule.FieldNo(acwapp_documentno), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Sales Invoice Creation Date"), CRMBillingSchedule.FieldNo(acwapp_salesinvoicecreationdate), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Status"), CRMBillingSchedule.FieldNo(acwapp_status), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Contract No."), CRMBillingSchedule.FieldNo(acwapp_contractno), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Contract Line No."), CRMBillingSchedule.FieldNo(acwapp_contractlineno), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("External Payment Gateway"), CRMBillingSchedule.FieldNo(acwapp_externalpaymentgateway), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('BC to CRM Bil. Sch.', BillingSchedule.FieldNo("Stripe Invoice ID"), CRMBillingSchedule.FieldNo(acwapp_stripeqfpayinvoiceid), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'BC to CRM Bil. Sch.');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);

    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";
}
