pageextension 70002 VendorCardExt extends "Vendor Card"         //Created By MK
{
    actions
    {
        addafter(Items)
        {
            action("Vendor Trade Scheme")
            {
                Image = VendorLedger;
                RunObject = page "Vendor Trade Scheme";
                RunPageView = SORTING("Vendor No.", "Item No.");
                RunPageLink = "Vendor No." = field("No.");
                ApplicationArea = Planning;
                ToolTip = 'Open the list of items that you trade in.';
            }
        }
    }
}
