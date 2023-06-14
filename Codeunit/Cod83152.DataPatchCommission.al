codeunit 83152 "Data Patch Commission"
{
    Permissions = tabledata "Sales Invoice Header" = rimd,
                  tabledata "Sales Cr.Memo Header" = rimd;


    trigger OnRun()
    begin
        ModifySalesInvoice();
        ModifyPostedSalesInvoice();
        ModifyPostedCreditMemo();


    end;

    procedure ModifySalesInvoice()
    var
        l_recSalesHeader: Record "Sales Header";
        l_recLeaseContractHeader: Record "Lease Contract Header";
        l_Salescommissionsetup: Record "Sales Commission Setup";
    begin
        l_recSalesHeader.Reset;
        l_recSalesHeader.SetFilter("Document Type", '=%1|%2', l_recSalesHeader."Document Type"::Invoice, l_recSalesHeader."Document Type"::"Credit Memo");
        If l_recSalesHeader.FindFirst() then
            repeat
                l_recLeaseContractHeader.reset;
                l_Salescommissionsetup.reset;
                l_recLeaseContractHeader.SetRange("No.", l_recSalesHeader."Lease Contract No.");
                If l_recLeaseContractHeader.FindFirst() then begin
                    If l_recLeaseContractHeader."Commission Type" <> l_recLeaseContractHeader."Commission Type"::" " then begin
                        l_Salescommissionsetup.Setrange(Type, l_recLeaseContractHeader."Commission Type");
                        l_Salescommissionsetup.FindFirst;
                        l_recSalesHeader."Commission Type" := l_recLeaseContractHeader."Commission Type";
                        l_recSalesHeader."Calculation Type" := l_Salescommissionsetup."Calculation Type";
                        l_recSalesHeader."Commission Amount" := l_Salescommissionsetup.Amount;
                        If l_recLeaseContractHeader."Salesperson Code" <> '' then
                            l_recSalesHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
                        l_recSalesHeader.Modify();
                    end;
                end;
            /*If l_recSalesHeader."Commission Type" <> l_recSalesHeader."Commission Type"::" " then begin
                l_recLeaseContractHeader.Reset;
                l_recLeaseContractHeader.SetRange("No.", l_recSalesHeader."Lease Contract No.");
                If l_recLeaseContractHeader.FindFirst() then begin
                    If l_recLeaseContractHeader."Salesperson Code" <> '' then begin
                        l_recSalesHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
                        l_recSalesHeader.Modify();
                    end;
                end;
            end else begin
                l_recLeaseContractHeader.reset;
                l_Salescommissionsetup.reset;
                l_recLeaseContractHeader.SetRange("No.", l_recSalesHeader."Lease Contract No.");
                If l_recLeaseContractHeader.FindFirst() then begin
                    If l_recLeaseContractHeader."Commission Type" <> l_recLeaseContractHeader."Commission Type"::" " then begin
                        l_Salescommissionsetup.Setrange(Type, l_recLeaseContractHeader."Commission Type");
                        l_Salescommissionsetup.FindFirst;

                        l_recSalesHeader."Commission Type" := l_recLeaseContractHeader."Commission Type";
                        l_recSalesHeader."Calculation Type" := l_Salescommissionsetup."Calculation Type";
                        l_recSalesHeader."Commission Amount" := l_Salescommissionsetup.Amount;
                        If l_recLeaseContractHeader."Salesperson Code" <> '' then
                            l_recSalesHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
                        l_recSalesHeader.Modify();
                    end;
                end;
            end;*/
            until l_recSalesHeader.Next() = 0;
    end;




    procedure ModifyPostedSalesInvoice()
    var
        l_recSalesInvoiceHeader: Record "Sales Invoice Header";
        l_recLeaseContractHeader: Record "Lease Contract Header";
        l_Salescommissionsetup: Record "Sales Commission Setup";
    begin
        l_recSalesInvoiceHeader.Reset;

        if l_recSalesInvoiceHeader.FindFirst() then
            repeat


                l_recLeaseContractHeader.reset;
                l_Salescommissionsetup.reset;
                l_recLeaseContractHeader.SetRange("No.", l_recSalesInvoiceHeader."Lease Contract No.");
                If l_recLeaseContractHeader.FindFirst() then begin
                    If l_recLeaseContractHeader."Commission Type" <> l_recLeaseContractHeader."Commission Type"::" " then begin
                        l_Salescommissionsetup.Setrange(Type, l_recLeaseContractHeader."Commission Type");
                        l_Salescommissionsetup.FindFirst;
                        l_recSalesInvoiceHeader."Commission Type" := l_recLeaseContractHeader."Commission Type";
                        l_recSalesInvoiceHeader."Calculation Type" := l_Salescommissionsetup."Calculation Type";
                        l_recSalesInvoiceHeader."Commission Amount" := l_Salescommissionsetup.Amount;
                        If l_recLeaseContractHeader."Salesperson Code" <> '' then
                            l_recSalesInvoiceHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
                        l_recSalesInvoiceHeader.Modify();
                    end;
                end;
            // If l_recSalesInvoiceHeader."Commission Type" <> l_recSalesInvoiceHeader."Commission Type"::" " then begin
            //     l_recLeaseContractHeader.Reset;
            //     l_recLeaseContractHeader.SetRange("No.", l_recSalesInvoiceHeader."Lease Contract No.");
            //     If l_recLeaseContractHeader.FindFirst() then begin
            //         If l_recLeaseContractHeader."Salesperson Code" <> '' then begin
            //             l_recSalesInvoiceHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
            //             l_recSalesInvoiceHeader.Modify();
            //         end;
            //     end;
            // end else begin
            //     l_recLeaseContractHeader.reset;
            //     l_Salescommissionsetup.reset;
            //     l_recLeaseContractHeader.SetRange("No.", l_recSalesInvoiceHeader."Lease Contract No.");
            //     If l_recLeaseContractHeader.FindFirst() then begin
            //         If l_recLeaseContractHeader."Commission Type" <> l_recLeaseContractHeader."Commission Type"::" " then begin
            //             l_Salescommissionsetup.Setrange(Type, l_recLeaseContractHeader."Commission Type");
            //             l_Salescommissionsetup.FindFirst;

            //             l_recSalesInvoiceHeader."Commission Type" := l_recLeaseContractHeader."Commission Type";
            //             l_recSalesInvoiceHeader."Calculation Type" := l_Salescommissionsetup."Calculation Type";
            //             l_recSalesInvoiceHeader."Commission Amount" := l_Salescommissionsetup.Amount;
            //             If l_recLeaseContractHeader."Salesperson Code" <> '' then
            //                 l_recSalesInvoiceHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
            //             l_recSalesInvoiceHeader.Modify();
            //         end;
            //     end;
            // end;
            until l_recSalesInvoiceHeader.Next() = 0;
    end;

    procedure ModifyPostedCreditMemo()
    var
        l_recCreditMemoHeader: Record "Sales Cr.Memo Header";
        l_recLeaseContractHeader: Record "Lease Contract Header";
        l_Salescommissionsetup: Record "Sales Commission Setup";
    begin
        l_recCreditMemoHeader.Reset;
        if l_recCreditMemoHeader.FindFirst() then
            repeat
                l_recLeaseContractHeader.reset;
                l_Salescommissionsetup.reset;
                l_recLeaseContractHeader.SetRange("No.", l_recCreditMemoHeader."Lease Contract No.");
                If l_recLeaseContractHeader.FindFirst() then begin
                    If l_recLeaseContractHeader."Commission Type" <> l_recLeaseContractHeader."Commission Type"::" " then begin
                        l_Salescommissionsetup.Setrange(Type, l_recLeaseContractHeader."Commission Type");
                        l_Salescommissionsetup.FindFirst;
                        l_recCreditMemoHeader."Commission Type" := l_recLeaseContractHeader."Commission Type";
                        l_recCreditMemoHeader."Calculation Type" := l_Salescommissionsetup."Calculation Type";
                        l_recCreditMemoHeader."Commission Amount" := l_Salescommissionsetup.Amount;
                        If l_recLeaseContractHeader."Salesperson Code" <> '' then
                            l_recCreditMemoHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
                        l_recCreditMemoHeader.Modify();
                    end;
                end;
            // If l_recCreditMemoHeader."Commission Type" <> l_recCreditMemoHeader."Commission Type"::" " then begin
            //     l_recLeaseContractHeader.Reset;
            //     l_recLeaseContractHeader.SetRange("No.", l_recCreditMemoHeader."Lease Contract No.");
            //     If l_recLeaseContractHeader.FindFirst() then begin
            //         If l_recLeaseContractHeader."Salesperson Code" <> '' then begin
            //             l_recCreditMemoHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
            //             l_recCreditMemoHeader.Modify();
            //         end;
            //     end;
            // end else begin
            //     l_recLeaseContractHeader.reset;
            //     l_Salescommissionsetup.reset;
            //     l_recLeaseContractHeader.SetRange("No.", l_recCreditMemoHeader."Lease Contract No.");
            //     If l_recLeaseContractHeader.FindFirst() then begin
            //         If l_recLeaseContractHeader."Commission Type" <> l_recLeaseContractHeader."Commission Type"::" " then begin
            //             l_Salescommissionsetup.Setrange(Type, l_recLeaseContractHeader."Commission Type");
            //             l_Salescommissionsetup.FindFirst;

            //             l_recCreditMemoHeader."Commission Type" := l_recLeaseContractHeader."Commission Type";
            //             l_recCreditMemoHeader."Calculation Type" := l_Salescommissionsetup."Calculation Type";
            //             l_recCreditMemoHeader."Commission Amount" := l_Salescommissionsetup.Amount;
            //             If l_recLeaseContractHeader."Salesperson Code" <> '' then
            //                 l_recCreditMemoHeader."Salesperson Code" := l_recLeaseContractHeader."Salesperson Code";
            //             l_recCreditMemoHeader.Modify();
            //         end;
            //     end;
            // end;
            until l_recCreditMemoHeader.Next() = 0;
    end;












}
