page 83123 "CRM Extra Charges"
{
    Caption = 'Extra Charges';
    PageType = List;
    SourceTable = "CDS acwapp_extracharges";
    UsageCategory = Lists;
    //ApplicationArea = all;

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
                field(acwapp_ProductTypeName; Rec.acwapp_ProductTypeName)
                {
                    ApplicationArea = All;
                    Caption = 'Product Type Name';

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
                    Caption = 'Product Name';
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
                field(acwapp_amount_Base; Rec.acwapp_amount_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount (Base) field.';
                }
                field(acwapp_BCStatus; Rec.acwapp_BCStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Status field.';
                }

                field(acwapp_SalesInvoiceName; Rec.acwapp_SalesInvoiceName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Invoice Name field.';
                }


                field(acwapp_StripeInvoiceID; Rec.acwapp_StripeInvoiceID) { ApplicationArea = All; }
                field(acwapp_PostedSalesInvoiceNo; Rec.acwapp_PostedSalesInvoiceNo) { ApplicationArea = All; }

                field(CreatedOn; Rec.CreatedOn) { ApplicationArea = All; }

            }
        }
    }
    actions
    {
        area(Processing)
        {

        }
    }
    var
        CurrentlyCoupledCRMExtraCharges: Record "CDS acwapp_extracharges";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMExtraCharges(CRMExtraCharges: Record "CDS acwapp_extracharges")
    begin
        CurrentlyCoupledCRMExtraCharges := CRMExtraCharges;
    end;
}
