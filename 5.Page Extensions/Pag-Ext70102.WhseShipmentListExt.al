pageextension 70102 "Whse. Shipment List Ext" extends "Warehouse Shipment List"
{

    layout {
        addafter("Shipment Method Code")
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

    actions
    {
        addafter("Posted &Warehouse Shipments")
        {
            action("PageAttributes")
            {
                Caption = 'Attributes';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var WarehouseAttributeListL:page WhseShpAttributesList;
                begin
                    // @22_Jun_2021_09_54_AM
                    CLEAR(WarehouseAttributeListL);
                    WarehouseAttributeListL.SetWarehouseDocumentNo(Rec."No.");
                    WarehouseAttributeListL.EDITABLE(FALSE);
                    WarehouseAttributeListL.RUN;
                end;
            }
        }

        addafter(PageAttributes)
        {
            group("Print")
            {
                action("Print WP Report")
                {
                    Caption = 'Print WP Report';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Way Plan Detail Report For WHS";
                }
            }
        }
    }
}
