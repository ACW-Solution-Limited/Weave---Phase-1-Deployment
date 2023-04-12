page 83009 "Lease Contract Setup"
{
    Caption = 'Lease Contract Setup';
    ApplicationArea = Basic, Suite;
    PageType = Card;
    SourceTable = "Lease Contract Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Rental Deposit G/L Account No."; Rec."Rental Deposit G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rental Deposit G/L Account No. field.';
                }

                field("Monthly Disc G/L Account No."; Rec."Monthly Disc G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Monthly Income G/L Account No. field.';
                }
                field("One-Off Disc G/L Account No."; Rec."One-Off Disc G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the One-Off Discount G/L Account No. field.';
                }
                field("Prepaid Disc G/L Account No."; Rec."Prepaid Disc G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepaid Discount G/L Account No. field.';
                }

                field("Rental Income Deferral Template"; Rec."Rental Income Deferral Templ.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rental Income Deferral Template field.';
                }
                field("Item Sales Location"; rec."Item Sales Location") { ApplicationArea = All; }
                field("Event Fee G/L Account No."; Rec."Event Fee G/L Account No.") { ApplicationArea = all; }

            }
        }


    }

    actions
    {
        area(Processing)
        {
            action("Tender Type Discount Setup")

            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EditList;
                trigger OnAction()
                var
                    l_pagetendertypesetup: page "Tender Type Disocunt Setup";
                begin

                    l_pagetendertypesetup.RunModal();

                end;

            }

        }


    }
    trigger OnOpenPage()
    begin

        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init();
            Rec.Insert;
        end;

    end;
}
