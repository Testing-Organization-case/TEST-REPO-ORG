query 70005 "Trans Header Trans Sales Entry"
{

    elements
    {
        dataitem(Transaction_Header; "LSC Transaction Header")
        {
            column(Posted_Statement_No; "Posted Statement No.")
            {
                ColumnFilter = Posted_Statement_No = FILTER('');
            }
            column(Statement_No; "Statement No.")
            {
            }
            dataitem(Trans_Sales_Entry; "LSC Trans. Sales Entry")
            {
                DataItemLink = "Transaction No." = Transaction_Header."Transaction No.", "Receipt No." = Transaction_Header."Receipt No.";
                SqlJoinType = InnerJoin;
                column(Item_No; "Item No.")
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
                column(Sum_TSE; Quantity)
                {
                    Method = Sum;
                }
            }
        }
    }
}

