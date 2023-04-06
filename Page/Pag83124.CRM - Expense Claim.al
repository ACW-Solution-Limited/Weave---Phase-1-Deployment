page 83124 "CRM Expense Claim"
{
    // ApplicationArea = All;
    Caption = 'Expense Claim';
    PageType = List;
    SourceTable = "CDS acwapp_expenseclaim";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_ExpenseID; Rec.acwapp_ExpenseID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ExpenseID field.';
                }
                field(acwapp_ClaimDate; Rec.acwapp_ClaimDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim Date field.';
                }
                field(acwapp_Description; Rec.acwapp_Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(acwapp_ExpenseTypeName; Rec.acwapp_ExpenseTypeName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_ExpenseTypeName field.';
                    Caption = 'Expense Type Name';
                }
                field(acwapp_BCStatus; Rec.acwapp_BCStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Status field.';
                }
                field(acwapp_unitprice_Base; Rec.acwapp_unitprice_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price (Base) field.';
                }
                field(acwapp_PaymentDate; Rec.acwapp_PaymentDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field(acwapp_ApprovedBy; Rec.acwapp_ApprovedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved By field.';
                }
                field(acwapp_ApprovalStatus; Rec.acwapp_ApprovalStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
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
        CurrentlyCoupledCRMExpenseClaim: Record "CDS acwapp_expenseclaim";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMExpenseClaim(CRMExpenseClaim: Record "CDS acwapp_expenseclaim")
    begin
        CurrentlyCoupledCRMExpenseClaim := CRMExpenseClaim;
    end;

}