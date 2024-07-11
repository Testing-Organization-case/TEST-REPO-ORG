pageextension 70131 LSCPurchReplenJnlExt extends "LSC Purchase Replen. Journal"     //Created by MK
{
    layout
    {
        addafter(ReplLocation)
        {
            field("Repl. Name"; ReplenishmentLocation.Name)
            {
                Caption = 'Replenishment Name';
                ApplicationArea = All;
                Editable = false;
            }
        }

    }
    actions
    {
        addafter("Show Thresholds")
        {
            action("Rounding Up")
            {
                Image = RollUpCosts;
                trigger OnAction()
                var
                    OrderMultiple, RoundedQty : Decimal;
                    TotalQty: Integer;
                    ItemRec: Record Item;
                    ReplnJnlDetail: Record "LSC Replen. Jrnl. Details";
                begin
                    Rec.RESET;
                    Rec.SETRANGE("Replenishment Template Code", Rec."Replenishment Template Code");
                    IF Rec.FINDSET THEN
                        REPEAT
                            OrderMultiple := 0;
                            ItemRec.RESET;
                            ItemRec.SETRANGE("No.", Rec."Item No.");
                            IF ItemRec.FINDFIRST THEN
                                //TransferMultiple := ItemRec."Transfer Multiple";
                                OrderMultiple := ItemRec."Order Multiple";

                            IF OrderMultiple > 0 THEN BEGIN
                                ReplnJnlDetail.RESET;
                                ReplnJnlDetail.SETRANGE("Replenishment Template Code", Rec."Replenishment Template Code");
                                ReplnJnlDetail.SETRANGE("Item No.", Rec."Item No.");
                                RoundedQty := 0;
                                TotalQty := 0;
                                IF ReplnJnlDetail.FINDSET THEN
                                    REPEAT
                                        ReplnJnlDetail."Before Rounded Qty" := ReplnJnlDetail.Quantity;
                                        ReplnJnlDetail."Before Rounded CrossDot Qty" := ReplnJnlDetail."Quantity to Cross Dock";
                                        RoundedQty := ROUND(ReplnJnlDetail.Quantity, OrderMultiple, '>');
                                        TotalQty += RoundedQty;
                                        ReplnJnlDetail.MODIFY(TRUE);
                                    UNTIL ReplnJnlDetail.NEXT = 0;
                                //Rec.Quantity := TotalQty;
                                Rec.VALIDATE(Quantity, TotalQty);
                                Rec.MODIFY(TRUE);


                                ReplnJnlDetail.RESET;
                                ReplnJnlDetail.SETRANGE("Replenishment Template Code", Rec."Replenishment Template Code");
                                ReplnJnlDetail.SETRANGE("Item No.", Rec."Item No.");
                                RoundedQty := 0;
                                //TotalQty := 0;
                                IF ReplnJnlDetail.FINDSET THEN
                                    REPEAT
                                        RoundedQty := ROUND(ReplnJnlDetail."Before Rounded Qty", OrderMultiple, '>');
                                        //RoundedCrossDotQty := ROUND(ReplnJnlDetail."Quantity to Cross Dock",TransferMultiple,'>');
                                        //ReplnJnlDetail.Quantity := RoundedQty;
                                        ReplnJnlDetail.VALIDATE(Quantity, RoundedQty);
                                        IF ReplnJnlDetail."Before Rounded CrossDot Qty" <> 0 THEN BEGIN
                                            ReplnJnlDetail."Quantity to Cross Dock" := ReplnJnlDetail."Before Rounded CrossDot Qty";
                                        END ELSE BEGIN
                                            //ReplnJnlDetail."Quantity to Cross Dock" := RoundedQty;
                                            ReplnJnlDetail.VALIDATE("Quantity to Cross Dock", RoundedQty);
                                        END;
                                        ReplnJnlDetail.MODIFY(TRUE);
                                    UNTIL ReplnJnlDetail.NEXT = 0;
                                //          Rec.Quantity := TotalQty;
                                //          Rec.VALIDATE(Quantity,TotalQty);
                                //          Rec.MODIFY(TRUE);
                            END;
                        UNTIL Rec.NEXT = 0;
                    MESSAGE('Successfully rounded test 3!');
                end;
            }
        }
    }
    var
        ReplenishmentLocation: Record Location;
}
