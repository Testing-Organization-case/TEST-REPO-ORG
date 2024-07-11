page 70017 "Consolidate Detail Card"
{
    PageType = Card;
    SourceTable = "Consolidate PO Detail Line";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Line Discount %"; LineDiscG)
                {
                    Caption = 'Line Discount %';
                }
                field("Update Net Cost"; NetCostG)
                {
                    Caption = 'Update Net Cost';
                }
                field(Remark; Remarks)
                {
                }
                field("Update Direct Unit Cost"; UnitPrice)
                {
                }
            }
            part("Consolidate PO Details"; "Consign PO Detail Lines")
            {
                Caption = 'Consolidate PO Details';
                SubPageLink = "Document No." = FIELD("Document No."),
                              "Item No." = FIELD("Item No.");


            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Update Line Discount%")
                {
                    Caption = 'Update Line Discount%';
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PurchaseAttributeListL: Page PurchaseAttributesList;
                    begin

                        ConPODetailLines.Reset;
                        ConPODetailLines.SetRange("Document No.", Rec."Document No.");
                        ConPODetailLines.SetRange("Item No.", Rec."Item No.");
                        if ConPODetailLines.FindSet then
                            repeat

                                ConPODetailLines."Line Discount %" := LineDiscG;
                                ConPODetailLines."Line Discount Amount" := (ConPODetailLines.Quantity * ConPODetailLines."Direct Unit Cost Excl. VAT") * ConPODetailLines."Line Discount %" / 100;
                                ConPODetailLines."Line Amount Excl. VAT" := (ConPODetailLines.Quantity * ConPODetailLines."Direct Unit Cost Excl. VAT") - ConPODetailLines."Line Discount Amount";
                                ConPODetailLines.Modify;

                            until ConPODetailLines.Next = 0; //IF ConPODetailLines.FINDSET THEN

                        Message('Line Discount %1% is successfully applied to all Purchase Lines', LineDiscG);
                    end;
                }
                action("Update Net Cost at CPO Lines")
                {
                    Caption = 'Update Net Cost at CPO Lines';
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PurchaseAttributeListL: Page PurchaseAttributesList;
                    begin

                        ConPODetailLines.Reset;
                        ConPODetailLines.SetRange("Document No.", Rec."Document No.");
                        ConPODetailLines.SetRange("Item No.", Rec."Item No.");
                        if ConPODetailLines.FindSet then
                            repeat

                                ConPODetailLines."Net Cost" := NetCostG;
                                ConPODetailLines.Modify;

                            until ConPODetailLines.Next = 0; //IF ConPODetailLines.FINDSET THEN

                        Message('Net Cost %1 is successfully applied to all CPO Lines', NetCostG);
                    end;
                }
                action("Update Consolidate PO")
                {
                    Caption = 'Update Consolidate PO';
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PurchaseAttributeListL: Page PurchaseAttributesList;
                    begin

                        UpdateConPO;
                    end;
                }
                action("Apply Child PO No.")
                {
                    Caption = 'Apply FOC PO No.';
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Rec.FindSet then
                            repeat
                                if Rec."Child PO No." <> '' then begin

                                    PurHeader.Reset;
                                    PurHeader.SetRange("No.", Rec."PO No.");
                                    if PurHeader.FindSet then
                                        repeat

                                            PurHeader."FOC PO No." := Rec."Child PO No.";
                                            PurHeader.Modify;

                                        until PurHeader.Next = 0; //IF PurHeader.FINDSET THEN

                                end; //IF Rec."Child PO No." <> '' THEN

                            until Rec.Next = 0; //IF Rec.FINDSET THEN

                        Message('FOC PO No. is successfully updated!');
                    end;
                }
                action("Update Remark at CPO Lines")
                {
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        ConPODetailLines.Reset;
                        ConPODetailLines.SetRange("Document No.", Rec."Document No.");
                        ConPODetailLines.SetRange("Item No.", Rec."Item No.");
                        if ConPODetailLines.FindSet then
                            repeat
                                if Remarks <> '' then begin

                                    ConPODetailLines.Remark := Remarks;
                                    ConPODetailLines.Modify;

                                end;  //IF Remarks <> '' THEN

                            until ConPODetailLines.Next = 0; //IF ConPODetailLines.FINDSET THEN

                        Message('Remark %1 is successfully applied to all CPO Lines', Remarks);
                    end;
                }
                action("Update Unit Price at CPO Lines")
                {
                    Caption = 'Update Direct Unit  Cost at CPO Lines';
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        ConPODetailLines.Reset;
                        ConPODetailLines.SetRange("Document No.", Rec."Document No.");
                        ConPODetailLines.SetRange("Item No.", Rec."Item No.");
                        if ConPODetailLines.FindSet then
                            repeat
                                if UnitPrice <> 0 then begin

                                    ConPODetailLines."Direct Unit Cost Excl. VAT" := UnitPrice;
                                    ConPODetailLines."Line Discount Amount" := (ConPODetailLines.Quantity * ConPODetailLines."Direct Unit Cost Excl. VAT") * ConPODetailLines."Line Discount %" / 100;
                                    ConPODetailLines."Line Amount Excl. VAT" := (ConPODetailLines.Quantity * ConPODetailLines."Direct Unit Cost Excl. VAT") - ConPODetailLines."Line Discount Amount";
                                    ConPODetailLines.Modify;

                                end;  //IF UnitPrice <> '' THEN

                            until ConPODetailLines.Next = 0; //IF ConPODetailLines.FINDSET THEN

                        Message('Update Direct Unit Cost %1 is successfully applied to all CPO Lines', UnitPrice);
                    end;
                }
            }
        }
    }

    var
        ConPODetailLines: Record "Consolidate PO Detail Line";
        LineDiscG: Decimal;
        Qty: Decimal;
        TotalDisAmt: Decimal;
        DirectUnitCost: Decimal;
        LineAmtExclVAT: Decimal;
        LineDisc: Decimal;
        DiscG: Decimal;
        DiscountG: Decimal;
        PurHeader: Record "Purchase Header";
        PurPriceR: Record "Purchase Price";
        DirUnitCost: Decimal;
        ConPurLine: Record "Consolidate Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
        LineDiscAmt: Decimal;
        TotalNetPrice: Decimal;
        NetCostG: Decimal;
        Remarks: Text;
        PurchLine: Record "Purchase Line";
        TempRemark: Text;
        UnitPrice: Decimal;

    [Scope('OnPrem')]
    procedure SetDiscValue(Disc: Decimal)
    var
        InventoryBufferR: Record "Inventory Buffer";
    begin

        InventoryBufferR.DeleteAll;
        InventoryBufferR.Init;
        InventoryBufferR.Quantity := Disc;
        InventoryBufferR.Insert;
    end;

    [Scope('OnPrem')]
    procedure GetDisValue() DisVal: Decimal
    var
        InventoryBufferR: Record "Inventory Buffer";
    begin
        if InventoryBufferR.FindFirst then begin
            DisVal := InventoryBufferR.Quantity;
            InventoryBufferR.DeleteAll;
            exit(DisVal);
        end;
    end;

    local procedure UpdateConPO()
    var
        ConPOLine: Record "Consolidate Purchase Line";
        QTYSUM1: Decimal;
        Multi1: Decimal;
        ItemUOM: Record "Item Unit of Measure";
        FromUOMQty: Integer;
        ToUOMQty: Integer;
        PrintQty: Integer;
        ConPODetailLine: Record "Consolidate PO Detail Line";
        LoopCount: Integer;
        TempUOM: Text;
        UOMDiff: Boolean;
        TempNetCost: Decimal;
        SummaryNetCost: Decimal;
        NetCostDiff: Boolean;
        TempDirectUnitCost: Decimal;
        DirectUnitCost: Decimal;
        DirectUnitCostDiff: Boolean;
    begin

        Rec.Reset;
        Rec.SetRange("Vendor No.", Rec."Vendor No.");
        Rec.SetRange("Item No.", Rec."Item No.");
        Rec.SetRange("Document No.", Rec."Document No.");
        if Rec.FindSet then
            repeat

                TotalDisAmt += Rec."Line Discount Amount";
                DirectUnitCost := Rec."Direct Unit Cost Excl. VAT";
                LineAmtExclVAT += Rec."Net Cost";
                LineDiscAmt += Rec."Line Amount Excl. VAT";
                TotalNetPrice += Rec."Net Cost";

                ConPurLine.Reset;
                ConPurLine.SetRange("Document No.", Rec."Document No.");
                ConPurLine.SetRange("Vendor No.", Rec."Vendor No.");
                ConPurLine.SetRange("Item No.", Rec."Item No.");
                if ConPurLine.FindSet then
                    repeat
                    begin

                        ConPurLine.Quantity := 0;
                        ConPurLine.Quantity += Rec.Quantity;
                        ConPurLine."Net Cost Price" := LineAmtExclVAT;
                        ConPurLine."Line Amount Excl. VAT" := LineDiscAmt;
                        ConPurLine."Net Cost Price" := TotalNetPrice;
                        ConPurLine.Remark := Rec.Remark;
                        ConPurLine."Direct Unit Cost Excl. VAT" := Rec."Direct Unit Cost Excl. VAT";
                        ConPurLine.Modify;

                    end;



                    Rec.Reset;
                    Rec.SetRange("Document No.", ConPurLine."Document No.");
                    Rec.SetRange("Vendor No.", ConPurLine."Vendor No.");
                    Rec.SetRange("Item No.", ConPurLine."Item No.");
                    Rec.SetRange("Unit of Measure Code", ConPurLine."Unit of Measure Code");
                    if Rec.FindSet then
                        repeat
                        begin

                            ConPurLine."Direct Unit Cost Excl. VAT" := Rec."Direct Unit Cost Excl. VAT";
                            ConPurLine.Modify;
                        end;
                        until Rec.Next = 0;



                    LoopCount := 0;
                    TempUOM := '';
                    UOMDiff := false;
                    TempNetCost := 0;
                    SummaryNetCost := 0;
                    NetCostDiff := false;
                    TempDirectUnitCost := 0;
                    DirectUnitCost := 0;
                    ConPurLine."Total Discount Amt" := 0;

                    ConPODetailLine.Reset;
                    ConPODetailLine.SetRange("Document No.", ConPurLine."Document No.");
                    ConPODetailLine.SetRange("Vendor No.", ConPurLine."Vendor No.");
                    ConPODetailLine.SetRange("Item No.", ConPurLine."Item No.");
                    if ConPODetailLine.FindSet then
                        repeat

                            ConPurLine."Total Discount Amt" += ConPODetailLine."Line Discount Amount";
                            LoopCount += 1;
                            if (TempUOM = ConPODetailLine."Unit of Measure Code") or (LoopCount = 1) then begin
                                //Same UOM
                            end else
                                UOMDiff := true;

                            if (TempNetCost = ConPODetailLine."Net Cost") or (LoopCount = 1) then begin
                                //SummaryNetCost += ConPODetailLine."Net Cost";
                                SummaryNetCost := ConPODetailLine."Net Cost";
                            end else begin
                                SummaryNetCost := 0;
                                ConPODetailLine.Next := 0;
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

                        until ConPODetailLine.Next = 0; //IF ConPODetailLine.FINDSET THEN

                    if (NetCostDiff = true) or (UOMDiff = true) then
                        ConPurLine."Net Cost Price" := 0
                    else begin

                        ConPurLine."Net Cost Price" := SummaryNetCost;
                        ConPurLine.Modify;

                    end; //IF (NetCostDiff = TRUE) OR (UOMDiff = TRUE) THEN

                    if (DirectUnitCostDiff = true) or (UOMDiff = true) then begin

                        ConPurLine."Direct Unit Cost Excl. VAT" := 0;
                        ConPurLine."Total Discount Amt" := 0;
                        ConPurLine."Line Amount Excl. VAT" := 0;
                        ConPurLine.Modify(true);

                    end
                    else begin

                        ConPurLine."Direct Unit Cost Excl. VAT" := DirectUnitCost;
                        ConPurLine.Modify;

                    end; //IF (DirectUnitCostDiff = TRUE) OR (UOMDiff = TRUE) THEN




                    if Rec.Count > 0 then begin
                        if Rec.MaxUOM = true then begin
                            ConPurLine."Unit of Measure Code" := Rec."Unit of Measure Code";
                            ConPurLine.Modify;
                        end;
                    end
                    else begin
                        ConPurLine."Unit of Measure Code" := Rec."Unit of Measure Code";
                        ConPurLine.Modify;
                    end;


                    until ConPurLine.Next = 0; //IF ConPurLine.FINDSET THEN

            until Rec.Next = 0; //IF Rec.FINDSET THEN



        Qty := 0;
        Rec.Reset;
        Rec.SetRange("Vendor No.", Rec."Vendor No.");
        Rec.SetRange("Item No.", Rec."Item No.");
        Rec.SetRange("Document No.", Rec."Document No.");
        Rec.SetRange(MaxUOM, true);
        if Rec.FindSet then
            repeat

                Multi1 := Rec."Qty per UOM";

            until Rec.Next = 0; //IF Rec.FINDSET THEN

        Rec.Reset;
        Rec.SetRange("Vendor No.", ConPurLine."Vendor No.");
        Rec.SetRange("Item No.", ConPurLine."Item No.");
        Rec.SetRange("Document No.", ConPurLine."Document No.");
        if Rec.FindSet then
            repeat
                if Multi1 <> 0 then begin

                    Qty += Rec.Quantity * Rec."Qty per UOM" / Multi1;

                    ConPurLine.Quantity := Qty;
                    ConPurLine."Line Amount Excl. VAT" := ConPurLine."Direct Unit Cost Excl. VAT" * Qty - ConPurLine."Total Discount Amt";
                    ConPurLine.Modify;

                end; //IF Multi1 <> 0 THEN

            until Rec.Next = 0; //IF Rec.FINDSET THEN

        Message('Consolidate Purchase lines are updated successfully!');
    end;

    [Scope('OnPrem')]
    procedure QuantityUpdateNEW(PQuantity: Integer)
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        QTYSUM1: Decimal;
        ConPOLine: Record "Consolidate Purchase Line";
        Multi1: Decimal;
        QTY1: Decimal;
        ItemUOM: Record "Item Unit of Measure";
        FromUOMQty: Integer;
        ToUOMQty: Integer;
        PrintQty: Integer;
    begin

        ConPurLine.Reset;
        ConPurLine.SetRange("Vendor No.", Rec."Vendor No.");
        ConPurLine.SetRange("Item No.", Rec."Item No.");
        ConPurLine.SetRange("Unit of Measure Code", Rec."Unit of Measure Code");
        if ConPurLine.FindSet then
            repeat

                ConPurLine.Quantity += Rec.Quantity;
                ConPurLine.Modify;

            until ConPurLine.Next = 0; //IF ConPurLine.FINDSET THEN
    end;
}

