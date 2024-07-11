codeunit 70000 StandardCodeunitsExt                 //Created By MK
{
    EventSubscriberInstance = StaticAutomatic;

    //@@@@ For Gen.Jnl.Check Line 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", OnBeforeCheckAccountNo, '', true, false)]
    // procedure FixCheckBalAccountNo(GenJnlLine: Record "Gen. Journal Line")
    // var
    //     ICPartner: Record "IC Partner";
    //     CheckDone: Boolean;
    // begin
    //     with GenJnlLine do
    //         case "Bal. Account Type" of
    //             "Bal. Account Type"::"G/L Account":
    //                 begin
    //                     if (("Bal. Gen. Bus. Posting Group" <> '') or ("Bal. Gen. Prod. Posting Group" <> '') or
    //                         ("Bal. VAT Bus. Posting Group" <> '') or ("Bal. VAT Prod. Posting Group" <> '')) and
    //                        not ApplicationAreaMgmt.IsSalesTaxEnabled()
    //                     then
    //                         TestField("Bal. Gen. Posting Type", ErrorInfo.Create());

    //                     CheckBalGenProdPostingGroupWhenAdjustForPmtDisc(GenJnlLine);

    //                     if ("Bal. Gen. Posting Type" <> "Bal. Gen. Posting Type"::" ") and
    //                        ("VAT Posting" = "VAT Posting"::"Automatic VAT Entry")
    //                     then begin
    //                         if "Bal. VAT Amount" + "Bal. VAT Base Amount" <> -Amount then
    //                             Error(
    //                                 ErrorInfo.Create(
    //                                     StrSubstNo(
    //                                         Text006, FieldCaption("Bal. VAT Amount"), FieldCaption("Bal. VAT Base Amount"),
    //                                         FieldCaption(Amount)),
    //                                     true,
    //                                     GenJnlLine,
    //                                     FieldNo("Bal. VAT Amount")));
    //                         if "Currency Code" <> '' then
    //                             if "Bal. VAT Amount (LCY)" + "Bal. VAT Base Amount (LCY)" <> -"Amount (LCY)" then
    //                                 Error(
    //                                     ErrorInfo.Create(
    //                                         StrSubstNo(
    //                                             Text006, FieldCaption("Bal. VAT Amount (LCY)"),
    //                                             FieldCaption("Bal. VAT Base Amount (LCY)"), FieldCaption("Amount (LCY)")),
    //                                                             true,
    //                                     GenJnlLine,
    //                                     FieldNo("Bal. VAT Amount (LCY)")));
    //                     end;
    //                 end;
    //             "Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::Employee:
    //                 begin
    //                     TestField("Bal. Gen. Posting Type", 0, ErrorInfo.Create());
    //                     TestField("Bal. Gen. Bus. Posting Group", '', ErrorInfo.Create());
    //                     TestField("Bal. Gen. Prod. Posting Group", '', ErrorInfo.Create());
    //                     TestField("Bal. VAT Bus. Posting Group", '', ErrorInfo.Create());
    //                     TestField("Bal. VAT Prod. Posting Group", '', ErrorInfo.Create());

    //                     CheckBalAccountType(GenJnlLine);

    //                     CheckBalDocType(GenJnlLine);

    //                     if ((Amount > 0) xor ("Sales/Purch. (LCY)" < 0)) and (Amount <> 0) and ("Sales/Purch. (LCY)" <> 0) then
    //                         FieldError("Sales/Purch. (LCY)", ErrorInfo.Create(StrSubstNo(Text009, FieldCaption(Amount)), true));
    //                     CheckJobNoIsEmpty(GenJnlLine);

    //                     CheckICPartner("Bal. Account Type", "Bal. Account No.", "Document Type", GenJnlLine);
    //                 end;
    //             "Bal. Account Type"::"Bank Account":
    //                 begin
    //                     TestField("Bal. Gen. Posting Type", 0, ErrorInfo.Create());
    //                     TestField("Bal. Gen. Bus. Posting Group", '', ErrorInfo.Create());
    //                     TestField("Bal. Gen. Prod. Posting Group", '', ErrorInfo.Create());
    //                     TestField("Bal. VAT Bus. Posting Group", '', ErrorInfo.Create());
    //                     TestField("Bal. VAT Prod. Posting Group", '', ErrorInfo.Create());
    //                     if (Amount > 0) and ("Bank Payment Type" = "Bank Payment Type"::"Computer Check") then
    //                         TestField("Check Printed", true, ErrorInfo.Create());
    //                     CheckElectronicPaymentFields(GenJnlLine);
    //                 end;
    //             "Bal. Account Type"::"IC Partner":
    //                 begin
    //                     ICPartner.Get("Bal. Account No.");
    //                     ICPartner.CheckICPartner();
    //                     if GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany then
    //                         FieldError("Bal. Account Type", ErrorInfo.Create());
    //                 end;
    //         end;


    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", OnCheckSalesDocNoIsNotUsedOnAfterSetFilters, '', false, false)]
    procedure FixCheckSalesDocNoIsNotUsed()
    var
        IsHandle: Boolean;
        OldCustLedgEntry: Record "Cust. Ledger Entry";
        test: Interface "Allocate Reservation";
    begin
        IsHandle := true;
        IF OldCustLedgEntry.FindFirst() then;
        if IsHandle then
            exit;

    end;
    //@@@@ For Gen.Jnl.Check Line

    //------------------------------------------------------------------------------------------------------------------------

    //@@@@ For Sales Post Codeunit 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnInsertShipmentLineOnAfterInitQuantityFields, '', false, false)]
    procedure OnInsertShipmentLineOnAfterInitQuantityFields(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesShptLine."Variant Code" := SalesLine."Variant Code";
        //SalesShptLine."Variant Descriptions" := SalesLine."Variant Descriptions";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeReturnRcptLineInsert, '', false, false)]
    procedure OnBeforeReturnRcptLineInsert(var ReturnRcptLine: Record "Return Receipt Line"; ReturnRcptHeader: Record "Return Receipt Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; xSalesLine: record "Sales Line"; var TempSalesLineGlobal: record "Sales Line" temporary; var SalesHeader: Record "Sales Header")
    begin
        ReturnRcptLine."Variant Code" := SalesLine."Variant Code";
        //ReturnRcptLine."Variant Descriptions" := SalesLine."Variant Descriptions";
    end;

    //@@@@ For Sales Post Codeunit

    //------------------------------------------------------------------------------------------------------------------------

    //@@@@ For Purch Post Codeunit
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePurchInvLineInsert, '', false, false)]
    procedure OnBeforePurchInvLineInsert(var PurchInvLine: Record "Purch. Inv. Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var xPurchaseLine: Record "Purchase Line")
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        if PurchInvLine."Order No." = PurchRcptLine."Order No." then begin
            PurchInvLine."Variant Code" := PurchRcptLine."Variant Code";
            // PurchInvLine."Variant Descriptions" := PurchRcptLine."Variant Descriptions"
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePurchRcptHeaderInsert, '', false, false)]
    procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        if (PurchRcptHeader."Order No. Series" = PurchaseHeader."No. Series") and (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) then begin
            PurchRcptHeader."Child PO No." := PurchaseHeader."FOC PO No."
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnInsertReceiptLineOnAfterInitPurchRcptLine, '', false, false)]
    procedure OnInsertReceiptLineOnAfterInitPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; xPurchLine: Record "Purchase Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var CostBaseAmount: Decimal; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header"; WhseRcptHeader: Record "Warehouse Receipt Header"; var WhseRcptLine: Record "Warehouse Receipt Line")
    begin
        PurchRcptLine."Variant Code" := PurchLine."Variant Code";
        //PurchRcptLine."Variant Descriptions" := PurchLine."Variant Descriptions";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeReturnShptHeaderInsert, '', false, false)]
    procedure OnBeforeReturnShptHeaderInsert(var ReturnShptHeader: Record "Return Shipment Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order" then
            ReturnShptHeader."Return Order No." := PurchHeader."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnInsertReturnShipmentLineOnAfterReturnShptLineInit, '', false, false)]
    procedure OnInsertReturnShipmentLineOnAfterReturnShptLineInit(var ReturnShptHeader: Record "Return Shipment Header"; var ReturnShptLine: Record "Return Shipment Line"; var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; var CostBaseAmount: Decimal; WhseShip: Boolean; WhseReceive: Boolean)
    begin
        ReturnShptLine."Variant Code" := PurchLine."Variant Code";
        //ReturnShptLine."Variant Descriptions" := ReturnShptLine."Variant Descriptions";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePurchInvHeaderInsert, '', false, false)]
    procedure OnBeforePurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then begin
            PurchInvHeader."Child PO No." := PurchHeader."FOC PO No.";
        end;
    end;

    //@@@@ For Purch Post Codeunit

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC Replen. Create Transf. Ord", OnBeforeInsertTransferHeaderTEMP, '', false, false)]
    procedure OnBeforeInsertTransferHeaderTEMP(var TransferHeaderTEMP: Record "Transfer Header" temporary; var RepJrnlLines: Record "LSC Replen. Journal Lines")
    begin
        TransferHeaderTEMP."Transfer From" := TransferHeaderTEMP."Transfer From"::"Transfer to TO"; //ModifiedBy NWMM(CCW) 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC Replen. Create Purch Order", OnInsertQtyForTransferOnBeforeModifyTransferHeader, '', false, false)]
    procedure OnInsertQtyForTransferOnBeforeModifyTransferHeader(PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; var TransferHeader: Record "Transfer Header")
    begin
        TransferHeader."Transfer From" := TransferHeader."Transfer From"::"Purchase to TO";  //ModifiedBy NWMM(CCW) 
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC Replen. Create Transf. Ord", OnCreateTransfOrdersOnBeforeModifyTransferHeader, '', false, false)]
    procedure OnCreateTransfOrdersOnBeforeModifyTransferHeader(ReplenTemplate: Record "LSC Replen. Template"; var ReplenJournalLines: Record "LSC Replen. Journal Lines"; ReplenJrnlDetails: Record "LSC Replen. Jrnl. Details"; var TransferHeader: Record "Transfer Header"; TransferHeaderTEMP: Record "Transfer Header" temporary)
    begin
        TransferHeader."Transfer From" := TransferHeader."Transfer From"::"Transfer to TO";  //ModifiedBy NWMM(CCW) 
    end;


    //-------------------------------------------------------------------------------------------------------------------------

    //@@@@ For Whse-Post Shipment
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforePostedWhseShptHeaderInsert, '', false, false)]
    procedure OnBeforePostedWhseShptHeaderInsert(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        PostedWhseShipmentHeader."Route No." := WarehouseShipmentHeader."Route No.";
        PostedWhseShipmentHeader."Sequence No." := WarehouseShipmentHeader."Sequence No.";
        PostedWhseShipmentHeader."Expected Arrival" := WarehouseShipmentHeader."Expected Arrival";
        PostedWhseShipmentHeader."Unloading Time" := WarehouseShipmentHeader."Unloading Time";
        PostedWhseShipmentHeader."Actual Arrival Time" := WarehouseShipmentHeader."Actual Arrival Time";
        PostedWhseShipmentHeader."Number of Container" := WarehouseShipmentHeader."Number of Container";
        PostedWhseShipmentHeader."Number of Bult Units" := WarehouseShipmentHeader."Number of Bult Units";
        PostedWhseShipmentHeader."Truck ID" := WarehouseShipmentHeader."Truck ID";
        PostedWhseShipmentHeader."Trailer ID" := WarehouseShipmentHeader."Trailer ID";
        PostedWhseShipmentHeader.Driver := WarehouseShipmentHeader.Driver;
        PostedWhseShipmentHeader."Service Provider" := WarehouseShipmentHeader."Service Provider";
        PostedWhseShipmentHeader."Expected Start Time" := WarehouseShipmentHeader."Expected Start Time";
        PostedWhseShipmentHeader."Expected Return Time" := WarehouseShipmentHeader."Expected Return Time";
        PostedWhseShipmentHeader."Dock/Bay Lane Number" := WarehouseShipmentHeader."Dock/Bay Lane Number";
        PostedWhseShipmentHeader.Priority := WarehouseShipmentHeader.Priority;
    end;
    //@@@@ For Whse-Post Shipment

    //-------------------------------------------------------------------------------------------------------------------------

    //@@@@ For Whse Create Source Document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine, '', false, false)]
    procedure OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; PurchaseLine: Record "Purchase Line")
    begin
        WarehouseReceiptLine.Remark := PurchaseLine.Remark;
        WarehouseReceiptLine."Cross-Reference No." := PurchaseLine."Item Reference No.";
    end;

    //@@@@ For Whse Post Receipt
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnBeforePostedWhseRcptLineInsert, '', false, false)]
    procedure OnBeforePostedWhseRcptLineInsert(var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line")
    begin
        PostedWhseReceiptLine.Remark := WarehouseReceiptLine.Remark;
    end;
    //CodeUnit 7313
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnCreateNewWhseActivityOnAfterAssignBinZone, '', false, false)]
    // procedure OnCreateNewWhseActivityOnAfterAssignBinZone(var WhseActivLine: Record "Warehouse Activity Line")//WhseActivLine  WarehouseActivityLine
    // var
    //     PostWhseReceiptLine: Record "Posted Whse. Receipt Line";
    // begin
    //     PostWhseReceiptLine.Reset();
    //     PostWhseReceiptLine.SetRange("Source No.", WhseActivLine."Source No.");
    //     if PostWhseReceiptLine.FindFirst() then
    //         repeat
    //             WhseActivLine.Remark := PostWhseReceiptLine.Remark; //Modifiedby NWMM
    //         until PostWhseReceiptLine.Next() = 0;

    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnBeforeWhseActivLineInsert, '', false, false)]
    procedure OnBeforeWhseActivLineInsert(VAR WarehouseActivityLine: Record "Warehouse Activity Line"; PostedWhseRcptLine: Record "Posted Whse. Receipt Line")
    var
    begin
        //Message('PostedWhseRcptLine Remark is %1', PostedWhseRcptLine.Remark);
        WarehouseActivityLine.Remark := PostedWhseRcptLine.Remark; //Modifiedby NWMM

    end;
    //CodeUnit 7307
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeRegisteredWhseActivLineInsert, '', false, false)]
    procedure CreateRegActivLineNwmm(var RegisteredWhseActivityLine: Record "Registered Whse. Activity Line"; WarehouseActivityLine: Record "Warehouse Activity Line")

    begin
        RegisteredWhseActivityLine.Remark := WarehouseActivityLine.Remark; //Modifiedby NWMM
    end;
    //CodeUnit 7311
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Worksheet-Create", OnAfterFromWhseRcptLineCreateWhseWkshLine, '', false, false)]
    procedure OnAfterFromWhseRcptLineCreateWhseWkshLine(var WhseWorksheetLine: Record "Whse. Worksheet Line"; PostedWhseReceiptLine: Record "Posted Whse. Receipt Line")

    begin
        WhseWorksheetLine.Remark := PostedWhseReceiptLine.Remark; //Modifiedby NWMM
    end;


    //@@@@ For LSC Product Ext
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC Product Ext.", OnBeforeCalculatePrices, '', false, false)]
    procedure CalculatePrices(var SalesPrice: Record "Sales Price"; var Item: Record Item; var CalledByFieldNo: Integer; var IsHandled: Boolean)
    var
        Price: Decimal;
        CurrencyFactor: Decimal;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        VATPostingSetup: Record "VAT Posting Setup";
        AmountRounding: Codeunit "LSC Helper";
        //SalesPrice: Record "Sales Price";
        //IsHandled: Boolean;
        Text1000700: Label 'Closing date must be later then starting date';
        Text1000701: Label 'Prices including VAT cannot be calculated when ';
        Text1000702: Label '%1 is %2.';
    begin

        case Item."Price/Profit Calculation" of
            Item."Price/Profit Calculation"::"Profit=Price-Cost":
                begin
                    if SalesPrice."Price Includes VAT" then
                        //SalesPrice."Unit Price" := AmountRounding.InvoiceRound(SalesPrice."Currency Code", SalesPrice."Unit Price")
                        SalesPrice."Unit Price" := SalesPrice."Unit Price"
                    else
                        //SalesPrice."Unit Price" := AmountRounding.UnitAmountRound(SalesPrice."Currency Code", SalesPrice."Unit Price");
                        SalesPrice."Unit Price" := SalesPrice."Unit Price";

                    if SalesPrice."Price Includes VAT" then begin
                        VATPostingSetup.Get(SalesPrice."VAT Bus. Posting Gr. (Price)", Item."VAT Prod. Posting Group");
                        case VATPostingSetup."VAT Calculation Type" of
                            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                VATPostingSetup."VAT %" := 0;
                            VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                Error(Text1000701 +
                                      Text1000702, VATPostingSetup.FieldCaption("VAT Calculation Type"),
                                      VATPostingSetup."VAT Calculation Type");
                        end;  //Case
                        Price := SalesPrice."Unit Price" / (1 + VATPostingSetup."VAT %" / 100);
                    end
                    else
                        Price := SalesPrice."Unit Price";

                    if SalesPrice."Unit of Measure Code" <> '' then begin
                        ItemUnitofMeasure.Get(SalesPrice."Item No.", SalesPrice."Unit of Measure Code");
                        if ItemUnitofMeasure."Qty. per Unit of Measure" <> 0 then
                            Price := Price / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end;

                    if SalesPrice."Currency Code" <> '' then begin
                        CurrencyFactor := CurrencyExchangeRate.ExchangeRate(Today(), SalesPrice."Currency Code");
                        Price := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today(), SalesPrice."Currency Code", Price, CurrencyFactor);
                    end;

                    if Item."Unit Cost" <> 0 then
                        SalesPrice."LSC Markup %" := Round((Price / Item."Unit Cost" - 1) * 100, 0.00001)
                    else
                        SalesPrice."LSC Markup %" := 0;

                    if Price <> 0 then begin
                        SalesPrice."LSC Profit %" := Round(100 * (1 - Item."Unit Cost" / Price), 0.00001);
                        SalesPrice."LSC Profit (LCY)" := Round(Price - Item."Unit Cost", 0.01);
                    end
                    else begin
                        SalesPrice."LSC Profit %" := 0;
                        SalesPrice."LSC Profit (LCY)" := 0;
                    end;
                end;

            Item."Price/Profit Calculation"::"Price=Cost+Profit":
                begin
                    SalesPrice."LSC Markup %" := Round(Item."Profit %" / (100 - Item."Profit %") * 100, 0.00001);
                    Price := Item."Unit Cost" * (1 + SalesPrice."LSC Markup %" / 100);
                    if Price <> 0 then begin
                        SalesPrice."LSC Profit %" := Round(100 * (1 - Item."Unit Cost" / Price), 0.00001);
                        SalesPrice."LSC Profit (LCY)" := Round(Price - Item."Unit Cost", 0.01);
                    end
                    else begin
                        SalesPrice."LSC Profit %" := 0;
                        SalesPrice."LSC Profit (LCY)" := 0;
                    end;

                    if SalesPrice."Unit of Measure Code" <> '' then begin
                        ItemUnitofMeasure.Get(SalesPrice."Item No.", SalesPrice."Unit of Measure Code");
                        Price := Price * ItemUnitofMeasure."Qty. per Unit of Measure";
                    end;

                    if SalesPrice."Currency Code" <> '' then begin
                        CurrencyFactor := CurrencyExchangeRate.ExchangeRate(Today(), SalesPrice."Currency Code");
                        Price := CurrencyExchangeRate.ExchangeAmtLCYToFCY(Today(), SalesPrice."Currency Code", Price, CurrencyFactor);
                    end;

                    if SalesPrice."Price Includes VAT" then begin
                        VATPostingSetup.Get(SalesPrice."VAT Bus. Posting Gr. (Price)", Item."VAT Prod. Posting Group");
                        case VATPostingSetup."VAT Calculation Type" of
                            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                VATPostingSetup."VAT %" := 0;
                            VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                Error(Text1000701 +
                                      Text1000702, VATPostingSetup.FieldCaption("VAT Calculation Type"),
                                      VATPostingSetup."VAT Calculation Type");
                        end;
                        Price := Price * (1 + VATPostingSetup."VAT %" / 100);
                    end;

                    if SalesPrice."Price Includes VAT" then
                        //SalesPrice."Unit Price" := AmountRounding.InvoiceRound(SalesPrice."Currency Code", Price)
                        SalesPrice."Unit Price" := Price
                    else
                        //SalesPrice."Unit Price" := AmountRounding.UnitAmountRound(SalesPrice."Currency Code", Price);
                        SalesPrice."Unit Price" := Price;
                    CalledByFieldNo := 0;
                end;

            Item."Price/Profit Calculation"::"No Relationship":
                begin
                    if SalesPrice."Price Includes VAT" then
                        //SalesPrice."Unit Price" := AmountRounding.InvoiceRound(SalesPrice."Currency Code", SalesPrice."Unit Price")
                        SalesPrice."Unit Price" := SalesPrice."Unit Price"
                    else
                        //SalesPrice."Unit Price" := AmountRounding.UnitAmountRound(SalesPrice."Currency Code", SalesPrice."Unit Price");
                        SalesPrice."Unit Price" := SalesPrice."Unit Price";

                    if SalesPrice."Price Includes VAT" then begin
                        VATPostingSetup.Get(SalesPrice."VAT Bus. Posting Gr. (Price)", Item."VAT Prod. Posting Group");
                        case VATPostingSetup."VAT Calculation Type" of
                            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                VATPostingSetup."VAT %" := 0;
                            VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                Error(Text1000701 +
                                      Text1000702, VATPostingSetup.FieldCaption("VAT Calculation Type"),
                                      VATPostingSetup."VAT Calculation Type");
                        end;
                        Price := SalesPrice."Unit Price" / (1 + VATPostingSetup."VAT %" / 100);
                    end
                    else
                        Price := SalesPrice."Unit Price";

                    if SalesPrice."Unit of Measure Code" <> '' then begin
                        ItemUnitofMeasure.Get(SalesPrice."Item No.", SalesPrice."Unit of Measure Code");
                        if ItemUnitofMeasure."Qty. per Unit of Measure" <> 0 then
                            Price := Price / ItemUnitofMeasure."Qty. per Unit of Measure";
                    end;
                    if SalesPrice."Currency Code" <> '' then begin
                        CurrencyFactor := CurrencyExchangeRate.ExchangeRate(Today(), SalesPrice."Currency Code");
                        Price := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today(), SalesPrice."Currency Code", Price, CurrencyFactor);
                    end;

                    if Item."Unit Cost" <> 0 then
                        SalesPrice."LSC Markup %" := Round((Price / Item."Unit Cost" - 1) * 100, 0.00001)
                    else
                        SalesPrice."LSC Markup %" := 0;
                end;
        end;  //Case
        IsHandled := true;
    end;
    //@@@@ For LSC Product Ext

    //-------------------------------------------------------------------------------------------------------------------------

    //@@@@ For LSC BO Utils
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC BO Utils", OnIsItemComplex, '', false, false)]
    procedure OnIsItemComplex(Item: Record Item; var IsComplex: Boolean)
    var
        pItemNo: Code[20];
    begin
        IsItemComplexNWMM(pItemNo);
    end;

    local procedure IsItemComplexNWMM(pItemNo: Code[20]): Boolean
    var
        Item: Record Item;
        TableSpecInfocode: Record "LSC Table Specific Infocode";
        POSActions: Record "LSC POS Actions";
        LinkedItem: Record "LSC Linked Item";
        IsComplex, IsHandle : Boolean;
    begin
        if IsComplex then
            exit(true);
        if Item."Assembly BOM" then
            exit(true);
        if Item."Item Tracking Code" <> '' then
            exit(false);            //Fix EXIT(TRUE) to EXIT(FALSE) by NWMM on 18 Nov 2021
        if Item."LSC Scale Item" then
            exit(true);
        if Item."LSC Keying in Price" > 0 then
            exit(true);
        if Item."LSC Keying in Quantity" > 0 then
            exit(true);
        if Item."LSC BOM Type" > 0 then
            exit(true);

        TableSpecInfocode.Reset;
        TableSpecInfocode.SetRange("Table ID", 27);
        TableSpecInfocode.SetRange(Value, pItemNo);
        if not TableSpecInfocode.IsEmpty then
            exit(true);

        POSActions.Reset;
        POSActions.SetRange("Data Trigger", POSActions."Data Trigger"::Item);
        POSActions.SetRange("Data ID", pItemNo);
        if not POSActions.IsEmpty then
            exit(true);

        LinkedItem.Reset;
        LinkedItem.SetRange("Item No.", pItemNo);
        if not LinkedItem.IsEmpty then
            exit(true);

        exit(false);
        IsHandle := true;
        if IsHandle then
            exit;
    end;
    //@@@@ For LSC BO Utils

    //-------------------------------------------------------------------------------------------------------------------------

    //@@@@ For LSC Statement Post 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC Statement-Post", OnBeforeGenJnlPostLine, '', false, false)]
    // procedure OnBeforeGenJnlPostLine(var GenJournalLine: Record "Gen. Journal Line"; var Statement: Record "LSC Statement"; var TransactionHeader: Record "LSC Transaction Header")
    // begin
    //     if TransactionHeader."Trans. Currency" = '' then begin
    //         GenJournalLine."Sales/Purch. (LCY)" := -1 * TransactionHeader."Net Amount";
    //         GenJournalLine."Profit (LCY)" := -1 * (TransactionHeader."Net Amount" - TransactionHeader."Cost Amount");
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Page, Page::"Item Attribute Value List", OnBeforeCheckAttributeName, '', false, false)]
    // procedure NWMM(var ItemAttributeValueSelection: Record "Item Attribute Value Selection"; RelatedRecordCode: Code[20])
    // var
    //     xRec, Rec : Record "Item Attribute Value Selection";
    //     ItemAttributeValue: Record "Item Attribute Value";
    //     ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
    //     ItemAttribute: Record "Item Attribute";
    //     CustomizeFun: Codeunit CustomizeFunctions;
    // begin
    //     if xRec."Attribute Name" <> '' then begin
    //         xRec.FindItemAttributeByName(ItemAttribute);
    //         DeleteItemAttributeValueMapping(ItemAttribute.ID, RelatedRecordCode);
    //     end;

    //     if not Rec.FindAttributeValue(ItemAttributeValue) then
    //         CustomizeFun.InsertItemAttributeValueNWMM(ItemAttributeValue, Rec);

    //     if ItemAttributeValue.Get(ItemAttributeValue."Attribute ID", ItemAttributeValue.ID) then begin
    //         ItemAttributeValueMapping.Reset();
    //         ItemAttributeValueMapping.Init();
    //         ItemAttributeValueMapping."Table ID" := Database::Item;
    //         ItemAttributeValueMapping."No." := RelatedRecordCode;
    //         ItemAttributeValueMapping."Item Attribute ID" := ItemAttributeValue."Attribute ID";
    //         ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
    //         //OnBeforeItemAttributeValueMappingInsert(ItemAttributeValueMapping, ItemAttributeValue, Rec);
    //         ItemAttributeValueMapping.Insert();
    //     end;
    // end;

    // local procedure DeleteItemAttributeValueMapping(AttributeToDeleteID: Integer; RelatedRecordCode: Code[20])
    // var
    //     ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
    //     ItemAttribute: Record "Item Attribute";
    // //RelatedRecordCode: Code[20];
    // begin
    //     ItemAttributeValueMapping.SetRange("Table ID", Database::Item);
    //     ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
    //     ItemAttributeValueMapping.SetRange("Item Attribute ID", AttributeToDeleteID);
    //     if ItemAttributeValueMapping.FindFirst() then begin
    //         ItemAttributeValueMapping.Delete();
    //         //OnAfterItemAttributeValueMappingDelete(AttributeToDeleteID, RelatedRecordCode, Rec);
    //     end;

    //     ItemAttribute.Get(AttributeToDeleteID);
    //     ItemAttribute.RemoveUnusedArbitraryValues();
    // end;


}
