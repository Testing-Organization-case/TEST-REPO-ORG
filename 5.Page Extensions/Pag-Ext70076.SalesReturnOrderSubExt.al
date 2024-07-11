pageextension 70076 "Sales Return Order SubExt" extends "Sales Return Order Subform"
{
    layout
    {


        addafter(ShortcutDimCode8)
        {
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = All;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()

    begin
        GetPackAndSize();


    end;

    local procedure GetPackAndSize()
    var
        ItemTable: Record Item;
    begin
        Itemtable.RESET();
        Itemtable.SETRANGE("No.", Rec."No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END

    end;
}
