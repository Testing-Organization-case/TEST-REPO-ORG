pageextension 70058 TransferOrderSubExt extends "Transfer Order Subform"
{
    layout
    {

        addafter(Quantity)
        {
            field("Item Family Code"; Rec."Item Family Code")
            {
                ApplicationArea = All;
            }
        }

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

        modify("Item No.")
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
