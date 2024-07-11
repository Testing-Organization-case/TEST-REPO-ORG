pageextension 70155 LSCReplenItemQuantitiesListExt extends "LSC Replen. Item Quantities"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = all;
            }
        }
    }
}
