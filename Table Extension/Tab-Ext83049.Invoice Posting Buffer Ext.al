tableextension 83049 "Invoice Posting Buffer Ext" extends "Invoice Post. Buffer"
{
    fields
    {
        field(83000; "Sales Invoice Description"; Text[250])
        {
            Caption = 'Sales Invoice Description';
            DataClassification = ToBeClassified;
        }
    }
}
