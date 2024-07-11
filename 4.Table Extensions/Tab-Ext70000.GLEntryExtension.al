tableextension 70000 "G/L Entry Extension" extends "G/L Entry"
{
    fields
    {
        field(70000; "BI Timestamp"; DateTime)
        {
            Caption = 'BI Timestamp';
            DataClassification = ToBeClassified;
        }
    }
}
