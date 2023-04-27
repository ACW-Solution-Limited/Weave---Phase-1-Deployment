codeunit 83150 "Data Patch"
{
    Permissions = tabledata "Sales Invoice Header" = rimd,
                  tabledata "Sales Invoice Line" = rimd;


    trigger OnRun()
    begin

        ModifySalesInvoiceHeader('SI-2023030001', 'PB-230221-003', 'PB-230221-003 | Tan Wai Yee ', DMY2Date(21, 2, 2023), DMY2Date(15, 3, 2023), DMY2Date(14, 3, 2024), 0);
        ModifySalesInvoiceHeader('SI-2023030002', 'PB-230223-004', 'PB-230223-004 | Ho Kit Mun Jasmine ', DMY2Date(23, 2, 2023), DMY2Date(17, 4, 2023), DMY2Date(16, 5, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030003', 'PB-230220-001', 'PB-230220-001 | Trissha Devina Kunzru ', DMY2Date(20, 2, 2023), DMY2Date(8, 3, 2023), DMY2Date(7, 5, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030004', 'PB-230222-001', 'PB-230222-001 | David Grant Anthony ', DMY2Date(22, 2, 2023), DMY2Date(26, 3, 2023), DMY2Date(30, 4, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030005', 'PB-230223-001', 'PB-230223-001 | Sean Peter Mccarvill ', DMY2Date(23, 2, 2023), DMY2Date(17, 3, 2023), DMY2Date(16, 6, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030006', 'PB-230223-006', 'PB-230223-006 | Sharon Bahl  | Sajeeve Bahl ', DMY2Date(23, 2, 2023), DMY2Date(15, 3, 2023), DMY2Date(14, 5, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030007', 'PB-230224-001', 'PB-230224-001 | Neoh Ka Kit  | Navina Rajendran Mudaliar ', DMY2Date(24, 2, 2023), DMY2Date(1, 4, 2023), DMY2Date(1, 4, 2024), 0);
        ModifySalesInvoiceHeader('SI-2023030008', 'PB-230301-002', 'PB-230301-002 | Liu Chang ', DMY2Date(1, 3, 2023), DMY2Date(12, 4, 2023), DMY2Date(7, 6, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030009', 'PB-230228-002', 'PB-230228-002 | Krizia Enola Nata ', DMY2Date(28, 2, 2023), DMY2Date(15, 3, 2023), DMY2Date(22, 4, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030010', 'PB-230228-001', 'PB-230228-001 | Anirudh Baliga ', DMY2Date(28, 2, 2023), DMY2Date(8, 3, 2023), DMY2Date(8, 9, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030011', 'PB-230301-001', 'PB-230301-001 | Melody Yun Xuan Lau ', DMY2Date(1, 3, 2023), DMY2Date(17, 3, 2023), DMY2Date(17, 6, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030012', 'PB-230303-003', 'PB-230303-003 | Alexander Campbell Forgie ', DMY2Date(3, 3, 2023), DMY2Date(9, 3, 2023), DMY2Date(8, 4, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030013', 'PB-230303-001', 'PB-230303-001 | Aman Deep Kochher ', DMY2Date(3, 3, 2023), DMY2Date(25, 3, 2023), DMY2Date(24, 7, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030014', 'PB-230303-002', 'PB-230303-002 | Carolyn Summer Shayne ', DMY2Date(3, 3, 2023), DMY2Date(31, 3, 2023), DMY2Date(31, 3, 2024), 0);
        ModifySalesInvoiceHeader('SI-2023030015', 'PB-230303-004', 'PB-230303-004 | Rashidah Rashid ', DMY2Date(3, 3, 2023), DMY2Date(7, 3, 2023), DMY2Date(6, 9, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023030016', 'PB-230303-005', 'PB-230303-005 | Anushka Sikka  | Kaamil Shah ', DMY2Date(3, 3, 2023), DMY2Date(1, 4, 2023), DMY2Date(30, 6, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023040038', 'PB-230223-006', 'PB-230223-006 | Sharon Bahl  | Sajeeve Bahl ', DMY2Date(23, 2, 2023), DMY2Date(15, 3, 2023), DMY2Date(14, 5, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023040039', 'PB-230309-001', 'PB-230309-001 | Hong Bin Choi | Jae youn Lee', DMY2Date(9, 3, 2023), DMY2Date(20, 3, 2023), DMY2Date(19, 5, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023040040', 'PB-230228-002', 'PB-230228-002 | Krizia Enola Nata ', DMY2Date(28, 2, 2023), DMY2Date(15, 3, 2023), DMY2Date(22, 4, 2023), 0);
        ModifySalesInvoiceHeader('SI-2023040041', 'PB-230419-007', 'PB-230419-007 | Ashrin Krishnan ', DMY2Date(19, 4, 2023), DMY2Date(23, 4, 2023), DMY2Date(30, 5, 2023), 4);



        ModifySalesInvoiceLine('SI-2023030025', 30000, 'Discount (MKTG-KOL20) - Midtown Premium Suite L2 in Weave Suites - Midtown - MT-212 (PB-230310-001))');
        ModifySalesInvoiceLine('SI-2023040038', 10000, 'Extension Fee - Midtown Loft Suite in Weave Suites - Midtown - (MT-201)');
        ModifySalesInvoiceLine('SI-2023040039', 10000, 'Extension Fee - Midtown One Bedroom Suite in Weave Suites - Midtown - (MT-234)');
        ModifySalesInvoiceLine('SI-2023040040', 10000, 'Extension Fee - Midtown Premium Suite in Weave Suites - Midtown - (MT-220)');
        ModifySalesInvoiceLine('SI-2023040037', 20000, 'Midtown Premium Suite in Weave Suites - Midtown - (MT-110) (PB-230419-001)');
        ModifySalesInvoiceLine('SI-2023040041', 20000, 'Midtown Skylight Suite in Weave Suites - Midtown - (MT-109) (PB-230419-007)');
        ModifySalesInvoiceLine('SI-2023040036', 20000, 'Midtown Premium Suite in Weave Suites - Midtown - (MT-202) (PB-230420-011)');
        ModifySalesInvoiceLine('SI-2023040043', 20000, 'Midtown Premium Suite in Weave Suites - Midtown - (MT-206) (PB-230421-001)');
        ModifySalesInvoiceLine('SI-2023040028', 10000, 'Midtown Premium Suite in Weave Suites - Midtown - (MT-228) (PB-230327-005)');
        ModifySalesInvoiceLine('SI-2023040019', 20000, 'Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-208) (PB-230413-002)');
        ModifySalesInvoiceLine('SI-2023030018', 30000, 'Prepaid Discount - Midtown Loft Suite in Weave Suites - Midtown (MT-215) (PB-230306-001)');
        ModifySalesInvoiceLine('SI-2023030054', 10000, 'Rent - Midtown Garden Suite in Weave Suites - Midtown - (MT-248) (PB-230317-002)');
        ModifySalesInvoiceLine('SI-2023030051', 10000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-231) (PB-230228-001)');
        ModifySalesInvoiceLine('SI-2023030003', 20000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-204) (PB-230220-001)');
        ModifySalesInvoiceLine('SI-2023030001', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-221) (PB-230221-003)');
        ModifySalesInvoiceLine('SI-2023030004', 20000, 'Rent - Midtown One Bedroom Suite in Weave Suites - Midtown - (MT-236) (PB-230222-001)');
        ModifySalesInvoiceLine('SI-2023030005', 20000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-218) (PB-230223-001)');
        ModifySalesInvoiceLine('SI-2023030002', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-223) (PB-230223-004)');
        ModifySalesInvoiceLine('SI-2023030006', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-201) (PB-230223-006)');
        ModifySalesInvoiceLine('SI-2023030007', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-211) (PB-230224-001)');
        ModifySalesInvoiceLine('SI-2023030010', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-231) (PB-230228-001)');
        ModifySalesInvoiceLine('SI-2023030009', 20000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-220) (PB-230228-002)');
        ModifySalesInvoiceLine('SI-2023030011', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-227) (PB-230301-001)');
        ModifySalesInvoiceLine('SI-2023030008', 20000, 'Rent - Midtown Garden Suite in Weave Suites - Midtown - (MT-248) (PB-230301-002)');
        ModifySalesInvoiceLine('SI-2023030013', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-232) (PB-230303-001)');
        ModifySalesInvoiceLine('SI-2023030014', 20000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-216) (PB-230303-002)');
        ModifySalesInvoiceLine('SI-2023030012', 20000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-202) (PB-230303-003)');
        ModifySalesInvoiceLine('SI-2023030015', 20000, 'Rent - Midtown Urban Suite in Weave Suites - Midtown - (MT-240) (PB-230303-004)');
        ModifySalesInvoiceLine('SI-2023030018', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-215) (PB-230306-001)');
        ModifySalesInvoiceLine('SI-2023030018', 40000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-215) (PB-230306-001)');
        ModifySalesInvoiceLine('SI-2023030018', 50000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-215) (PB-230306-001)');
        ModifySalesInvoiceLine('SI-2023030018', 60000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-215) (PB-230306-001)');
        ModifySalesInvoiceLine('SI-2023030018', 70000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-215) (PB-230306-001)');
        ModifySalesInvoiceLine('SI-2023030018', 80000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-215) (PB-230306-001)');
        ModifySalesInvoiceLine('SI-2023030019', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-213) (PB-230306-002)');
        ModifySalesInvoiceLine('SI-2023030046', 20000, 'Rent - Midtown Loft Suite in Weave Suites - Midtown - (MT-205) (PB-230323-005)');
        ModifySalesInvoiceLine('SI-2023030034', 20000, 'Rent - Midtown One Bedroom Suite in Weave Suites - Midtown - (MT-238) (PB-230317-003)');
        ModifySalesInvoiceLine('SI-2023030020', 20000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-214) (PB-230307-001)');
        ModifySalesInvoiceLine('SI-2023030025', 20000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-212) (PB-230310-001)');
        ModifySalesInvoiceLine('SI-2023030030', 20000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-212) (PB-230310-001)');
        ModifySalesInvoiceLine('SI-2023040012', 20000, 'Rent - Midtown Premium Suite in Weave Suites - Midtown - (MT-114) (PB-230410-001)');
        ModifySalesInvoiceLine('SI-2023040006', 10000, 'Rent - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-220) (PB-230228-002)');
        ModifySalesInvoiceLine('SI-2023030042', 20000, 'Rent - Midtown Premium Suite in Weave Suites - Midtown - (MT-204) (PB-230320-008)');
        ModifySalesInvoiceLine('SI-2023030049', 20000, 'Rent - Midtown Premium Suite in Weave Suites - Midtown - (MT-228) (PB-230327-005)');
        ModifySalesInvoiceLine('SI-2023040014', 20000, 'Rent - Midtown Skylight Suite in Weave Suites - Midtown - (MT-113) (PB-230407-002)');
        ModifySalesInvoiceLine('SI-2023030047', 20000, 'Rent - Midtown Urban Suite in Weave Suites - Midtown - (MT-244) (PB-230324-002)');
        ModifySalesInvoiceLine('SI-2023030003', 10000, 'Deposit - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-204) (PB-230220-001)');
        ModifySalesInvoiceLine('SI-2023030001', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-221) (PB-230221-003)');
        ModifySalesInvoiceLine('SI-2023030004', 10000, 'Deposit - Midtown One Bedroom Suite in Weave Suites - Midtown - (MT-236) (PB-230222-001)');
        ModifySalesInvoiceLine('SI-2023030005', 10000, 'Deposit - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-218) (PB-230223-001)');
        ModifySalesInvoiceLine('SI-2023030002', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-223) (PB-230223-004)');
        ModifySalesInvoiceLine('SI-2023030006', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-201) (PB-230223-006)');
        ModifySalesInvoiceLine('SI-2023030007', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-211) (PB-230224-001)');
        ModifySalesInvoiceLine('SI-2023030010', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-231) (PB-230228-001)');
        ModifySalesInvoiceLine('SI-2023030009', 10000, 'Deposit - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-220) (PB-230228-002)');
        ModifySalesInvoiceLine('SI-2023030011', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-227) (PB-230301-001)');
        ModifySalesInvoiceLine('SI-2023030008', 10000, 'Deposit - Midtown Garden Suite in Weave Suites - Midtown - (MT-248) (PB-230301-002)');
        ModifySalesInvoiceLine('SI-2023030013', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-232) (PB-230303-001)');
        ModifySalesInvoiceLine('SI-2023030014', 10000, 'Deposit - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-216) (PB-230303-002)');
        ModifySalesInvoiceLine('SI-2023030012', 10000, 'Deposit - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-202) (PB-230303-003)');
        ModifySalesInvoiceLine('SI-2023030015', 10000, 'Deposit - Midtown Urban Suite in Weave Suites - Midtown - (MT-240) (PB-230303-004)');
        ModifySalesInvoiceLine('SI-2023030018', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-215) (PB-230306-001)');
        ModifySalesInvoiceLine('SI-2023030019', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-213) (PB-230306-002)');
        ModifySalesInvoiceLine('SI-2023030046', 10000, 'Deposit - Midtown Loft Suite in Weave Suites - Midtown - (MT-205) (PB-230323-005)');
        ModifySalesInvoiceLine('SI-2023030034', 10000, 'Deposit - Midtown One Bedroom Suite in Weave Suites - Midtown - (MT-238) (PB-230317-003)');
        ModifySalesInvoiceLine('SI-2023030020', 10000, 'Deposit - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-214) (PB-230307-001)');
        ModifySalesInvoiceLine('SI-2023030025', 10000, 'Deposit - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-212) (PB-230310-001)');
        ModifySalesInvoiceLine('SI-2023030030', 10000, 'Deposit - Midtown Premium Suite L2 in Weave Suites - Midtown - (MT-212) (PB-230310-001)');
        ModifySalesInvoiceLine('SI-2023040012', 10000, 'Deposit - Midtown Premium Suite in Weave Suites - Midtown - (MT-114) (PB-230410-001)');
        ModifySalesInvoiceLine('SI-2023030042', 10000, 'Deposit - Midtown Premium Suite in Weave Suites - Midtown - (MT-204) (PB-230320-008)');
        ModifySalesInvoiceLine('SI-2023030049', 10000, 'Deposit - Midtown Premium Suite in Weave Suites - Midtown - (MT-228) (PB-230327-005)');
        ModifySalesInvoiceLine('SI-2023040014', 10000, 'Deposit - Midtown Skylight Suite in Weave Suites - Midtown - (MT-113) (PB-230407-002)');
        ModifySalesInvoiceLine('SI-2023030047', 10000, 'Deposit - Midtown Urban Suite in Weave Suites - Midtown - (MT-244) (PB-230324-002)');
        ModifySalesInvoiceLine('SI-2023040037', 10000, 'Midtown Premium Suite in Weave Suites - Midtown - (MT-110) (PB-230419-001)');
        ModifySalesInvoiceLine('SI-2023040041', 10000, 'Midtown Skylight Suite in Weave Suites - Midtown - (MT-109) (PB-230419-007)');
        ModifySalesInvoiceLine('SI-2023040036', 10000, 'Midtown Premium Suite in Weave Suites - Midtown - (MT-202) (PB-230420-011)');
        ModifySalesInvoiceLine('SI-2023040043', 10000, 'Midtown Premium Suite in Weave Suites - Midtown - (MT-206) (PB-230421-001)');
        ModifySalesInvoiceLine('SI-2023040019', 10000, 'Midtown Premium Suite in Weave Suites - Midtown - (MT-208) (PB-230413-002)');

    end;





    procedure ModifySalesInvoiceHeader(DocumentNo: Code[250]; NewLeaseContractNo: Text; NewLeaseContractName: Text; NewLeaseContractCreationDate: Date; NewContractStartDate: Date; NewContractEndDate: Date; NewCommissionType: Option)
    var
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if l_recSalesInvoiceHeader.Get(DocumentNo) then begin
            l_recSalesInvoiceHeader."Lease Contract No." := NewLeaseContractNo;
            l_recSalesInvoiceHeader."Lease Contract Name" := NewLeaseContractName;
            l_recSalesInvoiceHeader."Lease Contract Creation Date" := NewLeaseContractCreationDate;
            l_recSalesInvoiceHeader."Contract Start Date" := NewContractStartDate;
            l_recSalesInvoiceHeader."Contract End Date" := NewContractEndDate;
            l_recSalesInvoiceHeader."Commission Type" := NewCommissionType;
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
