pageextension 70073 RegiPutAwaySubExt extends "Registered Put-away Subform"
{
    layout
    {

        addafter(Quantity)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
            }

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
