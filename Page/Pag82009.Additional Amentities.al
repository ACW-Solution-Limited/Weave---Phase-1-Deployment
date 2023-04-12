page 82009 "Additional Amentities"
{
    ApplicationArea = All;
    Caption = 'Additional Amentities';
    PageType = List;
    SourceTable = "Additional Amenities";
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
                    TableRelation = Item."No.";
                    trigger OnValidate()
                    var
                        Item: Record Item;
                    begin
                        Item.Get(Rec."Item No.");
                        Rec."Item Description" := Item.Description;
                    end;
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
                    TableRelation = Customer."No.";
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact No. field.';
                    TableRelation = Contact."No.";
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
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
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
                field("Stripe Invoice ID"; Rec."Stripe Invoice ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Invoice ID field.';
                }
                field("Posted Sales Invoice No."; Rec."Posted Sales Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Invoice No. field.';
                }
                field("Billing Schedule Line No."; Rec."Billing Schedule Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Billing Schedule Line No. field.';
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
                    CRMAdditionalAmenities: Record "Additional Amenities";
                begin
                    CurrPage.SetSelectionFilter(CRMAdditionalAmenities);
                    l_cuAAddiItemSalestoBillSch.CreateAdditionalAmenities(CRMAdditionalAmenities);
                end;

            }
        }
    }
}
