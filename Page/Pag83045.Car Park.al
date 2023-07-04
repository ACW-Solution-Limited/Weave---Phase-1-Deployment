page 83045 "Car Park"
{
    ApplicationArea = All;
    Caption = 'Car Park';
    PageType = List;
    SourceTable = "Car Park";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Car Park ID"; Rec."Car Park ID")
                {
                    ToolTip = 'Specifies the value of the Car Park ID field.';
                }
                field("Car Park Type Name"; Rec."Car Park Type Name")
                {
                    ToolTip = 'Specifies the value of the Car Park Type Name field.';
                }
                field("Car Park Property No."; Rec."Car Park Property No.")
                {
                    ToolTip = 'Specifies the value of the Car Park Property No. field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Bill. Sche. Creation Datetime"; Rec."Bill. Sche. Creation Datetime")
                {
                    ToolTip = 'Specifies the value of the Bill. Sche. Creation Datetime field.';
                }
                field("Created to Billing Schedule"; Rec."Created to Billing Schedule")
                {
                    ToolTip = 'Specifies the value of the Created to Billing Schedule field.';
                }
                field("Monthy Rent"; Rec."Monthy Rent")
                {
                    ToolTip = 'Specifies the value of the Monthy Rent field.';
                }
                field("Created On"; Rec."Created On")
                {
                    ToolTip = 'Specifies the value of the Created On field.';
                }
                field("Modified On"; Rec."Modified On")
                {
                    ToolTip = 'Specifies the value of the Modified On field.';
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
                    l_recCarPark: Record "Car Park";
                begin
                    CurrPage.SetSelectionFilter(l_recCarPark);
                    l_cuAAddiItemSalestoBillSch.CreateCarPark(l_recCarPark);
                end;

            }
        }
    }
}
