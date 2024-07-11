tableextension 70060 "Item Attri Value Mapping Ext" extends "Item Attribute Value Mapping"
{
    fields
    {
        field(70000; "Sales Order"; Boolean)
        {
            Caption = 'Sales Order';
            DataClassification = ToBeClassified;
        }
        field(70001; "Purchase Order"; Boolean)
        {
            Caption = 'Purchase Order';
            DataClassification = ToBeClassified;
        }
        field(70002; "Transfer Order"; Boolean)
        {
            Caption = 'Transfer Order';
            DataClassification = ToBeClassified;
        }
        field(70003; "Warehouse Receipt"; Boolean)
        {
            Caption = 'Warehouse Receipt';
            DataClassification = ToBeClassified;
        }
        field(70004; "Warehouse Shipment"; Boolean)
        {
            Caption = 'Warehouse Shipment';
            DataClassification = ToBeClassified;
        }
    }
}
