report 70000 "Shelf Label A4 Landscape 3x7KM"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/ShelfLabelA4Landscape3x7KM.rdl';
    EnableExternalAssemblies = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("LSC Shelf Label"; "LSC Shelf Label")
        {
            dataitem(SetMainData; "Integer")
            {

                trigger OnAfterGetRecord()
                begin
                    //
                    if RecordNo > gRec_ShelfLabel.Quantity then exit;
                    if gCurrColumn1 = 1 then begin
                        ModifyCol1;
                        if RecordNo > gRec_ShelfLabel.Quantity then exit;
                        ModifyCol2;
                    end;
                    if gCurrColumn2 = 2 then begin
                        ModifyCol2;
                        if RecordNo > gRec_ShelfLabel.Quantity then exit;
                        ModifyCol3;
                    end;
                    // Modified on 12 Jan 2021 05:47 PM by MMK NWMM
                    if gCurrColumn3 = 3 then begin
                        ModifyCol3;
                    end;

                    //+
                    gMainData.Reset;
                    gNo += 1;
                    gMainData.Init;
                    gMainData."No." := gNo;

                    InsertCol1;
                    InsertCol2;
                    // Modified on 12 Jan 2021 05:47 PM by MMK NWMM
                    InsertCol3;

                    gMainData.Insert;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, gRec_ShelfLabel.Quantity);
                    gRec_Item.Get(gRec_ShelfLabel."Item No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                gRec_ShelfLabel := "LSC Shelf Label";
                gRec_ShelfLabel.CalcFields("Item Description");
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
            column(StartingDate1; gMainData.Date_4)
            {
            }
            column(EndingDate1; gMainData.Date_7)
            {
            }
            column(Promotion1; gMainData.Decimal_4)
            {
            }
            column(ItemNo2; gMainData.Code_2)
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
            column(StartingDate2; gMainData.Date_5)
            {
            }
            column(EndingDate2; gMainData.Date_8)
            {
            }
            column(Promotion2; gMainData.Decimal_5)
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
            column(StartingDate3; gMainData.Date_6)
            {
            }
            column(EndingDate3; gMainData.Date_9)
            {
            }
            column(Promotion3; gMainData.Decimal_6)
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
            column(Variant1; gMainData.Text_10)
            {
            }
            column(Variant2; gMainData.Text_11)
            {
            }
            column(Variiant3; gMainData.Text_12)
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
            column(Nprice1; gMainData.Decimal_11)
            {
            }
            column(Nprice2; gMainData.Decimal_12)
            {
            }
            column(CurrencyCodeG; CurrencyCodeG)
            {
            }
            column(ContentSize1; gMainData.Text_7)
            {
            }
            column(ContentSize2; gMainData.Text_8)
            {
            }
            column(ContentSize3; gMainData.Text_9)
            {
            }
            column(PrintDate; PrintDateG)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //BarcodeNumber := '4006381333931';
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

                if gMainData.Code_4 <> '' then BarcodeLines1 := EncodedBarcode128(gMainData.Code_4); //Modified By NWMM(CCW) 21Feb2022
                if gMainData.Code_5 <> '' then BarcodeLines2 := EncodedBarcode128(gMainData.Code_5); //Modified By NWMM(CCW) 21Feb2022
                if gMainData.Code_6 <> '' then BarcodeLines3 := EncodedBarcode128(gMainData.Code_6); //Modified By NWMM(CCW) 21Feb2022
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
            column(L_ApplyFrom; gTxt_IntLabel[5])
            {
            }
            column(L_ItemNo; gTxt_IntLabel[2])
            {
            }
            column(FormatDecimal; '#,###.##;(#,###.##);')
            {
            }
            column(L_Giathuong; gTxt_IntLabel[4])
            {
            }
            column(L_Masp; gTxt_IntLabel[8])
            {
            }
            column(L_To; gTxt_IntLabel[6])
            {
            }
            column(L_D; gTxt_IntLabel[7])
            {
            }
            column(L_DVT; gTxt_IntLabel[1])
            {
            }
            column(L_GiaKM; gTxt_IntLabel[9])
            {
            }

            trigger OnAfterGetRecord()
            begin

                CurrencyCodeG := 'Ks';
                PrintDateG := Today; //ModifiedBy NWMM(CCW)
            end;

            trigger OnPostDataItem()
            begin

                CurrencyCodeG := 'Ks';
                PrintDateG := Today; //ModifiedBy NWMM(CCW)
            end;

            trigger OnPreDataItem()
            begin

                CurrencyCodeG := 'Ks';
                PrintDateG := Today; //ModifiedBy NWMM(CCW)
            end;
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

    trigger OnInitReport()
    begin

        CurrencyCodeG := 'Ks';
        PrintDateG := Today; //ModifiedBy NWMM(CCW)
    end;

    trigger OnPostReport()
    begin

        CurrencyCodeG := 'Ks';
        PrintDateG := Today; //ModifiedBy NWMM(CCW)
    end;

    trigger OnPreReport()
    begin
        // gCu_VASMgt.FillRptLabelCaptions(0, REPORT::"Shelf Label A4 Landscape 3x7KM",gTxt_IntLabel);
        // gCu_VASMgt.FillRptLabelCaptions(1, REPORT::"Shelf Label A4 Landscape 3x7KM",gTxt_ExtLabel);

        CurrencyCodeG := 'Ks';
        PrintDateG := Today; //ModifiedBy NWMM(CCW)
    end;

    var
        NoOfColumns: Integer;
        gRec_ShelfLabel: Record "LSC Shelf Label";
        gRec_Item: Record Item;
        TextArray: array[3, 15] of Text[100];
        RecordNo: Integer;
        ColumnNo: Integer;
        i: Integer;
        NoOfRecords: Integer;
        ShelfLabelSetup: Record "LSC Shelf Label Setup";
        gMainData: Record "Temporary Data Buffer" temporary;
        gNo: Integer;
        gTxt_IntLabel: array[200] of Text;
        gTxt_ExtLabel: array[200] of Text;
        gCu_VASMgt: Codeunit "VAS Management";
        gBarcodeMgt: Codeunit "LSC Barcode Management";
        gBarcode: array[3] of Record "Upgrade Blob Storage";
        gCurrColumn1: Integer;
        gCurrColumn2: Integer;
        Text001: Label 'Barcode must be %1 chars length.';
        Text002: Label 'Wrong barcode.';
        Text003: Label 'CheckSum in barcode is wrong.';
        gCurrColumn3: Integer;
        BarcodeLines1: Text;
        BarcodeNumber1: Text;
        BarcodeLines2: Text;
        BarcodeNumber2: Text;
        BarcodeLines3: Text;
        BarcodeNumber3: Text;
        CurrencyCodeG: Text;
        PrintDateG: Date;
        gRec_ItemVariant: Record "Item Variant";

    [Scope('OnPrem')]
    procedure InsertCol1()
    begin
        //Column 1
        if RecordNo <= gRec_ShelfLabel.Quantity then begin
            gMainData.Code_1 := gRec_ShelfLabel."Item No.";
            gMainData.Decimal_1 := gRec_ShelfLabel."Price on Shelf Label" -
                                      (gRec_ShelfLabel."Price on Shelf Label" - Round(gRec_ShelfLabel."Price on Shelf Label", 1, '<'));
            //gMainData.Decimal_11 := gRec_ShelfLabel."Standard Price Incl.VAT";
            gMainData.Text_1 := gRec_ShelfLabel."Unit of Measure";
            gMainData.Text_4 := gRec_ShelfLabel."Item Description";
            gMainData.Code_4 := gRec_ShelfLabel."Barcode No.";
            gMainData.Date_1 := gRec_ShelfLabel."Label Is Valid on Date";
            //gMainData.Date_4 := gRec_ShelfLabel."Starting Date";
            //gMainData.Date_7 := gRec_ShelfLabel."Ending Date";
            gMainData.Boolean_1 := false;
            gMainData.Code_7 := gRec_ShelfLabel.Variant; //ModifiedBy NWMM(CCW) 20Feb2022
            if gRec_ShelfLabel.Variant <> '' then //ModifiedBy NWMM(CCW) 20Feb2022
              begin  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.Reset;  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.SetRange("Item No.", gRec_ShelfLabel."Item No.");  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.SetRange(Code, gRec_ShelfLabel.Variant);  //ModifiedBy NWMM(CCW) 20Feb2022
                if gRec_ItemVariant.FindFirst then  //ModifiedBy NWMM(CCW) 20Feb2022
                  begin  //ModifiedBy NWMM(CCW) 20Feb2022

                    gMainData.Text_10 := gRec_ItemVariant."Description 2";  //ModifiedBy NWMM(CCW) 20Feb2022

                end;  //ModifiedBy NWMM(CCW) 20Feb2022
            end;  //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_7 := gRec_Item.Size; //ModifiedBy NWMM(CCW) 20Feb2022
                                                //IF gRec_ShelfLabel."Standard Price Incl.VAT" <> 0 THEN
                                                //gMainData.Decimal_4 := ROUND(((gRec_ShelfLabel."Standard Price Incl.VAT" - gMainData.Decimal_1)*100/gRec_ShelfLabel."Standard Price Incl.VAT"),0.1,'=');
            if gMainData.Decimal_4 > 50 then
                gMainData.Decimal_4 := 50;
        end
        else begin
            gMainData.Code_1 := '';
            gMainData.Decimal_1 := 0;
            gMainData.Text_1 := '';
            gMainData.Text_4 := '';
            gMainData.Code_4 := '';
            gMainData.Date_1 := 0D;
            gMainData.Boolean_1 := true;
            gMainData.Code_7 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_7 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_10 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gCurrColumn1 := 1;
        end;
        RecordNo += 1;
        //Column 1 +
    end;

    [Scope('OnPrem')]
    procedure InsertCol2()
    begin
        //Column 2
        if RecordNo <= gRec_ShelfLabel.Quantity then begin
            gMainData.Code_2 := gRec_ShelfLabel."Item No.";
            gMainData.Decimal_2 := gRec_ShelfLabel."Price on Shelf Label" -
                                      (gRec_ShelfLabel."Price on Shelf Label" - Round(gRec_ShelfLabel."Price on Shelf Label", 1, '<'));
            //gMainData.Decimal_12 := gRec_ShelfLabel."Standard Price Incl.VAT";
            gMainData.Text_2 := gRec_ShelfLabel."Unit of Measure";
            gMainData.Text_5 := gRec_ShelfLabel."Item Description";
            gMainData.Code_5 := gRec_ShelfLabel."Barcode No.";
            gMainData.Date_2 := gRec_ShelfLabel."Label Is Valid on Date";
            //gMainData.Date_5 := gRec_ShelfLabel."Starting Date";
            //gMainData.Date_8 := gRec_ShelfLabel."Ending Date";
            gMainData.Boolean_2 := false;
            gMainData.Code_8 := gRec_ShelfLabel.Variant; //ModifiedBy NWMM(CCW) 20Feb2022
            if gRec_ShelfLabel.Variant <> '' then //ModifiedBy NWMM(CCW) 20Feb2022
              begin  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.Reset;  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.SetRange("Item No.", gRec_ShelfLabel."Item No.");  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.SetRange(Code, gRec_ShelfLabel.Variant);  //ModifiedBy NWMM(CCW) 20Feb2022
                if gRec_ItemVariant.FindFirst then  //ModifiedBy NWMM(CCW) 20Feb2022
                  begin  //ModifiedBy NWMM(CCW) 20Feb2022

                    gMainData.Text_11 := gRec_ItemVariant."Description 2";  //ModifiedBy NWMM(CCW) 20Feb2022

                end;  //ModifiedBy NWMM(CCW) 20Feb2022
            end;  //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_8 := gRec_Item.Size; //ModifiedBy NWMM(CCW) 20Feb2022
                                                //IF gRec_ShelfLabel."Standard Price Incl.VAT" <> 0 THEN
                                                //gMainData.Decimal_5 := ROUND(((gRec_ShelfLabel."Standard Price Incl.VAT" - gMainData.Decimal_2)*100/gRec_ShelfLabel."Standard Price Incl.VAT"),0.1,'=');
            if gMainData.Decimal_5 > 50 then
                gMainData.Decimal_5 := 50;
        end
        else begin
            gMainData.Code_2 := '';
            gMainData.Decimal_2 := 0;
            gMainData.Text_2 := '';
            gMainData.Text_5 := '';
            gMainData.Code_5 := '';
            gMainData.Date_2 := 0D;
            gMainData.Boolean_2 := true;
            gMainData.Code_8 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_8 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_11 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gCurrColumn2 := 2;
        end;
        RecordNo += 1;
        //Column 2 +
    end;

    [Scope('OnPrem')]
    procedure InsertCol3()
    begin

        //Column 3
        if RecordNo <= gRec_ShelfLabel.Quantity then begin
            gMainData.Code_3 := gRec_ShelfLabel."Item No.";
            gMainData.Decimal_3 := gRec_ShelfLabel."Price on Shelf Label" -
                                      (gRec_ShelfLabel."Price on Shelf Label" - Round(gRec_ShelfLabel."Price on Shelf Label", 1, '<'));
            //gMainData.Decimal_12 := gRec_ShelfLabel."Standard Price Incl.VAT";
            gMainData.Text_3 := gRec_ShelfLabel."Unit of Measure";
            gMainData.Text_6 := gRec_ShelfLabel."Item Description";
            gMainData.Code_6 := gRec_ShelfLabel."Barcode No.";
            gMainData.Date_3 := gRec_ShelfLabel."Label Is Valid on Date";
            //gMainData.Date_5 := gRec_ShelfLabel."Starting Date";
            //gMainData.Date_8 := gRec_ShelfLabel."Ending Date";
            gMainData.Boolean_3 := false;
            gMainData.Code_9 := gRec_ShelfLabel.Variant; //ModifiedBy NWMM(CCW) 20Feb2022
            if gRec_ShelfLabel.Variant <> '' then //ModifiedBy NWMM(CCW) 20Feb2022
              begin  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.Reset;  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.SetRange("Item No.", gRec_ShelfLabel."Item No.");  //ModifiedBy NWMM(CCW) 20Feb2022
                gRec_ItemVariant.SetRange(Code, gRec_ShelfLabel.Variant);  //ModifiedBy NWMM(CCW) 20Feb2022
                if gRec_ItemVariant.FindFirst then  //ModifiedBy NWMM(CCW) 20Feb2022
                  begin  //ModifiedBy NWMM(CCW) 20Feb2022

                    gMainData.Text_12 := gRec_ItemVariant."Description 2";  //ModifiedBy NWMM(CCW) 20Feb2022

                end;  //ModifiedBy NWMM(CCW) 20Feb2022
            end;  //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_9 := gRec_Item.Size; //ModifiedBy NWMM(CCW) 20Feb2022
                                                //IF gRec_ShelfLabel."Standard Price Incl.VAT" <> 0 THEN
                                                //gMainData.Decimal_5 := ROUND(((gRec_ShelfLabel."Standard Price Incl.VAT" - gMainData.Decimal_2)*100/gRec_ShelfLabel."Standard Price Incl.VAT"),0.1,'=');
            if gMainData.Decimal_6 > 50 then
                gMainData.Decimal_6 := 50;
        end
        else begin
            gMainData.Code_3 := '';
            gMainData.Decimal_3 := 0;
            gMainData.Text_3 := '';
            gMainData.Text_6 := '';
            gMainData.Code_6 := '';
            gMainData.Date_3 := 0D;
            gMainData.Boolean_3 := true;
            gMainData.Code_9 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_9 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gMainData.Text_12 := ''; //ModifiedBy NWMM(CCW) 20Feb2022
            gCurrColumn3 := 3;
        end;
        RecordNo += 1;
        //Column 3 +
    end;

    [Scope('OnPrem')]
    procedure ModifyCol1()
    begin
        gMainData.Get(gNo);
        gMainData.Code_1 := gRec_ShelfLabel."Item No.";
        gMainData.Decimal_1 := gRec_ShelfLabel."Price on Shelf Label" -
                                  (gRec_ShelfLabel."Price on Shelf Label" - Round(gRec_ShelfLabel."Price on Shelf Label", 1, '<'));
        //gMainData.Decimal_11 := gRec_ShelfLabel."Standard Price Incl.VAT";
        gMainData.Text_1 := gRec_ShelfLabel."Unit of Measure";
        gMainData.Text_4 := gRec_ShelfLabel."Item Description";
        gMainData.Code_4 := gRec_ShelfLabel."Barcode No.";
        gMainData.Date_1 := gRec_ShelfLabel."Label Is Valid on Date";
        //gMainData.Date_4 := gRec_ShelfLabel."Starting Date";
        //gMainData.Date_7 := gRec_ShelfLabel."Ending Date";
        gMainData.Boolean_1 := false;
        gMainData.Code_7 := gRec_ShelfLabel.Variant; //ModifiedBy NWMM(CCW) 20Feb2022
        if gRec_ShelfLabel.Variant <> '' then //ModifiedBy NWMM(CCW) 20Feb2022
            begin  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.Reset;  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.SetRange("Item No.", gRec_ShelfLabel."Item No.");  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.SetRange(Code, gRec_ShelfLabel.Variant);  //ModifiedBy NWMM(CCW) 20Feb2022
            if gRec_ItemVariant.FindFirst then  //ModifiedBy NWMM(CCW) 20Feb2022
              begin  //ModifiedBy NWMM(CCW) 20Feb2022

                gMainData.Text_10 := gRec_ItemVariant."Description 2";  //ModifiedBy NWMM(CCW) 20Feb2022

            end;  //ModifiedBy NWMM(CCW) 20Feb2022
        end;  //ModifiedBy NWMM(CCW) 20Feb2022
        gMainData.Text_7 := gRec_Item.Size; //ModifiedBy NWMM(CCW) 20Feb2022
                                            //IF gRec_ShelfLabel."Standard Price Incl.VAT" <> 0 THEN
                                            //gMainData.Decimal_4 := ROUND(((gRec_ShelfLabel."Standard Price Incl.VAT" - gMainData.Decimal_1)*100/gRec_ShelfLabel."Standard Price Incl.VAT"),0.1,'=');
        if gMainData.Decimal_4 > 50 then
            gMainData.Decimal_4 := 50;
        gMainData.Modify;
        gCurrColumn1 := 0;
        RecordNo += 1;
    end;

    [Scope('OnPrem')]
    procedure ModifyCol2()
    begin
        gMainData.Get(gNo);
        gMainData.Code_2 := gRec_ShelfLabel."Item No.";
        gMainData.Decimal_2 := gRec_ShelfLabel."Price on Shelf Label" -
                                  (gRec_ShelfLabel."Price on Shelf Label" - Round(gRec_ShelfLabel."Price on Shelf Label", 1, '<'));
        //gMainData.Decimal_12 := gRec_ShelfLabel."Standard Price Incl.VAT";
        gMainData.Text_2 := gRec_ShelfLabel."Unit of Measure";
        gMainData.Text_5 := gRec_ShelfLabel."Item Description";
        gMainData.Code_5 := gRec_ShelfLabel."Barcode No.";
        gMainData.Date_2 := gRec_ShelfLabel."Label Is Valid on Date";
        //gMainData.Date_5 := gRec_ShelfLabel."Starting Date";
        //gMainData.Date_8 := gRec_ShelfLabel."Ending Date";
        gMainData.Boolean_2 := false;
        gMainData.Code_8 := gRec_ShelfLabel.Variant; //ModifiedBy NWMM(CCW) 20Feb2022
        if gRec_ShelfLabel.Variant <> '' then //ModifiedBy NWMM(CCW) 20Feb2022
            begin  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.Reset;  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.SetRange("Item No.", gRec_ShelfLabel."Item No.");  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.SetRange(Code, gRec_ShelfLabel.Variant);  //ModifiedBy NWMM(CCW) 20Feb2022
            if gRec_ItemVariant.FindFirst then  //ModifiedBy NWMM(CCW) 20Feb2022
              begin  //ModifiedBy NWMM(CCW) 20Feb2022

                gMainData.Text_11 := gRec_ItemVariant."Description 2";  //ModifiedBy NWMM(CCW) 20Feb2022

            end;  //ModifiedBy NWMM(CCW) 20Feb2022
        end;  //ModifiedBy NWMM(CCW) 20Feb2022
        gMainData.Text_8 := gRec_Item.Size; //ModifiedBy NWMM(CCW) 20Feb2022
                                            //IF gRec_ShelfLabel."Standard Price Incl.VAT" <> 0 THEN
                                            //gMainData.Decimal_5 := ROUND(((gRec_ShelfLabel."Standard Price Incl.VAT" - gMainData.Decimal_2)*100/gRec_ShelfLabel."Standard Price Incl.VAT"),0.1,'=');
        if gMainData.Decimal_5 > 50 then
            gMainData.Decimal_5 := 50;
        gMainData.Modify;
        gCurrColumn2 := 0;
        RecordNo += 1;
    end;

    [Scope('OnPrem')]
    procedure ModifyCol3()
    begin
        gMainData.Get(gNo);
        gMainData.Code_3 := gRec_ShelfLabel."Item No.";
        gMainData.Decimal_3 := gRec_ShelfLabel."Price on Shelf Label" -
                                  (gRec_ShelfLabel."Price on Shelf Label" - Round(gRec_ShelfLabel."Price on Shelf Label", 1, '<'));
        //gMainData.Decimal_12 := gRec_ShelfLabel."Standard Price Incl.VAT";
        gMainData.Text_3 := gRec_ShelfLabel."Unit of Measure";
        gMainData.Text_6 := gRec_ShelfLabel."Item Description";
        gMainData.Code_6 := gRec_ShelfLabel."Barcode No.";
        gMainData.Date_3 := gRec_ShelfLabel."Label Is Valid on Date";
        //gMainData.Date_5 := gRec_ShelfLabel."Starting Date";
        //gMainData.Date_8 := gRec_ShelfLabel."Ending Date";
        gMainData.Boolean_3 := false;
        gMainData.Code_9 := gRec_ShelfLabel.Variant; //ModifiedBy NWMM(CCW) 20Feb2022
        if gRec_ShelfLabel.Variant <> '' then //ModifiedBy NWMM(CCW) 20Feb2022
            begin  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.Reset;  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.SetRange("Item No.", gRec_ShelfLabel."Item No.");  //ModifiedBy NWMM(CCW) 20Feb2022
            gRec_ItemVariant.SetRange(Code, gRec_ShelfLabel.Variant);  //ModifiedBy NWMM(CCW) 20Feb2022
            if gRec_ItemVariant.FindFirst then  //ModifiedBy NWMM(CCW) 20Feb2022
              begin  //ModifiedBy NWMM(CCW) 20Feb2022

                gMainData.Text_12 := gRec_ItemVariant."Description 2";  //ModifiedBy NWMM(CCW) 20Feb2022

            end;  //ModifiedBy NWMM(CCW) 20Feb2022
        end;  //ModifiedBy NWMM(CCW) 20Feb2022
        gMainData.Text_9 := gRec_Item.Size; //ModifiedBy NWMM(CCW) 20Feb2022
                                            //IF gRec_ShelfLabel."Standard Price Incl.VAT" <> 0 THEN
                                            //gMainData.Decimal_5 := ROUND(((gRec_ShelfLabel."Standard Price Incl.VAT" - gMainData.Decimal_2)*100/gRec_ShelfLabel."Standard Price Incl.VAT"),0.1,'=');
        if gMainData.Decimal_6 > 50 then
            gMainData.Decimal_6 := 50;
        gMainData.Modify;
        gCurrColumn3 := 0;
        RecordNo += 1;
    end;

    [Scope('OnPrem')]
    procedure EAN13_10String(InputBarcode: Code[20]): Text
    var
        LRSeparator: Text[3];
        CSeparator: Text[6];
        Encoding: array[10, 3] of Text[7];
        Structure: array[10] of Text[6];
        Weight: Text[12];
        LeftStructure: Text[6];
        CurrentBarcode: Text;
        EncodedBarcode: Text;
        BarcodeWithCheckSum: Code[13];
        CheckDigit: Integer;
        "Count": Integer;
        NumberEval: Integer;
        StructureIndex: Integer;
    begin
        // In Separators '2' is used to identify line length for nicer look'n'feel
        LRSeparator := '202';
        CSeparator := '02020';
        Weight := '131313131313';

        // If barcode is already with Checksum digit at the end
        if StrLen(InputBarcode) = 13 then begin
            Evaluate(CheckDigit, CopyStr(InputBarcode, 13, 1));
            CurrentBarcode := CopyStr(InputBarcode, 1, 12);
            //Comparing checkdigit
            if CheckDigit <> StrCheckSum(CurrentBarcode, Weight, 10) then begin
                //ERROR(Text003);
                CurrentBarcode := '2300000000009';
            end;
        end else begin
            //BINHNT TEST REMOVE
            if StrLen(InputBarcode) <> 12 then
                Error(Text001, 12);
            CurrentBarcode := InputBarcode;
        end;
        //BINHNT

        for Count := 1 to StrLen(CurrentBarcode) do begin
            //Checking if barcode constructed only of digits
            if not (CurrentBarcode[Count] in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']) then
                Error(Text002);
        end;

        //Initializing EAN13 structure
        InitEAN13Structure(Structure, Encoding);

        //Checkdigit again
        CheckDigit := StrCheckSum(CurrentBarcode, Weight, 10);

        //Barcode to encode with checksum
        BarcodeWithCheckSum := CopyStr(CurrentBarcode, 2, StrLen(CurrentBarcode)) + Format(CheckDigit);

        //Structure to use (Left Part)
        Evaluate(StructureIndex, Format(CurrentBarcode[1]));
        StructureIndex := StructureIndex + 1;
        LeftStructure := Structure[StructureIndex];

        //Add Beginning lines
        EncodedBarcode := EncodedBarcode + LRSeparator;

        for Count := 1 to StrLen(BarcodeWithCheckSum) do begin
            //Add Middle Lines
            if Count = 7 then begin
                EncodedBarcode := EncodedBarcode + CSeparator;
            end;
            //Getting Barcode digit by index
            Evaluate(NumberEval, Format(BarcodeWithCheckSum[Count]));

            if Count <= 6 then begin
                //Left Part
                case LeftStructure[Count] of
                    'L':
                        EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [1];
                    'G':
                        EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [2];
                end;
            end else begin
                //Right Part
                EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [3];
            end;

        end;

        //Ending Lines
        EncodedBarcode := EncodedBarcode + LRSeparator;

        exit(EncodedBarcode);
    end;

    local procedure InitEAN13Structure(var Structures: array[10] of Text[6]; var Encodings: array[10, 3] of Text[7])
    begin
        Structures[1] := 'LLLLLL';
        Structures[2] := 'LLGLGG';
        Structures[3] := 'LLGGLG';
        Structures[4] := 'LLGGGL';
        Structures[5] := 'LGLLGG';
        Structures[6] := 'LGGLLG';
        Structures[7] := 'LGGGLL';
        Structures[8] := 'LGLGLG';
        Structures[9] := 'LGLGGL';
        Structures[10] := 'LGGLGL';

        Encodings[1] [1] := '0001101';
        Encodings[1] [2] := '0100111';
        Encodings[1] [3] := '1110010';
        Encodings[2] [1] := '0011001';
        Encodings[2] [2] := '0110011';
        Encodings[2] [3] := '1100110';
        Encodings[3] [1] := '0010011';
        Encodings[3] [2] := '0011011';
        Encodings[3] [3] := '1101100';
        Encodings[4] [1] := '0111101';
        Encodings[4] [2] := '0100001';
        Encodings[4] [3] := '1000010';
        Encodings[5] [1] := '0100011';
        Encodings[5] [2] := '0011101';
        Encodings[5] [3] := '1011100';
        Encodings[6] [1] := '0110001';
        Encodings[6] [2] := '0111001';
        Encodings[6] [3] := '1001110';
        Encodings[7] [1] := '0101111';
        Encodings[7] [2] := '0000101';
        Encodings[7] [3] := '1010000';
        Encodings[8] [1] := '0111011';
        Encodings[8] [2] := '0010001';
        Encodings[8] [3] := '1000100';
        Encodings[9] [1] := '0110111';
        Encodings[9] [2] := '0001001';
        Encodings[9] [3] := '1001000';
        Encodings[10] [1] := '0001011';
        Encodings[10] [2] := '0010111';
        Encodings[10] [3] := '1110100';
    end;

    local procedure EncodedBarcode128(pText: Text[250]) RetVal: Text[250]
    var
        ChecksumCode128: Integer;
        i: Integer;
        currentchar: Char;
        ChecksumChar: Char;
        Code128: Integer;
        ASCII: Integer;
        SpaceChar: Char;
        StartChar: Char;
        StopChar: Integer;
        Checksum: Integer;
    begin

        ChecksumCode128 := 104;
        for i := 1 to StrLen(pText) do begin
            currentchar := pText[i];
            ChecksumCode128 := ChecksumCode128 + (i * (currentchar - 32));
        end;

        ChecksumCode128 := (ChecksumCode128 mod 103);

        case ChecksumCode128 of
            0:
                ASCII := 8364;
            1 .. 94:
                ASCII := ChecksumCode128 + 32;
            95:
                ASCII := 8216;
            96:
                ASCII := 8217;
            97:
                ASCII := 8220;
            98:
                ASCII := 8221;
            99:
                ASCII := 8226;
            100:
                ASCII := 8211;
            101:
                ASCII := 8212;
            102:
                ASCII := 732;
            103:
                ASCII := 8482;
        end;
        ChecksumChar := ASCII;

        SpaceChar := 8364;
        pText := ConvertStr(pText, ' ', Format(SpaceChar));

        RetVal[1] := 353; //start Bar
        RetVal += pText + Format(ChecksumChar);
        RetVal[StrLen(RetVal) + 1] := 339; //stop Bar

        exit(RetVal);
    end;
}

