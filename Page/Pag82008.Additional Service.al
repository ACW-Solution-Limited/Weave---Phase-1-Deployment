page 82008 "Additional Service"
{
    ApplicationArea = All;
    Caption = 'Additional Service';
    PageType = List;
    SourceTable = "Additional Service";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field("Price Inclu. VAT"; Rec."Price Inclu. VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the "Total Amount Inclu. VAT" field.';
                }
                field("Service Start Date"; Rec."Service Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Start Date field.';
                }
                field("Service End Date"; Rec."Service End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service End Date field.';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Status field.';
                }
                field("BC Status"; Rec."BC Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Status field.';
                }
                field("Stripe/QFPay Invoice ID"; Rec."Stripe/QFPay Invoice ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Invoice ID field.';
                }
                field("Posted Sales Invoice No."; Rec."Posted Sales Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Invoice No. field.';
                }
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

}
