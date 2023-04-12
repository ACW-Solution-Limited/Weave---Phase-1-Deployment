codeunit 83124 "CDS Extra Charges"
{
    local procedure LookupCRMExtraCharges(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMExtraCharges: Record "CDS acwapp_extracharges";
        OriginalCRMExtraCharges: Record "CDS acwapp_extracharges";
        OriginalCRMExtraChargesList: Page "CRM Extra Charges";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMExtraCharges.Get(CRMId) then
                OriginalCRMExtraChargesList.SetRecord(CRMExtraCharges);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMExtraCharges.Get(SavedCRMId) then
                    OriginalCRMExtraChargesList.SetCurrentlyCoupledCRMExtraCharges(OriginalCRMExtraCharges);
        end;

        CRMExtraCharges.SetView(IntTableFilter);
        OriginalCRMExtraChargesList.SetTableView(CRMExtraCharges);
        OriginalCRMExtraChargesList.LookupMode(true);
        if OriginalCRMExtraChargesList.RunModal = ACTION::LookupOK then begin
            OriginalCRMExtraChargesList.GetRecord(CRMExtraCharges);
            CRMId := CRMExtraCharges.acwapp_extrachargesId;
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
        if BCTableNo = DATABASE::Item then begin
            CDSTableNo := DATABASE::"CDS acwapp_extracharges";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_extracharges" then
            Handled := LookupCRMExtraCharges(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Ext. Char.', DATABASE::"CDS acwapp_extracharges", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Ext. Char.', DATABASE::"Extra Charge", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMExtraCharges: Record "CDS acwapp_extracharges";
        ExtraCharges: Record "Extra Charge";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Ext. Char.',
        DATABASE::"Extra Charge", DATABASE::"CDS acwapp_extracharges", CRMExtraCharges.FieldNo(acwapp_extrachargesId), CRMExtraCharges.FieldNo(ModifiedOn), '', '', false);
        // InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo(), CRMExtraCharges.FieldNo(acwapp_PropertyNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Key"), CRMExtraCharges.FieldNo(acwapp_extrachargesId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Contract No."), CRMExtraCharges.FieldNo(acwapp_ContractNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Charges Type"), CRMExtraCharges.FieldNo(acwapp_ChargesType), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Item Type"), CRMExtraCharges.FieldNo(acwapp_ProductTypeName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Item No."), CRMExtraCharges.FieldNo(acwapp_ProductID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Description"), CRMExtraCharges.FieldNo(acwapp_Description), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Total Amount"), CRMExtraCharges.FieldNo(acwapp_Amount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Total Amount Inclu. VAT"), CRMExtraCharges.FieldNo(acwapp_amountincludegst), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("BC Status"), CRMExtraCharges.FieldNo(acwapp_BCStatus), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Posted Sales Invoice Guid"), CRMExtraCharges.FieldNo(acwapp_postedsalesinvoices), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Stripe Invoice ID"), CRMExtraCharges.FieldNo(acwapp_StripeInvoiceID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Payment Link"), CRMExtraCharges.FieldNo(acwapp_paymentlink), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Customer No."), CRMExtraCharges.FieldNo(acwapp_accountid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Created On"), CRMExtraCharges.FieldNo(createdon), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("New Contract Start Date"), CRMExtraCharges.FieldNo(acwapp_newcontractstartdate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("New Contract End Date"), CRMExtraCharges.FieldNo(acwapp_newcontractenddate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("Extra Charge ID"), CRMExtraCharges.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Ext. Char.', ExtraCharges.FieldNo("CRM Status"), CRMExtraCharges.FieldNo(acwapp_Status), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);

        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field77=1(' + CompanyInformation."CRM Company Guid" + '))';
        // FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field77=1(' + CompanyInformation."CRM Company Guid" + '),Field84=1(1))';
        //VERSION(1) SORTING(Field1) WHERE(Field77=1({317C54FD-9170-ED11-81AC-000D3A85C5F6}),Field84=1(1))
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();


        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Ext. Char.');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";
}
