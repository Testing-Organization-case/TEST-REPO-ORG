pageextension 70024 "Item Vendor Catalog Extension" extends "Item Vendor Catalog"
{
    layout
    {
        addafter("Vendor Item No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
    }
}
