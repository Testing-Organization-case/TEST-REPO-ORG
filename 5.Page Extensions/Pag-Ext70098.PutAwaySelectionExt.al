pageextension 70098 PutAwaySelectionExt extends "Put-away Selection"
{
    layout
    {
        addafter("Completely Put Away")
        {
            field("Vendor Name";Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
            field("Warehouse Receipt No.";Rec."Warehouse Receipt No.")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    var 
       PostedWhseReceiptR:Record "Posted Whse. Receipt Header";
       PostedWhseReceiptLineR:Record "Posted Whse. Receipt Line";
       PurchaseR:Record "Purchase Header";

    begin
        PostedWhseReceiptR.RESET;
        PostedWhseReceiptR.SETRANGE("No.",Rec."Document No.");
        IF PostedWhseReceiptR.FINDSET THEN
        BEGIN
            Rec."Warehouse Receipt No." := PostedWhseReceiptR."Whse. Receipt No.";
        END;

        PostedWhseReceiptLineR.RESET;
        PostedWhseReceiptLineR.SETRANGE("No.",Rec."Document No.");
        IF PostedWhseReceiptLineR.FINDSET THEN
        BEGIN
            PONo := PostedWhseReceiptLineR."Source No.";
            PurchaseR.RESET;
            PurchaseR.SETRANGE("No.",PONo);
            IF PurchaseR.FINDSET THEN
            BEGIN
                Rec."Vendor Name" := PurchaseR."Buy-from Vendor Name";
            END;
        END;
    end;

    var PONo:Code[50];
}
