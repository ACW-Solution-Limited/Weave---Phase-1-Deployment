page 83030 "Event Fee"
{
    ApplicationArea = All;
    Caption = 'Event Fee';
    PageType = List;
    SourceTable = "Event Fee";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Property No."; Rec."Property No.")
                {
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ToolTip = 'Specifies the value of the Customer Code field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Contact Code"; Rec."Contact Code")
                {
                    ToolTip = 'Specifies the value of the Contact Code field.';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field("Event"; Rec."Event")
                {
                    ToolTip = 'Specifies the value of the Event field.';
                }
                field("Event Session"; Rec."Event Session")
                {
                    ToolTip = 'Specifies the value of the Event Session field.';
                }
                field("Event Registration"; Rec."Event Registration")
                {
                    ToolTip = 'Specifies the value of the Event Registration field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Payment Reference ID"; Rec."Payment Reference ID")
                {
                    ToolTip = 'Specifies the value of the Payment Reference ID field.';
                }

                field("BC Status"; Rec."BC Status")
                {
                    ToolTip = 'Specifies the value of the BC Status field.';
                }

                field("Company  Guid"; Rec."Company  Guid")
                {
                    ToolTip = 'Specifies the value of the Company  Guid field.';
                    Visible = false;
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
                    CRMEventFee: Record "Event Fee";
                begin
                    CurrPage.SetSelectionFilter(CRMEventFee);
                    l_cuAAddiItemSalestoBillSch.CreateEventFee(CRMEventFee);
                end;

            }
        }
    }
}
