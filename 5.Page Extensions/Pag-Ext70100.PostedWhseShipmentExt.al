pageextension 70100 PostedWhseShipmentExt extends "Posted Whse. Shipment"
{
    layout{
        addafter("Shipment Method Code")
        {
            group("Way Plan")
            {
                field("Route No.";Rec."Route No.")
                {
                    ApplicationArea = All;
                }
                field("Sequence No.";Rec."Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("Expected Arrival";Rec."Expected Arrival")
                {
                    ApplicationArea = All;
                }
                field("Unloading Time";Rec."Unloading Time")
                {
                    ApplicationArea = All;
                }
                field("Actual Arrival Time";Rec."Actual Arrival Time")
                {
                    ApplicationArea = All;
                }
                field("Number of Container";Rec."Number of Container")
                {
                    ApplicationArea = All;
                }
                field("Number of Bult Units";Rec."Number of Bult Units")
                {
                    ApplicationArea = All;
                }
                field("Truck ID";Rec."Truck ID")
                {
                    ApplicationArea = All;
                }
                field("Trailer ID";Rec."Trailer ID")
                {
                    ApplicationArea = All;
                }
                field(Driver;Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Service Provider";Rec."Service Provider")
                {
                    ApplicationArea = All;
                }
                field("Expected Start Time";Rec."Expected Start Time")
                {
                    ApplicationArea = All;
                }
                field("Expected Return Time";Rec."Expected Return Time")
                {
                    ApplicationArea = All;
                }
                field("Dock/Bay Lane Number";Rec."Dock/Bay Lane Number")
                {
                    ApplicationArea = All;
                }
                field(Priority;Rec.Priority)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

