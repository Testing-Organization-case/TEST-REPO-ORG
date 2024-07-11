pageextension 70099 "Warehouse Shipment Ext" extends "Warehouse Shipment"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("Scanning Barcode"; Rec."Scanning Barcode")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    BarcodeR: Record "LSC Barcodes";
                    WarehouseShipmentLines: Record "Warehouse Shipment Line";
                begin
                    IF Rec."Scanning Barcode" <> '' THEN BEGIN
                        BarcodeR.RESET;
                        BarcodeR.SETRANGE("Barcode No.", Rec."Scanning Barcode");
                        IF BarcodeR.FINDFIRST THEN BEGIN
                            WarehouseShipmentLines.SETRANGE("No.", Rec."No.");
                            WarehouseShipmentLines.SETRANGE("Item No.", BarcodeR."Item No.");
                            //WarehouseShipmentLines.SETRANGE("Variant Code", BarcodeR."Variant Code");
                            IF WarehouseShipmentLines.FINDFIRST THEN BEGIN
                                IF WarehouseShipmentLines."Qty. to Ship" <> WarehouseShipmentLines.Quantity THEN BEGIN
                                    //WarehouseShipmentLines."Qty. to Ship" := WarehouseShipmentLines."Qty. to Ship" + 1;
                                    WarehouseShipmentLines.VALIDATE("Qty. to Ship", WarehouseShipmentLines."Qty. to Ship" + 1);
                                    WarehouseShipmentLines.MODIFY(TRUE);
                                END ELSE
                                    ERROR('Item No. %1 cannot be received more than Quantity %2!', WarehouseShipmentLines."Item No.", WarehouseShipmentLines.Quantity);
                            END ELSE BEGIN
                                ERROR('Item No. %1 does not exist in this Warehouse Shipment!', BarcodeR."Item No.");
                            END;
                        END ELSE BEGIN
                            ERROR('Barcode %1 does not exist in system!', Rec."Scanning Barcode");
                        END;
                    END;
                end;
            }
        }

        addafter("Shipment Method Code")
        {
            group("Way Plan")
            {
                field("Route No."; Rec."Route No.")
                {
                    ApplicationArea = All;
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("Expected Arrival"; Rec."Expected Arrival")
                {
                    ApplicationArea = All;
                }
                field("Unloading Time"; Rec."Unloading Time")
                {
                    ApplicationArea = All;
                }
                field("Actual Arrival Time"; Rec."Actual Arrival Time")
                {
                    ApplicationArea = All;
                }
                field("Number of Container"; Rec."Number of Container")
                {
                    ApplicationArea = All;
                }
                field("Number of Bult Units"; Rec."Number of Bult Units")
                {
                    ApplicationArea = All;
                }
                field("Truck ID"; Rec."Truck ID")
                {
                    ApplicationArea = All;
                }
                field("Trailer ID"; Rec."Trailer ID")
                {
                    ApplicationArea = All;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Service Provider"; Rec."Service Provider")
                {
                    ApplicationArea = All;
                }
                field("Expected Start Time"; Rec."Expected Start Time")
                {
                    ApplicationArea = All;
                }
                field("Expected Return Time"; Rec."Expected Return Time")
                {
                    ApplicationArea = All;
                }
                field("Dock/Bay Lane Number"; Rec."Dock/Bay Lane Number")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        addafter("Posted &Whse. Shipments")
        {
            action("PageAttributes")
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    WarehouseAttributeListL: page WhseShpAttributesList;
                begin
                    // @22_Jun_2021_09_54_AM
                    CLEAR(WarehouseAttributeListL);
                    WarehouseAttributeListL.SetWarehouseDocumentNo(Rec."No.");
                    WarehouseAttributeListL.EDITABLE(FALSE);
                    WarehouseAttributeListL.RUN;
                    PackagingInfo;
                end;
            }
        }
    }

    local procedure PackagingInfo()
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
        WhseActivityLine: Record "Warehouse Activity Line";
        ItemR: Record Item;
    begin
        WhseActivityHeader.RESET;
        WhseActivityHeader.SETRANGE("Assignment Date", TODAY);
        WhseActivityHeader.SETRANGE(Type, WhseActivityHeader.Type::"Put-away");
        WhseActivityHeader.SETRANGE("Location Code", Rec."Location Code");
        IF WhseActivityHeader.FINDSET THEN
            REPEAT
                WhseActivityLine.RESET;
                WhseActivityLine.SETRANGE("No.", WhseActivityHeader."No.");
                IF WhseActivityLine.FINDSET THEN
                    REPEAT
                        IF (WhseActivityLine."Packaging Info" = '') AND (ItemR.GET(WhseActivityLine."Item No.")) THEN BEGIN
                            WhseActivityLine."Packaging Info" := ItemR."Packaging Info";
                            WhseActivityLine.MODIFY(TRUE);
                        END;

                    UNTIL WhseActivityLine.NEXT = 0;
            UNTIL WhseActivityHeader.NEXT = 0;

    end;
}
