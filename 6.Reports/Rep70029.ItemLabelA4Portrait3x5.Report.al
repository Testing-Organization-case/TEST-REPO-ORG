report 70029 "Item Label - A4 Portrait 3x5"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/ItemLabelA4Portrait3x5.rdl';
    EnableExternalAssemblies = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Label"; "LSC Item Label")
        {
            dataitem(SetMainData; "Integer")
            {

                trigger OnAfterGetRecord()
                begin
                    //
                    if RecordNo > gRec_ItemLabel.Quantity then exit;
                    if gCurrColumn1 = 1 then begin
                        if RecordNo > gRec_ItemLabel.Quantity then exit;
                        ModifyCol1;
                        if RecordNo > gRec_ItemLabel.Quantity then exit;
                        ModifyCol2;
                        if RecordNo > gRec_ItemLabel.Quantity then exit;
                        ModifyCol3;
                    end;
                    if gCurrColumn2 = 2 then begin
                        if RecordNo > gRec_ItemLabel.Quantity then exit;
                        ModifyCol2;
                        if RecordNo > gRec_ItemLabel.Quantity then exit;
                        ModifyCol3;
                    end;
                    if gCurrColumn3 = 3 then begin
                        if RecordNo > gRec_ItemLabel.Quantity then exit;
                        ModifyCol3;
                    end;
                    //+

                    gMainData.Reset;
                    gNo += 1;
                    gMainData.Init;
                    gMainData."No." := gNo;

                    InsertCol1;
                    InsertCol2;
                    InsertCol3;

                    gMainData.Insert;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, gRec_ItemLabel.Quantity);
                    gRec_Item.Get(gRec_ItemLabel."Item No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                gRec_ItemLabel := "Item Label";
                gRec_ItemLabel.CalcFields("Item Description");
                RecordNo := 1;
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := 0;
                repeat
                    NoOfRecords += Quantity;
                until Next = 0;
                NoOfRecords := NoOfRecords - 1;
                NoOfColumns := 3;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            column(ItemNo1; gMainData.Code_1)
            {
            }
            column(ItemDesc1; gMainData.Text_4)
            {
            }
            column(Price1; gMainData.Decimal_1)
            {
            }
            column(UMO1; gMainData.Text_1)
            {
            }
            column(BarcodeNo1; gMainData.Code_4)
            {
            }
            column(Date1; gMainData.Date_1)
            {
            }
            column(Show1; gMainData.Boolean_1)
            {
            }
            column(VendorNo1; gMainData.Code_7)
            {
            }
            column(ItemNo2; gMainData.Code_1)
            {
            }
            column(ItemDesc2; gMainData.Text_5)
            {
            }
            column(Price2; gMainData.Decimal_2)
            {
            }
            column(UOM2; gMainData.Text_2)
            {
            }
            column(BarcodeNo2; gMainData.Code_5)
            {
            }
            column(Date2; gMainData.Date_2)
            {
            }
            column(Show2; gMainData.Boolean_2)
            {
            }
            column(VendorNo2; gMainData.Code_8)
            {
            }
            column(ItemNo3; gMainData.Code_3)
            {
            }
            column(ItemDesc3; gMainData.Text_6)
            {
            }
            column(Price3; gMainData.Decimal_3)
            {
            }
            column(UOM3; gMainData.Text_3)
            {
            }
            column(BarcodeNo3; gMainData.Code_6)
            {
            }
            column(Date3; gMainData.Date_3)
            {
            }
            column(Show3; gMainData.Boolean_3)
            {
            }
            column(VendorNo3; gMainData.Code_9)
            {
            }
            column(Barcode1; gBarcode[1].Blob)
            {
            }
            column(Barcode2; gBarcode[2].Blob)
            {
            }
            column(Barcode3; gBarcode[3].Blob)
            {
            }
            column(BarcodeLines1; BarcodeLines1)
            {
            }
            column(BarcodeNumber1; BarcodeNumber1)
            {
            }
            column(BarcodeLines2; BarcodeLines2)
            {
            }
            column(BarcodeNumber2; BarcodeNumber2)
            {
            }
            column(BarcodeLines3; BarcodeLines3)
            {
            }
            column(BarcodeNumber3; BarcodeNumber3)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    gMainData.FindSet
                else
                    gMainData.Next;
                if (gMainData.Code_1 = '') then
                    CurrReport.Skip;

                //binhnt
                //gBarcodeMgt.EncodeCode128(gMainData.Code_4, 2, FALSE, gBarcode[1]);
                //gBarcodeMgt.EncodeCode128(gMainData.Code_5, 2, FALSE, gBarcode[2]);
                //gBarcodeMgt.EncodeCode128(gMainData.Code_6, 2, FALSE, gBarcode[3]);

                if gMainData.Code_4 <> '' then BarcodeLines1 := gBarcodeMgt.EAN13_10String(gMainData.Code_4);
                if gMainData.Code_5 <> '' then BarcodeLines2 := gBarcodeMgt.EAN13_10String(gMainData.Code_5);
                if gMainData.Code_6 <> '' then BarcodeLines3 := gBarcodeMgt.EAN13_10String(gMainData.Code_6);
                BarcodeNumber1 := gMainData.Code_4;
                BarcodeNumber2 := gMainData.Code_5;
                BarcodeNumber3 := gMainData.Code_6;

                //binhnt
            end;

            trigger OnPreDataItem()
            begin
                gMainData.Reset;
                SetRange(Number, 1, gMainData.Count);
            end;
        }
        dataitem("Company Information"; "Company Information")
        {
            column(L_Gia; gTxt_IntLabel[1])
            {
            }
            column(L_Currency; gTxt_IntLabel[2])
            {
            }
            column(FormatDecimal; '#,###.##;(#,###.##);')
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        // gCu_VASMgt.FillRptLabelCaptions(0, REPORT::"Item Label - A4 Portrait 3x5",gTxt_IntLabel);
        // gCu_VASMgt.FillRptLabelCaptions(1, REPORT::"Item Label - A4 Portrait 3x5",gTxt_ExtLabel);
    end;

    var
        NoOfColumns: Integer;
        gRec_ItemLabel: Record "LSC Item Label";
        gRec_Item: Record Item;
        TextArray: array[3, 15] of Text[100];
        RecordNo: Integer;
        ColumnNo: Integer;
        i: Integer;
        NoOfRecords: Integer;
        ItemLabelSetup: Record "LSC Item Label Setup";
        gMainData: Record "Temporary Data Buffer" temporary;
        gNo: Integer;
        gTxt_IntLabel: array[200] of Text;
        gTxt_ExtLabel: array[200] of Text;
        gCu_VASMgt: Codeunit "VAS Management";
        gBarcodeMgt: Codeunit CustomizeFunctions;       //replaced "LSC Barcode Management"
        gBarcode: array[3] of Record "Upgrade Blob Storage";
        gCurrColumn1: Integer;
        gCurrColumn2: Integer;
        gCurrColumn3: Integer;
        BarcodeLines1: Text;
        BarcodeNumber1: Text;
        BarcodeLines2: Text;
        BarcodeNumber2: Text;
        BarcodeLines3: Text;
        BarcodeNumber3: Text;

    [Scope('OnPrem')]
    local procedure InsertCol1()
    begin
        //Column 1
        if RecordNo <= gRec_ItemLabel.Quantity then begin
            gMainData.Code_1 := gRec_ItemLabel."Item No.";
            gMainData.Decimal_1 := gRec_ItemLabel."Price on Item Label";
            gMainData.Text_1 := gRec_ItemLabel."Unit of Measure";
            gMainData.Text_4 := gRec_ItemLabel."Text 1";
            gMainData.Code_4 := gRec_ItemLabel."Barcode No.";
            gMainData.Date_1 := gRec_ItemLabel."Label Is Valid on Date";
            gMainData.Code_7 := gRec_Item."Vendor No.";
            gMainData.Boolean_1 := false;
        end
        else begin
            gMainData.Code_1 := '';
            gMainData.Decimal_1 := 0;
            gMainData.Text_1 := '';
            gMainData.Text_4 := '';
            gMainData.Code_4 := '';
            gMainData.Date_1 := 0D;
            gMainData.Code_7 := '';
            gMainData.Boolean_1 := true;
            gCurrColumn1 := 1;
        end;
        RecordNo += 1;
        //Column 1 +
    end;

    [Scope('OnPrem')]
    local procedure InsertCol2()
    begin
        //Column 2
        if RecordNo <= gRec_ItemLabel.Quantity then begin
            gMainData.Code_2 := gRec_ItemLabel."Item No.";
            gMainData.Decimal_2 := gRec_ItemLabel."Price on Item Label";
            gMainData.Text_2 := gRec_ItemLabel."Unit of Measure";
            gMainData.Text_5 := gRec_ItemLabel."Text 1";
            gMainData.Code_5 := gRec_ItemLabel."Barcode No.";
            gMainData.Date_2 := gRec_ItemLabel."Label Is Valid on Date";
            gMainData.Code_8 := gRec_Item."Vendor No.";
            gMainData.Boolean_2 := false;
        end
        else begin
            gMainData.Code_2 := '';
            gMainData.Decimal_2 := 0;
            gMainData.Text_2 := '';
            gMainData.Text_5 := '';
            gMainData.Code_5 := '';
            gMainData.Date_2 := 0D;
            gMainData.Code_8 := '';
            gMainData.Boolean_2 := true;
            gCurrColumn2 := 2;
        end;
        RecordNo += 1;
        //Column 2 +
    end;

    [Scope('OnPrem')]
    local procedure InsertCol3()
    begin
        //Column 3
        if RecordNo <= gRec_ItemLabel.Quantity then begin
            gMainData.Code_3 := gRec_ItemLabel."Item No.";
            gMainData.Decimal_3 := gRec_ItemLabel."Price on Item Label";
            gMainData.Text_3 := gRec_ItemLabel."Unit of Measure";
            gMainData.Text_6 := gRec_ItemLabel."Text 1";
            gMainData.Code_6 := gRec_ItemLabel."Barcode No.";
            gMainData.Date_3 := gRec_ItemLabel."Label Is Valid on Date";
            gMainData.Code_9 := gRec_Item."Vendor No.";
            gMainData.Boolean_3 := false;
        end
        else begin
            gMainData.Code_3 := '';
            gMainData.Decimal_3 := 0;
            gMainData.Text_3 := '';
            gMainData.Text_6 := '';
            gMainData.Code_6 := '';
            gMainData.Date_3 := 0D;
            gMainData.Code_9 := '';
            gMainData.Boolean_3 := true;
            gCurrColumn3 := 3;
        end;
        RecordNo += 1;
        //Column 3 +
    end;

    [Scope('OnPrem')]
    local procedure ModifyCol1()
    begin
        gMainData.Get(gNo);
        gMainData.Code_1 := gRec_ItemLabel."Item No.";
        gMainData.Decimal_1 := gRec_ItemLabel."Price on Item Label";
        gMainData.Text_1 := gRec_ItemLabel."Unit of Measure";
        gMainData.Text_4 := gRec_ItemLabel."Text 1";
        gMainData.Code_4 := gRec_ItemLabel."Barcode No.";
        gMainData.Date_1 := gRec_ItemLabel."Label Is Valid on Date";
        gMainData.Code_7 := gRec_Item."Vendor No.";
        gMainData.Boolean_1 := false;
        gMainData.Modify;
        gCurrColumn1 := 0;
        RecordNo += 1;
    end;

    [Scope('Internal')]
    procedure ModifyCol2()
    begin
        gMainData.Get(gNo);
        gMainData.Code_2 := gRec_ItemLabel."Item No.";
        gMainData.Decimal_2 := gRec_ItemLabel."Price on Item Label";
        gMainData.Text_2 := gRec_ItemLabel."Unit of Measure";
        gMainData.Text_5 := gRec_ItemLabel."Text 1";
        gMainData.Code_5 := gRec_ItemLabel."Barcode No.";
        gMainData.Date_2 := gRec_ItemLabel."Label Is Valid on Date";
        gMainData.Code_8 := gRec_Item."Vendor No.";
        gMainData.Boolean_2 := false;
        gMainData.Modify;
        gCurrColumn2 := 0;
        RecordNo += 1;
    end;

    [Scope('Internal')]
    procedure ModifyCol3()
    begin
        gMainData.Get(gNo);
        gMainData.Code_3 := gRec_ItemLabel."Item No.";
        gMainData.Decimal_3 := gRec_ItemLabel."Price on Item Label";
        gMainData.Text_3 := gRec_ItemLabel."Unit of Measure";
        gMainData.Text_6 := gRec_ItemLabel."Text 1";
        gMainData.Code_6 := gRec_ItemLabel."Barcode No.";
        gMainData.Date_3 := gRec_ItemLabel."Label Is Valid on Date";
        gMainData.Code_9 := gRec_Item."Vendor No.";
        gMainData.Boolean_3 := false;
        gMainData.Modify;
        gCurrColumn3 := 0;
        RecordNo += 1;
    end;
}

