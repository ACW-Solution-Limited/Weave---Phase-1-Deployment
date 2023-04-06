page 83215 "API Stripe Payout"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiStripePayout';
    DelayedInsert = true;
    EntityName = 'stripepayout';
    EntitySetName = 'stripepayout';
    PageType = API;
    SourceTable = "Stripe Payout";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.Id)
                {
                    Caption = 'Id';
                }
                field(created; Rec.Created)
                {
                    Caption = 'Created';
                }
                field(arrivalDate; Rec."Arrival Date")
                {
                    Caption = 'Arrival Date';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
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
