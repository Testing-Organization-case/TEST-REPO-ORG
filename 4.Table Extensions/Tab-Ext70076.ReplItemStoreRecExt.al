tableextension 70076 ReplItemStoreRecExt extends "LSC Replen. Item Store Rec"
{
    fields
    {

        field(70009; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description where("No." = field("Item No.")));
        }
        field(70010; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name where("No." = field("Vendor No.")));
        }
        field(70011; "Variant Description"; Text[100])
        {
            Caption = 'Variant Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant"."Description 2" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
        }
    }
}
