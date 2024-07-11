codeunit 70007 "LSC Store Inventory Mgt Ext"
{
    procedure PrintShelfLabel_NWMM(var StoreInventoryWorksheet: Record "LSC Store Inventory Worksheet")
    var
        StoreInvMgmt: Codeunit "LSC Store Inventory Management";
        StoreInventoryLineTemp: Record "LSC Store Inventory Line" temporary;
        ItemLabelSetup: Record "LSC Item Label Setup";
        ShelfLabelSetup: Record "LSC Shelf Label Setup";
        NothingToProcess: Label 'There is nothing to process.';
        ProcessErrorConfirm: Label 'One or more lines cannot be printed.\Error log has been created.\\Do you want to process lines not in error?\\';
        ProcessedTxt: Label '%1 : \Worksheet: %2 has been printed for %3 %4.';
    begin
        IF StoreInventoryWorksheet."Worksheet Type" <> StoreInventoryWorksheet."Worksheet Type"::Labels THEN
            EXIT;

        OnBeforeProcessWorksheet(StoreInventoryWorksheet);
        BEGIN
            IF StoreInvMgmt.ErrorInBasicDataWorksheet(StoreInventoryWorksheet, StoreInventoryLineTemp) THEN
                IF StoreInventoryLineTemp.ISEMPTY THEN BEGIN
                    MESSAGE(NothingToProcess);
                    EXIT;
                END ELSE
                    IF NOT CONFIRM(ProcessErrorConfirm) THEN
                        EXIT;
            IF StoreInventoryLineTemp.ISEMPTY THEN BEGIN
                MESSAGE(NothingToProcess);
                EXIT;
            END ELSE
                CASE StoreInventoryWorksheet."Label Type" OF
                    StoreInventoryWorksheet."Label Type"::"Item Label":
                        BEGIN

                            CreateItemLabels(StoreInventoryLineTemp, ItemLabelSetup);
                            DeleteProcessedLines(StoreInventoryLineTemp);
                            PrintItemLables(StoreInventoryWorksheet, ItemLabelSetup);
                        END;
                    StoreInventoryWorksheet."Label Type"::"Shelf Label":
                        BEGIN
                            CreateShelfLabels_NWV(StoreInventoryLineTemp, ShelfLabelSetup);
                            DeleteProcessedLines(StoreInventoryLineTemp);
                            // PrintShelfLables(StoreInventoryWorksheet,ShelfLabelSetup);
                            PrintShelfLables(StoreInventoryWorksheet, ShelfLabelSetup, StoreInventoryLineTemp); //ModifiedBy NWMM(CCW) 20Feb2022
                        END;
                END;
        END;
        DeleteProcessedLines(StoreInventoryLineTemp);

        OnAfterProcessWorksheet(StoreInventoryWorksheet);
        MESSAGE(ProcessedTxt, StoreInventoryWorksheet."Worksheet Type", StoreInventoryWorksheet.Description, StoreInventoryWorksheet.FIELDCAPTION("Store No."), StoreInventoryWorksheet."Store No.");

    end;

    procedure CreateShelfLabels_NWV(var StoreInventoryLineTemp_p: Record "LSC Store Inventory Line" temporary; var ShelfLabelSetup_p: Record "LSC Shelf Label Setup")
    var
        ShelfLabel: Record "LSC Shelf Label";
        StoreInventoryWorksheet: Record "LSC Store Inventory Worksheet";
        LabelUtility: Codeunit "LSC Label Utility";
        LabelCommands: Record "LSC Label Functions";
        SalesPrice: Record "Sales Price";

    begin

        StoreInventoryWorksheet.GET(StoreInventoryLineTemp_p.WorksheetSeqNo);
        IF StoreInventoryLineTemp_p.FINDSET THEN
            REPEAT
                LabelUtility.FindShelfLabelSetup(ShelfLabelSetup_p, StoreInventoryLineTemp_p."Item No.", StoreInventoryWorksheet."Store No.");
                ShelfLabelSetup_p.SETRANGE("Label Code", StoreInventoryWorksheet."Label Function Code");
                IF NOT ShelfLabelSetup_p.FINDFIRST THEN BEGIN
                    ShelfLabelSetup_p.SETRANGE("Store Group Code");
                    IF NOT ShelfLabelSetup_p.FINDFIRST THEN BEGIN
                        ShelfLabelSetup_p."Item No." := StoreInventoryLineTemp_p."Item No.";
                        ShelfLabelSetup_p."Label Code" := StoreInventoryWorksheet."Label Function Code";
                    END;
                END;

                IF ShelfLabel.GET(StoreInventoryWorksheet."Store No.", StoreInventoryLineTemp_p."Item No.", StoreInventoryLineTemp_p."Variant Code",
                   StoreInventoryLineTemp_p."Unit of Measure Code", WORKDATE, ShelfLabelSetup_p."Label Code")
                THEN BEGIN
                    //Message('Shelf Label price %1', ShelfLabel."Price on Shelf Label");
                    IF ShelfLabel.Printed THEN
                        ShelfLabel."Order From Code" := '';
                    ShelfLabel.InitRecord(ShelfLabelSetup_p);
                    IF ShelfLabel."Order From Code" = '' THEN
                        ShelfLabel.Quantity := StoreInventoryLineTemp_p.Quantity
                    ELSE
                        ShelfLabel.Quantity := ShelfLabel.Quantity + StoreInventoryLineTemp_p.Quantity;
                    ShelfLabel."Order From Code" := 'W' + COPYSTR(StoreInventoryWorksheet.Description, 1, 20);
                    ShelfLabel.Sequence := StoreInventoryLineTemp_p."Line No.";
                    ShelfLabel.Printed := FALSE;


                    //Modify
                    if ShelfLabel."Item No." <> '' then begin
                        SalesPrice.Reset();
                        SalesPrice.SetRange("Item No.", ShelfLabel."Item No.");
                        SalesPrice.SetRange("Unit of Measure Code", ShelfLabel."Unit of Measure");
                        SalesPrice.SetRange("Sales Type", SalesPrice."Sales Type"::"Customer Price Group"); //Modified 9Dec2022(From Ma Kay Zin)
                        if ShelfLabel.Variant <> '' then begin
                            SalesPrice.SetRange("Variant Code", ShelfLabel.Variant);
                        end;
                        if SalesPrice.FindSet() then
                            repeat

                                if (SalesPrice."Starting Date" <> 0D) and (SalesPrice."Ending Date" <> 0D) then begin

                                    if (ShelfLabel."Label Is Valid on Date" >= SalesPrice."Starting Date") and (ShelfLabel."Label Is Valid on Date" <= SalesPrice."Ending Date") then begin
                                        ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";

                                    end;

                                end
                                else
                                    if (SalesPrice."Starting Date" <> 0D) and (SalesPrice."Ending Date" = 0D) then begin

                                        if (ShelfLabel."Label Is Valid on Date" >= SalesPrice."Starting Date") then begin
                                            ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";

                                        end;
                                    end
                                    else
                                        if (SalesPrice."Starting Date" = 0D) and (SalesPrice."Ending Date" <> 0D) then begin
                                            if (ShelfLabel."Label Is Valid on Date" <= SalesPrice."Ending Date") then begin
                                                ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";
                                            end;
                                        end;
                            // ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";
                            until SalesPrice.Next() = 0;
                    end; //MOdify

                    ShelfLabel.MODIFY;
                END ELSE BEGIN
                    // Message('hello');
                    CLEAR(ShelfLabel);
                    ShelfLabel."Store No." := StoreInventoryWorksheet."Store No.";
                    ShelfLabel."Item No." := StoreInventoryLineTemp_p."Item No.";
                    ShelfLabel.Variant := StoreInventoryLineTemp_p."Variant Code";
                    ShelfLabel."Unit of Measure" := StoreInventoryLineTemp_p."Unit of Measure Code";
                    ShelfLabel."Label Is Valid on Date" := WORKDATE;
                    ShelfLabel."Label Code" := ShelfLabelSetup_p."Label Code";
                    ShelfLabel.InitRecord(ShelfLabelSetup_p);
                    ShelfLabel.Quantity := StoreInventoryLineTemp_p.Quantity;
                    ShelfLabel."Order From Code" := 'W' + COPYSTR(StoreInventoryWorksheet.Description, 1, 20);
                    ShelfLabel.Sequence := StoreInventoryLineTemp_p."Line No.";

                    //Modify
                    if ShelfLabel."Item No." <> '' then begin
                        SalesPrice.Reset();
                        SalesPrice.SetRange("Item No.", ShelfLabel."Item No.");
                        SalesPrice.SetRange("Unit of Measure Code", ShelfLabel."Unit of Measure");
                        SalesPrice.SetRange("Sales Type", SalesPrice."Sales Type"::"Customer Price Group"); //Modified 9Dec2022 (From Ma Kay Zin)
                        if ShelfLabel.Variant <> '' then begin
                            SalesPrice.SetRange("Variant Code", ShelfLabel.Variant);
                        end;
                        if SalesPrice.FindSet() then
                            repeat

                                if (SalesPrice."Starting Date" <> 0D) and (SalesPrice."Ending Date" <> 0D) then begin

                                    if (ShelfLabel."Label Is Valid on Date" >= SalesPrice."Starting Date") and (ShelfLabel."Label Is Valid on Date" <= SalesPrice."Ending Date") then begin
                                        ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";

                                    end;

                                end
                                else
                                    if (SalesPrice."Starting Date" <> 0D) and (SalesPrice."Ending Date" = 0D) then begin

                                        if (ShelfLabel."Label Is Valid on Date" >= SalesPrice."Starting Date") then begin
                                            ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";

                                        end;
                                    end
                                    else
                                        if (SalesPrice."Starting Date" = 0D) and (SalesPrice."Ending Date" <> 0D) then begin
                                            if (ShelfLabel."Label Is Valid on Date" <= SalesPrice."Ending Date") then begin
                                                ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";
                                            end;
                                        end;
                            // ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";
                            until SalesPrice.Next() = 0;
                    end; //MOdify

                    ShelfLabel.INSERT;
                END;
            UNTIL StoreInventoryLineTemp_p.NEXT = 0;
    end;

    procedure PrintShelfLables(StoreInventoryWorksheet: Record "LSC Store Inventory Worksheet"; ShelfLabelSetup: Record "LSC Shelf Label Setup"; StoreInventoryLineTemp: Record "LSC Store Inventory Line")
    var
        ShelfLabel: Record "LSC Shelf Label";
        LabelFunctions: Record "LSC Label Functions";
        PrintLabelsNowTxt: Label 'Labels have been ordered. Do you want to print them now?';
    begin
        COMMIT;
        IF CONFIRM(PrintLabelsNowTxt, TRUE) THEN BEGIN
            ShelfLabel.SETRANGE("Store No.", StoreInventoryWorksheet."Store No.");
            ShelfLabel.SETRANGE("Label Code", ShelfLabelSetup."Label Code");
            ShelfLabel.SETRANGE("Label Is Valid on Date", WORKDATE);
            ShelfLabel.SETRANGE(Printed, FALSE);
            ShelfLabel.SETRANGE("Order From Code", 'W' + COPYSTR(StoreInventoryWorksheet.Description, 1, 20));
            //  IF StoreInventoryLineTemp."Variant Code" <> '' THEN //ModifiedBy NWMM(CCW) 20Feb2022
            //    BEGIN //ModifiedBy NWMM(CCW) 20Feb2022
            //      ShelfLabel.SETRANGE(Variant,StoreInventoryLineTemp."Variant Code"); //ModifiedBy NWMM(CCW) 20Feb2022
            //      LabelFunctions.GET(LabelFunctions.Type::"Shelf Label",ShelfLabelSetup."Label Code");
            //      END; //ModifiedBy NWMM(CCW) 20Feb2022

            LabelFunctions.GET(LabelFunctions.Type::"Shelf Label", ShelfLabelSetup."Label Code");
            //NWV-WATFIX1.0 - 01 -
            //LabelFunctions.TESTFIELD("Run Codeunit");
            //CODEUNIT.RUN(LabelFunctions."Run Codeunit",ShelfLabel);
            COMMIT;
            REPORT.RUNMODAL(LabelFunctions."Run Reports", TRUE, FALSE, ShelfLabel); //LS7.1-01
            IF ShelfLabel.FINDFIRST THEN
                REPEAT
                    ShelfLabel.Printed := TRUE;
                    ShelfLabel."Date Last Printed" := TODAY;
                    ShelfLabel."Time Last Printed" := TIME;
                    ShelfLabel.MODIFY;
                UNTIL ShelfLabel.NEXT = 0;
            //NWV-WATFIX1.0 - 01 +w
        END;
    end;

    procedure CreateItemLabels(var StoreInventoryLineTemp_p: Record "LSC Store Inventory Line" temporary; var ItemLabelSetup_p: Record "LSC Item Label Setup")
    var
        StoreInventoryWorksheet: Record "LSC Store Inventory Worksheet";
        ItemLabel: Record "LSC Item Label";
        LabelUtility: Codeunit "LSC Label Utility";
        BarcodeNo: Code[22];
        SalesPrice: Record "Sales Price";
    begin
        StoreInventoryWorksheet.GET(StoreInventoryLineTemp_p.WorksheetSeqNo);
        IF StoreInventoryLineTemp_p.FINDSET THEN
            REPEAT
                LabelUtility.FindItemLabelSetup(ItemLabelSetup_p, StoreInventoryLineTemp_p."Item No.", StoreInventoryWorksheet."Store No.");
                ItemLabelSetup_p.SETRANGE("Label Code", StoreInventoryWorksheet."Label Function Code");
                IF NOT ItemLabelSetup_p.FINDFIRST THEN BEGIN
                    ItemLabelSetup_p.SETRANGE("Store Group Code");
                    IF NOT ItemLabelSetup_p.FINDFIRST THEN BEGIN
                        ItemLabelSetup_p."Item No." := StoreInventoryLineTemp_p."Item No.";
                        ItemLabelSetup_p."Label Code" := StoreInventoryWorksheet."Label Function Code";
                    END;
                END;

                IF ItemLabel.GET(StoreInventoryWorksheet."Store No.", StoreInventoryLineTemp_p."Item No.", StoreInventoryLineTemp_p."Variant Code",
                    StoreInventoryLineTemp_p."Unit of Measure Code", WORKDATE, ItemLabelSetup_p."Label Code")
                THEN BEGIN
                    IF ItemLabel.Printed THEN
                        ItemLabel."Order From Code" := '';
                    ItemLabel.InitRecord(ItemLabelSetup_p);
                    IF ItemLabel."Order From Code" = '' THEN
                        ItemLabel.Quantity := StoreInventoryLineTemp_p.Quantity
                    ELSE
                        ItemLabel.Quantity := ItemLabel.Quantity + StoreInventoryLineTemp_p.Quantity;
                    ItemLabel."Order From Code" := 'W' + COPYSTR(StoreInventoryWorksheet.Description, 1, 20);
                    ItemLabel.Sequence := StoreInventoryLineTemp_p."Line No.";
                    ItemLabel.Printed := FALSE;
                    IF ItemLabel.Variant <> '' THEN BEGIN
                        BarcodeNo := LabelUtility.FindItemVariantBarcode(ItemLabel."Item No.", ItemLabel.Variant);
                        IF BarcodeNo <> '' THEN
                            ItemLabel."Barcode No." := BarcodeNo;
                    END;

                    //Modify
                    if ItemLabel."Item No." <> '' then begin
                        SalesPrice.Reset();
                        SalesPrice.SetRange("Item No.", ItemLabel."Item No.");
                        SalesPrice.SetRange("Unit of Measure Code", ItemLabel."Unit of Measure");
                        SalesPrice.SetRange("Sales Type", SalesPrice."Sales Type"::"Customer Price Group"); //Modified 12-Dec-2022(Request From Ma Kay Zin)
                        if ItemLabel.Variant <> '' then begin
                            SalesPrice.SetRange("Variant Code", ItemLabel.Variant);
                        end;
                        if SalesPrice.FindSet() then
                            repeat

                                if (SalesPrice."Starting Date" <> 0D) and (SalesPrice."Ending Date" <> 0D) then begin

                                    if (ItemLabel."Label Is Valid on Date" >= SalesPrice."Starting Date") and (ItemLabel."Label Is Valid on Date" <= SalesPrice."Ending Date") then begin
                                        ItemLabel."Price on Item Label" := SalesPrice."Unit Price";

                                    end;

                                end
                                else
                                    if (SalesPrice."Starting Date" <> 0D) and (SalesPrice."Ending Date" = 0D) then begin

                                        if (ItemLabel."Label Is Valid on Date" >= SalesPrice."Starting Date") then begin
                                            ItemLabel."Price on Item Label" := SalesPrice."Unit Price";

                                        end;
                                    end
                                    else
                                        if (SalesPrice."Starting Date" = 0D) and (SalesPrice."Ending Date" <> 0D) then begin
                                            if (ItemLabel."Label Is Valid on Date" <= SalesPrice."Ending Date") then begin
                                                ItemLabel."Price on Item Label" := SalesPrice."Unit Price";
                                            end;
                                        end;
                            // ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";
                            until SalesPrice.Next() = 0;
                    end; //MOdify

                    ItemLabel.MODIFY;
                END ELSE BEGIN
                    CLEAR(ItemLabel);
                    ItemLabel."Store No." := StoreInventoryWorksheet."Store No.";
                    ItemLabel."Item No." := StoreInventoryLineTemp_p."Item No.";
                    ItemLabel.Variant := StoreInventoryLineTemp_p."Variant Code";
                    ItemLabel."Unit of Measure" := StoreInventoryLineTemp_p."Unit of Measure Code";
                    ItemLabel."Label Is Valid on Date" := WORKDATE;
                    ItemLabel."Label Code" := ItemLabelSetup_p."Label Code";
                    ItemLabel.InitRecord(ItemLabelSetup_p);
                    ItemLabel.Quantity := StoreInventoryLineTemp_p.Quantity;
                    ItemLabel."Order From Code" := 'W' + COPYSTR(StoreInventoryWorksheet.Description, 1, 20);
                    ItemLabel.Sequence := StoreInventoryLineTemp_p."Line No.";
                    IF ItemLabel.Variant <> '' THEN BEGIN
                        BarcodeNo := LabelUtility.FindItemVariantBarcode(ItemLabel."Item No.", ItemLabel.Variant);
                        IF BarcodeNo <> '' THEN
                            ItemLabel."Barcode No." := BarcodeNo;
                    END;

                    //Modify
                    if ItemLabel."Item No." <> '' then begin
                        SalesPrice.Reset();
                        SalesPrice.SetRange("Item No.", ItemLabel."Item No.");
                        SalesPrice.SetRange("Unit of Measure Code", ItemLabel."Unit of Measure");
                        SalesPrice.SetRange("Sales Type", SalesPrice."Sales Type"::"Customer Price Group"); //MOdified 9Dec2022(From Ma Kay Zin)
                        if ItemLabel.Variant <> '' then begin
                            SalesPrice.SetRange("Variant Code", ItemLabel.Variant);
                        end;
                        if SalesPrice.FindSet() then
                            repeat

                                if (SalesPrice."Starting Date" <> 0D) and (SalesPrice."Ending Date" <> 0D) then begin

                                    if (ItemLabel."Label Is Valid on Date" >= SalesPrice."Starting Date") and (ItemLabel."Label Is Valid on Date" <= SalesPrice."Ending Date") then begin
                                        ItemLabel."Price on Item Label" := SalesPrice."Unit Price";

                                    end;

                                end
                                else
                                    if (SalesPrice."Starting Date" <> 0D) and (SalesPrice."Ending Date" = 0D) then begin

                                        if (ItemLabel."Label Is Valid on Date" >= SalesPrice."Starting Date") then begin
                                            ItemLabel."Price on Item Label" := SalesPrice."Unit Price";

                                        end;
                                    end
                                    else
                                        if (SalesPrice."Starting Date" = 0D) and (SalesPrice."Ending Date" <> 0D) then begin
                                            if (ItemLabel."Label Is Valid on Date" <= SalesPrice."Ending Date") then begin
                                                ItemLabel."Price on Item Label" := SalesPrice."Unit Price";
                                            end;
                                        end;
                            // ShelfLabel."Price on Shelf Label" := SalesPrice."Unit Price";
                            until SalesPrice.Next() = 0;
                    end; //MOdify

                    ItemLabel.INSERT;
                END;
            UNTIL StoreInventoryLineTemp_p.NEXT = 0;
    end;

    procedure DeleteProcessedLines(var StoreInventoryLineTemp_p: Record "LSC Store Inventory Line" temporary)
    var
        StoreInventoryLine: Record "LSC Store Inventory Line";
    begin
        IF StoreInventoryLineTemp_p.FINDFIRST THEN
            REPEAT
                IF StoreInventoryLine.GET(StoreInventoryLineTemp_p.WorksheetSeqNo, StoreInventoryLineTemp_p."Line No.") THEN
                    StoreInventoryLine.DELETE(TRUE);
            UNTIL StoreInventoryLineTemp_p.NEXT = 0;
    end;

    procedure PrintItemLables(var StoreInventoryWorksheet: Record "LSC Store Inventory Worksheet"; var ItemLabelSetup: Record "LSC Item Label Setup")
    var
        ItemLabel: Record "LSC Item Label";
        LabelFunctions: Record "LSC Label Functions";
        PrintLabelsNowTxt: label 'Labels have been ordered. Do you want to print them now?';
    begin
        COMMIT;
        IF CONFIRM(PrintLabelsNowTxt, TRUE) THEN BEGIN
            ItemLabel.SETRANGE("Store No.", StoreInventoryWorksheet."Store No.");
            ItemLabel.SETRANGE("Label Code", ItemLabelSetup."Label Code");
            ItemLabel.SETRANGE("Label Is Valid on Date", WORKDATE);
            ItemLabel.SETRANGE(Printed, FALSE);
            ItemLabel.SETRANGE("Order From Code", 'W' + COPYSTR(StoreInventoryWorksheet.Description, 1, 20));
            LabelFunctions.GET(LabelFunctions.Type::"Item Label", ItemLabelSetup."Label Code");
            //NWV-WATFIX1.0 - 01  -
            //LabelFunctions.TESTFIELD("Run Codeunit");
            //CODEUNIT.RUN(LabelFunctions."Run Codeunit",ItemLabel);
            COMMIT;
            REPORT.RUNMODAL(LabelFunctions."Run Reports", TRUE, FALSE, ItemLabel); //LS7.1-01
            IF ItemLabel.FINDFIRST THEN
                REPEAT
                    ItemLabel.Printed := TRUE;
                    ItemLabel."Date Last Printed" := TODAY;
                    ItemLabel."Time Last Printed" := TIME;
                    ItemLabel.MODIFY;
                UNTIL ItemLabel.NEXT = 0;
            //NWV-WATFIX1.0 - 01  =
        END;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"LSC Store Inventory Worksheet", 'OnAfterProcessWorksheet', '', true, true)]
    [IntegrationEvent(true, true)]
    local procedure OnAfterProcessWorksheet(var StoreInventoryWorksheet: Record "LSC Store Inventory Worksheet")
    begin
        // My subscriber code
    end;

    //[EventSubscriber(ObjectType::Table, Database::"LSC Store Inventory Worksheet", 'OnBeforeProcessWorksheet', '', true, true)]
    [IntegrationEvent(true, true)]
    local procedure OnBeforeProcessWorksheet(var StoreInventoryWorksheet: Record "LSC Store Inventory Worksheet")
    begin
        // My subscriber code
    end;

}
