tableextension 70028 "Item Cross Reference Extension" extends "Item Reference"
{
    fields
    {
        field(70000; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
        }

        field(70002; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Reference Type No.")));
        }
        modify("Reference Type")
        {
            trigger OnAfterValidate()
            begin
                IF ("Reference Type" <> xRec."Reference Type") AND
   (xRec."Reference Type" <> xRec."Reference Type"::" ") OR
   ("Reference Type" = "Reference Type"::"Bar Code")
THEN
                    "Reference Type No." := '';
            end;
        }
        // modify("Discontinue Bar Code")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         IF "Discontinue Bar Code" AND
        //            ("Cross-Reference Type" <> "Cross-Reference Type"::"Bar Code")
        //         THEN
        //             ERROR(Text001, TABLECAPTION);
        //     end;
        // }
    }

    trigger OnInsert()
    begin
        IF ("Reference Type No." <> '') AND
           ("Reference Type" = "Reference Type"::" ")
        THEN
            ERROR(Text000, FIELDCAPTION("Reference Type No."));

        Item.GET("Item No.");
        IF "Unit of Measure" = '' THEN
            VALIDATE("Unit of Measure", Item."Base Unit of Measure");
        CreateItemVendor;
    end;

    var
        Item: Record Item;
        ItemVend: Record "Item Vendor";
        Text000: TextConst ENU = 'You cannot enter a %1 for a blank Cross-Reference Type.';
        Text001: TextConst ENU = 'This %1 is not a bar code.';

    local procedure MultipleCrossReferencesExist(ItemCrossReference: Record "Item Reference"): Boolean
    var
        ItemCrossReference2: Record "Item Reference";
    begin
        ItemCrossReference2.SETRANGE("Item No.", ItemCrossReference."Item No.");
        ItemCrossReference2.SETRANGE("Reference Type", ItemCrossReference."Reference Type");
        ItemCrossReference2.SETRANGE("Reference Type No.", ItemCrossReference."Reference Type No.");
        ItemCrossReference2.SETRANGE("Reference No.", ItemCrossReference."Reference No.");
        ItemCrossReference2.SETFILTER("Unit of Measure", '<>%1', ItemCrossReference."Unit of Measure");

        EXIT(NOT ItemCrossReference2.ISEMPTY);
    end;

    procedure GetItemDescription(var ItemDescription: text; var ItemDescription2: Text; ItemNo: Code[20]; VariantCode: Code[10]; UnitOfMeasureCode: code[10]; CrossRefType: Option; CrossRefTypeNo: Code[20]): Boolean
    var
        ItemCrossReference: Record "Item Reference";
    begin
        ItemCrossReference.SETRANGE("Item No.", ItemNo);
        //ItemCrossReference.SETRANGE("Variant Code", VariantCode);
        ItemCrossReference.SETRANGE("Unit of Measure", UnitOfMeasureCode);
        ItemCrossReference.SETRANGE("Reference Type", CrossRefType);
        ItemCrossReference.SETRANGE("Reference Type No.", CrossRefTypeNo);
        IF ItemCrossReference.FINDFIRST THEN BEGIN
            IF (ItemCrossReference.Description = '') AND (ItemCrossReference."Description 2" = '') THEN
                EXIT(FALSE);
            ItemDescription := ItemCrossReference.Description;
            ItemDescription2 := ItemCrossReference."Description 2";
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;



}
