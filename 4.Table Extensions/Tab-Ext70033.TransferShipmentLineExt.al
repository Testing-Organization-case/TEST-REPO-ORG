tableextension 70033 "Transfer Shipment Line Ext" extends "Transfer Shipment Line"
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
        field(70005; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
        }
        field(70006; Division; Code[10])
        {
            Caption = 'Division';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Division";
        }
        field(70007; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code".Code;
        }

        field(70011; "Item Family Code"; Code[50])
        {
            Caption = 'Item Family Code';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."LSC Item Family Code" WHERE("No." = FIELD("Item No.")));
        }
    }
}
