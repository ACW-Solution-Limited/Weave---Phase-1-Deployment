pageextension 83008 PostedSalesCreditMemoExt extends "Posted Sales Credit Memo Lines"
{
    layout
    {
        addafter(Description)
        {
            field("Invoice Description"; Rec."Invoice Description")
            { ApplicationArea = All; }
        }
        addlast(content)
        {


            field("Sales Credit Memo Guid for CRM"; Rec."Sales Credit Memo Guid for CRM") { ApplicationArea = all; }
        }
    }
}
