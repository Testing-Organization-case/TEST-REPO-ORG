pageextension 70043 "Purchase Lines" extends "Purchase Lines"
{
    layout
    {
        addafter("Amt. Rcd. Not Invoiced (LCY)")
        {
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = All;
            }
            field("Line Discount Amount"; Rec."Line Discount Amount")
            {
                ApplicationArea = All;
            }
            field("PO Status"; Rec."PO Status")
            {
                ApplicationArea = All;
            }
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
            field("External Document No"; Rec."External Document No")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Item &Tracking Lines")
        {
            action("Apply Line Discount %")
            {
                ApplicationArea = ItemTracking;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    Rec.SETRANGE("No.", Rec."No.");
                    Rec.SETRANGE("Document Type", Rec."Document Type"::Order);
                    IF Rec.FINDFIRST THEN BEGIN
                        LineDis := Rec."Line Discount %";
                        QtyMulti := Rec.Quantity * Rec."Direct Unit Cost";
                        IF Rec.FINDSET THEN
                            REPEAT
                                Rec."Line Discount %" := LineDis;
                                Rec."Line Discount Amount" := (QtyMulti * Rec."Line Discount %") / 100;
                                Rec.MODIFY(TRUE);
                            UNTIL Rec.NEXT = 0;
                    END;
                end;

            }
            action("Apply Consolidate PO")
            {
                ApplicationArea = ItemTracking;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    Rec.SETRANGE("No.", Rec."No.");
                    IF Rec.FINDSET THEN
                        REPEAT
                            Qty += Rec.Quantity;
                            ConPOLine.RESET;
                            ConPOLine.SETRANGE("Vendor No.", Rec."Buy-from Vendor No.");
                            ConPOLine.SETRANGE("Item No.", Rec."No.");
                            IF ConPOLine.FINDSET THEN
                                REPEAT
                                    ConPOLine.Quantity := Qty;
                                    ConPOLine.MODIFY(TRUE);
                                UNTIL ConPOLine.NEXT = 0;

                        UNTIL Rec.NEXT = 0;
                end;
            }
        }
    }
    var
        LineDis: Decimal;
        QtyMulti: Decimal;
        Qty: Decimal;
        ConPOLine: Record "Consolidate Purchase Line";
}
