tableextension 70019 PurchCrdMemoHdrExt extends "Purch. Cr. Memo Hdr."      //Created By MK
{
    fields
    {
        field(70000; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            TableRelation = "LSC Store";
            DataClassification = ToBeClassified;
        }
        field(70001; "Item Registration No."; Code[20])
        {
            Caption = 'Item Registration No.';
            DataClassification = ToBeClassified;
        }
        field(70017; "External Document No."; Text[30])
        {
            Caption = 'External Document No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
}
