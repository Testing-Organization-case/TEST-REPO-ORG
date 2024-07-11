pageextension 70055 CatalogItemListExt extends "Catalog Item List"
{
    layout{

        addbefore("Vendor Item No.")
        {
            field("Entry No.";Rec."Entry No.")
            {
                ApplicationArea = All;
            }
        }

        addafter("Vendor Item No.")
        {
            field("Vendor Name";Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Chemical Name";Rec."Chemical Name")
            {
                ApplicationArea = All;
            }
        }

    }
}
