pageextension 70083 "Posted Return Shipment Ext" extends "Posted Return Shipment"
{
    layout{
        addafter("Vendor Authorization No.")
        {
            field("External Document No.";Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }

    }
}
