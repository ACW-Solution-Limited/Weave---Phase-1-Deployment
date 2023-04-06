page 83120 "CRM Additional Service"
{

    Caption = 'Additional Service';
    PageType = List;
    SourceTable = "CDS acwapp_additionalservice";
    UsageCategory = Lists;
    // ApplicationArea = all;

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
                    trigger OnDrillDown()
                    var
                        l_recCRMPropertyBooking: Record "CDS acwapp_propertybooking";
                        l_pageCRMPropertyBooking: Page "CRM Lease Contract";
                    begin
                        l_recCRMPropertyBooking.Reset();
                        l_recCRMPropertyBooking.SetFilter(acwapp_ContractNo, Rec.acwapp_ContractNo);
                        Clear(l_pageCRMPropertyBooking);
                        l_pageCRMPropertyBooking.SetTableView(l_recCRMPropertyBooking);
                        l_pageCRMPropertyBooking.Run();
                    end;
                }
                field(acwapp_ProductID; Rec.acwapp_ProductID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product ID field.';
                }
                field(acwapp_ProductName; Rec.acwapp_ProductName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_ProductName field.';
                }

                field(acwapp_AccountID; Rec.acwapp_AccountID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account ID field.';
                }

                field(acwapp_ContactID; Rec.acwapp_ContactID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact ID field.';
                }

                field(acwapp_Quantity; Rec.acwapp_Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(acwapp_Price; Rec.acwapp_Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }

                field(acwapp_ServiceStartDate; Rec.acwapp_ServiceStartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Start Date field.';
                }
                field(acwapp_ServiceEndDate; Rec.acwapp_ServiceEndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service End Date field.';
                }
                field(acwapp_PaymentStatus; Rec.acwapp_PaymentStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Status field.';
                }
                field(acwapp_BCStatus; Rec.acwapp_BCStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Status field.';
                }
                field(acwapp_TotalAmount; Rec.acwapp_TotalAmount) { ApplicationArea = All; }
                field(acwapp_StripeInvoiceID; Rec.acwapp_StripeInvoiceID) { ApplicationArea = All; }
                field(acwapp_PostedSalesInvoiceNo; Rec.acwapp_PostedSalesInvoices) { ApplicationArea = All; }
                field(CreatedOn; Rec.CreatedOn) { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Insert Into Billing Schedule by Select Line")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = InsertStartingFee;
                trigger OnAction()
                var
                    l_cuAAddiItemSalestoBillSch: Codeunit "Addi.Item Sales to Bill. Sch.";
                    CRMAdditionalService: Record "Additional Service";
                begin
                    CurrPage.SetSelectionFilter(CRMAdditionalService);
                    l_cuAAddiItemSalestoBillSch.CreateAdditionalService(CRMAdditionalService);
                end;

            }
        }
    }


    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    trigger OnOpenPage()
    var
        l_recCompanyInformation: Record "Company Information";
    begin
        l_recCompanyInformation.Get;
        Rec.SetFilter(acwapp_PropertyNo, l_recCompanyInformation."Property Unit No.");
    end;

    procedure SetCurrentlyCoupledCRMAdditionalService(CRMAdditionalservice: Record "CDS acwapp_additionalservice")
    begin
        CurrentlyCoupledCRMAdditionalService := CRMAdditionalservice;
    end;

    var
        CurrentlyCoupledCRMAdditionalService: Record "CDS acwapp_additionalservice";
}
