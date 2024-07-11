query 70007 "Periodic Discount NWMM"
{

    elements
    {
        dataitem(Periodic_Discount; "LSC Periodic Discount")
        {
            column(Description; Description)
            {
            }
            column(Status; Status)
            {
            }
            column(Type; Type)
            {
            }
            column(Price_Group; "Price Group")
            {
            }
            column(Priority; Priority)
            {
            }
            column(Validation_Period_ID; "Validation Period ID")
            {
            }
            column(Validation_Description; "Validation Description")
            {
            }
            column(Starting_Date; "Starting Date")
            {
            }
            column(Ending_Date; "Ending Date")
            {
            }
            column(Sales_Qty; "Sales (Qty.)")
            {
            }
            column(Sales_LCY; "Sales (LCY)")
            {
            }
            column(COGS_LCY; "COGS (LCY)")
            {
            }
            column(Discount_Type; "Discount Type")
            {
            }
            column(Discount_Value; "Discount % Value")
            {
            }
            column(Discount_Amount_Value; "Discount Amount Value")
            {
            }
            column(Customer_Disc_Group; "Customer Disc. Group")
            {
            }
            column(Member_Value; "Member Value")
            {
            }
            column(Coupon_Code; "Coupon Code")
            {
            }
            column(Coupon_Qty_Needed; "Coupon Qty Needed")
            {
            }
            column(Member_Type; "Member Type")
            {
            }
            column(Member_Attribute; "Member Attribute")
            {
            }
            column(Member_Attribute_Value; "Member Attribute Value")
            {
            }
            column(Maximum_Discount_Amount; "Maximum Discount Amount")
            {
            }
            column(Tender_Offer; "Tender Offer %")
            {
            }
            column(Tender_Offer_Amount; "Tender Offer Amount")
            {
            }
            column(Line_Discount_Group_Code; "Line Discount Group Code")
            {
            }
            column(Member_Points; "Member Points")
            {
            }
            dataitem(Periodic_Discount_Line; "LSC Periodic Discount Line")
            {
                DataItemLink = "Offer No." = Periodic_Discount."No.";
                SqlJoinType = InnerJoin;
                column(Offer_No; "Offer No.")
                {
                }
                column(No; "No.")
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(ItemDescription; Description)
                {
                    Caption = '<ItemDescription>';
                }
                dataitem(Periodic_Discount_Benefits; "LSC Periodic Discount Benefits")
                {
                    DataItemLink = "Offer No." = Periodic_Discount_Line."Offer No.";
                    SqlJoinType = InnerJoin;
                    column(BenefitCode; "No.")
                    {
                    }
                    column(BenefitDescription; Description)
                    {
                    }
                    dataitem(Information_Subcode; "LSC Information Subcode")
                    {
                        DataItemLink = Code = Periodic_Discount_Benefits."No.";
                        SqlJoinType = InnerJoin;
                        column(Trigger_Code; "Trigger Code")
                        {
                        }
                        column(InfoDescription; Description)
                        {
                        }
                    }
                }
            }
        }
    }
}

