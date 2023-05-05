codeunit 83150 "Data Patch"
{
    Permissions = tabledata "Sales Invoice Header" = rimd,
                  tabledata "Sales Invoice Line" = rimd;


    trigger OnRun()
    begin
        ModifyAllContractPropertyUnit();
        ModifySalesInvoiceHeader('SI-2023040045', 'PB-230224-001', 'PB-230224-001 | Neoh Ka Kit  | Navina Rajendran Mudaliar ');
        ModifySalesInvoiceHeader('SI-2023040046', 'PB-230303-002', 'PB-230303-002 | Carolyn Summer Shayne ');
        ModifySalesInvoiceHeader('SI-2023040047', 'PB-230303-005', 'PB-230303-005 | Anushka Sikka  | Kaamil Shah ');
        ModifySalesInvoiceHeader('SI-2023040048', 'PB-230306-002', 'PB-230306-002 | Aline Caroline Bonino Cordier  | Olivier Frederic Berthyl Cordier ');
        ModifySalesInvoiceHeader('SI-2023040049', 'PB-230320-007', 'PB-230320-007 | RISHI GARG ');
        ModifySalesInvoiceHeader('SI-2023040050', 'PB-230425-004', 'PB-230425-004 - McConnell Dowell South East Asia Pte Ltd | Gimaj Nikki Marita  ');
        ModifySalesInvoiceHeader('SI-2023040051', 'PB-230321-002', 'PB-230321-002 | Yong Chiang Jasper Ong  | Yung-Cheng Chang ');
        ModifySalesInvoiceHeader('SI-2023040052', 'PB-230320-003', 'PB-230320-003 | ANA CATARINA DE VASCONCELOS BARBEDO ');
        ModifySalesInvoiceHeader('SI-2023040053', 'PB-230424-001', 'PB-230424-001 | ARKADY LEVINSKY ');
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



    procedure ModifySalesInvoiceLine(DocumentNo: Code[250]; LineNo: Integer; NewInvoiceDescription: Text)
    var
        l_recSalesInvoiceLine: Record "Sales Invoice Line";
        l_recPostedSalesInvoiceLine: Record "Posted Sales Inv. Line for CRM";
    begin

        if l_recSalesInvoiceLine.Get(DocumentNo, LineNo) then begin
            l_recSalesInvoiceLine."Invoice Description" := NewInvoiceDescription;
            l_recSalesInvoiceLine.Modify();
        end;

        if l_recPostedSalesInvoiceLine.Get(DocumentNo, LineNo) then begin
            l_recPostedSalesInvoiceLine."Invoice Description" := NewInvoiceDescription;
            l_recPostedSalesInvoiceLine.Modify();
        end;

    end;
}
