query 70001 "Offer & Promo Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'offerpromoentity';
    EntitySetName = 'offerpromoentity';
    QueryType = API;

    elements
    {
        dataitem(Periodic_Discount; "LSC Periodic Discount")
        {
            column(id; ID)
            {
            }
            column(offerNo; "No.")
            {
            }
            column(type; Type)
            {
            }
            column(offerName; Description)
            {
            }
            column(priority; Priority)
            {
            }
            column(validationPeriodID; "Validation Period ID")
            {
            }
            column(startingDate; "Starting Date")
            {
            }
            column(endingDate; "Ending Date")
            {
            }
            column(priceGroup; "Price Group")
            {
            }
            column(statusEnable; StatusEnable)
            {
            }
            dataitem(Periodic_Discount_Line; "LSC Periodic Discount Line")
            {
                DataItemLink = "Offer No." = Periodic_Discount."No.";
                SqlJoinType = InnerJoin;
                column(lineNo; "Line No.")
                {
                }
                column(itemCode; "No.")
                {
                }
                column(displayName; Description)
                {
                }
                column(status; Status)
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
            }
        }
    }
}

