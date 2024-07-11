pageextension 70066 WarehouseRcptExt extends "Warehouse Receipt"
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
                    WarehouseReceiptLines: Record "Warehouse Receipt Line";
                begin
                    IF Rec."Scanning Barcode" <> '' THEN BEGIN
                        BarcodeR.RESET;
                        BarcodeR.SETRANGE("Barcode No.", Rec."Scanning Barcode");
                        IF BarcodeR.FINDFIRST THEN BEGIN
                            WarehouseReceiptLines.SETRANGE("No.", Rec."No.");
                            WarehouseReceiptLines.SETRANGE("Item No.", BarcodeR."Item No.");
                            // WarehouseReceiptLines.SETRANGE("Variant Code",BarcodeR."Variant Code");
                            IF WarehouseReceiptLines.FINDFIRST THEN BEGIN
                                IF WarehouseReceiptLines."Qty. to Receive" <> WarehouseReceiptLines.Quantity THEN BEGIN
                                    //                WarehouseReceiptLines."Qty. to Receive" := WarehouseReceiptLines."Qty. to Receive" + 1;
                                    //                WarehouseReceiptLines.MODIFY(TRUE);

                                    WarehouseReceiptLines.VALIDATE("Qty. to Receive", WarehouseReceiptLines."Qty. to Receive" + 1);
                                    WarehouseReceiptLines.MODIFY(TRUE);
                                END ELSE
                                    ERROR('Item No. %1 cannot be received more than Quantity %2!', WarehouseReceiptLines."Item No.", WarehouseReceiptLines.Quantity);
                            END ELSE BEGIN
                                ERROR('Item No. %1 does not exist in this Warehouse Receipt!', BarcodeR."Item No.");
                            END;
                        END ELSE BEGIN
                            ERROR('Barcode %1 does not exist in system!', Rec."Scanning Barcode");
                        END;
                    END;
                end;
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action("PrintBarcode")
            {
                Caption = 'Print Barcode';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    CurrPage.WhseReceiptLines.PAGE.RunReport(Rec);
                    CurrPage.UPDATE;
                end;



            }
        }

        addafter("Posted &Whse. Receipts")
        {
            action("PageAttributes")
            {

                Caption = 'Page Attributes';
                ApplicationArea = All;
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WarehouseAttributeListL: page WhseRcptAttributesList;
                begin
                    // @22_Jun_2021_09_54_AM
                    CLEAR(WarehouseAttributeListL);
                    WarehouseAttributeListL.SetWarehouseDocumentNo(Rec."No.");
                    WarehouseAttributeListL.EDITABLE(FALSE);
                    WarehouseAttributeListL.RUN;
                end;

            }
        }
    }
}
