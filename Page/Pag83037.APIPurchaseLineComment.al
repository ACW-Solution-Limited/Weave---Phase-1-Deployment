page 83037 "API Purchase Line Comment"
{
    APIGroup = 'app1';
    APIPublisher = 'weave';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiPurchaseLineComment';
    DelayedInsert = true;
    EntityName = 'PurchaseLineComment';
    EntitySetName = 'PurchaseLineComment';
    PageType = API;
    SourceTable = "Purch. Comment Line";
    //AutoSplitKey = true;
    //ODataKeyFields = SystemId;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(documentLineNo; Rec."Document Line No.")
                {
                    Caption = 'Document Line No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
