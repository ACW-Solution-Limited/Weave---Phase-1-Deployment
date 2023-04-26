codeunit 83125 "CDS Expense Claim"
{
    local procedure LookupCRMExpenseClaim(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMExpenseClaim: Record "CDS acwapp_expenseclaim";
        OriginalCRMExpenseClaim: Record "CDS acwapp_expenseclaim";
        OriginalCRMExpenseClaimList: Page "CRM Expense Claim";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMExpenseClaim.Get(CRMId) then
                OriginalCRMExpenseClaimList.SetRecord(CRMExpenseClaim);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMExpenseClaim.Get(SavedCRMId) then
                    OriginalCRMExpenseClaimList.SetCurrentlyCoupledCRMExpenseClaim(OriginalCRMExpenseClaim);
        end;

        CRMExpenseClaim.SetView(IntTableFilter);
        OriginalCRMExpenseClaimList.SetTableView(CRMExpenseClaim);
        OriginalCRMExpenseClaimList.LookupMode(true);
        if OriginalCRMExpenseClaimList.RunModal = ACTION::LookupOK then begin
            OriginalCRMExpenseClaimList.GetRecord(CRMExpenseClaim);
            CRMId := CRMExpenseClaim.acwapp_expenseclaimId;
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
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::FromIntegrationTable, 'CDS');
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
            CDSTableNo := DATABASE::"CDS acwapp_expenseclaim";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_expenseclaim" then
            Handled := LookupCRMExpenseClaim(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Exp. Claim', DATABASE::"CDS acwapp_expenseclaim", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Exp. Claim', DATABASE::"Sales Invoice Header", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMExpenseClaim: Record "CDS acwapp_expenseclaim";
        ExpenseClaim: Record "Expense Claim";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Exp. Claim',
        DATABASE::"Expense Claim", DATABASE::"CDS acwapp_expenseclaim", CRMExpenseClaim.FieldNo(acwapp_expenseclaimId), CRMExpenseClaim.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo("No."), CRMExpenseClaim.FieldNo(acwapp_ExpenseID), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo(Description), CRMExpenseClaim.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo("Expense Type"), CRMExpenseClaim.FieldNo(acwapp_ExpenseTypeName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo("CRM Guid"), CRMExpenseClaim.FieldNo(acwapp_company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo(Description), CRMExpenseClaim.FieldNo(acwapp_Description), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo(Amount), CRMExpenseClaim.FieldNo(acwapp_UnitPrice), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo(Date), CRMExpenseClaim.FieldNo(acwapp_ClaimDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo("Staff Email"), CRMExpenseClaim.FieldNo(acwapp_StaffEmail), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Exp. Claim', ExpenseClaim.FieldNo(Status), CRMExpenseClaim.FieldNo(acwapp_BCStatus), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);



        CompanyInformation.Get;
        if CompanyInformation."HK Expense Claim Master" then begin
            IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
            FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field57=1(3),Field78=1(1))';
            FilterStr.Write(FilterText);
            IntegrationTableMapping.Modify();
        End
        else
            if CompanyInformation."SG Expense Claim Master" then begin
                IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
                FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field57=1(3),Field78=1(2))';
                FilterStr.Write(FilterText);
                IntegrationTableMapping.Modify();
            end;

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Exp. Claim');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);
    end;

    var
        FilterStr: OutStream;
        FilterText: Text;
        CompanyInformation: Record "Company Information";

}
