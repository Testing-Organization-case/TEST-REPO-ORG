tableextension 70039 RegWhseActivityLineExt extends "Registered Whse. Activity Line"            //Created By MK
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
        field(70003; Remark; Text[30])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
