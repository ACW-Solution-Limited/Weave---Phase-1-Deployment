tableextension 83130 "G/L Account Extension" extends "G/L Account"
{
    fields
    {
        field(80000; "PowerApp PO"; Boolean)
        {
            Caption = 'PowerApp PO';
            DataClassification = ToBeClassified;
        }
    }
}
