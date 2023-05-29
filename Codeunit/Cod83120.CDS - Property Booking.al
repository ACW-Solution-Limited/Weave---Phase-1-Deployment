codeunit 83120 "CDS Property Booking"
{
    local procedure LookupCRMPropertybooking(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRMPropertybooking: Record "CDS acwapp_propertybooking";
        OriginalCRMPropertybooking: Record "CDS acwapp_propertybooking";
        OriginalCRMPropertybookingList: Page "CRM Lease Contract List";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRMPropertybooking.Get(CRMId) then
                OriginalCRMPropertybookingList.SetRecord(CRMPropertybooking);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRMPropertybooking.Get(SavedCRMId) then
                    OriginalCRMPropertybookingList.SetCurrentlyCoupledCRMPropertybooking(OriginalCRMPropertybooking);
        end;

        CRMPropertybooking.SetView(IntTableFilter);
        OriginalCRMPropertybookingList.SetTableView(CRMPropertybooking);
        OriginalCRMPropertybookingList.LookupMode(true);
        if OriginalCRMPropertybookingList.RunModal = ACTION::LookupOK then begin
            OriginalCRMPropertybookingList.GetRecord(CRMPropertybooking);
            CRMId := CRMPropertybooking.acwapp_propertybookingId;
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Integration Record Synch.", 'OnTransferFieldData', '', false, false)]
    local procedure OnTransferFieldData(SourceFieldRef: FieldRef; DestinationFieldRef: FieldRef; var NewValue: Variant; var IsValueFound: Boolean; var NeedsConversion: Boolean)
    var
        CRMPropertybooking: Record "CDS acwapp_propertybooking";
        LeaseContractHeader: Record "Lease Contract Header";

    begin
        // write this in AL code: if SourceFieldRef is not acwapp_ContractStatus on table 83128 then exit
        if (SourceFieldRef.Name <> 'acwapp_ContractStatus') then exit;

        // write this in AL code: if DestinationFieldRef is not Status on table Lease Contract Header then exit  

        if DestinationFieldRef.Name <> 'Status' then exit;

        // write this in AL Code: make a case statement, check all possible cases for SourceFieldRef (acwapp_ContractStatus) and assign the appropriate value (appropriate LeaseContractHeader.Status) to the NewValue Variable
        // in the case statement, once you find the appropriate NewValue, set IsValueFound to True and NeedsConversion to false
        case
    format(SourceFieldRef.OptionCaption()) of
            format(CRMPropertybooking.acwapp_ContractStatus::" "):
                begin
                    DestinationFieldRef.Value := LeaseContractHeader.Status::" ";
                    IsValueFound := true;
                    NeedsConversion := false;
                end;
            format(CRMPropertybooking.acwapp_ContractStatus::ConfirmedWithRoomAllocated):
                begin
                    DestinationFieldRef.Value := LeaseContractHeader.Status::ConfirmedWithRoomAllocated;
                    IsValueFound := true;
                    NeedsConversion := false;
                end;
            format(CRMPropertybooking.acwapp_ContractStatus::"ReadyForCheck-in"):
                begin
                    DestinationFieldRef.Value := LeaseContractHeader.Status::"ReadyForCheck-in";
                    IsValueFound := true;
                    NeedsConversion := false;
                end;
            format(CRMPropertybooking.acwapp_ContractStatus::Active):
                begin
                    DestinationFieldRef.Value := LeaseContractHeader.Status::Active;
                    IsValueFound := true;
                    NeedsConversion := false;
                end;
            format(CRMPropertybooking.acwapp_ContractStatus::FinishedContract):
                begin
                    DestinationFieldRef.Value := LeaseContractHeader.Status::FinishedContract;
                    IsValueFound := true;
                    NeedsConversion := false;
                end;
            format(CRMPropertybooking.acwapp_ContractStatus::Terminated):
                begin
                    DestinationFieldRef.Value := LeaseContractHeader.Status::Terminated;
                    IsValueFound := true;
                    NeedsConversion := false;
                end;
        end;



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
        if BCTableNo = DATABASE::"Lease Contract Header" then begin
            CDSTableNo := DATABASE::"CDS acwapp_propertybooking";
            handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]

    local procedure OnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean);
    begin
        if CRMTableID = Database::"CDS acwapp_propertybooking" then
            Handled := LookupCRMPropertybooking(SavedCRMId, CRMId, IntTableFilter);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]

    local procedure OnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer");
    begin
        AddEntityTableMapping('CRM to BC Property', DATABASE::"CDS acwapp_propertybooking", TempNameValueBuffer);
        AddEntityTableMapping('CRM to BC Property', DATABASE::"Lease Contract Header", TempNameValueBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]

    local procedure OnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup");
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CRMPropertybooking: Record "CDS acwapp_propertybooking";
        LeaseContractHeader: Record "Lease Contract Header";
        CUCreateJob: Codeunit "Integ. Table Create Job Queue";
    begin
        InsertIntegrationTableMapping(
        IntegrationTableMapping, 'CRM to BC Property',
        DATABASE::"Lease Contract Header", DATABASE::"CDS acwapp_propertybooking", CRMPropertybooking.FieldNo(acwapp_propertybookingId), CRMPropertybooking.FieldNo(ModifiedOn), '', '', false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Key"), CRMPropertybooking.FieldNo(acwapp_propertybookingId), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo(CompanyId), CRMPropertybooking.FieldNo(acwapp_Company), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Company Name"), CRMPropertybooking.FieldNo(acwapp_CompanyName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Contract Name"), CRMPropertybooking.FieldNo(acwapp_name), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Property No."), CRMPropertybooking.FieldNo(acwapp_propertyno), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("No."), CRMPropertybooking.FieldNo(acwapp_contractno), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Status"), CRMPropertybooking.FieldNo(acwapp_contractstatus), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        //InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Customer Name"), CRMPropertybooking.FieldNo(acwapp_account), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Customer No."), CRMPropertybooking.FieldNo(acwapp_accountid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Property CRMGuid"), CRMPropertybooking.FieldNo(acwapp_Room), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Property Unit Name"), CRMPropertybooking.FieldNo(acwapp_PropertyUnitName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("New Contract Start Date"), CRMPropertybooking.FieldNo(acwapp_NewContractStartDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("New Contract End Date"), CRMPropertybooking.FieldNo(acwapp_NewContractEndDate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Contract Start Date"), CRMPropertybooking.FieldNo(acwapp_contractstartdate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Contract End Date"), CRMPropertybooking.FieldNo(acwapp_contractenddate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Contract Termination Date"), CRMPropertybooking.FieldNo(acwapp_contractterminationdate), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Promotion code type"), CRMPropertybooking.FieldNo(acwapp_promotioncodechargetype), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Promotion CRMGuid"), CRMPropertybooking.FieldNo(acwapp_promotioncode), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Payment Type"), CRMPropertybooking.FieldNo(acwapp_paymenttype), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Price"), CRMPropertybooking.FieldNo(acwapp_price), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Net Amount Include VAT"), CRMPropertybooking.FieldNo(acwapp_priceincludevat), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Prepaid Amount"), CRMPropertybooking.FieldNo(acwapp_prepaidamount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Monthly discount"), CRMPropertybooking.FieldNo(acwapp_discount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("One off Discount"), CRMPropertybooking.FieldNo(acwapp_oneoffdiscount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Prepaid Discount"), CRMPropertybooking.FieldNo(acwapp_prepaiddiscount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Net Amount"), CRMPropertybooking.FieldNo(acwapp_netamount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Deposit Amount"), CRMPropertybooking.FieldNo(acwapp_depositamount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Payment Amount"), CRMPropertybooking.FieldNo(acwapp_paymentamount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("1st Payment Stripe Invoice ID"), CRMPropertybooking.FieldNo(acwapp_paymentreferenceid), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Final Amount"), CRMPropertybooking.FieldNo(acwapp_netamountincludevat), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Monthly Rent"), CRMPropertybooking.FieldNo(acwapp_monthlyrent), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Daily Rent"), CRMPropertybooking.FieldNo(acwapp_dailyrent), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("No. of Extra Charge"), CRMPropertybooking.FieldNo(acwapp_NoofExtraChargesLine), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Promotion Deduction Type"), CRMPropertybooking.FieldNo(acwapp_PriceDeductionType), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Promotion Amount / %"), CRMPropertybooking.FieldNo(acwapp_DeductionAmountdecimal), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Tender Type"), CRMPropertybooking.FieldNo(acwapp_TenderTypeName), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Tender Type Discount Amount"), CRMPropertybooking.FieldNo(acwapp_discountamount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Commission Type"), CRMPropertybooking.FieldNo(acwapp_CommissionType), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Salesperson Email"), CRMPropertybooking.FieldNo(acwapp_OwnerEmail), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Latest Deposit Amount"), CRMPropertybooking.FieldNo(acwapp_LatestDepositAmount), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Original Contract No."), CRMPropertybooking.FieldNo(acwapp_OldContractNo), IntegrationFieldMapping.Direction::FromIntegrationTable, '', false, false);
        // >> Add new fields for Commission
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Viewing By"), CRMPropertybooking.FieldNo(acwapp_ViewingByFullname), IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('CRM to BC Property', LeaseContractHeader.FieldNo("Renewal By"), CRMPropertybooking.FieldNo(acwapp_RenewalByFullname), IntegrationFieldMapping.Direction::FromIntegrationTable, '', false, false);
        // << Add new fields for Commission
        CompanyInformation.Get;
        IntegrationTableMapping."Integration Table Filter".CreateOutStream(FilterStr);
        FilterText := 'VERSION(1) SORTING(Field1) WHERE(Field199=1(' + CompanyInformation."CRM Company Guid" + '))';
        FilterStr.Write(FilterText);
        IntegrationTableMapping.Modify();

        IntegrationTableMapping.reset;
        IntegrationTableMapping.SetFilter(Name, 'CRM to BC Property');
        CUCreateJob.CreateCustomSyncJobQueueEntry(IntegrationTableMapping);

    end;

    var
        FilterStr: OutStream;

        FilterText: Text;
        CompanyInformation: Record "Company Information";

}
