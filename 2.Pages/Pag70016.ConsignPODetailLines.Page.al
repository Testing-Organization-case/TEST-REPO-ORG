page 70016 "Consign PO Detail Lines"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Consolidate PO Detail Line";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PO No."; Rec."PO No.")
                {
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Editable = false;
                }

                field(Remark; Rec.Remark)
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {

                    trigger OnValidate()
                    begin

                        Rec."Line Discount Amount" := (Rec."Direct Unit Cost Excl. VAT" * Rec.Quantity) * (Rec."Line Discount %" / 100);
                        Rec."Line Amount Excl. VAT" := (Rec.Quantity * Rec."Direct Unit Cost Excl. VAT") - Rec."Line Discount Amount";
                        Rec."Sum of Qty" := Rec.Quantity * Rec."Qty per UOM";
                        Rec.Modify(true);
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {

                    trigger OnValidate()
                    var
                        UOMRec: Record "Item Unit of Measure";
                    begin

                        Rec."Line Discount %" := 0;
                        Rec."Line Discount Amount" := 0;
                        Rec."Line Amount Excl. VAT" := 0;
                        Rec."Net Cost" := 0;
                        Rec."Direct Unit Cost Excl. VAT" := 0;


                        PurPriceR.Reset;
                        PurPriceR.SetRange("Unit of Measure Code", Rec."Unit of Measure Code");
                        PurPriceR.SetRange("Item No.", Rec."Item No.");
                        if PurPriceR.FindSet then
                            repeat

                                Rec."Net Cost" := PurPriceR."Net Cost Price";
                                Rec."Line Amount Excl. VAT" := Rec.Quantity * Rec."Direct Unit Cost Excl. VAT";

                            until PurPriceR.Next = 0; //IF PurPriceR.FINDSET THEN

                        UOMRec.Reset;
                        UOMRec.SetRange(Code, Rec."Unit of Measure Code");
                        UOMRec.SetRange("Item No.", Rec."Item No.");
                        if UOMRec.FindFirst then begin

                            Rec."Qty per UOM" := UOMRec."Qty. per Unit of Measure";
                            Rec."Sum of Qty" := Rec.Quantity * Rec."Qty per UOM";

                        end; //IF UOMRec.FINDFIRST THEN

                        Rec.Modify(true);
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {

                    trigger OnValidate()
                    begin

                        Rec."Line Discount %" := Rec."Line Discount Amount" / (Rec.Quantity * Rec."Direct Unit Cost Excl. VAT") * 100;
                        Rec."Line Amount Excl. VAT" := (Rec.Quantity * Rec."Direct Unit Cost Excl. VAT") - Rec."Line Discount Amount";
                    end;
                }
                field(Scheme; Rec.Scheme)
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field("Direct Unit Cost Excl. VAT"; Rec."Direct Unit Cost Excl. VAT")
                {

                    trigger OnValidate()
                    begin

                        Rec."Line Discount Amount" := (Rec."Direct Unit Cost Excl. VAT" * Rec.Quantity) * (Rec."Line Discount %" / 100);
                        Rec."Line Amount Excl. VAT" := Rec.Quantity * Rec."Direct Unit Cost Excl. VAT";
                        if Rec."Line Discount %" <> 0 then begin

                            Rec."Line Amount Excl. VAT" := (Rec.Quantity * Rec."Direct Unit Cost Excl. VAT") - Rec."Line Discount Amount";

                        end; //IF Rec."Line Discount %" <> 0 THEN
                    end;
                }
                field("Net Cost"; Rec."Net Cost")
                {
                    Caption = 'Net Cost';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {

                    trigger OnValidate()
                    begin
                        Rec."Line Discount Amount" := (Rec.Quantity * Rec."Direct Unit Cost Excl. VAT") * Rec."Line Discount %" / 100;
                        Rec."Line Amount Excl. VAT" := (Rec.Quantity * Rec."Direct Unit Cost Excl. VAT") - Rec."Line Discount Amount";
                    end;
                }
                field("Line Amount Excl. VAT"; Rec."Line Amount Excl. VAT")
                {
                    Editable = false;
                }
                field("FOC PO No. Update"; Rec."Child PO No. Update")
                {
                    Caption = 'FOC PO No. Update';
                    Editable = true;
                }
                field("FOC PO No."; Rec."Child PO No.")
                {
                    Caption = 'FOC PO No.';
                    Editable = true;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Qty per UOM"; Rec."Qty per UOM")
                {
                    Editable = false;
                    Visible = true;
                }
                field(MaxUOM; Rec.MaxUOM)
                {
                    Editable = false;
                }
                field("Sum of Qty"; Rec."Sum of Qty")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                }
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
                action("Update Consolidate PO")
                {
                    Caption = 'Update Consolidate PO';
                    Image = Apply;

                    trigger OnAction()
                    var
                        PurchaseAttributeListL: Page PurchaseAttributesList;
                    begin

                        // ConPurLine.RESET;
                        // ConPurLine.SETRANGE("Vendor No.",Rec."Vendor No.");
                        //  ConPurLine.SETRANGE("Item No.",Rec."Item No.");
                        //  ConPurLine.SETRANGE("PO No.",Rec."PO No.");
                        //
                        // IF ConPurLine.FINDSET THEN
                        //   REPEAT
                        // //ConPurLine.Quantity := 0;
                        //     Qty += Rec.Quantity;
                        //      MESSAGE('%1',Qty);
                        //  //ConPurLine.Quantity += Qty;
                        //
                        //
                        //   ConPurLine.MODIFY;
                        //
                        //          UNTIL ConPurLine.NEXT = 0;
                        Qty := 0;

                        Rec.Reset;
                        Rec.SetRange("Vendor No.", Rec."Vendor No.");
                        Rec.SetRange("Item No.", Rec."Item No.");
                        Rec.SetRange("Document No.", Rec."Document No.");
                        if Rec.FindSet then
                            repeat
                                Qty += Rec.Quantity;
                                TotalDisAmt += Rec."Line Discount Amount";
                                DirectUnitCost += Rec."Direct Unit Cost Excl. VAT";
                                LineAmtExclVAT += Rec."Net Cost";


                                ConPurLine.Reset;
                                ConPurLine.SetRange("Vendor No.", Rec."Vendor No.");
                                ConPurLine.SetRange("Item No.", Rec."Item No.");
                                ConPurLine.SetRange("PO No.", Rec."PO No.");
                                if ConPurLine.FindSet then
                                    repeat

                                        ConPurLine.Quantity := Qty;
                                        ConPurLine."Total Dis AMT" := TotalDisAmt;
                                        ConPurLine."Direct Unit Cost Excl. VAT" := DirectUnitCost;
                                        ConPurLine."Net Cost Price" := LineAmtExclVAT;

                                        ConPurLine.Modify;
                                    // MESSAGE('%1',ConPurLine."Line Amount Excl. VAT");
                                    until ConPurLine.Next = 0;
                            until Rec.Next = 0;
                        Message('Consolidate Purchase lines are updated successfully!');

                        // ConPODetailLine.RESET;
                        // ConPODetailLine.SETRANGE("Vendor No.",ConPODetailLine."Vendor No.");
                        //  ConPODetailLine.SETRANGE("Item No.",ConPODetailLine."Item No.");
                        //  ConPODetailLine.SETRANGE("Document No.",ConPODetailLine."Document No.");
                        //  IF ConPODetailLine.FINDSET THEN
                        //   REPEAT
                        //     Qty += ConPODetailLine.Quantity;
                        //     MESSAGE('%1',Qty);
                        //     ConPurLine.RESET;
                        //     ConPurLine.SETRANGE("Vendor No.",Rec."Vendor No.");
                        //      ConPurLine.SETRANGE("Item No.",Rec."Item No.");
                        //      ConPurLine.SETRANGE("PO No.",Rec."PO No.");
                        //      IF ConPurLine.FINDSET THEN
                        //       REPEAT
                        //
                        //      ConPurLine.Quantity += ConPurLine.Quantity;
                        //
                        //         ConPurLine.MODIFY;
                        //
                        //          UNTIL ConPurLine.NEXT = 0;
                        //  UNTIL ConPODetailLine.NEXT = 0;
                    end;
                }
                action("Apply Child PO No.")
                {
                    Caption = 'Apply Child PO No.';
                    Image = Apply;

                    trigger OnAction()
                    begin
                        // PurHeader.RESET;
                        // PurHeader.SETRANGE("No.",Rec."PO No.");
                        //
                        // IF PurHeader.FINDFIRST THEN
                        //  BEGIN
                        //    PurHeader."Child PO No." := Rec."Child PO No.";
                        //    PurHeader.MODIFY;
                        //    END;

                        ConPODetailLine.Reset;
                        ConPODetailLine.SetRange("Vendor No.", Rec."Vendor No.");
                        ConPODetailLine.SetRange("Document No.", Rec."Document No.");
                        if ConPODetailLine.FindSet then
                            repeat
                                PurHeader.Reset;
                                PurHeader.SetRange("No.", ConPODetailLine."PO No.");

                                if PurHeader.FindFirst then begin
                                    PurHeader."FOC PO No." := ConPODetailLine."Child PO No.";
                                    PurHeader.Modify;
                                end;
                            until ConPODetailLine.Next = 0;
                        Message('Child PO No. is successfully updated!');
                    end;
                }
            }
        }
    }

    var
        ConPurLine: Record "Consolidate Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
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
        LineDisAmt: Decimal;
        PurchLine: Record "Purchase Line";
}

