tableextension 70084 ReplUnavailableStockExt extends "LSC Replen. Unavailable Stock"
{
    fields
    {
        field(70000; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }

    }
}
