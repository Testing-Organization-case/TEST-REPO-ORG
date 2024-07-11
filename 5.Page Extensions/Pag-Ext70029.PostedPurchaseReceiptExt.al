pageextension 70029 "Posted Purchase Receipt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Order No.")
        {
            field("FOC PO NO."; Rec."Child PO No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
