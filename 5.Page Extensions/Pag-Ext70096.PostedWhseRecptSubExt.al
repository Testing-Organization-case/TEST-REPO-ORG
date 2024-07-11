pageextension 70096 PostedWhseRecptSubExt extends "Posted Whse. Receipt Subform"
{
    layout
    {

        addafter("Description 2")
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
            }
        }

        addafter("Unit of Measure Code")
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
        Itemtable.SETRANGE("No.", Rec."No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END

    end;

    procedure RunReport(PostedWRH: Record "Posted Whse. Receipt Header")
    var
        PostedWRLIne: Record "Posted Whse. Receipt Line";
        BarcodeR: Record "LSC Barcodes";
        ReportCount: Integer;
    begin
        PostedWRLIne.RESET;
        PostedWRLIne.SETRANGE("No.", Rec."No.");
        //WarehouseReceiptLIneR.SETRANGE("Item No.",Rec."Item No.");
        //CurrPage.SETSELECTIONFILTER(WarehouseReceiptLIneR);
        IF PostedWRLIne.FINDSET THEN
            REPEAT
                BarcodeR.RESET;
                BarcodeR.SETRANGE("Item No.", PostedWRLIne."Item No.");
                IF BarcodeR.FINDSET THEN
                    REPEAT
                        IF BarcodeR."Barcode Active" = TRUE THEN BEGIN
                            //
                            ReportCount := 1;
                        END;

                    UNTIL BarcodeR.NEXT = 0;
            UNTIL PostedWRLIne.NEXT = 0;

        IF ReportCount = 1 THEN BEGIN
            REPORT.RUNMODAL(REPORT::"Barcode Printing For PostWHR", TRUE, FALSE, PostedWRLIne);
        END;
        CurrPage.UPDATE;
    end;


}
