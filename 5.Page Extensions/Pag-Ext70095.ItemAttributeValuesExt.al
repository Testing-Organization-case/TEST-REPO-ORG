pageextension 70095 "Item Attribute Values Ext" extends "Item Attribute Values"
{
    layout
    {
        addafter(Value)
        {
            field(Value1; Rec.Value1)
            {
                ApplicationArea = All;

            }
        }
    }
}
