tableextension 70063 "StoreInv.LineExt" extends "LSC Store Inventory Line"
{
    fields
    {

        field(70001; "Packaging Info"; Text[100])
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
