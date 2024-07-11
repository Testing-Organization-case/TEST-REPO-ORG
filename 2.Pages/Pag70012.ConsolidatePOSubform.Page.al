page 70012 "Consolidate PO Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Consolidate Purchase Line";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    TableRelation = Vendor;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    TableRelation = Item;

                    trigger OnValidate()
                    begin
                        ItemTable.Reset;
                        ItemTable.SetRange("No.", Rec."Item No.");
                        if ItemTable.FindFirst then begin
                            Rec.Description := ItemTable.Description;
                        end;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }

                field(Remark; Rec.Remark)
                {
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    AssistEdit = true;
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;

                    trigger OnAssistEdit()
                    begin


                        if Rec."Item No." <> '' then begin

                            ConPODetailLine.Reset;
                            ConPODetailLine.SetRange("Vendor No.", Rec."Vendor No.");
                            ConPODetailLine.SetRange("Item No.", Rec."Item No.");
                            ConPODetailLine.SetRange("Document Type", 'Order');
                            ConPODetailLine.SetRange("Document No.", Rec."Document No.");
                            PAGE.Run(70017, ConPODetailLine);

                        end;

                        ConPODetailLine."Document No." := Rec."Document No.";
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Direct Unit Cost Excl. VAT"; Rec."Direct Unit Cost Excl. VAT")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin

                        PurLine.Reset;
                        PurLine.SetRange("Buy-from Vendor No.", Rec."Vendor No.");
                        PurLine.SetRange("No.", Rec."Item No.");
                        if PurLine.FindSet then
                            repeat
                                PurLine."Direct Unit Cost" := Rec."Direct Unit Cost Excl. VAT";
                                PurLine.Modify(true);
                            until PurLine.Next = 0;
                    end;
                }
                field("Net Cost"; Rec."Net Cost Price")
                {
                    Caption = 'Net Cost';
                    Editable = false;
                }
                field("Total Discount Amt"; Rec."Total Discount Amt")
                {
                    Editable = false;
                }
                field("Total Dis AMT"; Rec."Total Dis AMT")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line Amount Excl. VAT"; Rec."Line Amount Excl. VAT")
                {
                    Editable = false;
                }
                field("Scheme Code"; Rec."Scheme Code")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Consolidate Start Date"; Rec."Consolidate Start Date")
                {
                    Editable = false;
                }
                field("Consolidate End Date"; Rec."Consolidate End Date")
                {
                    Editable = false;
                }
                field("Retrieve Purchase Lines"; Rec."Retrieve Purchase Lines")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(MaxQtyperUOM; Rec.MaxQtyperUOM)
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
            }
            group(Control10014519)
            {
                ShowCaption = false;
                group(Control10014518)
                {
                    ShowCaption = false;
                    field("Total Discount Amount"; Rec."Total Discount Amount")
                    {
                        Editable = false;
                    }
                    field("Total Line Amount Excl. VAT"; Rec."Total Line Amount Excl. VAT")
                    {
                        Editable = false;
                    }
                }
                group(Control10014517)
                {
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Purchase Order List")
            {

                trigger OnAction()
                var
                    SelectionFilterManagement: Codeunit SelectionFilterManagement;
                    LoopCount: Integer;
                    AlreadyExist: Boolean;
                    PurchaseAttributeListL: Page PurchaseAttributesList;
                    Value: Decimal;
                    MaxValue: Code[10];
                    ConPODetailLine: Record "Consolidate PO Detail Line";
                    UOMR: Record "Unit of Measure";
                    ItemR: Record Item;
                    MyRecRef: Record "Consolidate Purchase Line";
                    MyFieldRef: Decimal;
                    LineNo: Integer;
                    LocCodeL: Code[200];
                    VDesc: Text;
                    CuzFunction: Codeunit CustomizeFunctions;      //Modify By MK
                begin
                    Commit;
                    CPOHeader.Reset;
                    CPOHeader.SetRange("No.", Rec."Document No.");
                    if CPOHeader.FindFirst then begin
                        if CPOHeader."Vendor No." = '' then
                            Error('"Vendor No." must be filled to get related purchase order!');

                        Clear(POListPage);
                        PORecord.Reset;
                        PORecord.SetRange("Buy-from Vendor No.", CPOHeader."Vendor No.");
                        PORecord.SetRange(Status, PORecord.Status::Open);
                        if (CPOHeader."Consolidate Starting Date" <> 0D) and (CPOHeader."Consolidate Ending Date" <> 0D) then
                            PORecord.SetRange("Posting Date", CPOHeader."Consolidate Starting Date", CPOHeader."Consolidate Ending Date");
                        PORecord.SetRange("CPO Confirm", false);
                        PORecord.SetRange("CPO No.", '');
                        PORecord.SetCurrentKey("No.");
                        PORecord.Ascending;
                        POListPage.SetTableView(PORecord);
                        POListPage.LookupMode(true);
                        if POListPage.RunModal in [ACTION::LookupOK, ACTION::LookupOK] then begin
                            POListPage.SetSelectionFilter(PORecord);
                            SelectionFilter1 := CuzFunction.GetSelectionFilterForPORecord(PORecord);        //Fix GetSelectionFilterForPORecord to CuzFunction Jan/25/2024
                            if SelectionFilter1 <> '' then begin
                                AlreadyExist := false;
                                PORecord.Reset;
                                PORecord.SetFilter("No.", SelectionFilter1);
                                if PORecord.FindSet then
                                    if PORecord."CPO Confirm" = true then begin
                                        AlreadyExist := true;
                                        Error('Some PO are already existed in CPO!');
                                    end;
                                //PurchLine.LOCKTABLE(TRUE);
                                PurchLine.Reset;
                                PurchLine.SetFilter("Document No.", SelectionFilter1);
                                if PurchLine.FindFirst then
                                    repeat

                                        LineNo := 1000;
                                        ConPOLine.Reset;
                                        ConPOLine.SetRange("Document No.", Rec."Document No.");
                                        if ConPOLine.FindLast then begin
                                            LineNo := ConPOLine."Line No." + 1000;
                                        end;
                                        //ConPOLine.LOCKTABLE(TRUE);

                                        ConPOLine.Init;
                                        ConPOLine."Document No." := Rec."Document No.";
                                        ConPOLine."Vendor No." := Rec."Vendor No.";
                                        ConPOLine."Line No." := LineNo;
                                        ConPOLine."Item No." := PurchLine."No.";
                                        ConPOLine."Location Code" := PurchLine."Location Code";
                                        ConPOLine."Location Code" := Rec."Location Code";
                                        ConPOLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                                        ConPOLine."Scheme Code" := PurchLine.Scheme;

                                        ConPOLine.Reset;
                                        ConPOLine.SetRange("Item No.", ConPOLine."Item No.");
                                        ConPOLine.SetRange("Document No.", ConPOLine."Document No.");
                                        ConPOLine.SetRange("Vendor No.", ConPOLine."Vendor No.");

                                        if ConPOLine.FindFirst then
                                            repeat
                                                ConPOLine.Delete;
                                            until ConPOLine.Next = 0;

                                        ConPOLine.Description := PurchLine.Description;
                                        ConPOLine."PO No." := PurchLine."Document No.";

                                        if ConPOLine."PO No." <> '' then begin
                                            PurchHeader.Reset;
                                            PurchHeader.SetRange("No.", ConPOLine."PO No.");
                                            if PurchHeader.FindFirst then
                                                repeat

                                                    ConPOLine."Posting Date" := PurchHeader."Posting Date";

                                                until PurchHeader.Next = 0;
                                        end;
                                        ConPOLine."Net Cost Price" := PurchLine."Net Price";
                                        ConPOLine.Remark := PurchLine.Remark; ////Modified 9/12/2023
                                        ConPOLine."Total Discount Amt" += PurchLine."Line Discount Amount";
                                        ConPOLine."Retrieve Purchase Lines" := true;
                                        ConPOLine."Cross-Reference No." := PurchLine."Item Reference No."; //Modifiedby NWMM

                                        ConPOLine.Insert;

                                        InsertConPOLinesLoc;
                                        CPOCheck(SelectionFilter1, Rec."Document No.");
                                    until PurchLine.Next = 0;
                                NetCostSummary;

                            end;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        LineAmt: Decimal;
        LineDisc: Decimal;
        ConPOLine: Record "Consolidate Purchase Line";
    begin
        ConPOLine.SetRange("Document No.", Rec."Document No.");
        ConPOLine.CalcSums("Total Discount Amt");
        ConPOLine.CalcSums("Line Amount Excl. VAT");
        LineAmt := ConPOLine."Line Amount Excl. VAT";
        LineDisc := ConPOLine."Total Discount Amt";
        // MESSAGE('%1',LineAmt);
        // MESSAGE('%1',LineDisc);
        Rec."Total Discount Amount" := LineDisc;
        Rec."Total Line Amount Excl. VAT" := LineAmt;
        Rec.Modify(true);



        //CalcTotalDisAmt;
        //NewCalc;
        // TotalConPOLine.RESET;
        // TotalConPOLine.SETRANGE("Document No.",ConPurHeader."No.");
        // IF TotalConPOLine.FINDSET THEN
        //  REPEAT
        // //    ConPOLine.CALCSUMS("Total Line Amount Excl. VAT");
        // // //    ConPOLine."Total Line Amount Excl. VAT" += ConPOLine."Line Amount Excl. VAT";
        // // //    ConPOLine.MODIFY;
        // // TotalLineAmount += ConPOLine."Line Amount Excl. VAT";
        // //    ConPOLine."Total Line Amount Excl. VAT" := TotalLineAmount;
        // //    ConPOLine.MODIFY;
        // //    MESSAGE('%1', ConPOLine."Line Amount Excl. VAT");
        // TotalLineAmount += TotalConPOLine."Line Amount Excl. VAT";
        // TotalDisAmountLoc += TotalConPOLine."Total Discount Amt";
        // TotalDisAmount := TotalConPOLine.COUNT;
        // TotalConPOLine."Total Discount Amount" := TotalLineAmount;
        // TotalConPOLine."Total Line Amount Excl. VAT" := TotalDisAmountLoc;
        // TotalConPOLine.MODIFY;
        //    UNTIL TotalConPOLine.NEXT = 0;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        PurchHeader.Reset;
        PurchHeader.SetRange("No.", Rec."PO No.");
        if PurchHeader.FindSet then
            repeat
                PurchHeader."CPO Confirm" := false;
                PurchHeader."CPO No." := '';
                PurchHeader.Modify(true);
            until PurchHeader.Next = 0;
    end;

    var
        ItemTable: Record Item;
        PurLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        ConPurLine: Record "Consolidate Purchase Line";
        PurchaseLinePage: Page "Purchase Lines";
        TotalConPOLine: Record "Consolidate Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
        ConPurHeader: Record "Consolidate Purchase Header";
        TotalLineAmount: Decimal;
        TotalDisAmount: Decimal;
        TotalDisAmountLoc: Decimal;
        CPOHeader: Record "Consolidate Purchase Header";
        POListPage: Page "Purchase Order List";
        PORecord: Record "Purchase Header";
        Vend: Record Vendor;
        ConPOHeader: Record "Consolidate Purchase Header";
        ConPOLine: Record "Consolidate Purchase Line";
        PurchLine: Record "Purchase Line";
        VenTradeScheme: Record "Vendor Trade Scheme";
        Purch: Record "Purchase Header";
        TempPurchLine: Record "Purchase Line";
        ConPODetailLines: Record "Consolidate PO Detail Line";
        ItemUOM: Record "Item Unit of Measure";
        value: Decimal;
        Maxvalue: Decimal;
        specific_ReceiptID_var: Code[10];
        Multi1: Decimal;
        Multi2: Decimal;
        Multi3: Decimal;
        Count1: Decimal;
        Count2: Decimal;
        Count3: Decimal;
        Count4: Decimal;
        SUM1: Decimal;
        SUM2: Decimal;
        QTY1: Decimal;
        ItemR: Record Item;
        PUnitofMeasure: Code[10];
        VarTemp: Integer;
        SelectionFilter1: Text;
        PurchPriceWorksheet: Record "Purchase Price";
        NetCostExist: Boolean;

    local procedure CalcTotalDisAmt()
    var
        PurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
    begin

        PurchHeader.Reset;
        PurchHeader.SetRange("Buy-from Vendor No.", Rec."Vendor No.");
        PurchHeader.SetRange(Status, PurchHeader.Status::Open);
        if PurchHeader.FindSet then
            repeat
                PurchLine.Reset;
                PurchLine.SetRange("Document No.", PurchHeader."No.");
                PurchLine.SetRange("Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
                PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                PurchLine.SetRange("Document No.", Rec."PO No.");
                if PurchLine.FindSet then
                    repeat
                        Rec.Reset;
                        Rec.SetCurrentKey("Document No.");
                        if Rec.FindFirst then
                            repeat

                                PurchLine.CalcSums("Line Discount Amount");
                                PurchLine.CalcSums("Line Amount");
                                Rec."Total Discount Amount" := PurchLine."Line Discount Amount";
                                Rec."Total Line Amount Excl. VAT" := PurchLine."Line Amount";

                            until Rec.Next = 0;

                    until PurchLine.Next = 0;

            until PurchHeader.Next = 0;
    end;

    local procedure NewCalc()
    var
        PurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        ConPOLine: Record "Consolidate Purchase Line";
    begin
    end;

    local procedure InsertConPOLines()
    var
        PurchLine: Record "Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
        MaxValue: Code[10];
        LineNo: Integer;
    begin

        PurchLine.Reset;
        PurchLine.SetRange("Buy-from Vendor No.", ConPOLine."Vendor No.");
        PurchLine.SetRange("Document No.", ConPOLine."PO No.");
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        if PurchLine.FindSet then
            repeat
                LineNo := 1000;

                ConPODetailLine.Reset;
                if ConPODetailLine.FindLast then begin
                    LineNo := ConPODetailLine."Line No." + 1000;
                end;

                ConPODetailLine.Init;
                ConPODetailLine."PO No." := PurchLine."Document No.";
                ConPODetailLine."Document Type" := 'Order';
                ConPODetailLine."Vendor No." := PurchLine."Buy-from Vendor No.";
                ConPODetailLine."Line No." := LineNo;

                Vend.Reset;
                Vend.SetRange("No.", ConPODetailLine."Vendor No.");
                if Vend.FindFirst then begin
                    ConPODetailLine."Vendor Name" := Vend.Name;
                end;

                ConPODetailLine."Posting Date" := PurchHeader."Posting Date";
                ConPODetailLine."Vendor Name" := Vend.Name;
                ConPODetailLine.Type := 'Item';
                ConPODetailLine."Item No." := PurchLine."No.";
                ConPODetailLine.Scheme := PurchLine.Scheme;

                ConPODetailLine."Document No." := ConPOLine."Document No.";
                ConPODetailLine.Description := PurchLine.Description;
                ConPODetailLine."Location Code" := PurchLine."Location Code";
                ConPODetailLine.Quantity := PurchLine.Quantity;
                ConPODetailLine."Net Cost" := PurchLine."Net Price";
                ConPODetailLine."Line Discount %" := PurchLine."Line Discount %";
                ConPODetailLine."Line Discount Amount" := PurchLine."Line Discount Amount";
                ConPODetailLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                ConPODetailLine."Line Amount Excl. VAT" := PurchLine."Line Amount";
                ConPODetailLine."Unit of Measure Code" := PurchLine."Unit of Measure Code";

                ItemUOM.Reset;
                ItemUOM.SetRange("Item No.", ConPODetailLine."Item No.");
                ItemUOM.SetRange(Code, ConPODetailLine."Unit of Measure Code");
                if ItemUOM.FindFirst then
                    repeat

                        ConPODetailLine."Qty per UOM" := ItemUOM."Qty. per Unit of Measure";

                    until ItemUOM.Next = 0;

                ConPODetailLine."Sum of Qty" += ConPODetailLine.Quantity * ConPODetailLine."Qty per UOM";
                ConPODetailLine."Child PO No." := PurchHeader."FOC PO No.";
                if ConPODetailLine."Child PO No." <> '' then begin
                    ConPODetailLine."Child PO No. Update" := true;
                end
                else begin
                    ConPODetailLine."Child PO No. Update" := false;
                end;



                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPODetailLine."Item No.");
                ConPODetailLine.SetRange("PO No.", ConPODetailLine."PO No.");
                ConPODetailLine.SetRange("Vendor No.", ConPODetailLine."Vendor No.");
                ConPODetailLine.SetRange("Document No.", ConPODetailLine."Document No.");
                ConPODetailLine.SetRange("Line Discount Amount", ConPODetailLine."Line Discount Amount");
                ConPODetailLine.SetRange("Location Code", ConPODetailLine."Location Code");
                ConPODetailLine.SetRange("Direct Unit Cost Excl. VAT", ConPODetailLine."Direct Unit Cost Excl. VAT");
                ConPODetailLine.SetRange("Unit of Measure Code", ConPODetailLine."Unit of Measure Code");
                ConPODetailLine.SetRange(Quantity, ConPODetailLine.Quantity);
                if ConPODetailLine.FindSet then
                    repeat
                        ConPODetailLine.Delete;
                    until ConPODetailLine.Next = 0;

                ConPODetailLine.Insert;
                MaxUOMFunction(ConPOLine);
                AddUOM_CalcQty;

            //  UnitofMeasureUpdateLoc;
            until PurchLine.Next = 0;
    end;

    local procedure InsertConPOLinesLoc()
    var
        PurchLine: Record "Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
        MaxValue: Code[10];
        LineNo: Integer;
        LocCodeL: Code[200];
        ConPOHeaderL: Record "Consolidate Purchase Header";
        LineNoMsgL: Text;
        StoreNoMsgL: Text;
        ProgressBarL: Text;
        DialogBoxL: Dialog;
        NoOfRecordL: Integer;
        NextL: Integer;
        Dec: Decimal;
        PurHeader: Record "Purchase Header";
    begin

        PurchLine.Reset;
        PurchLine.SetRange("Buy-from Vendor No.", ConPOLine."Vendor No.");
        PurchLine.SetRange("Document No.", ConPOLine."PO No.");
        PurchLine.SetRange("No.", ConPOLine."Item No.");
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        if PurchLine.FindSet then
            repeat
                LineNo := 1000;

                ConPODetailLine.Reset;
                if ConPODetailLine.FindLast then begin
                    LineNo := ConPODetailLine."Line No." + 1000;
                end;

                ConPODetailLine.Init;
                ConPODetailLine."PO No." := PurchLine."Document No.";
                ConPODetailLine."Document Type" := 'Order';
                ConPODetailLine."Vendor No." := PurchLine."Buy-from Vendor No.";
                ConPODetailLine."Line No." := LineNo;
                ConPODetailLine.Type := 'Item';
                ConPODetailLine."Item No." := PurchLine."No.";
                ConPODetailLine.Scheme := PurchLine.Scheme;
                ConPODetailLine."Document No." := ConPOLine."Document No.";
                ConPODetailLine.Remark := PurchLine.Remark;//Modified 9/12/2023
                ConPODetailLine.Description := PurchLine.Description;
                ConPODetailLine."Location Code" := PurchLine."Location Code";
                ConPODetailLine.Quantity := PurchLine.Quantity;

                //For Posting Date
                PurchHeader.Reset;
                PurchHeader.SetRange("No.", PurchLine."Document No.");
                if PurchHeader.FindFirst then
                    ConPODetailLine."Posting Date" := PurchHeader."Posting Date";
                ConPODetailLine."Cross-Reference No." := PurchLine."Item Reference No."; //Modified Date 4-Sep-2023

                //For Net cost
                if PurchLine."Net Price" > 0 then begin
                    ConPODetailLine."Net Cost" := PurchLine."Net Price";
                    NetCostExist := true;
                end else begin
                    PurchPriceWorksheet.Reset;
                    PurchPriceWorksheet.SetRange("Vendor No.", Rec."Vendor No.");
                    PurchPriceWorksheet.SetRange("Item No.", PurchLine."No.");
                    PurchPriceWorksheet.SetRange("Unit of Measure Code", PurchLine."Unit of Measure Code");
                    if PurchPriceWorksheet.FindSet then
                        repeat
                            PurHeader.Reset;
                            PurHeader.SetRange("No.", PurchLine."Document No.");
                            if PurHeader.FindFirst then begin
                                if ((PurchPriceWorksheet."Starting Date" <> 0D) and (PurchPriceWorksheet."Ending Date" <> 0D)) then begin
                                    if ((PurchPriceWorksheet."Starting Date" <= PurHeader."Document Date") and (PurchPriceWorksheet."Ending Date" >= PurHeader."Document Date")) then begin
                                        ConPODetailLine."Net Cost" := PurchPriceWorksheet."Net Price";
                                        //ConPODetailLine.MODIFY(TRUE);
                                    end;
                                end else
                                    if PurchPriceWorksheet."Ending Date" = 0D then begin
                                        if PurchPriceWorksheet."Starting Date" <= PurHeader."Document Date" then begin
                                            ConPODetailLine."Net Cost" := PurchPriceWorksheet."Net Price";
                                            //ConPODetailLine.MODIFY(TRUE);
                                        end;
                                    end;
                            end;

                        until PurchPriceWorksheet.Next = 0;
                end;

                ConPODetailLine."Line Discount %" := PurchLine."Line Discount %";
                ConPODetailLine."Line Discount Amount" := PurchLine."Line Discount Amount";


                //for direct unit cost
                if PurchLine."Direct Unit Cost" > 0 then begin
                    ConPODetailLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                end else begin
                    PurchPriceWorksheet.Reset;
                    PurchPriceWorksheet.SetRange("Vendor No.", Rec."Vendor No.");
                    PurchPriceWorksheet.SetRange("Item No.", PurchLine."No.");
                    PurchPriceWorksheet.SetRange("Unit of Measure Code", PurchLine."Unit of Measure Code");
                    if PurchPriceWorksheet.FindFirst then begin
                        ConPODetailLine."Direct Unit Cost Excl. VAT" := PurchPriceWorksheet."Direct Unit Cost";
                    end;
                end;

                ConPODetailLine."Line Amount Excl. VAT" := PurchLine."Line Amount";

                Vend.Reset;
                Vend.SetRange("No.", ConPODetailLine."Vendor No.");
                if Vend.FindFirst then begin
                    ConPODetailLine."Vendor Name" := Vend.Name;
                end;


                ConPODetailLine."Unit of Measure Code" := PurchLine."Unit of Measure Code";
                ItemUOM.Reset;
                ItemUOM.SetRange("Item No.", ConPODetailLine."Item No.");
                ItemUOM.SetRange(Code, ConPODetailLine."Unit of Measure Code");
                if ItemUOM.FindSet then
                    repeat
                        ConPODetailLine."Qty per UOM" := ItemUOM."Qty. per Unit of Measure";
                    until ItemUOM.Next = 0;

                ConPODetailLine."Sum of Qty" += ConPODetailLine.Quantity * ConPODetailLine."Qty per UOM";
                ConPODetailLine."Child PO No." := PurchHeader."FOC PO No.";
                if ConPODetailLine."Child PO No." <> '' then begin
                    ConPODetailLine."Child PO No. Update" := true;
                end
                else begin
                    ConPODetailLine."Child PO No. Update" := false;
                end;

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPODetailLine."Item No.");
                ConPODetailLine.SetRange("PO No.", ConPODetailLine."PO No.");
                ConPODetailLine.SetRange("Vendor No.", ConPODetailLine."Vendor No.");
                ConPODetailLine.SetRange("Document No.", ConPODetailLine."Document No.");
                ConPODetailLine.SetRange("Line Discount Amount", ConPODetailLine."Line Discount Amount");
                ConPODetailLine.SetRange("Location Code", ConPODetailLine."Location Code");
                ConPODetailLine.SetRange("Direct Unit Cost Excl. VAT", ConPODetailLine."Direct Unit Cost Excl. VAT");
                ConPODetailLine.SetRange(Quantity, ConPODetailLine.Quantity);
                ConPODetailLine.SetRange("Unit of Measure Code", ConPODetailLine."Unit of Measure Code");
                if ConPODetailLine.FindSet then
                    repeat
                        ConPODetailLine.Delete;
                    until ConPODetailLine.Next = 0;

                ConPODetailLine.Insert;
                MaxUOMFunction(ConPOLine);
                AddUOM_CalcQty;

            until PurchLine.Next = 0;
        ConPOLine.Modify(true);


    end;

    local procedure MaxUOMFunction(Con_POLine: Record "Consolidate Purchase Line")
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        CalcSUM: Decimal;
        QTYSUM1: Decimal;
        QTYSUM2: Integer;
        NewConPODeatilLine: Record "Consolidate PO Detail Line";
    begin


        if ConPOLine.FindSet then //Need?
            repeat

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Document No.", ConPOLine."Document No.");
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                if ConPOLine."Location Code" <> '' then
                    ConPODetailLine.SetRange("Location Code", ConPOLine."Location Code");
                ConPODetailLine.SetCurrentKey("Qty per UOM");
                if ConPODetailLine.Find('+') then begin

                    ConPODetailLine.MaxUOM := true;
                    ConPODetailLine.Modify;

                end; //IF ConPODetailLine.FIND ('+') THEN


            until ConPOLine.Next = 0; //IF ConPOLine.FINDSET THEN

    end;

    local procedure AddUOM_CalcQty()
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        CalcSUM: Decimal;
        QTYSUM1: Decimal;
        QTYSUM2: Integer;
        NewConPODeatilLine: Record "Consolidate PO Detail Line";
    begin

        QTYSUM1 := 0;
        //........................................... Add UOM and Quantity ........................................................................
        // Consolidate Purchase Order Count >1
        if ConPOLine.FindSet then //need?
            repeat

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                ConPODetailLine.SetRange("Document No.", ConPOLine."Document No.");
                if ConPOLine."Location Code" <> '' then
                    ConPODetailLine.SetRange("Location Code", ConPOLine."Location Code");
                if ConPODetailLine.FindSet then
                    repeat
                        if ConPODetailLine.Count >= 1 then begin

                            ConPODetailLine.CalcSums("Sum of Qty");
                            QTYSUM1 := ConPODetailLine."Sum of Qty";

                            if ConPODetailLine.MaxUOM = true then begin
                                ConPOLine."Unit of Measure Code" := ConPODetailLine."Unit of Measure Code";
                                ConPOLine.MaxQtyperUOM := ConPODetailLine."Qty per UOM";
                                ConPOLine.Quantity := QTYSUM1 / ConPOLine.MaxQtyperUOM;
                                ConPOLine."Direct Unit Cost Excl. VAT" := ConPODetailLine."Direct Unit Cost Excl. VAT";
                                ConPOLine."Line Amount Excl. VAT" := (ConPOLine.Quantity * ConPOLine."Direct Unit Cost Excl. VAT") - ConPOLine."Total Discount Amt";
                                ConPOLine.Modify(true);
                            end;

                        end;  //IF ConPODetailLine.COUNT > 1 THEN

                    until ConPODetailLine.Next = 0; //IF ConPODetailLine.FINDSET THEN

            until ConPOLine.Next() = 0;
    end;

    local procedure InsertConPOLinesLocDateBlank()
    var
        PurchLine: Record "Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
        MaxValue: Code[10];
        LineNo: Integer;
        LocCodeL: Code[200];
        ConPOHeaderL: Record "Consolidate Purchase Header";
        LineNoMsgL: Text;
        StoreNoMsgL: Text;
        ProgressBarL: Text;
        DialogBoxL: Dialog;
        NoOfRecordL: Integer;
        NextL: Integer;
        Dec: Decimal;
    begin

        PurchLine.Reset;
        PurchLine.SetRange("Buy-from Vendor No.", ConPOLine."Vendor No.");
        PurchLine.SetRange("Document No.", ConPOLine."PO No.");
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetFilter("Location Code", Rec."Location Code");
        if PurchLine.FindSet then
            repeat
                LineNo := 1000;

                ConPODetailLine.Reset;
                if ConPODetailLine.FindLast then begin
                    LineNo := ConPODetailLine."Line No." + 1000;
                end;

                ConPODetailLine.Init;
                ConPODetailLine."PO No." := PurchLine."Document No.";
                ConPODetailLine."Document Type" := 'Order';
                ConPODetailLine."Vendor No." := PurchLine."Buy-from Vendor No.";
                ConPODetailLine."Line No." := LineNo;
                ConPODetailLine.Type := 'Item';
                ConPODetailLine."Item No." := PurchLine."No.";
                ConPODetailLine.Scheme := PurchLine.Scheme;
                ConPODetailLine."Document No." := ConPOLine."Document No.";
                ConPODetailLine.Description := PurchLine.Description;
                ConPODetailLine."Location Code" := PurchLine."Location Code";
                ConPODetailLine.Quantity := PurchLine.Quantity;
                ConPODetailLine."Net Cost" := PurchLine."Net Price";
                ConPODetailLine."Line Discount %" := PurchLine."Line Discount %";
                ConPODetailLine."Line Discount Amount" := PurchLine."Line Discount Amount";
                ConPODetailLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                ConPODetailLine."Line Amount Excl. VAT" := PurchLine."Line Amount";
                ConPODetailLine."Cross-Reference No." := PurchLine."Item Reference No."; //Modified Date 4-Sep-2023

                Vend.Reset;
                Vend.SetRange("No.", ConPODetailLine."Vendor No.");
                if Vend.FindFirst then begin
                    ConPODetailLine."Vendor Name" := Vend.Name;
                end;


                ConPODetailLine."Unit of Measure Code" := PurchLine."Unit of Measure Code";
                ItemUOM.Reset;
                ItemUOM.SetRange("Item No.", ConPODetailLine."Item No.");
                ItemUOM.SetRange(Code, ConPODetailLine."Unit of Measure Code");
                if ItemUOM.FindSet then
                    repeat
                        ConPODetailLine."Qty per UOM" := ItemUOM."Qty. per Unit of Measure";
                    until ItemUOM.Next = 0;

                ConPODetailLine."Sum of Qty" += ConPODetailLine.Quantity * ConPODetailLine."Qty per UOM";
                ConPODetailLine."Child PO No." := PurchHeader."FOC PO No.";
                if ConPODetailLine."Child PO No." <> '' then begin
                    ConPODetailLine."Child PO No. Update" := true;
                end
                else begin
                    ConPODetailLine."Child PO No. Update" := false;
                end;

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPODetailLine."Item No.");
                ConPODetailLine.SetRange("PO No.", ConPODetailLine."PO No.");
                ConPODetailLine.SetRange("Vendor No.", ConPODetailLine."Vendor No.");
                ConPODetailLine.SetRange("Document No.", ConPODetailLine."Document No.");
                ConPODetailLine.SetRange("Line Discount Amount", ConPODetailLine."Line Discount Amount");
                ConPODetailLine.SetRange("Location Code", ConPODetailLine."Location Code");
                ConPODetailLine.SetRange("Direct Unit Cost Excl. VAT", ConPODetailLine."Direct Unit Cost Excl. VAT");
                ConPODetailLine.SetRange(Quantity, ConPODetailLine.Quantity);
                ConPODetailLine.SetRange("Unit of Measure Code", ConPODetailLine."Unit of Measure Code");
                if ConPODetailLine.FindSet then
                    repeat
                        ConPODetailLine.Delete;
                    until ConPODetailLine.Next = 0;

                ConPODetailLine.Insert;
                MaxUOMFunctionDateBlank(ConPOLine);
                AddUOM_CalcQtyDateBlank;

            until PurchLine.Next = 0;
    end;

    local procedure MaxUOMFunctionDateBlank(Con_POLine: Record "Consolidate Purchase Line")
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        CalcSUM: Decimal;
        QTYSUM1: Decimal;
        QTYSUM2: Integer;
        NewConPODeatilLine: Record "Consolidate PO Detail Line";
    begin


        if ConPOLine.FindSet then
            repeat

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Document No.", ConPOLine."Document No.");
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                if ConPOLine."Location Code" <> '' then
                    ConPODetailLine.SetRange("Location Code", ConPOLine."Location Code");

                ConPODetailLine.SetCurrentKey("Qty per UOM");
                if ConPODetailLine.Find('+') then begin

                    ConPODetailLine.MaxUOM := true;
                    ConPODetailLine.Modify;

                end; //IF ConPODetailLine.FIND ('+') THEN



            until ConPOLine.Next = 0; //IF ConPOLine.FINDSET THEN

    end;

    local procedure AddUOM_CalcQtyDateBlank()
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        CalcSUM: Decimal;
        QTYSUM1: Decimal;
        QTYSUM2: Integer;
        NewConPODeatilLine: Record "Consolidate PO Detail Line";
    begin

        QTYSUM1 := 0;
        //........................................... Add UOM and Quantity ........................................................................
        // Consolidate Purchase Order Count >1
        ConPOLine.Reset();
        if ConPOLine.FindSet then
            repeat

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                ConPODetailLine.SetRange("Document No.", ConPOLine."Document No.");
                if ConPODetailLine."Location Code" <> '' then
                    ConPODetailLine.SetRange("Location Code", ConPOLine."Location Code");
                if ConPODetailLine.FindSet then
                    repeat
                        if ConPODetailLine.Count >= 1 then begin

                            ConPODetailLine.CalcSums("Sum of Qty");
                            QTYSUM1 := ConPODetailLine."Sum of Qty";

                            if ConPODetailLine.MaxUOM = true then begin
                                ConPOLine."Unit of Measure Code" := ConPODetailLine."Unit of Measure Code";
                                ConPOLine.MaxQtyperUOM := ConPODetailLine."Qty per UOM";
                                ConPOLine.Quantity := QTYSUM1 / ConPOLine.MaxQtyperUOM;
                                ConPOLine."Direct Unit Cost Excl. VAT" := ConPODetailLine."Direct Unit Cost Excl. VAT";
                                ConPOLine."Line Amount Excl. VAT" := (ConPOLine.Quantity * ConPOLine."Direct Unit Cost Excl. VAT") - ConPOLine."Total Discount Amt";
                                ConPOLine.Modify(true);
                            end;

                        end;  //IF ConPODetailLine.COUNT > 1 THEN

                    until ConPODetailLine.Next = 0; //IF ConPODetailLine.FINDSET THEN


            until ConPOLine.Next = 0; //IF ConPOLine.FINDSET THEN
    end; //IF "Location Code" <> '' THEN


    local procedure CPOCheck(var SelectionPO: Text; var CPONo: Code[10])
    begin
        PurchHeader.Reset;
        PurchHeader.SetFilter("No.", SelectionPO);
        if PurchHeader.FindSet then
            repeat
                PurchHeader."CPO No." := CPONo;
                PurchHeader.Modify(true);
            until PurchHeader.Next = 0;
    end;

    local procedure NetCostSummary()
    var
        NetCostDiff: Boolean;
        TempNetCost: Decimal;
        TotalNetCost: Decimal;
        UOMDiff: Boolean;
        TempUOM: Text;
        LoopCount: Integer;
        DirectUnitCost: Decimal;
        DirectUnitCostDiff: Boolean;
        TempDirectUnitCost: Decimal;
    begin

        TempNetCost := 0;
        TempDirectUnitCost := 0;
        TempUOM := '';
        UOMDiff := false;
        NetCostDiff := false;
        DirectUnitCostDiff := false;
        TotalNetCost := 0;
        DirectUnitCost := 0;
        LoopCount := 0;


        ConPOLine.Reset;
        ConPOLine.SetRange("Document No.", Rec."Document No.");
        if ConPOLine.FindSet then
            repeat
                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Document No.", Rec."Document No.");
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                if ConPODetailLine.FindSet then
                    repeat
                        LoopCount += 1;
                        if (TempUOM = ConPODetailLine."Unit of Measure Code") or (LoopCount = 1) then begin
                            //Same UOM
                        end else
                            UOMDiff := true;

                        if (TempNetCost = ConPODetailLine."Net Cost") or (LoopCount = 1) then begin
                            //TotalNetCost += ConPODetailLine."Net Cost";
                            TotalNetCost := ConPODetailLine."Net Cost";
                        end else begin
                            TotalNetCost := 0;
                            //ConPODetailLine.NEXT := 0;
                            NetCostDiff := true;
                        end;

                        if (TempDirectUnitCost = ConPODetailLine."Direct Unit Cost Excl. VAT") or (LoopCount = 1) then begin
                            DirectUnitCost := ConPODetailLine."Direct Unit Cost Excl. VAT";
                        end else begin
                            DirectUnitCost := 0;
                            DirectUnitCostDiff := true;
                        end;
                        TempNetCost := ConPODetailLine."Net Cost";
                        TempUOM := ConPODetailLine."Unit of Measure Code";
                        TempDirectUnitCost := ConPODetailLine."Direct Unit Cost Excl. VAT";

                    until ConPODetailLine.Next = 0;

                // if (NetCostDiff = true) or (UOMDiff = true) then
                //     ConPOLine."Net Cost Price" := 0
                // else
                //     ConPOLine."Net Cost Price" := TotalNetCost;


                // if (DirectUnitCostDiff = true) or (UOMDiff = true) then begin
                //     ConPOLine."Direct Unit Cost Excl. VAT" := 0;
                //     ConPOLine."Total Discount Amt" := 0;
                //     ConPOLine."Line Amount Excl. VAT" := 0;
                // end
                // else
                //     ConPOLine."Direct Unit Cost Excl. VAT" := DirectUnitCost;


                ConPOLine.Modify(true);
            until ConPOLine.Next = 0;


    end;

    local procedure DirectUnitCostSummary()
    var
        UnitCostDiff: Boolean;
        TempUnitCost: Decimal;
        TotalUnitCost: Decimal;
    begin
        ConPOLine.Reset;
        ConPOLine.SetRange("Document No.", Rec."Document No.");
        if ConPOLine.FindSet then
            repeat
                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Document No.", Rec."Document No.");
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                ConPODetailLine.SetRange("Unit of Measure Code", ConPOLine."Unit of Measure Code");
                TempUnitCost := 0;
                TotalUnitCost := 0;
                if ConPODetailLine.FindSet then
                    repeat
                        if (TempUnitCost = ConPODetailLine."Direct Unit Cost Excl. VAT") or (TempUnitCost = 0) then begin
                            //TotalNetCost += ConPODetailLine."Net Cost";
                            TotalUnitCost := ConPODetailLine."Direct Unit Cost Excl. VAT";
                        end else begin
                            TotalUnitCost := 0;
                            ConPODetailLine.Next := 0;
                        end;
                        TempUnitCost := ConPODetailLine."Direct Unit Cost Excl. VAT";
                    until ConPODetailLine.Next = 0;
                ConPOLine."Direct Unit Cost Excl. VAT" := TotalUnitCost;
                ConPOLine.Modify(true);
            until ConPOLine.Next = 0;


    end;
}

