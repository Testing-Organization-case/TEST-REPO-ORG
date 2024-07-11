pageextension 70135 LSCItemBarcodesExt extends "LSC Item Barcodes"      //Created By MK
{
    layout
    {
        addafter("Barcode No.")
        {
            field("Item No."; Rec."Item No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Barcode Active"; Rec."Barcode Active")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    OneDefalutFunction();
                    CurrPage.Update();
                end;
            }
        }
        addafter("Last Date Modified")
        {
            field("Last Modified User"; Rec."Last Modified User")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter("Print GS1 DataBar Barcode")
        {
            action("Barcode Active Enable")
            {
                ApplicationArea = All;
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    BarcodeActiveEnabledFunction;
                    CurrPage.UPDATE;
                end;
            }
            action(CreateGUID)
            {
                ApplicationArea = All;
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    BarcodeR: Record "LSC Barcodes";
                begin
                    BarcodeR.RESET;
                    IF BarcodeR.FINDSET THEN
                        REPEAT
                            //CustomerR.Latitude := 1;
                            BarcodeR.ID := CREATEGUID;
                            BarcodeR.MODIFY(TRUE);
                        UNTIL BarcodeR.NEXT = 0;
                    CurrPage.UPDATE;
                end;
            }
        }
    }
    var
        ActiveEnable: Boolean;

    trigger OnAfterGetRecord()
    begin
        OneDefalutFunction();
    end;

    local procedure OneDefalutFunction()
    var
        ItemBarcodeR: Record "LSC Barcodes";
    begin
        ActiveEnable := TRUE;

        ItemBarcodeR.RESET;
        ItemBarcodeR.SETCURRENTKEY("Item No.", "Barcode Active");
        ItemBarcodeR.SETRANGE("Item No.", Rec."Item No.");
        ItemBarcodeR.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
        // ItemBarcodeR.SETRANGE("Variant Code", Rec."Variant Code");
        ItemBarcodeR.SETRANGE("Barcode Active", TRUE);
        IF ItemBarcodeR.COUNT = 1 THEN BEGIN

            ItemBarcodeR.FINDFIRST;
            ActiveEnable := FALSE;
            ItemBarcodeR.MODIFY(TRUE);

        END;
    end;

    local procedure BarcodeActiveEnabledFunction()
    var
        ItemBarcodeR: Record "LSC Barcodes";
    begin
        ItemBarcodeR.RESET;
        ItemBarcodeR.SETCURRENTKEY("Item No.");
        ItemBarcodeR.SETRANGE("Item No.", Rec."Item No.");
        // ItemBarcodeR.SETRANGE("Unit of Measure Code",Rec."Unit of Measure Code");
        // ItemBarcodeR.SETRANGE("Variant Code",Rec."Variant Code");
        IF ItemBarcodeR.FINDSET THEN
            REPEAT

                ItemBarcodeR."Barcode Active" := FALSE;
                ActiveEnable := FALSE;
                ItemBarcodeR.MODIFY(TRUE);


            UNTIL ItemBarcodeR.NEXT = 0;
    end;
}
