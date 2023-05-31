codeunit 83150 "Data Patch"
{
    Permissions = tabledata "Sales Invoice Header" = rimd,
                  tabledata "Sales Invoice Line" = rimd;


    trigger OnRun()
    begin
        ModifyAllContractPropertyUnit();
        ModifySalesInvoiceHeader('SIML-2023060031', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060031.pdf');
        ModifySalesInvoiceHeader('SIML-2023060030', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060030.pdf');
        ModifySalesInvoiceHeader('SIML-2023060029', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060029.pdf');
        ModifySalesInvoiceHeader('SIML-2023060028', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060028.pdf');
        ModifySalesInvoiceHeader('SIML-2023060027', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060027.pdf');
        ModifySalesInvoiceHeader('SIML-2023060026', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060025.pdf');
        ModifySalesInvoiceHeader('SIML-2023060025', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060025.pdf');
        ModifySalesInvoiceHeader('SIML-2023060024', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060024.pdf');
        ModifySalesInvoiceHeader('SIML-2023060023', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060023.pdf');
        ModifySalesInvoiceHeader('SIML-2023060022', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060022.pdf');
        ModifySalesInvoiceHeader('SIML-2023060021', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060021.pdf');
        ModifySalesInvoiceHeader('SIML-2023060020', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060020.pdf');
        ModifySalesInvoiceHeader('SIML-2023060019', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060019.pdf');
        ModifySalesInvoiceHeader('SIML-2023060018', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060018.pdf');
        ModifySalesInvoiceHeader('SIML-2023060017', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060017.pdf');
        ModifySalesInvoiceHeader('SIML-2023060016', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060016.pdf');
        ModifySalesInvoiceHeader('SIML-2023060015', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060015.pdf');
        ModifySalesInvoiceHeader('SIML-2023060014', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060014.pdf');
        ModifySalesInvoiceHeader('SIML-2023060013', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060013.pdf');
        ModifySalesInvoiceHeader('SIML-2023060012', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060012.pdf');
        ModifySalesInvoiceHeader('SIML-2023060011', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060011.pdf');
        ModifySalesInvoiceHeader('SIML-2023060010', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060010.pdf');
        ModifySalesInvoiceHeader('SIML-2023060009', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060009.pdf');
        ModifySalesInvoiceHeader('SIML-2023060008', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060008.pdf');
        ModifySalesInvoiceHeader('SIML-2023060007', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060007.pdf');
        ModifySalesInvoiceHeader('SIML-2023060006', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060006.pdf');
        ModifySalesInvoiceHeader('SIML-2023060005', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060005.pdf');
        ModifySalesInvoiceHeader('SIML-2023060004', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060004.pdf');
        ModifySalesInvoiceHeader('SIML-2023060003', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060003.pdf');
        ModifySalesInvoiceHeader('SIML-2023060002', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060002.pdf');
        ModifySalesInvoiceHeader('SIML-2023060001', 'https://wlbooking.blob.core.windows.net/futureappeal/1306 Sales - Invoice SIML-2023060001.pdf');
        ModifySalesInvoiceHeader('SIKT-2023060081', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023060081.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050011', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050011.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050010', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050010.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050009', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050009.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050008', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050008.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050007', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050007.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050006', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050006.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050005', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050005.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050004', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050004.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050003', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050003.pdf');
        ModifySalesInvoiceHeader('SIKT-2023050002', 'https://wlbooking.blob.core.windows.net/asiabest/1306 Sales - Invoice SIKT-2023050002.pdf');
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




    procedure ModifySalesInvoiceHeader(DocumentNo: Code[250]; BlobURL: Text[1024])
    var
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
        l_recLeaseContractHeader: Record "Lease Contract Header";
    begin
        if l_recSalesInvoiceHeader.Get(DocumentNo) then begin
            l_recSalesInvoiceHeader.BlobURL := BlobURL;
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
