codeunit 83135 "CDS - Bank Transfer Payment"
{
    local procedure LookupCRMBankTransferPayment(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMBankTransferPayment: Record "CDS acwapp_banktransferpayment";
        OriginalCRMBankTransferPayment: Record "CDS acwapp_banktransferpayment";
        OriginalCRMBankTransferPaymentList: Page "CRM  Bank Transfer Payment";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMBankTransferPayment.Get(CRMId) then
                OriginalCRMBankTransferPaymentList.SetRecord(CRMBankTransferPayment);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMBankTransferPayment.Get(SavedCRMId) then
                    OriginalCRMBankTransferPaymentList.SetCurrentlyCoupledCRMBankTransferPayment(OriginalCRMBankTransferPayment);
        end;

        CRMBankTransferPayment.SetView(IntTableFilter);
        OriginalCRMBankTransferPaymentList.SetTableView(CRMBankTransferPayment);
        OriginalCRMBankTransferPaymentList.LookupMode(true);
        if OriginalCRMBankTransferPaymentList.RunModal = ACTION::LookupOK then begin
            OriginalCRMBankTransferPaymentList.GetRecord(CRMBankTransferPayment);
            CRMId := CRMBankTransferPayment.acwapp_banktransferpaymentId;
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
        if BCTableNo = DATABASE::"Bank Transfer Payment" then begin
            CDSTableNo := DATABASE::"CDS acwapp_banktransferpayment";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_banktransferpayment" then
            Handled := LookupCRMBankTransferPayment(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Bank Pymt', DATABASE::"CDS acwapp_banktransferpayment", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Bank Pymt', DATABASE::"Bank Transfer Payment", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMBankTransferPayment: Record "CDS acwapp_banktransferpayment";
        BankTransferPayment: Record "Bank Transfer Payment";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Bank Pymt',
        DATABASE::"Bank Transfer Payment", DATABASE::"CDS acwapp_banktransferpayment", CRMBankTransferPayment.FieldNo(acwapp_banktransferpaymentId), CRMBankTransferPayment.FieldNo(ModifiedOn), '', '', false);

        InsertIntegrationFieldMapping('CRM to BC Bank Pymt', BankTransferPayment.FieldNo(Code), CRMBankTransferPayment.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Bank Pymt', BankTransferPayment.FieldNo("Bedroom Offer"), CRMBankTransferPayment.FieldNo(acwapp_BedroomOfferName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Bank Pymt', BankTransferPayment.FieldNo("Bank Transfer Payslip"), CRMBankTransferPayment.FieldNo(acwapp_BankTransferSlip), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Bank Pymt', BankTransferPayment.FieldNo("Confirmed Transfer Payment"), CRMBankTransferPayment.FieldNo(acwapp_BCStatus), IntegrationFieldMapping.Direction::ToIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Bank Pymt', BankTransferPayment.FieldNo("Company Guid"), CRMBankTransferPayment.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);



        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field41=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();



        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Bank Pymt');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);



    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";
}

