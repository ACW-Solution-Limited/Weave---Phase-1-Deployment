page 83130 "CRM Lease Contract List"
{
    ApplicationArea = All;
    Caption = 'CRM Lease Contract List';
    PageType = List;
    SourceTable = "CDS acwapp_propertybooking";
    UsageCategory = Lists;
    CardPageId = "CRM Lease Contract";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_ContractNo; Rec.acwapp_ContractNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                    Caption = 'Name';
                }
                field(acwapp_ContractStatus; Rec.acwapp_ContractStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Status field.';
                }
                field(acwapp_PropertyNo; Rec.acwapp_PropertyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field(acwapp_PropertyUnitName; Rec.acwapp_PropertyUnitName)
                {
                    ApplicationArea = All;
                    Caption = 'Property Unit Name';
                    ToolTip = 'Specifies the value of the acwapp_PropertyUnitName field.';
                }
                field(acwapp_ContractStartDate; Rec.acwapp_ContractStartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                }
                field(acwapp_ContractEndDate; Rec.acwapp_ContractEndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

        }
    }
    trigger OnInit()
    begin
        // SynchronizeNow(False);
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    trigger OnOpenPage()
    var
        l_recCompanyInformation: Record "Company Information";
    begin
        l_recCompanyInformation.Get;
        Rec.SetFilter(acwapp_PropertyNo, l_recCompanyInformation."Property Unit No.");
    end;

    // procedure SynchronizeNow(DoFullSynch: Boolean)
    // var
    //     IntegrationTableMapping: Record "Integration Table Mapping";
    //     TempNameValueBuffer: Record "Name/Value Buffer" temporary;
    //     CDSSetupDefaults: Codeunit "CDS Setup Defaults";
    // begin
    //     CDSSetupDefaults.GetPrioritizedMappingList(TempNameValueBuffer);

    //     TempNameValueBuffer.Ascending(true);
    //     if not TempNameValueBuffer.FindSet() then
    //         exit;

    //     repeat
    //         if IntegrationTableMapping.Get(TempNameValueBuffer.Value) then
    //             IntegrationTableMapping.SynchronizeNow(DoFullSynch);
    //     until TempNameValueBuffer.Next() = 0;
    // end;



    procedure SetCurrentlyCoupledCRMPropertybooking(CRMPropertybooking: Record "CDS acwapp_propertybooking")
    begin
        CurrentlyCoupledCRMPropertybooking := CRMPropertybooking;
    end;

    var
        CurrentlyCoupledCRMPropertybooking: Record "CDS acwapp_propertybooking";
}
