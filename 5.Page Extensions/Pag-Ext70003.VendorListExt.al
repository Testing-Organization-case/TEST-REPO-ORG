pageextension 70003 VendorListExt extends "Vendor List"         //Created By MK
{
    actions
    {
        addafter(Items)
        {
            action("Vendor Trade Scheme")
            {
                Image = VendorLedger;
                ApplicationArea = planning;
                RunObject = Page "Vendor Trade Scheme";
                RunPageLink = "Vendor No." = field("No.");
                RunPageView = SORTING("Vendor No.", "Item No.");

            }
        }
        addafter("Co&mments")
        {
            action("Cross Re&ferences")
            {
                Image = Change;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "Item References";
                RunPageLink = "Reference Type" = CONST(Vendor), "Reference Type No." = FIELD("No.");
                RunPageView = SORTING("Reference Type", "Reference No.");
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
