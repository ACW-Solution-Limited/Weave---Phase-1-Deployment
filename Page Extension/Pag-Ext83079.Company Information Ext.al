pageextension 83079 "Company Information Ext" extends "Company Information"
{
    layout
    {
        addafter("Use GLN in Electronic Document")
        {
            group("Property Unit")
            {
                field("CRM Company Guid"; Rec."CRM Company Guid") { ApplicationArea = all; }
                field("Customer Type"; Rec."Customer Type") { ApplicationArea = all; }
                field("Apply Property Unit No."; Rec."Apply Property Unit No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        if not (Rec."Apply Property Unit No.") then
                            Rec."Property Unit No." := '';
                    end;
                }
                field("Property Unit No."; Rec."Property Unit No.")
                {
                    ApplicationArea = all;
                    Editable = Rec."Apply Property Unit No.";
                    trigger OnAssistEdit()
                    var
                        CRMPropertyUnit: Record "CDS acwapp_propertyunit";
                        CRMPropertyUnitList: Page "CRM Property Unit List";
                    begin
                        CRMPropertyUnit.SetRange(acwapp_Type, CRMPropertyUnit.acwapp_Type::Property);
                        CRMPropertyUnitList.LookupMode := true;
                        if CRMPropertyUnitList.RunModal() = Action::LookupOK then
                            CRMPropertyUnitList.GetRecord(CRMPropertyUnit);

                        Rec."Property Unit No." := CRMPropertyUnit.acwapp_PropertyID;

                    end;
                }
            }

            group("Master Company")
            {
                field("Building Name"; Rec."Building Name") { ApplicationArea = all; }
                field("Purch. Inv. Default Location"; "Purch. Inv. Default Location") { ApplicationArea = all; }
                group(Master)
                {
                    field("HK Master Company"; Rec."HK Master Company") { ApplicationArea = all; }
                    field("SG Master Company"; Rec."SG Master Company") { ApplicationArea = all; }
                }
                group("Expense Claim")
                {
                    field("CRM Currency Guid"; Rec."CRM Currency Guid") { ApplicationArea = all; }
                    field("HK Expense Claim Master"; Rec."HK Expense Claim Master") { ApplicationArea = all; }
                    field("SG Expense Claim Master"; Rec."SG Expense Claim Master") { ApplicationArea = all; }
                }
            }

        }
    }

}
