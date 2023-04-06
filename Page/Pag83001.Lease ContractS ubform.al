page 83001 "Lease Contract Subform"
{
    Caption = 'Lease Contract Subform';
    PageType = ListPart;
    SourceTable = "Lease Contract Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Property No."; rec."Property No.")
                {
                    ApplicationArea = All;

                }
                field("Lease Unit No."; Rec."Property Unit No.")
                {
                    ToolTip = 'Specifies the value of the Lease Unit No. field.';
                    ApplicationArea = All;
                }
                field("Lease From Date"; Rec."Lease From Date")
                {
                    ToolTip = 'Specifies the value of the Lease From Date field.';
                    ApplicationArea = All;
                }
                field("Lease To Date"; Rec."Lease To Date")
                {
                    ToolTip = 'Specifies the value of the Lease To Date field.';
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ToolTip = 'Specifies the value of the Price field.';
                    ApplicationArea = All;
                }
                // field("Price Type"; Rec."Price Type")
                // {
                //     ToolTip = 'Specifies the value of the Price Type field.';
                //     ApplicationArea = All;
                // }
                // field(Quantity; Rec.Quantity)
                // {
                //     ToolTip = 'Specifies the value of the Quantity field.';
                //     ApplicationArea = All;
                // }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Split Contract Line")
            {
                ApplicationArea = all;
                image = Splitlines;
                trigger OnAction()
                var
                    l_pagSplitContractDate: Page "Split Contract Date";
                    l_recLeaseContractLine: Record "Lease Contract Line";
                    l_intLineNo: Integer;

                begin
                    l_pagSplitContractDate.LookupMode := true;
                    if l_pagSplitContractDate.RunModal() = Action::LookupOK THEN begin

                        l_recLeaseContractLine.reset;
                        l_recLeaseContractLine.setrange("Contract No.", rec."Contract No.");
                        l_recLeaseContractLine.SetFilter("Line No.", '>%1', rec."Line No.");
                        if l_recLeaseContractLine.FindFirst() then begin
                            l_intLineNo := rec."Line No." + (l_recLeaseContractLine."Line No." - rec."Line No.") / 2;
                        end else
                            l_intLineNo := rec."Line No." + 10000;

                        if rec."Lease From Date" >= l_pagSplitContractDate.GetSplitContractDate() then
                            error('Split Contract Date must be later than %1', rec."Lease From Date");
                        if rec."Lease To Date" < l_pagSplitContractDate.GetSplitContractDate() then
                            Error('Split Contract Date must be between %1 and %2', rec."Lease From Date", rec."Lease To Date");
                        l_recLeaseContractLine := rec;
                        l_recLeaseContractLine."Lease From Date" := l_pagSplitContractDate.GetSplitContractDate();
                        l_recLeaseContractLine."Line No." := l_intLineNo;
                        if l_recLeaseContractLine.insert then;

                        if l_recLeaseContractLine.get(rec."Contract No.", rec."Line No.") then begin
                            l_recLeaseContractLine."Lease To Date" := l_pagSplitContractDate.GetSplitContractDate();
                            l_recLeaseContractLine.Modify();
                        end;

                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        l_recLeaseContractHeader: Record "Lease Contract Header";
    begin
        if l_recLeaseContractHeader.get(rec."Contract No.") then begin
            if rec."Property No." = '' then
                rec."Property No." := l_recLeaseContractHeader."Property No.";
        end;

    end;

}
