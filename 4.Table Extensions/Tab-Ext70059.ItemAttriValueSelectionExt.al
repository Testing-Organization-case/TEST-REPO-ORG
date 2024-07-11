tableextension 70059 "Item Attri Value Selection Ext" extends "Item Attribute Value Selection"
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
        field(70005; Value1; Text[250])
        {
            Caption = 'Value1';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.Value1 := Value1;
            end;
        }
        field(70006; "Item No."; Code[30])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
    }

}
