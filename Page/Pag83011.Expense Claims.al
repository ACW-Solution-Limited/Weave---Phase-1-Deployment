page 83011 "Expense Claims"
{
    ApplicationArea = All;
    Caption = 'Expense Claims';
    PageType = List;
    SourceTable = "Expense Claim";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Expense Claim Admin"; Rec."Expense Claim Admin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense Claim Admin field.';
                }
                field("Expense Type"; Rec."Expense Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense Type field.';
                }
                field("IC Partner"; Rec."IC Partner")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Order No. field.';
                }
                field("Purchase Order Line No."; Rec."Purchase Order Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Order Line No. field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Expense Claim PO")
            {
                ApplicationArea = all;
                RunObject = report "Create Expense Claim PO";
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Report;

            }
            action("Show Document")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                image = Document;
                trigger OnAction()
                var
                    l_recPurchaseHeader: Record "Purchase Header";
                begin
                    l_recPurchaseHeader.reset;

                    //  If Rec.Status <> Rec.Status::Open then 
                    rec.TestField("Purchase Order No.");
                    // case rec.Status of
                    //      rec.status::Created:
                    l_recPurchaseHeader.get(l_recPurchaseHeader."Document Type"::Order, rec."Purchase Order No.");
                    page.run(page::"Purchase Order", l_recPurchaseHeader);

                end;
            }
        }
    }
}
