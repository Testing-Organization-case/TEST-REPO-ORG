pageextension 70127 LSCSROSubExt extends "LSC Retail SRO Subform"       //Created By Mk
{
    layout
    {
        addafter(XtobeReceived)
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
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                GetPackAndSize();
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        GetPackAndSize();
    end;

    local procedure GetPackAndSize()
    var
        Itemtable: Record Item;
    begin
        Itemtable.RESET();
        Itemtable.SETRANGE("No.", Rec."No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END
    end;
}
