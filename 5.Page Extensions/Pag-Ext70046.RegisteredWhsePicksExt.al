pageextension 70046 "Registered Whse. Picks Ext" extends "Registered Whse. Picks"
{
    layout
    {
        addafter("Assignment Date")
        {
            field("Warehouse Shipment No."; Rec."Warehouse Shipment No.")
            {
                ApplicationArea = All;
            }
            field("ADCS User ID"; Rec."ADCS User ID")
            {
                ApplicationArea = All;
            }
        }
    }
}
