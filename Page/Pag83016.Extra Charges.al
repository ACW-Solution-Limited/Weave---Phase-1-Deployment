page 83016 "Extra Charges"
{
    ApplicationArea = All;
    Caption = 'Extra Charges';
    PageType = List;
    SourceTable = "Extra Charge";
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

                field("Charges Type"; Rec."Charges Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charges Type field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No." field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Type field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }

                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Total Amount Inclu. VAT"; Rec."Total Amount Inclu. VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the "Total Amount Inclu. VAT" field.';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Status field.';
                }
                field("Posted Sales Invoice No."; Rec."Posted Sales Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Invoice No. field.';
                }
                field("Stripe Invoice ID"; Rec."Stripe Invoice ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Invoice ID field.';
                }

                field("Payment Link"; Rec."Payment Link")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Link field.';
                }
                field("BC Status"; Rec."BC Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Status field.';
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created on field.';
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
                    l_recExtraCharge: Record "Extra Charge";
                begin
                    CurrPage.SetSelectionFilter(l_recExtraCharge);
                    l_cuAAddiItemSalestoBillSch.CreateExtraCharge(l_recExtraCharge);
                end;

            }
        }
    }
}
