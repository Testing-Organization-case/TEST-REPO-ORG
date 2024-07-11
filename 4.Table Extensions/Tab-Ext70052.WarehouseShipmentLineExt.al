tableextension 70052 "Warehouse Shipment Line Ext" extends "Warehouse Shipment Line"
{
    fields
    {
        field(70000; "Attribute Name"; Text[250])
        {
            Caption = 'Attribute Name';
            DataClassification = ToBeClassified;
        }
        field(70001; "Value"; Text[250])
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
        }


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
        field(70005; "Attribute Type"; Option)
        {
            OptionMembers = Option,Text,Integer,Decimal,Date;
            Caption = 'Attribute Type';
            DataClassification = ToBeClassified;
        }

    }
}
