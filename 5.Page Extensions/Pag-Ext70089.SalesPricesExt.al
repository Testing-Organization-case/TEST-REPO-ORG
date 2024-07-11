pageextension 70089 SalesPricesExt extends "Sales Prices"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
        }


    }
}
