pageextension 70021 LSCSalesOrderSubExt extends "LSC Retail Sales Order Subpage"        //Created by MK
{
    layout
    {
        addafter("Unit of Measure Code")
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
        addafter("Line Discount %")
        {
            field("Offer No."; Rec."Offer No.")
            {
                ApplicationArea = All;
            }
            field("Promotion No."; Rec."Promotion No.")
            {
                ApplicationArea = All;
            }
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                NonInventoryItemUpdate();
            end;
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
        END;
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
