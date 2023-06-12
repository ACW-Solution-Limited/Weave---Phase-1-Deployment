page 83046 "Locker"
{
    ApplicationArea = All;
    Caption = 'Locker';
    PageType = List;
    SourceTable = "Locker";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Locker ID"; Rec."Locker ID")
                {
                    ToolTip = 'Specifies the value of the Locker ID field.';
                }
                field("Locker Type Name"; Rec."Locker Type Name")
                {
                    ToolTip = 'Specifies the value of the Locker Type Name field.';
                }
                field("Locker Property No."; Rec."Locker Property No.")
                {
                    ToolTip = 'Specifies the value of the Locker Property No. field.';
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
                field("Monthy Rent"; Rec."Monthy Rent")
                {
                    ToolTip = 'Specifies the value of the Monthy Rent field.';
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
                    l_recLocker: Record Locker;
                begin
                    CurrPage.SetSelectionFilter(l_recLocker);
                    l_cuAAddiItemSalestoBillSch.CreateLocker(l_recLocker);
                end;

            }
        }
    }
}

