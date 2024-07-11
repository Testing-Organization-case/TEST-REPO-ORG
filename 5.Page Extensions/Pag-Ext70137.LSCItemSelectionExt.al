pageextension 70137 "LSC Item Selection Ext" extends "LSC Item Selection"
{
    layout
    {
        addafter("Unit Price")
        {
            field("Variant Framework Code"; Rec."LSC Variant Framework Code")
            {
                ApplicationArea = ALl;

            }
        }
    }
}
