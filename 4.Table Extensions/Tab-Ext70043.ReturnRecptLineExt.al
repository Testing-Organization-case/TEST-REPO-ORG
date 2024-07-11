tableextension 70043 ReturnRecptLineExt extends "Return Receipt Line"
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
        field(70005; "Collection Item No."; Code[20])
        {
            Caption = 'Collection Item No.';
            DataClassification = ToBeClassified;
        }
        field(70006; "Collection Line No."; Integer)
        {
            Caption = 'Collection Line No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }

        field(70009; "POS Received NO."; Code[50])
        {
            Caption = 'POS Received NO.';
            DataClassification = ToBeClassified;
        }

    }
}
