page 83013 "Additional Item Sales"
{
    //ApplicationArea = All;
    Caption = 'Additional Item Sales';
    PageType = List;
    SourceTable = "Additional Item Sales";
    UsageCategory = Lists;
    SourceTableView = sorting(Date, SystemCreatedAt) order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Id field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    TableRelation = Customer."No.";
                }
                field("Contract No."; rec."Contract No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Lease Contract Header"."No." where("Customer No." = field("Customer No."));
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                    trigger OnValidate()
                    var
                        l_reItem: Record Item;
                    begin
                        if l_reItem.get(rec."Item No.") THEN begin
                            if rec.Description = '' then BEGIN
                                rec.Description := l_reItem.Description;
                                rec.Modify();
                            end;
                        end;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Status field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Insert Into Billing Schedule")
            {
                ApplicationArea = All;
                Image = InsertStartingFee;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Ins. Add. Item Sales to Bill S";

            }
        }
    }

}
