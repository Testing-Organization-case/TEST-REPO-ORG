tableextension 70058 "Item Attribute Value Extension" extends "Item Attribute Value"
{
    fields
    {
        field(70000; "Sales Order"; Boolean)
        {
            Caption = 'Sales Order';
            DataClassification = ToBeClassified;
        }
        field(70001; "Purchase Order"; Boolean)
        {
            Caption = 'Purchase Order';
            DataClassification = ToBeClassified;
        }
        field(70002; "Transfer Order"; Boolean)
        {
            Caption = 'Transfer Order';
            DataClassification = ToBeClassified;
        }
        field(70003; "Warehouse Receipt"; Boolean)
        {
            Caption = 'Warehouse Receipt';
            DataClassification = ToBeClassified;
        }
        field(70004; "Warehouse Shipment"; Boolean)
        {
            Caption = 'Warehouse Shipment';
            DataClassification = ToBeClassified;
        }
        field(70005; Value1; Text[250])
        {
            Caption = 'Value1';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ItemAttribute: Record "Item Attribute";
            begin
                IF xRec.Value1 = Value1 THEN
                    EXIT;

                TESTFIELD(Value1);
                IF HasBeenUsed THEN
                    IF NOT CONFIRM(RenameUsedAttributeValueQst) THEN
                        ERROR('');

                CheckValueUniqueness(Rec, Value1);
                DeleteTranslationsConditionally(xRec, Value1);

                ItemAttribute.GET("Attribute ID");
                IF IsNumeric(ItemAttribute) THEN
                    EVALUATE("Numeric Value", Value1);
                IF ItemAttribute.Type = ItemAttribute.Type::Date THEN
                    EVALUATE("Date Value", Value1);
            end;
        }
    }
    var
        RenameUsedAttributeValueQst: TextConst ENU = 'This item attribute value has been assigned to at least one item.\\Are you sure you want to rename it?';

    procedure CheckValueUniqueness(ItemAttributeValue: Record "Item Attribute Value"; NameToCheck: Text[250])
    var
        NameAlreadyExistsErr: TextConst ENU = 'The item attribute value with value ''%1'' already exists.';
    begin
        ItemAttributeValue.SETRANGE("Attribute ID", "Attribute ID");
        ItemAttributeValue.SETFILTER(ID, '<>%1', ItemAttributeValue.ID);
        ItemAttributeValue.SETRANGE(Value1, NameToCheck);
        IF NOT ItemAttributeValue.ISEMPTY THEN
            ERROR(NameAlreadyExistsErr, NameToCheck);
    end;

    procedure DeleteTranslationsConditionally(ItemAttributeValue: Record "Item Attribute Value"; NameToCheck: Text[250])
    var
        ItemAttrValueTranslation: Record "Item Attr. Value Translation";
        ReuseValueTranslationsQst: Label 'There are translations for item attribute value ''%1''.''\\Do you want to reuse these translations for the new value ''%2''?';
    begin
        IF (ItemAttributeValue.Value1 <> '') AND (ItemAttributeValue.Value1 <> NameToCheck) THEN BEGIN
            ItemAttrValueTranslation.SETRANGE("Attribute ID", "Attribute ID");
            ItemAttrValueTranslation.SETRANGE(ID, ID);
            IF NOT ItemAttrValueTranslation.ISEMPTY THEN
                IF NOT CONFIRM(STRSUBSTNO(ReuseValueTranslationsQst, ItemAttributeValue.Value1, NameToCheck)) THEN
                    ItemAttrValueTranslation.DELETEALL;
        END;
    end;

    procedure IsNumeric(VAR ItemAttribute: Record "Item Attribute"): Boolean
    begin
        EXIT(ItemAttribute.Type IN [ItemAttribute.Type::Integer, ItemAttribute.Type::Decimal]);
    end;

}
