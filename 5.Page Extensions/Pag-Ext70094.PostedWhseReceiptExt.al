pageextension 70094 "Posted Whse. ReceiptExt" extends "Posted Whse. Receipt"
{
    actions
    {
        addafter("&Print")
        {
            action("PrintBarcode")
            {
                ApplicationArea = All;
                Image = Print;
                Caption = 'Print Barcode';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    CurrPage.PostedWhseRcptLines.PAGE.RunReport(Rec);
                    CurrPage.UPDATE;
                end;
            }

        }
        modify("Create Put-away")
        {
            trigger OnAfterAction()
            begin
                PackagingInfo();
            end;
        }
    }

    local procedure PackagingInfo()
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
        WhseActivityLine: Record "Warehouse Activity Line";
        ItemR: Record Item;

    begin
        WhseActivityHeader.RESET;
        WhseActivityHeader.SETRANGE("Assignment Date", TODAY);
        WhseActivityHeader.SETRANGE(Type, WhseActivityHeader.Type::"Put-away");
        WhseActivityHeader.SETRANGE("Location Code", Rec."Location Code");
        IF WhseActivityHeader.FINDSET THEN
            REPEAT
                WhseActivityLine.RESET;
                WhseActivityLine.SETRANGE("No.", WhseActivityHeader."No.");
                IF WhseActivityLine.FINDSET THEN
                    REPEAT
                        IF (WhseActivityLine."Packaging Info" = '') AND (ItemR.GET(WhseActivityLine."Item No.")) THEN BEGIN
                            WhseActivityLine."Packaging Info" := ItemR."Packaging Info";
                            WhseActivityLine.MODIFY(TRUE);
                        END;

                    UNTIL WhseActivityLine.NEXT = 0;
            UNTIL WhseActivityHeader.NEXT = 0;

    end;

}
