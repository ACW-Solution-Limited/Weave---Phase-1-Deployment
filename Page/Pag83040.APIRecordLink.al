page 83040 APIRecordLink
{
    APIGroup = 'app1';
    APIPublisher = 'weave';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiRecordLink';
    DelayedInsert = true;
    EntityName = 'RecordLink';
    EntitySetName = 'RecordLink';
    PageType = API;
    SourceTable = "Record Link";
    ODataKeyFields = SystemId;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(company; Rec.Company)
                {
                    Caption = 'Company';
                }
                field(created; Rec.Created)
                {
                    Caption = 'Created';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(linkID; Rec."Link ID")
                {
                    Caption = 'Link ID';
                }
                field(note; Rec.Note)
                {
                    Caption = 'Note';
                }
                field(notify; Rec.Notify)
                {
                    Caption = 'Notify';
                }
                field("recordID"; Rec."Record ID")
                {
                    Caption = 'Record ID';
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
                field(toUserID; Rec."To User ID")
                {
                    Caption = 'To User ID';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(url1; Rec.URL1)
                {
                    Caption = 'URL1';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
            }
        }
    }
}
