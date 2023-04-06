tableextension 83017 "G/L Entry Extension" extends "G/L Entry"
{
    fields
    {
        field(82000; "Invoice Description"; Text[2048])
        {
            Caption = 'Invoice Description';
            DataClassification = ToBeClassified;
        }
    }
}
