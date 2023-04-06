page 83131 "CRM Lease Contract"
{
    Caption = 'CRM Lease Contract';
    PageType = Card;
    SourceTable = "CDS acwapp_propertybooking";

    layout
    {
        area(content)
        {
            group(General)
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
                field(acwapp_ContractStartDate; DT2Date(Rec.acwapp_ContractStartDate))
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                    Caption = 'Contract Start Date';
                }
                field(acwapp_ContractEndDate; DT2Date(Rec.acwapp_ContractEndDate))
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                    Caption = 'Contract End Date';
                }
                field(acwapp_ContractTerminationDate; DT2Date(Rec.acwapp_ContractTerminationDate))
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Termination Date field.';
                    Caption = 'Termination Date';
                }
                field(AccountNoLookup; Rec.AccountNoLookup)
                {
                    ApplicationArea = all;
                    caption = 'Customer No.';
                }

                field("Customer Name"; Customer.Name)
                {
                    ApplicationArea = all;
                }

                field("Property Unit"; CRMPropertyUnit.acwapp_PropertyID) { ApplicationArea = all; }
                field(acwapp_PropertyUnitName; Rec.acwapp_PropertyUnitName)
                {
                    ApplicationArea = All;
                    Caption = 'Property Unit Name';
                    ToolTip = 'Specifies the value of the acwapp_PropertyUnitName field.';
                }
                field(acwapp_RoomTypeName; Rec.acwapp_RoomTypeName)
                {
                    ApplicationArea = All;
                    Caption = 'Room Type Name';
                    ToolTip = 'Specifies the value of the acwapp_RoomTypeName field.';
                }
                field(acwapp_RoomName; Rec.acwapp_RoomName)
                {
                    ApplicationArea = All;
                    Caption = 'Room Name';
                    ToolTip = 'Specifies the value of the acwapp_RoomName field.';
                }
                field(acwapp_ContractStatus; Rec.acwapp_ContractStatus) { ApplicationArea = All; ToolTip = 'Specifies the value of the Contract Status field.'; }

                group(Deposit)
                {
                    field(acwapp_depositamount; Rec.acwapp_depositamount) { ApplicationArea = all; Caption = 'Deposit Amount'; }
                }

                group(Price)
                {
                    field(acwapp_Price; Rec.acwapp_Price) { ApplicationArea = all; Caption = 'Price'; }
                    field(acwapp_discount; Rec.acwapp_discount) { ApplicationArea = all; Caption = 'Monthly Discount'; }
                    field(acwapp_netamount_Base; Rec.acwapp_netamount) { ApplicationArea = all; }
                }

                group("Promotion code")
                {
                    field(acwapp_promotioncodeName; Rec.acwapp_promotioncodeName) { ApplicationArea = all; Caption = 'Promotion Code'; }
                    field(acwapp_PaymentType; Rec.acwapp_PaymentType) { ApplicationArea = all; }
                    field(acwapp_oneoffdiscount; Rec.acwapp_oneoffdiscount) { ApplicationArea = all; Caption = 'One-Off Discount'; }
                }
                group("Prepayment")
                {
                    field(acwapp_PrepaidAmount; Rec.acwapp_PrepaidAmount) { ApplicationArea = all; Caption = 'Prepaid Discount Amount'; }
                    field(acwapp_PrepaidDiscount; Rec.acwapp_PrepaidDiscount) { ApplicationArea = all; Caption = 'Prepaid Discount %'; }
                    field(acwapp_PaymentReferenceID; Rec.acwapp_PaymentReferenceID) { ApplicationArea = all; }
                    field(acwapp_PaymentAmount; Rec.acwapp_PaymentAmount) { ApplicationArea = all; }
                }
            }
            part("CRM Lease Contract Subform"; "CRM Lease Contract Subform")
            {
                SubPageLink = acwapp_PropertyBooking = field(acwapp_propertybookingId);
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        area(Navigation)
        {
            group(Navigate)
            {
                action("Billing Schedule")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = ContractPayment;
                    RunObject = page "Lease Contract Billing Sched.";
                    RunPageLink = "Contract No." = field(acwapp_ContractNo);
                    RunPageView = sorting("Customer No.", "Posting Date", "Contract No.", "Line No.") order(ascending);

                }
            }
        }
        area(Processing)
        {
            group(Fuctions)
            {
                // action("Refresh Billing Schedule")
                // {
                //     ApplicationArea = All;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Process;
                //     image = SuggestPayment;

                //     trigger OnAction()
                //     var

                //         l_cduLeaseContractMgt: Codeunit "Lease Contract Management";
                //     begin
                //         l_cduLeaseContractMgt.RefreshBillingSchedule(rec);
                //     end;
                // }
                // action("Terminate Contract")
                // {
                //     ApplicationArea = All;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Process;
                //     image = Cancel;
                //     trigger OnAction()
                //     var
                //         l_cduLeaseContractMgt: Codeunit "Lease Contract Management";
                //     begin
                //         //l_cduLeaseContractMgt.RefundOneoffdiscount(rec);
                //         l_cduLeaseContractMgt.TerminateContract(rec);
                //     end;

                // }
                // action("Create Invoice/Credit Memo")
                // {
                //     ApplicationArea = All;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Process;
                //     Image = JobSalesInvoice;
                //     trigger OnAction()
                //     var
                //         l_rptLeaseContractCreateInvoice: Report "Lease Contract Create Invoices";
                //         l_rptLeaseContractCreateItemInv: Report "Lease Contract Create Item Inv";
                //         l_recLeaseBillingSchedule: Record "Lease Contract Billing Sched.";
                //         l_subtype: Text;
                //     begin
                //         rec.SetRecFilter();
                //         l_rptLeaseContractCreateInvoice.SetTableView(rec);
                //         l_rptLeaseContractCreateInvoice.run;
                /*l_recLeaseBillingSchedule.reset;
                l_recLeaseBillingSchedule.setrange("Contract No.", rec.acwapp_ContractNo);
                l_recLeaseBillingSchedule.setrange(type, l_recLeaseBillingSchedule.Type::Item);
                If l_recLeaseBillingSchedule.Findset then begin
                    repeat
                        l_rptLeaseContractCreateItemInv.SetTableView(rec);
                        l_rptLeaseContractCreateItemInv.run;
                    until l_recLeaseBillingSchedule.Next() = 0;
                end;*/
                // Report.run(report::"Lease Contract Create Invoices", true, true, rec);

                // end;
                //}
            }
        }
    }
    trigger OnInit()
    begin
        SynchronizeNow(False);
    end;


    trigger OnAfterGetRecord()
    begin
        if CRMPropertyUnit.Get(rec.acwapp_Room) then;
        if Customer.Get(Rec.AccountNoLookup) then;

    end;

    var
        Customer: Record Customer;
        CRMAccount: Record "CRM Account";
        CRMPropertyUnit: Record "CDS acwapp_propertyunit";

    procedure SynchronizeNow(DoFullSynch: Boolean)
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        CDSSetupDefaults: Codeunit "CDS Setup Defaults";
    begin
        CDSSetupDefaults.GetPrioritizedMappingList(TempNameValueBuffer);

        TempNameValueBuffer.Ascending(true);
        if not TempNameValueBuffer.FindSet() then
            exit;

        repeat
            if IntegrationTableMapping.Get(TempNameValueBuffer.Value) then
                IntegrationTableMapping.SynchronizeNow(DoFullSynch);
        until TempNameValueBuffer.Next() = 0;
    end;

}

