pageextension 70017 PurchOrdSubExt extends "Purchase Order Subform"         //Created by MK
{

    layout
    {
        addafter(Quantity)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
            }
            field("Net Price"; Rec."Net Price")
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
                PurchaseHeader.RESET;
                PurchaseHeader.SETRANGE("No.", Rec."Document No.");
                PurchaseHeader.SETRANGE("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                IF PurchaseHeader.FINDSET THEN
                    REPEAT
                        PurPrice.RESET;
                        PurPrice.SETRANGE("Item No.", Rec."No.");
                        PurPrice.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
                        PurPrice.SETRANGE("Variant Code", Rec."Variant Code");
                        PurPrice.SETRANGE("Vendor No.", Rec."Buy-from Vendor No.");
                        IF PurPrice.FINDSET THEN
                            REPEAT
                                Rec."Net Price" := PurPrice."Net Price";
                            UNTIL PurPrice.NEXT = 0;
                    UNTIL PurchaseHeader.NEXT = 0;
                SchemeFromVendor();
                GetPackAndSize();
            end;
        }

    }
    var
        VariantR: Record "Item Variant";
        PurchaseHeader: Record "Purchase Header";
        PurPrice: Record "Purchase Price";
        VendorTradeScheme: Record "Vendor Trade Scheme";
        PurchaseDocNo: Code[20];

    trigger OnAfterGetRecord()
    begin
        // VariantR.RESET;
        // VariantR.SETRANGE(Code, Rec."Variant Code");
        // VariantR.SETRANGE("Item No.", Rec."No.");
        // IF VariantR.FINDFIRST THEN BEGIN
        //     Rec."Variant Descriptions" := VariantR."Description 2";
        // END;

        SchemeFromVendor;
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

    local procedure SchemeFromVendor()
    begin
        VendorTradeScheme.RESET;
        VendorTradeScheme.SETRANGE("Item No.", Rec."No.");
        //VendorTradeScheme.SETRANGE("Variant Code", Rec."Variant Code");
        PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE("No.", Rec."Document No.");
        IF PurchaseHeader.FINDFIRST THEN BEGIN
            PurchaseDocNo := PurchaseHeader."No.";
        END;
        VendorTradeScheme.SETRANGE("Vendor No.", Rec."Buy-from Vendor No.");
        VendorTradeScheme.SETRANGE(Active, TRUE);
        IF VendorTradeScheme.FINDFIRST THEN BEGIN
            Rec.Scheme := VendorTradeScheme.Scheme;
            Rec.MODIFY(TRUE);
        END;

    end;
}
