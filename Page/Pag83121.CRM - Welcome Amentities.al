page 83121 "CRM Welcome Amentities"
{

    Caption = 'CRM Welcome Amentities';
    PageType = List;
    SourceTable = "CDS acwapp_welcomeamenities";
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
                field(acwapp_ProductID; Rec.acwapp_ProductID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product ID field.';
                }
                field(acwapp_ProdcutName; Rec.acwapp_ProdcutName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prodcut Name field.';
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


                field(acwapp_UnitPrice; Rec.acwapp_UnitPrice)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field(acwapp_Date; Rec.acwapp_Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
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
                //  field(acwapp_TotalAmount; Rec.acwapp_TotalAmount) { ApplicationArea = All; }
                field(acwapp_StripeInvoiceID; Rec.acwapp_StripeInvoiceID) { ApplicationArea = All; }
                //field(acwapp_PostedSalesInvoiceNo; Rec.acwapp_PostedSalesInvoiceNo) { ApplicationArea = All; }
                field(CreatedOn; Rec.CreatedOn) { ApplicationArea = All; }

            }
        }
    }
    trigger OnOpenPage()
    var
        l_recCompanyInformation: Record "Company Information";
    begin
        l_recCompanyInformation.Get;
        Rec.SetFilter(acwapp_PropertyNo, l_recCompanyInformation."Property Unit No.");
    end;

    trigger OnInit()
    begin
        SynchronizeNow(False);
    end;

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

    procedure SetCurrentlyCoupledCRMWelcomeAmenities(CRMWelcomeAmenities: Record "CDS acwapp_welcomeamenities")
    begin
        CurrentlyCoupledCRMWelcomeAmenities := CRMWelcomeAmenities;
    end;

    var
        CurrentlyCoupledCRMWelcomeAmenities: Record "CDS acwapp_welcomeamenities";
}
