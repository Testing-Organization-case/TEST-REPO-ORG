pageextension 70054 CatalogItemCardExt extends "Catalog Item Card"
{
    layout{
        addafter(Description)
        {
            field("Chemical Name";Rec."Chemical Name")
            {
                ApplicationArea = All;
            }
        }

    }
}
