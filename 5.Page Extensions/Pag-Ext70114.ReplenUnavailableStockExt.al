pageextension 70114 ReplenUnavailableStockExt extends "LSC Replen. Unavailable Stock"
{
    layout
    {
        addafter(Comment)
        {
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }

        }
    }
}
