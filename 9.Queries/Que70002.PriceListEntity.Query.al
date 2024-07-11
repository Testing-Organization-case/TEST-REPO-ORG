query 70002 "Price List Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'pricelistentity';
    EntitySetName = 'pricelistentity';
    QueryType = API;

    elements
    {
        dataitem(Item; Item)
        {
            DataItemTableFilter = "LSC Division Code" = FILTER(<> 'AD');
            column(number; "No.")
            {
            }
            column(displayName; Description)
            {
            }
            dataitem(Item_Unit_of_Measure; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = Item."No.";
                column("code"; "Code")
                {
                }
                column(qtyPerUOM; "Qty. per Unit of Measure")
                {
                }
                dataitem(Sales_Price; "Sales Price")
                {
                    DataItemLink = "Item No." = Item_Unit_of_Measure."Item No.", "Unit of Measure Code" = Item_Unit_of_Measure.Code;
                    SqlJoinType = InnerJoin;
                    column(salesCode; "Sales Code")
                    {
                    }
                    column(priceIncludesVAT; "Price Includes VAT")
                    {
                    }
                    column(startingDate; "Starting Date")
                    {
                    }
                    column(endingDate; "Ending Date")
                    {
                    }
                    column(salesType; "Sales Type")
                    {
                    }
                    column(minimumQty; "Minimum Quantity")
                    {
                    }
                    column(uomCode; "Unit of Measure Code")
                    {
                    }
                    column(unitPrice; "Unit Price")
                    {
                    }
                    column(variantCode; "Variant Code")
                    {
                    }
                    column(unitpriceIncludingVAT; "LSC Unit Price Including VAT")
                    {
                    }
                    column(variantDesc; "Variant Description")
                    {
                    }
                    column(Item_No; "Item No.")
                    {
                    }
                    column(Item_Description; "Item Description")
                    {
                    }
                }
            }
        }
    }
}

