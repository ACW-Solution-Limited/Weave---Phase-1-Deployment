tableextension 83040 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        field(80000; "Bank Code"; Text[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
    }
}
