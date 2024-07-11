pageextension 70126 "LSC Posted Receiving lines Ext" extends "LSC Posted Receiving lines"
{

    trigger OnAfterGetRecord()
    var
        ItemVariant: Record "Item Variant";
    begin
        // ItemVariant.RESET;
        // ItemVariant.SETRANGE("Item No.", Rec."Item No.");
        // ItemVariant.SETRANGE(Code, Rec."Variant Code");
        // IF ItemVariant.FINDSET THEN BEGIN
        //     Rec."Variant Description" := ItemVariant."Description 2";
        // END;
    end;
}
