pageextension 70070 WhsePickExt extends "Warehouse Pick"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("Warehouse Shipment No."; Rec."Warehouse Shipment No.")
            {
                ApplicationArea = All;
            }
            field("Scan Barcode"; Rec."Scan Barcode")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    Barcodes: Record "LSC Barcodes";
                    WarehouseActivityLine: Record "Warehouse Activity Line";
                    CountL: Boolean;
                begin
                    IF (Rec."Scan Barcode" <> '') THEN BEGIN

                        Barcodes.RESET;
                        Barcodes.SETCURRENTKEY("Barcode No.", "Variant Code");
                        Barcodes.SETRANGE("Barcode No.", Rec."Scan Barcode");
                        Barcodes.MARK(TRUE);
                        IF Barcodes.FINDSET THEN
                            REPEAT
                                WarehouseActivityLine.RESET;
                                WarehouseActivityLine.SETCURRENTKEY("No.", "Item No.", "Action Type", "Variant Code");
                                WarehouseActivityLine.SETRANGE("No.", Rec."No.");
                                WarehouseActivityLine.SETRANGE("Item No.", Barcodes."Item No.");
                                WarehouseActivityLine.SETRANGE("Action Type", WarehouseActivityLine."Action Type"::Take);
                                // IF WarehouseActivityLine."Variant Code" <> '' THEN
                                //WarehouseActivityLine.SETRANGE("Variant Code", Barcodes."Variant Code");

                                WarehouseActivityLine.MARK(TRUE);
                                IF WarehouseActivityLine.FINDSET THEN
                                    REPEAT

                                        WarehouseActivityLine."Check Item" := TRUE;
                                        WarehouseActivityLine."Scan Barcode" := Rec."Scan Barcode";
                                        WarehouseActivityLine.MODIFY(TRUE);
                                        CurrPage.WhseActivityLines.PAGE.UPDATE(TRUE);

                                    UNTIL WarehouseActivityLine.NEXT = 0; //IF WarehouseActivityLine.FINDSET THEN

                            UNTIL Barcodes.NEXT = 0; //IF Barcodes.FINDSET THEN
                    END
                    ELSE BEGIN

                        WarehouseActivityLine.RESET;
                        WarehouseActivityLine.SETRANGE("No.", Rec."No.");
                        IF WarehouseActivityLine.FINDSET THEN
                            REPEAT

                                WarehouseActivityLine."Check Item" := FALSE;
                                WarehouseActivityLine."Scan Barcode" := '';
                                WarehouseActivityLine.MODIFY(TRUE);
                                CurrPage.WhseActivityLines.PAGE.UPDATE(TRUE);

                            UNTIL WarehouseActivityLine.NEXT = 0;

                    END;


                    IF Rec."Scan Barcode" <> '' THEN BEGIN

                        WarehouseActivityLine.RESET;
                        WarehouseActivityLine.SETRANGE("No.", Rec."No.");
                        WarehouseActivityLine.SETFILTER("Scan Barcode", '<>%1', Rec."Scan Barcode");
                        IF WarehouseActivityLine.FINDSET THEN
                            REPEAT

                                WarehouseActivityLine."Check Item" := FALSE;
                                WarehouseActivityLine.MODIFY(TRUE);
                                CurrPage.WhseActivityLines.PAGE.UPDATE(TRUE);

                            UNTIL WarehouseActivityLine.NEXT = 0;

                    END; //IF Rec."Scan Barcode" <> '' THEN

                    CountL := FALSE;

                    IF Rec."Scan Barcode" <> '' THEN BEGIN

                        IF Barcodes.GET(Rec."Scan Barcode") THEN BEGIN
                            WarehouseActivityLine.RESET;
                            WarehouseActivityLine.SETRANGE("No.", Rec."No.");
                            WarehouseActivityLine.SETFILTER("Item No.", Barcodes."Item No.");
                            // WarehouseActivityLine.SETRANGE("Variant Code", Barcodes."Variant Code");
                            IF WarehouseActivityLine.FINDSET THEN
                                REPEAT

                                    CountL := TRUE;

                                UNTIL WarehouseActivityLine.NEXT = 0;

                        END;

                    END; //IF Rec."Scan Barcode" <> '' THEN

                    IF CountL = FALSE THEN BEGIN

                        MESSAGE('Barcode Not Found!');
                        EXIT;

                    END; //IF CountL = FALSE THEN
                end;
            }
        }
    }

    actions
    {

        modify("&Print")
        {
            Visible = false;
        }

        addafter("Registered Picks")
        {
            action("&PrintNWMM")
            {
                ApplicationArea = Warehouse;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    WarehouseActivityHeader: Record "Warehouse Activity Header";
                begin
                    //WhseActPrint.PrintPickHeader(Rec);
                    WarehouseActivityHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(70007, TRUE, FALSE, WarehouseActivityHeader);
                end;
            }
        }
    }
}
