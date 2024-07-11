query 70006 ItemLedgerEntryNWMM
{

    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            column(Item_No; "Item No.")
            {
                ColumnFilter = Item_No = FILTER('BELIP000001');
            }
            column(Variant_Code; "Variant Code")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Sum_Remaining_Quantity; "Remaining Quantity")
            {
                Method = Sum;
            }
        }
    }
}

