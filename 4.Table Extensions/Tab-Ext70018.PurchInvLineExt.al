tableextension 70018 PurchInvLineExt extends "Purch. Inv. Line"         //Created By MK
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
        }
        field(70006; "Collection Item No."; Code[20])
        {
            Caption = 'Collection Item No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Collection Line No."; Integer)
        {
            Caption = 'Collection Line No.';
            DataClassification = ToBeClassified;
        }
        field(70008; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70014; "PO Status"; Option)
        {
            Caption = 'PO Status';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            DataClassification = ToBeClassified;
        }
        field(70018; "Net Price"; Decimal)
        {
            Caption = 'Net Price';
            DataClassification = ToBeClassified;
        }

        field(70020; Scheme; Text[100])
        {
            Caption = 'Scheme';
            DataClassification = ToBeClassified;
        }
    }
}
