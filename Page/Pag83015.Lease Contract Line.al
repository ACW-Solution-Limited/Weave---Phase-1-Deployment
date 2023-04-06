page 83015 "Lease Contract Line"
{
    ApplicationArea = All;
    Caption = 'Lease Contract Line';
    PageType = List;
    SourceTable = "Lease Contract Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Billing Schedule Created"; Rec."Billing Schedule Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Billing Scheduled Created field.';
                }
                field(CompanyId; Rec.CompanyId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Guid field.';
                }
                field("Contract Name"; Rec."Contract Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Name field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Key"; Rec."Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CRM Guid field.';
                }
                field(Key2; Rec.Key2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CRM Guid 2 field.';
                }
                field("Lease From Date"; Rec."Lease From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lease From Date field.';
                }
                field("Lease To Date"; Rec."Lease To Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lease To Date field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field("Price Type"; Rec."Price Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Type field.';
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field("Property Unit No."; Rec."Property Unit No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lease Unit No. field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
