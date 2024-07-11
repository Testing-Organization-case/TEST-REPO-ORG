pageextension 70086 "Item Attribute Value List Ext" extends "Item Attribute Value List"
{
    layout
    {

        addafter(Value)
        {
            field("Sales Order"; Rec."Sales Order")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    UpdateBooleanFields;
                end;
            }
            field("Purchase Order"; Rec."Purchase Order")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    UpdateBooleanFields;
                end;
            }
            field("Transfer Order"; Rec."Transfer Order")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    UpdateBooleanFields;
                end;
            }
            field("Warehouse Receipt"; Rec."Warehouse Receipt")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    UpdateBooleanFields;
                end;
            }
            field("Warehouse Shipment"; Rec."Warehouse Shipment")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    UpdateBooleanFields;
                end;
            }
        }
    }
    actions
    {

        addlast("Processing")
        {
            action("Choose Date")
            {
                ApplicationArea = All;
                Image = ChangeDate;
                trigger OnAction()
                var
                    AttributeDatePageL: Page "Attribute Date Value";
                    ItemAttributeValue: Record "Item Attribute Value";
                    ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                    ItemAttribute: Record "Item Attribute";
                begin
                    CLEAR(AttributeDatePageL);
                    IF AttributeDatePageL.RUNMODAL = ACTION::OK THEN BEGIN
                        IF FORMAT(AttributeDatePageL.GetDate) <> '' THEN BEGIN
                            Rec.VALIDATE(Value, FORMAT(AttributeDatePageL.GetDate));

                            IF NOT Rec.FindAttributeValue(ItemAttributeValue) THEN
                                Rec.InsertItemAttributeValue(ItemAttributeValue, Rec);

                            ItemAttributeValueMapping.SETRANGE("Table ID", DATABASE::Item);
                            ItemAttributeValueMapping.SETRANGE("No.", RelatedRecordCode);
                            ItemAttributeValueMapping.SETRANGE("Item Attribute ID", ItemAttributeValue."Attribute ID");

                            IF ItemAttributeValueMapping.FINDFIRST THEN BEGIN
                                ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                                OnBeforeItemAttributeValueMappingModify(ItemAttributeValueMapping, ItemAttributeValue, RelatedRecordCode);
                                ItemAttributeValueMapping.MODIFY;
                            END;

                            ItemAttribute.GET(Rec."Attribute ID");
                            IF ItemAttribute.Type <> ItemAttribute.Type::Option THEN
                                IF Rec.FindAttributeValueFromRecord(ItemAttributeValue, xRec) THEN
                                    IF NOT ItemAttributeValue.HasBeenUsed THEN
                                        ItemAttributeValue.DELETE;

                        END; // IF FORMAT(AttributeDatePageL.GetDate) <> '' THEN
                    END; // IF AttributeDatePageL.RUNMODAL = ACTION::OK THEN
                end;

            }
        }
    }
    procedure UpdateBooleanFields()
    begin
        ItemAttributeIDL := Rec."Attribute ID";
        ItemAttributeValueIDL := 0;
        //ItemAttributeValueTextL := Rec.Value1;
        ItemAttributeValueTextL := Rec.Value;
        ItemNoL := RelatedRecordCode;

        IF (ItemAttributeIDL > 0) THEN BEGIN
            ItemAttributeValueL.RESET;
            //ItemAttributeValueL.SETCURRENTKEY("Attribute ID", Value1);
            ItemAttributeValueL.SETCURRENTKEY("Attribute ID", Value);
            ItemAttributeValueL.SETRANGE("Attribute ID", ItemAttributeIDL);
            //ItemAttributeValueL.SETRANGE(Value1, ItemAttributeValueTextL);
            ItemAttributeValueL.SETRANGE(Value, ItemAttributeValueTextL);
            IF ItemAttributeValueL.FINDFIRST THEN BEGIN
                ItemAttributeValueIDL := ItemAttributeValueL.ID;
            END; // IF ItemAttributeValueL.FINDFIRST THEN

            IF (ItemAttributeIDL > 0) THEN BEGIN
                ItemAttributeValueMappingL.RESET;
                ItemAttributeValueMappingL.SETRANGE("Item Attribute ID", ItemAttributeIDL);
                ItemAttributeValueMappingL.SETRANGE("Item Attribute Value ID", ItemAttributeValueIDL);
                ItemAttributeValueMappingL.SETRANGE("No.", ItemNoL);
                IF ItemAttributeValueMappingL.FINDSET THEN
                    REPEAT
                        ItemAttributeValueMappingL."Sales Order" := Rec."Sales Order";
                        ItemAttributeValueMappingL."Purchase Order" := Rec."Purchase Order";
                        ItemAttributeValueMappingL."Transfer Order" := Rec."Transfer Order";
                        ItemAttributeValueMappingL."Warehouse Receipt" := Rec."Warehouse Receipt";
                        ItemAttributeValueMappingL."Warehouse Shipment" := Rec."Warehouse Shipment";
                        ItemAttributeValueMappingL.MODIFY;
                    UNTIL ItemAttributeValueMappingL.NEXT = 0; // IF ItemAttributeValueMappingL.FINDSET THEN



            END; // IF (ItemAttributeIDL > 0) THEN
        END; // IF (ItemAttributeIDL > 0) AND (ItemAttributeValueL <> '') THEN

    end;

    var
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeIDL: Integer;
        ItemAttributeValueIDL: Integer;
        ItemAttributeValueTextL: Text;
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemNoL: Text;

    procedure OnBeforeItemAttributeValueMappingModify(VAR ItemAttributeValueMapping: Record "Item Attribute Value Mapping"; ItemAttributeValue: Record "Item Attribute Value"; RelatedRecordCode: Code[20])
    begin

    end;


    procedure OnAfterItemAttributeValueMappingModify(var ItemAttributeValueMapping: Record "Item Attribute Value Mapping"; ItemAttributeValueSelection: Record "Item Attribute Value Selection")
    begin

    end;








}
