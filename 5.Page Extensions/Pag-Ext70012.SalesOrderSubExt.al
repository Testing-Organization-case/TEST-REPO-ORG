pageextension 70012 SalesOrderSubExt extends "Sales Order Subform"      //Created by MK
{
    layout
    {
        addafter(SalesPriceExist)
        {
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line No.")
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
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                NonInventoryItemUpdate();
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
            Rec.Modify();
        END
    end;

    local procedure NonInventoryItemUpdate()
    var
        ItemR: Record Item;
    begin
        ItemR.RESET;
        ItemR.SETRANGE("No.", Rec."No.");
        IF ItemR.FINDFIRST THEN BEGIN
            IF (ItemR.Type = ItemR.Type::"Non-Inventory") AND (Rec."Location Code" = '') THEN BEGIN
                Rec.VALIDATE("Qty. to Ship", Rec.Quantity);
                Rec.MODIFY(TRUE);
            END;
        END;
    end;
}
