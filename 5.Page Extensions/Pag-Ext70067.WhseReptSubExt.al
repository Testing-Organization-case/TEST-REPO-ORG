pageextension 70067 WhseReptSubExt extends "Whse. Receipt Subform"
{
    layout
    {

        addafter(Quantity)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
            }
            field("Cross-Reference No."; Rec."Cross-Reference No.")
            {
                ApplicationArea = All;
            }
        }

        addafter("Qty. per Unit of Measure")
        {
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = All;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
            }

        }
    }

    trigger OnAfterGetRecord()

    begin


        GetPackAndSize();

    end;



    local procedure GetPackAndSize()
    var
        ItemTable: Record Item;
    begin
        Itemtable.RESET();
        Itemtable.SETRANGE("No.", Rec."Item No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END

    end;

    procedure RunReport(WRHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptLIneR: Record "Warehouse Receipt Line";
        BarcodeR: Record "LSC Barcodes";
        ReportCount: Integer;
    begin
        WarehouseReceiptLIneR.RESET;
        WarehouseReceiptLIneR.SETRANGE("No.", Rec."No.");
        //WarehouseReceiptLIneR.SETRANGE("Item No.",Rec."Item No.");
        //CurrPage.SETSELECTIONFILTER(WarehouseReceiptLIneR);
        IF WarehouseReceiptLIneR.FINDSET THEN
            REPEAT
                BarcodeR.RESET;
                BarcodeR.SETRANGE("Item No.", WarehouseReceiptLIneR."Item No.");
                IF BarcodeR.FINDSET THEN
                    REPEAT
                        IF BarcodeR."Barcode Active" = TRUE THEN BEGIN

                            ReportCount := 1;
                        END;

                    UNTIL BarcodeR.NEXT = 0;
            UNTIL WarehouseReceiptLIneR.NEXT = 0;

        IF ReportCount = 1 THEN BEGIN
            REPORT.RUNMODAL(REPORT::"Barcode Printing For WHR", TRUE, FALSE, WarehouseReceiptLIneR);
        END;
        CurrPage.UPDATE;

    end;


}
