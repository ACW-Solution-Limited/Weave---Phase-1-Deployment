tableextension 83003 "IC Partner Ext" extends "IC Partner"
{
    fields
    {
        field(83000; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account"."No.";
            DataClassification = SystemMetadata;
        }
        field(83005; "CRM Guid"; Guid)
        {
            Caption = 'CRM Guid';
            DataClassification = SystemMetadata;
        }
    }
}
