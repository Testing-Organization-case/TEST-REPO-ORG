pageextension 70065 "PostedTrans.RcptsExt" extends "Posted Transfer Receipts"
{
    layout{
        addafter("Shipping Agent Code")
        {
            field("Transfer Order No.";Rec."Transfer Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
