pageextension 70084 "Select Item AttributeValue Ext" extends "Select Item Attribute Value"
{
    layout
    {
        addafter(Value)
        {
            field(Value1; Rec.Value1)
            {
                Caption = 'Filter Value';
                ApplicationArea = All;
            }
        }
    }
}
