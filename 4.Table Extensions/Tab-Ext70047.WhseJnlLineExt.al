tableextension 70047 WhseJnlLineExt extends "Warehouse Journal Line"
{
    fields
    {

        field(70001; "Packaging Info"; Text[30])
        {
            Caption = 'Packaging Info';
            DataClassification = ToBeClassified;
        }
        field(70002; Size; Text[30])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
        }
    }
}
