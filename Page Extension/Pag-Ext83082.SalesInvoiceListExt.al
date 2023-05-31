pageextension 83082 SalesInvoiceListExt extends "Sales Invoice List"
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
            action("Post Inovice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category5;
                ShortCutKey = 'F9';
                AboutTitle = 'Post an invoice';
                AboutText = 'You post an invoice when you''ve completed all its details. This action posts the selected invoice, and you can later send it to the customer if needed.';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    l_CduSalesPost: CODEUNIT "Sales-Post";
                begin
                    CurrPage.SetSelectionFilter(SalesHeader);
                    If SalesHeader.FindSet then
                        repeat
                            SalesHeader.Invoice := true;
                            l_CduSalesPost.Run(SalesHeader);
                        until SalesHeader.next = 0;
                    /* if SalesHeader.Count > 1 then begin
                         If SalesHeader.FindSet then
                             repeat
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



