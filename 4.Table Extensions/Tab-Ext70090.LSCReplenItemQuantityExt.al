tableextension 70090 "LSCReplen.ItemQuantityExt" extends "LSC Replen. Item Quantity"
{
    fields
    {
        field(70000; "Item Description"; Text[150])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));


        }
    }
}
