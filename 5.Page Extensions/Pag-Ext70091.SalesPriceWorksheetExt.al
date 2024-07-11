pageextension 70091 SalesPriceWorksheetExt extends "Sales Price Worksheet"
{
    layout{
        addafter("New Unit Price")
        {
            field("LSC New Unit Price Incl. VAT";Rec."LSC New Unit Price Incl. VAT")
            {
                ApplicationArea = All;
                
            }
           
        }
    }
}
