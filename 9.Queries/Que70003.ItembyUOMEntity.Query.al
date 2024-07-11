query 70003 "Item by UOM Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'itembyUOM';
    EntitySetName = 'itembyUOM';
    QueryType = API;

    elements
    {
        dataitem(Item; Item)
        {
            column(number; "No.")
            {
            }
            column(displayname; Description)
            {
            }
            column(unitPrice; "Unit Price")
            {
            }
            dataitem(Item_Unit_of_Measure; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = Item."No.";
                SqlJoinType = InnerJoin;
                column("code"; "Code")
                {
                }
                column(QtyperUOM; "Qty. per Unit of Measure")
                {
                }
            }
        }
    }
}

