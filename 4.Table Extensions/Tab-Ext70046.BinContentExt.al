tableextension 70046 BinContentExt extends "Bin Content"
{
    fields
    {
        field(70000; "Item Description"; Text[250])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
        }

    }
}
