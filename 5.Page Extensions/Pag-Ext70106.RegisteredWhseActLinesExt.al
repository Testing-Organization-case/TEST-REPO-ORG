pageextension 70106 "RegisteredWhseActLines Ext" extends "Registered Whse. Act.-Lines"
{

    trigger OnAfterGetRecord()
    var
        VariantR: Record "Item Variant";
    begin
        // VariantR.RESET;
        // VariantR.SETRANGE(Code, Rec."Variant Code");
        // VariantR.SETRANGE("Item No.", Rec."No.");
        // IF VariantR.FINDFIRST THEN BEGIN
        //     rec."Variant Description" := VariantR."Description 2";
        // END;
    end;
}


