pageextension 70130 LSCItemDefLookupExt extends "LSC Item Default Lookup"           //Created By MK
{
    layout
    {
        addafter(VendorName)
        {
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(CatName)
        {
            // field(Category;Rec. Category)
            // {
            //     ApplicationArea = All;
            // }
            field("Retail Product Code"; Rec."Retail Product Code")
            {
                ApplicationArea = All;
            }
        }
    }
    var
        Category: Record "Item Category";
        Item: Record "LSC Item Default Settings";
}

