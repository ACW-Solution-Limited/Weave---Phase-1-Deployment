page 83142 "CRM - Product Inventory Line"
{
    ApplicationArea = All;
    Caption = 'CRM - Product Inventory Line';
    PageType = List;
    SourceTable = "CDS acwapp_productinventory";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(OwningBusinessUnit; Rec.OwningBusinessUnit)
                {
                    ToolTip = 'Specifies the value of the Owning Business Unit field.';
                }

                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }


                field(acwapp_Company; Rec.acwapp_Company)
                {
                    ToolTip = 'Specifies the value of the Company field.';
                }
                field(acwapp_CompanyName; Rec.acwapp_CompanyName)
                {
                    ToolTip = 'Specifies the value of the acwapp_CompanyName field.';
                }
                field(acwapp_Inventory; Rec.acwapp_Inventory)
                {
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field(acwapp_Product; Rec.acwapp_Product)
                {
                    ToolTip = 'Specifies the value of the Product field.';
                }
                field(acwapp_ProductName; Rec.acwapp_ProductName)
                {
                    ToolTip = 'Specifies the value of the acwapp_ProductName field.';
                }
                field(acwapp_Property; Rec.acwapp_Property)
                {
                    ToolTip = 'Specifies the value of the Property field.';
                }
                field(acwapp_PropertyName; Rec.acwapp_PropertyName)
                {
                    ToolTip = 'Specifies the value of the acwapp_PropertyName field.';
                }
                field(acwapp_PropertyUnitID; Rec.acwapp_PropertyUnitID)
                {
                    ToolTip = 'Specifies the value of the Property Unit ID field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(acwapp_productinventoryId; Rec.acwapp_productinventoryId)
                {
                    ToolTip = 'Specifies the value of the Product Inventory field.';
                }
                field(statecode; Rec.statecode)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(statuscode; Rec.statuscode)
                {
                    ToolTip = 'Specifies the value of the Status Reason field.';
                }
            }
        }
    }
    var
        CurrentlyCoupledProductInventory: Record "CDS acwapp_productinventory";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;
     procedure SetCurrentlyCoupledCRMProductInventory(CRMProductInventory: Record "CDS acwapp_productinventory")
    begin
        CurrentlyCoupledProductInventory := CRMProductInventory;
    end;
}
