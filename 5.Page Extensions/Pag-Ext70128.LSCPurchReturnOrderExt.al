pageextension 70128 LSCPurchReturnOrderExt extends "LSC Retail Purch. Return Order"     //Created By MK
{
    layout
    {
        addafter("Vendor Cr. Memo No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
