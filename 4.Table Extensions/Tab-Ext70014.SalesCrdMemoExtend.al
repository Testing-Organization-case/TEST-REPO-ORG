tableextension 70014 SalesCrdMemoExtend extends "Sales Cr.Memo Line"            //Created By MK
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
        field(70008; Division; Code[10])
        {
            Caption = 'Division';
            TableRelation = "LSC Division";
            DataClassification = ToBeClassified;
        }
        field(70009; "Offer No."; Code[20])
        {
            Caption = 'Offer No.';
            DataClassification = ToBeClassified;
        }

        field(70014; "POS Received N0."; Code[50])
        {
            Caption = 'POS Received N0.';
            DataClassification = ToBeClassified;
        }
        field(70015; "BI Timestamp"; DateTime)
        {
            Caption = 'BI Timestamp';
            DataClassification = ToBeClassified;
        }
        field(70016; "Member Points Type"; Option)
        {
            Caption = 'Member Points Type';
            OptionMembers = "Award Points","Other Points";
            DataClassification = ToBeClassified;
        }
        field(70017; "Member Points"; Decimal)
        {
            Caption = 'Member Points';
            DataClassification = ToBeClassified;
        }
    }
}
