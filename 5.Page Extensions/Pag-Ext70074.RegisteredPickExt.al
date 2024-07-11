pageextension 70074 RegisteredPickExt extends "Registered Pick"
{
    layout{
        addafter("Sorting Method")
        {
            field("Warehouse Shipment No.";Rec."Warehouse Shipment No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
