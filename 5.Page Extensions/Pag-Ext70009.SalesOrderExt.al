pageextension 70009 SalesOrderExt extends "Sales Order"         //Created BY MK
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(DocAttach)
        {
            action("Page Attributes")
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SOAttributeListL: Page SalesAttributeList;
                begin
                    CLEAR(SOAttributeListL);
                    SOAttributeListL.SetSalesDocumentNo(Rec."No.");
                    SOAttributeListL.EDITABLE(FALSE);
                    SOAttributeListL.RUN;
                end;
            }
            action("Import Sales Line Excel")
            {
                Caption = 'Import Sales Line Excel';
                Image = ImportExcel;
                trigger OnAction()
                begin
                    ImportSalesLIneExcel;
                end;
            }
        }
    }
    procedure ImportSalesLIneExcel()
    var
        LineNo, RowNo : Integer;
        FileName, SheetName, ExcelExt : Text;
        FileManagement: Codeunit "File Management";

    begin
        Rows := 0;
        Columns := 0;

        //UPLOADINTOSTREAM('Select file to upload!','','',Name,NVInstream);

        FileName := FileManagement.UploadFile('Select file to upload', ExcelExt);
        SheetName := Rec_ExcelBuffer.SelectSheetsName(FileName);


        Rec_ExcelBuffer.LOCKTABLE();
        Rec_ExcelBuffer.OpenBook(FileName, SheetName);
        Rec_ExcelBuffer.ReadSheet();

        GetLastColNoandRolNo;
        LineNo := FindLineNo();
        // AnalyseData;
        FOR RowNo := 2 TO Rows DO
            InsertData(RowNo);

        Rec_ExcelBuffer.DELETEALL;

        MESSAGE('Import is completed');
    end;

    procedure FindLineNo(): Integer
    var
        SalesLine: Record "Sales Line";
        Line_No: Integer;
    begin
        SalesLine.RESET;

        SalesLine.SETRANGE("Document No.", Rec."No.");

        SalesLine.SETCURRENTKEY("Line No.");

        IF SalesLine.FINDLAST() THEN
            Line_No := SalesLine."Line No." + 10000

        ELSE
            Line_No := 10000;

        EXIT(Line_No);
    end;

    local procedure GetLastColNoandRolNo()
    begin
        Rec_ExcelBuffer.SETRANGE("Row No.", 1);
        Columns := Rec_ExcelBuffer.COUNT;

        Rec_ExcelBuffer.RESET();
        IF Rec_ExcelBuffer.FINDLAST() THEN
            Rows := Rec_ExcelBuffer."Row No.";
    end;

    local procedure InsertData(RowNo: Integer)
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        GLAccountL: Record "G/L Account";
        ItemUOM: Record "Item Unit of Measure";
        TotalQty, LineTotal : Decimal;
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document No.", Rec."No.");
        SalesLine.SETRANGE("Document Type", Rec."Document Type");
        SalesLine.SETRANGE("Line No.", LineNo);
        IF SalesLine.FINDFIRST THEN BEGIN

            EVALUATE(SalesLine.Type, GetValueAtIndex(RowNo, 1));

            EVALUATE(SalesLine."No.", GetValueAtIndex(RowNo, 2));

            SalesLine."Line No." := LineNo;


            EVALUATE(SalesLine."Variant Code", GetValueAtIndex(RowNo, 3));


            EVALUATE(SalesLine."Location Code", GetValueAtIndex(RowNo, 4));

            Item.RESET;
            Item.SETRANGE("No.", SalesLine."No.");
            IF Item.FINDFIRST THEN BEGIN

                SalesLine.VALIDATE(Description, Item.Description);
                SalesLine."Posting Group" := Item."Inventory Posting Group";
                SalesLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                SalesLine."VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                SalesLine.Division := Item."LSC Division Code";
                SalesLine."Item Category Code" := Item."Item Category Code";
                SalesLine."Retail Product Code" := Item."LSC Retail Product Code";

            END; //IF Item.FINDFIRST THEN

            GLAccountL.RESET;
            GLAccountL.SETRANGE("No.", SalesLine."No.");
            IF GLAccountL.FINDFIRST THEN BEGIN

                SalesLine.VALIDATE(Description, GLAccountL.Name);
                SalesLine."Gen. Prod. Posting Group" := GLAccountL."Gen. Prod. Posting Group";
                SalesLine."VAT Prod. Posting Group" := GLAccountL."VAT Prod. Posting Group";

            END; //IF GLAccountL.FINDFIRST THEN

            EVALUATE(SalesLine.Quantity, GetValueAtIndex(RowNo, 5));

            SalesLine.VALIDATE(SalesLine.Quantity);

            EVALUATE(SalesLine."Unit Price", GetValueAtIndex(RowNo, 6));

            SalesLine.VALIDATE(SalesLine."Unit Price");

            EVALUATE(SalesLine."Line Discount %", GetValueAtIndex(RowNo, 7));

            SalesLine.VALIDATE(SalesLine."Line Discount %");

            EVALUATE(SalesLine."POS Received N0.", GetValueAtIndex(RowNo, 8));

            TotalQty := SalesLine.Quantity * SalesLine."Unit Price";
            LineTotal := TotalQty - (TotalQty * (SalesLine."Line Discount %" / 100));
            SalesLine.VALIDATE("Line Amount", LineTotal);

            EVALUATE(SalesLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 9));

            EVALUATE(SalesLine."Unit of Measure Code", GetValueAtIndex(RowNo, 10));

            ItemUOM.RESET;
            ItemUOM.SETRANGE("Item No.", GetValueAtIndex(RowNo, 2));
            ItemUOM.SETRANGE(Code, GetValueAtIndex(RowNo, 10));
            IF ItemUOM.FINDFIRST THEN BEGIN

                SalesLine.VALIDATE("Qty. per Unit of Measure", ItemUOM."Qty. per Unit of Measure");
                SalesLine."Quantity (Base)" := ItemUOM."Qty. per Unit of Measure";
                SalesLine."Qty. to Ship (Base)" := (ItemUOM."Qty. per Unit of Measure" * SalesLine."Qty. to Ship");
                SalesLine."Qty. to Invoice (Base)" := (ItemUOM."Qty. per Unit of Measure" * SalesLine."Qty. to Invoice");
                SalesLine."Outstanding Qty. (Base)" := (ItemUOM."Qty. per Unit of Measure" * SalesLine."Outstanding Quantity");
                SalesLine."Quantity (Base)" := (ItemUOM."Qty. per Unit of Measure" * SalesLine.Quantity);

            END;


            SalesLine.VALIDATE("Sell-to Customer No.", Rec."Sell-to Customer No.");

            SalesLine.VALIDATE("Bill-to Customer No.", Rec."Bill-to Customer No.");

            SalesLine.VALIDATE("Gen. Bus. Posting Group", Rec."Gen. Bus. Posting Group");

            SalesLine."VAT Bus. Posting Group" := Rec."VAT Bus. Posting Group";

            SalesLine.MODIFY(TRUE);

        END

        ELSE BEGIN


            SalesLine.INIT;

            SalesLine.VALIDATE("Document Type", Rec."Document Type");

            SalesLine.VALIDATE(SalesLine."Document No.", Rec."No.");

            EVALUATE(SalesLine.Type, GetValueAtIndex(RowNo, 1));

            EVALUATE(SalesLine."No.", GetValueAtIndex(RowNo, 2));

            SalesLine."Line No." := LineNo;


            EVALUATE(SalesLine."Variant Code", GetValueAtIndex(RowNo, 3));

            EVALUATE(SalesLine."Location Code", GetValueAtIndex(RowNo, 4));

            Item.RESET;
            Item.SETRANGE("No.", SalesLine."No.");
            IF Item.FINDFIRST THEN BEGIN

                SalesLine.VALIDATE(Description, Item.Description);
                SalesLine."Posting Group" := Item."Inventory Posting Group";
                SalesLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                SalesLine."VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                SalesLine.Division := Item."LSC Division Code";
                SalesLine."Item Category Code" := Item."Item Category Code";
                SalesLine."Retail Product Code" := Item."LSC Retail Product Code";

            END; //IF Item.FINDFIRST THEN

            GLAccountL.RESET;
            GLAccountL.SETRANGE("No.", SalesLine."No.");
            IF GLAccountL.FINDFIRST THEN BEGIN

                SalesLine.VALIDATE(Description, GLAccountL.Name);
                SalesLine."Gen. Prod. Posting Group" := GLAccountL."Gen. Prod. Posting Group";
                SalesLine."VAT Prod. Posting Group" := GLAccountL."VAT Prod. Posting Group";

            END; //IF GLAccountL.FINDFIRST THEN

            EVALUATE(SalesLine.Quantity, GetValueAtIndex(RowNo, 5));

            SalesLine.VALIDATE(SalesLine.Quantity);

            EVALUATE(SalesLine."Unit Price", GetValueAtIndex(RowNo, 6));

            SalesLine.VALIDATE(SalesLine."Unit Price");

            EVALUATE(SalesLine."Line Discount %", GetValueAtIndex(RowNo, 7));

            SalesLine.VALIDATE(SalesLine."Line Discount %");

            EVALUATE(SalesLine."POS Received N0.", GetValueAtIndex(RowNo, 8));

            TotalQty := SalesLine.Quantity * SalesLine."Unit Price";
            LineTotal := TotalQty - (TotalQty * (SalesLine."Line Discount %" / 100));
            SalesLine.VALIDATE("Line Amount", LineTotal);


            SalesLine.VALIDATE("Sell-to Customer No.", Rec."Sell-to Customer No.");

            EVALUATE(SalesLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 9));

            EVALUATE(SalesLine."Unit of Measure Code", GetValueAtIndex(RowNo, 10));

            ItemUOM.RESET;
            ItemUOM.SETRANGE("Item No.", GetValueAtIndex(RowNo, 2));
            ItemUOM.SETRANGE(Code, GetValueAtIndex(RowNo, 10));
            IF ItemUOM.FINDFIRST THEN BEGIN

                SalesLine.VALIDATE("Qty. per Unit of Measure", ItemUOM."Qty. per Unit of Measure");
                SalesLine."Quantity (Base)" := ItemUOM."Qty. per Unit of Measure";
                SalesLine."Qty. to Ship (Base)" := (ItemUOM."Qty. per Unit of Measure" * SalesLine."Qty. to Ship");
                SalesLine."Qty. to Invoice (Base)" := (ItemUOM."Qty. per Unit of Measure" * SalesLine."Qty. to Invoice");
                SalesLine."Outstanding Qty. (Base)" := (ItemUOM."Qty. per Unit of Measure" * SalesLine."Outstanding Quantity");
                SalesLine."Quantity (Base)" := (ItemUOM."Qty. per Unit of Measure" * SalesLine.Quantity);

            END;

            SalesLine.VALIDATE("Bill-to Customer No.", Rec."Bill-to Customer No.");

            SalesLine.VALIDATE("Gen. Bus. Posting Group", Rec."Gen. Bus. Posting Group");

            SalesLine."VAT Bus. Posting Group" := Rec."VAT Bus. Posting Group";

            SalesLine.INSERT(TRUE);

            LineNo := LineNo + 10000;

        END; //IF SalesLine.FINDFIRST THEN
    end;

    procedure GetValueAtIndex(RowNo: Integer; Colno: Integer): Text
    var
        ExcelBuffer: Record "Excel Buffer";
        NofromEx: Text;
    begin
        ExcelBuffer.RESET;

        IF ExcelBuffer.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuffer."Cell Value as Text")

        ELSE
            NofromEx := '';
        // EXIT(NofromEx);

    end;

    var
        Rec_ExcelBuffer: Record "Excel Buffer";
        Rows, Columns, LineNo : Integer;

}
