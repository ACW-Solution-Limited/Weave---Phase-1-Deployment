pageextension 83083 SalesCreditMemosExt extends "Sales Credit Memos"
{

    actions
    {

        modify(Post)
        {
            Visible = false;
        }

        modify("Post &Batch")
        {
            Visible = false;
        }

        addfirst("P&osting")

        {
            action("Post Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                PromotedCategory = Category5;
                Promoted = true;
                Caption = 'P&ost';
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    l_CduSalesPost: CODEUNIT "Sales-Post";
                    LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
                begin
                    CurrPage.SetSelectionFilter(SalesHeader);
                    If SalesHeader.FindSet then
                        repeat
                            LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(SalesHeader);
                            SalesHeader.Invoice := true;
                            l_CduSalesPost.Run(SalesHeader);
                        until SalesHeader.next = 0;
                    /* if SalesHeader.Count > 1 then begin
                         If SalesHeader.FindSet then
                             repeat
                                 LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(SalesHeader);
                                 SalesHeader.Invoice := true;
                                 l_CduSalesPost.Run(SalesHeader);
                             until SalesHeader.next = 0;

                     end else begin
                         SalesHeader.Invoice := true;
                         l_CduSalesPost.Run(SalesHeader);
                     end;*/
                end;

            }
        }
    }
}

