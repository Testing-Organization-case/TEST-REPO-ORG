pageextension 70062 "PostedTrans.Rcpt.SubExt" extends "Posted Transfer Rcpt. Subform"
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
        Itemtable.SETRANGE("No.", Rec."Item No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END

    end;
}
