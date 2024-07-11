pageextension 70110 "Replen. Sales Hist. Adj. Ext" extends "LSC Replen. Sales Hist. Adj."
{
    layout
    {

        addafter("Item No.")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
        }
    }
}
