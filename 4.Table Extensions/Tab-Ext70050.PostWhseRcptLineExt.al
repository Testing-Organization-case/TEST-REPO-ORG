tableextension 70050 PostWhseRcptLineExt extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(70003; "Packaging Info"; Text[30])
        {
            Caption = 'Packaging Info';
            DataClassification = ToBeClassified;
        }
        field(70004; Size; Text[30])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
        }



        field(70005; Remark; Text[30])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(70006; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = ToBeClassified;
        }

    }
}
