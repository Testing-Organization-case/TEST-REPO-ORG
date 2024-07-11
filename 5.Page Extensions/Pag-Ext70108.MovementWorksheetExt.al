pageextension 70108 "Movement Worksheet Ext" extends "Movement Worksheet"
{

    actions
    {
        modify("Create Movement")
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
        WhseActivityHeader.SETRANGE(Type, WhseActivityHeader.Type::Movement);
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
