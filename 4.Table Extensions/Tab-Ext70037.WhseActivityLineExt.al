tableextension 70037 WhseActivityLineExt extends "Warehouse Activity Line"          //Created By MK
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
        field(70003; "Scan Barcode"; Code[20])
        {
            Caption = 'Scan Barcode';
            DataClassification = ToBeClassified;
        }
        field(70004; Remark; Text[30])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70005; "Check Item"; Boolean)
        {
            Caption = 'Check Item';
            DataClassification = ToBeClassified;
        }
    }
}
