pageextension 70111 "Replen. Item Store List Ext" extends "LSC Replen. Item Store List"
{

    layout
    {
        addafter("Item No.")
        {
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }


    }
}
