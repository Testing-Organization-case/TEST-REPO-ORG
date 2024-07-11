pageextension 70156 "LSC Retail TO. Subpage Ext" extends "LSC Retail TO. Subp."
{
    layout
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                GetPackAndSize();
            end;
        }


    }
    local procedure GetPackAndSize()
    var
        Itemtable: Record Item;
    begin
        Itemtable.RESET();
        Itemtable.SETRANGE("No.", Rec."Item No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END
    end;
}
