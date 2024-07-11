pageextension 70132 LSCPurchReplJnlDetailExt extends "LSC Purch Replen. Jrnl Details"       //Created By MK
{
    layout
    {
        addafter("Vendor No.")
        {
            field("Before Rounded Qty"; Rec."Before Rounded Qty")
            {
                ApplicationArea = All;
            }
            field("Before Rounded CrossDot Qty"; Rec."Before Rounded CrossDot Qty")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        addafter("Replen. Item Store List")
        {
            action("Replen. Calculation Log Lines")
            {
                Caption = '&Calculation Log Lines';
                ApplicationArea = All;
                Image = CalculateLines;
                RunObject = page "LSC Replen. Calc. Log Lines";
                RunPageLink = "Replenishment Template Code" = FIELD("Replenishment Template Code"), "Batch No." = FIELD("Batch No."), "Item No." = FIELD("Item No."), "Location Code" = FIELD("Location Code");
                RunPageView = SORTING("Replenishment Template Code", "Batch No.", "Item No.", "Variant Code", "Location Code");
            }
            action("Copy Qty to XDoss")
            {
                Image = Copy;
                Promoted = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CopyQtyToCrossDoss(Rec."Item No.");
                    CurrPage.UPDATE;
                end;
            }
            action("Clear XDoss Qty")
            {
                Image = ClearLog;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //"Quantity to Cross Dock" := 0;
                    ClearQtyFromCrossDoss(Rec."Item No.");
                    CurrPage.UPDATE;
                end;
            }
        }
    }
    local procedure CopyQtyToCrossDoss(ItemNo: Code[20])
    var
        ReplenJournalDetail: Record "LSC Replen. Jrnl. Details";
    begin
        ReplenJournalDetail.RESET;
        ReplenJournalDetail.SETRANGE("Item No.", ItemNo);
        ReplenJournalDetail.SETRANGE("Line No.", Rec."Line No.");
        IF ReplenJournalDetail.FINDSET THEN
            REPEAT

                //Rec."Quantity to Cross Dock" := ReplenJournalDetail.Quantity;
                //Rec.MODIFY(TRUE);
                ReplenJournalDetail."Quantity to Cross Dock" := ReplenJournalDetail.Quantity;
                //MESSAGE('ReplenJournalDetail."Quantity to Cross Dock = %1 and ReplenJournalDetail.Quantity = %2',ReplenJournalDetail."Quantity to Cross Dock",ReplenJournalDetail.Quantity);
                ReplenJournalDetail.MODIFY(TRUE);
            //CurrPage.UPDATE;
            UNTIL ReplenJournalDetail.NEXT = 0; //IF ReplenJournalDetail.FINDSET THEN
    end;

    local procedure ClearQtyFromCrossDoss(ItemNo: Code[20])
    var
        ReplenJournalDetail: Record "LSC Replen. Jrnl. Details";
    begin
        ReplenJournalDetail.RESET;
        ReplenJournalDetail.SETRANGE("Item No.", ItemNo);
        ReplenJournalDetail.SETRANGE("Line No.", Rec."Line No.");
        IF ReplenJournalDetail.FINDSET THEN
            REPEAT

                //Rec."Quantity to Cross Dock" := ReplenJournalDetail.Quantity;
                //Rec.MODIFY(TRUE);
                ReplenJournalDetail."Quantity to Cross Dock" := 0;
                //MESSAGE('ReplenJournalDetail."Quantity to Cross Dock = %1 and ReplenJournalDetail.Quantity = %2',ReplenJournalDetail."Quantity to Cross Dock",ReplenJournalDetail.Quantity);
                ReplenJournalDetail.MODIFY(TRUE);
            //CurrPage.UPDATE;
            UNTIL ReplenJournalDetail.NEXT = 0; //IF ReplenJournalDetail.FINDSET THEN
    end;
}
