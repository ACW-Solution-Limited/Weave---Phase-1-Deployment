codeunit 83134 "CDS - Event Fee"
{
    local procedure LookupCRMEventFee(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMEventFee: Record "CDS acwapp_eventfee";
        OriginalCRMEventFee: Record "CDS acwapp_eventfee";
        OriginalCRMEventFeeList: Page "CRM Event Fee";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMEventFee.Get(CRMId) then
                OriginalCRMEventFeeList.SetRecord(CRMEventFee);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMEventFee.Get(SavedCRMId) then
                    OriginalCRMEventFeeList.SetCurrentlyCoupledCRMEventFee(OriginalCRMEventFee);
        end;

        CRMEventFee.SetView(IntTableFilter);
        OriginalCRMEventFeeList.SetTableView(CRMEventFee);
        OriginalCRMEventFeeList.LookupMode(true);
        if OriginalCRMEventFeeList.RunModal = ACTION::LookupOK then begin
            OriginalCRMEventFeeList.GetRecord(CRMEventFee);
            CRMId := CRMEventFee.acwapp_eventfeeId;
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
        if BCTableNo = DATABASE::"Event Fee" then begin
            CDSTableNo := DATABASE::"CDS acwapp_eventfee";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_eventfee" then
            Handled := LookupCRMEventFee(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC EventFee', DATABASE::"CDS acwapp_eventfee", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC EventFee', DATABASE::"Event Fee", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMEventFee: Record "CDS acwapp_eventfee";
        EventFee: Record "Event Fee";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC EventFee',
        DATABASE::"Event Fee", DATABASE::"CDS acwapp_eventfee", CRMEventFee.FieldNo(acwapp_eventfeeId), CRMEventFee.FieldNo(ModifiedOn), '', '', false);

        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo(Code), CRMEventFee.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Customer Code"), CRMEventFee.FieldNo(acwapp_AccountID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Customer Name"), CRMEventFee.FieldNo(acwapp_Account), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Contact Code"), CRMEventFee.FieldNo(acwapp_ContractNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo(Currency), CRMEventFee.FieldNo(acwapp_CurrencyID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo(Amount), CRMEventFee.FieldNo(acwapp_Amount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Amount Including VAT"), CRMEventFee.FieldNo(acwapp_AmountIncludeGST), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo(Date), CRMEventFee.FieldNo(acwapp_Date), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Payment Reference ID"), CRMEventFee.FieldNo(acwapp_PaymentReferenceID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Company  Guid"), CRMEventFee.FieldNo(acwapp_CompanyName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Property No."), CRMEventFee.FieldNo(acwapp_PropertyNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Property Booking No."), CRMEventFee.FieldNo(acwapp_PropertyBookingName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Contract No."), CRMEventFee.FieldNo(acwapp_ContractNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Event"), CRMEventFee.FieldNo(acwapp_EventID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Event Session"), CRMEventFee.FieldNo(acwapp_EventSessionID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC EventFee', EventFee.FieldNo("Event Registration"), CRMEventFee.FieldNo(acwapp_EventRegistrationID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);

        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field70=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();


        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC EventFee');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";
}

