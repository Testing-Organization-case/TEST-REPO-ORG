pageextension 70117 "LSC Item Finder Lines Ext" extends "LSC Item Finder Lines"
{
    layout
    {
        addafter("Pre Value")
        {
            field("Item Finder Code"; Rec."Item Finder Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
