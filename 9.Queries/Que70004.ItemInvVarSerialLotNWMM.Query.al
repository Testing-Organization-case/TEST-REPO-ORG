query 70004 "Item Inv. VarSerialLot NWMM"
{
    Caption = 'Item Inv. VarSerialLot';

    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            filter(ItemFilter; "Item No.")
            {
            }
            filter(VariantFilter; "Variant Code")
            {
            }
            filter(LocationFilter; "Location Code")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Variant_Code; "Variant Code")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Serial_No; "Serial No.")
            {
            }
            column(Sum_Quantity; Quantity)
            {
                Method = Sum;
            }
            column(Sum_Remaining_Quantity; "Remaining Quantity")
            {
                Method = Sum;
            }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = Item_Ledger_Entry."Item No.";
                SqlJoinType = InnerJoin;
                column(Description; Description)
                {
                }
            }
        }
    }
}

