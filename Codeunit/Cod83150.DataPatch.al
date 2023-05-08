codeunit 83150 "Data Patch"
{
    Permissions = tabledata "Sales Invoice Header" = rimd,
                  tabledata "Sales Invoice Line" = rimd;


    trigger OnRun()
    begin
        ModifyAllContractPropertyUnit();


        ModifySalesInvoiceLineByBillingSchedule('SI-2023040053', 10000, 10000, 'PB-230424-001', 1);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040053', 20000, 20000, 'PB-230424-001', 3);



        ModifySalesInvoiceLineByBillingSchedule('SI-2023040045', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040046', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040047', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040048', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040049', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040050', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040050', 20000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040051', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040052', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040053', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040053', 20000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040055', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040055', 20000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040056', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040056', 20000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040058', 10000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040058', 20000);
        ModifySalesInvoiceLineByBillingSchedule('SI-2023040060', 10000);

    end;

    procedure ModifyAllContractPropertyUnit()
    var
        l_recLeaseContractHeader: Record "Lease Contract Header";
    begin
        l_recLeaseContractHeader.Reset();
        if l_recLeaseContractHeader.FindFirst() then
            repeat
                l_recLeaseContractHeader.Validate("Property CRMGuid");
                l_recLeaseContractHeader.Modify();
            until l_recLeaseContractHeader.Next() = 0;
    end;




    procedure ModifySalesInvoiceHeader(DocumentNo: Code[250]; NewLeaseContractNo: Text; NewLeaseContractName: Text)
    var
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if l_recSalesInvoiceHeader.Get(DocumentNo) then begin
            l_recSalesInvoiceHeader."Lease Contract No." := NewLeaseContractNo;
            l_recSalesInvoiceHeader."Lease Contract Name" := NewLeaseContractName;
            l_recSalesInvoiceHeader.Modify();
        end;
    end;


    procedure ModifySalesInvoiceLineByBillingSchedule(DocumentNo: Code[250]; LineNo: Integer; NewBillingScheduleLineNo: Integer; NewContractNo: Code[100]; NewBillingScheduleType: Integer)
    var
        l_recSalesInvoiceLine: Record "Sales Invoice Line";
        l_recPostedSalesInvoiceLine: Record "Posted Sales Inv. Line for CRM";
    begin
        if l_recSalesInvoiceLine.Get(DocumentNo, LineNo) then begin
            l_recSalesInvoiceLine."Billing Schedule Line No." := NewBillingScheduleLineNo;
            l_recSalesInvoiceLine."Contract No." := NewContractNo;
            l_recSalesInvoiceLine."Billing Schedule Type" := NewBillingScheduleType;
            l_recSalesInvoiceLine.Modify();
        end;

        if l_recPostedSalesInvoiceLine.Get(DocumentNo, LineNo) then begin
            l_recPostedSalesInvoiceLine."Billing Schedule Line No." := NewBillingScheduleLineNo;
            l_recPostedSalesInvoiceLine."Contract No." := NewContractNo;
            l_recPostedSalesInvoiceLine."Billing Schedule Type" := NewBillingScheduleType;
            l_recPostedSalesInvoiceLine.Modify();
        end;



    end;


    procedure ModifySalesInvoiceLineByBillingSchedule(DocumentNo: Code[250]; LineNo: Integer)
    var
        l_recSalesInvoiceLine: Record "Sales Invoice Line";
        l_recPostedSalesInvoiceLine: Record "Posted Sales Inv. Line for CRM";
        l_recBillingSchedule: Record "Lease Contract Billing Sched.";
        l_recLeaseContractHeader: Record "Lease Contract Header";
    begin

        if l_recSalesInvoiceLine.Get(DocumentNo, LineNo) then begin
            l_recBillingSchedule.Reset();
            l_recBillingSchedule.SetFilter("Document No.", l_recSalesInvoiceLine."Document No.");
            l_recBillingSchedule.SetRange("Line No.", l_recSalesInvoiceLine."Billing Schedule Line No.");
            if l_recBillingSchedule.FindFirst() then begin
                l_recSalesInvoiceLine."Lease From Date" := l_recBillingSchedule."Contract Start Date";
                l_recSalesInvoiceLine."Lease To Date" := l_recBillingSchedule."Contract End Date";

                if l_recLeaseContractHeader.Get(l_recBillingSchedule."Contract No.") then
                    l_recSalesInvoiceLine."Invoice Description" := StrSubstNo('%1 in %2 - (%3) (%4)',
                                                  GetPropertyUnitInformation(l_recLeaseContractHeader."Property CRMGuid", 'RoomTypeName'),
                                                  GetPropertyUnitInformation(l_recLeaseContractHeader."Property CRMGuid", 'Description'),
                                                  GetPropertyUnitInformation(l_recLeaseContractHeader."Property CRMGuid", 'RoomUnit'),
                                                  l_recBillingSchedule."Contract No.");

                l_recSalesInvoiceLine.Modify();
            end;
        end;

        if l_recPostedSalesInvoiceLine.Get(DocumentNo, LineNo) then begin
            l_recBillingSchedule.Reset();
            l_recBillingSchedule.SetFilter("Document No.", l_recPostedSalesInvoiceLine."Document No.");
            l_recBillingSchedule.SetRange("Line No.", l_recPostedSalesInvoiceLine."Billing Schedule Line No.");
            if l_recBillingSchedule.FindFirst() then begin
                l_recPostedSalesInvoiceLine."Lease From Date" := l_recBillingSchedule."Contract Start Date";
                l_recPostedSalesInvoiceLine."Lease To Date" := l_recBillingSchedule."Contract End Date";

                if l_recLeaseContractHeader.Get(l_recBillingSchedule."Contract No.") then
                    l_recPostedSalesInvoiceLine."Invoice Description" := StrSubstNo('%1 in %2 - (%3) (%4)',
                                                  GetPropertyUnitInformation(l_recLeaseContractHeader."Property CRMGuid", 'RoomTypeName'),
                                                  GetPropertyUnitInformation(l_recLeaseContractHeader."Property CRMGuid", 'Description'),
                                                  GetPropertyUnitInformation(l_recLeaseContractHeader."Property CRMGuid", 'RoomUnit'),
                                                  l_recBillingSchedule."Contract No.");

                l_recPostedSalesInvoiceLine.Modify();
            end;
        end;
    end;



    procedure GetPropertyUnitInformation(PropertyCRMGuid: Guid; Type: Text[250]): Text
    var
        l_recPropertyUnit: Record "Property Unit";
    begin

        l_recPropertyUnit.SetRange("CRM Guid", PropertyCRMGuid);
        If l_recPropertyUnit.FindLast() then begin
            case Type of
                'RoomTypeName':
                    exit(l_recPropertyUnit."Room Type Name");//To be updated , delete comment after revised
                'RoomUnit':
                    exit(l_recPropertyUnit."No.");//To be updated , delete comment after revised
                'Description':
                    exit(l_recPropertyUnit."Property Unit Name");
            end;
        end

    end;

}
