pageextension 70129 LSCRetailPROSubExt extends "LSC Retail PRO Subform"         //Created By MK
{
    layout
    {
        addafter("ShortcutDimCode[8]")
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
