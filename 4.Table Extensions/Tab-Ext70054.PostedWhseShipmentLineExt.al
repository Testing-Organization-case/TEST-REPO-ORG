tableextension 70054 "Posted Whse. Shipment Line Ext" extends "Posted Whse. Shipment Line"
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
        field(70006; "Vatiant Descriptions"; Text[100])
        {
            Caption = 'Vatiant Descriptions';
            DataClassification = ToBeClassified;
        }
    }
}
