page 70063 "Item Attribute Value ListNWMM"
{
    Caption = 'Item Attribute Values';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Item Attribute Value Selection";
    SourceTableTemporary = true;
    ApplicationArea = ALl;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Attribute Name"; Rec."Attribute Name")
                {
                    ApplicationArea = Basic, Suite;
                    AssistEdit = false;
                    Caption = 'Attribute';
                    TableRelation = "Item Attribute".Name WHERE(Blocked = CONST(false));
                    ToolTip = 'Specifies the item attribute.';

                    trigger OnValidate()
                    var
                        ItemAttributeValue: Record "Item Attribute Value";
                        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";

                    begin
                        if xRec."Attribute Name" <> '' then
                            DeleteItemAttributeValueMapping(xRec."Attribute ID");

                        if not Rec.FindAttributeValue(ItemAttributeValue) then
                            Rec.InsertItemAttributeValue(ItemAttributeValue, Rec);

                        if ItemAttributeValue.Get(ItemAttributeValue."Attribute ID", ItemAttributeValue.ID) then begin
                            ItemAttributeValueMapping.Reset;
                            ItemAttributeValueMapping.Init;
                            ItemAttributeValueMapping."Table ID" := DATABASE::Item;
                            ItemAttributeValueMapping."No." := RelatedRecordCode;
                            ItemAttributeValueMapping."Item Attribute ID" := ItemAttributeValue."Attribute ID";
                            ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                            ItemAttributeValueMapping.Insert;
                        end;
                    end;
                }
                field(Value; Rec.Value)
                {
                    Caption = 'Value';
                    TableRelation = IF ("Attribute Type" = CONST(Option)) "Item Attribute Value".Value WHERE("Attribute ID" = FIELD("Attribute ID"),
                                                                                                             Blocked = CONST(false));

                    trigger OnValidate()
                    var
                        ItemAttributeValue: Record "Item Attribute Value";
                        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                        ItemAttribute: Record "Item Attribute";
                    begin
                        if not Rec.FindAttributeValue(ItemAttributeValue) then
                            Rec.InsertItemAttributeValue(ItemAttributeValue, Rec);

                        ItemAttributeValueMapping.SetRange("Table ID", DATABASE::Item);
                        ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
                        ItemAttributeValueMapping.SetRange("Item Attribute ID", ItemAttributeValue."Attribute ID");

                        if ItemAttributeValueMapping.FindFirst then begin
                            ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                            OnBeforeItemAttributeValueMappingModify(ItemAttributeValueMapping, ItemAttributeValue, RelatedRecordCode);
                            ItemAttributeValueMapping.Modify;
                        end;

                        ItemAttribute.Get(Rec."Attribute ID");
                        if ItemAttribute.Type <> ItemAttribute.Type::Option then
                            if Rec.FindAttributeValueFromRecord(ItemAttributeValue, xRec) then
                                if not ItemAttributeValue.HasBeenUsed then
                                    ItemAttributeValue.Delete;
                    end;
                }
                // field("Value"; Rec.Value)
                // {
                //     ApplicationArea = ALl;;
                //     Caption = 'Value';
                //     TableRelation = IF ("Attribute Type" = CONST(Option)) "Item Attribute Value".Value WHERE("Attribute ID" = FIELD("Attribute ID"),
                //                                                                                             Blocked = CONST(false));
                //     ToolTip = 'Specifies the value of the item attribute.';
                //     //Visible = false;

                //     trigger OnAssistEdit()
                //     var

                //     begin
                //     end;

                //     trigger OnLookup(var Text: Text): Boolean
                //     var
                //         AttributeDatePageL: Page "Attribute Date Value";
                //         ItemAttributeValue: Record "Item Attribute Value";
                //         ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                //         ItemAttribute: Record "Item Attribute";
                //     begin

                /*IF DateAttributeEditableG THEN
                  BEGIN

                    CLEAR(AttributeDatePageL);
                    IF AttributeDatePageL.RUNMODAL = ACTION::OK THEN
                      BEGIN
                        IF FORMAT(AttributeDatePageL.GetDate) <> '' THEN
                          BEGIN
                            VALIDATE(Value,FORMAT(AttributeDatePageL.GetDate));

                            IF NOT FindAttributeValue(ItemAttributeValue) THEN
                              InsertItemAttributeValue(ItemAttributeValue,Rec);

                            ItemAttributeValueMapping.SETRANGE("Table ID",DATABASE::Item);
                            ItemAttributeValueMapping.SETRANGE("No.",RelatedRecordCode);
                            ItemAttributeValueMapping.SETRANGE("Item Attribute ID",ItemAttributeValue."Attribute ID");

                            IF ItemAttributeValueMapping.FINDFIRST THEN BEGIN
                              ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                              OnBeforeItemAttributeValueMappingModify(ItemAttributeValueMapping,ItemAttributeValue,RelatedRecordCode);
                              ItemAttributeValueMapping.MODIFY;
                            END;

                            ItemAttribute.GET("Attribute ID");
                            IF ItemAttribute.Type <> ItemAttribute.Type::Option THEN
                              IF FindAttributeValueFromRecord(ItemAttributeValue,xRec) THEN
                                IF NOT ItemAttributeValue.HasBeenUsed THEN
                                  ItemAttributeValue.DELETE;

                          END; // IF FORMAT(AttributeDatePageL.GetDate) <> '' THEN
                      END; // IF AttributeDatePageL.RUNMODAL = ACTION::OK THEN
                  END; // IF DateAttributeEditableG THEN*/

                //end;

                //     trigger OnValidate()
                //     var
                //         ItemAttributeValue: Record "Item Attribute Value";
                //         ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                //         ItemAttribute: Record "Item Attribute";
                //     begin
                //         /*IF NOT FindAttributeValue(ItemAttributeValue) THEN
                //           InsertItemAttributeValue(ItemAttributeValue,Rec);

                //         ItemAttributeValueMapping.SETRANGE("Table ID",DATABASE::Item);
                //         ItemAttributeValueMapping.SETRANGE("No.",RelatedRecordCode);
                //         ItemAttributeValueMapping.SETRANGE("Item Attribute ID",ItemAttributeValue."Attribute ID");

                //         IF ItemAttributeValueMapping.FINDFIRST THEN BEGIN
                //           ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                //           OnBeforeItemAttributeValueMappingModify(ItemAttributeValueMapping,ItemAttributeValue,RelatedRecordCode);
                //           ItemAttributeValueMapping.MODIFY;
                //         END;

                //         ItemAttribute.GET("Attribute ID");
                //         IF ItemAttribute.Type <> ItemAttribute.Type::Option THEN
                //           IF FindAttributeValueFromRecord(ItemAttributeValue,xRec) THEN
                //             IF NOT ItemAttributeValue.HasBeenUsed THEN
                //               ItemAttributeValue.DELETE;*/

                //     end;
                // }
                field("Sales Order"; Rec."Sales Order")
                {

                    trigger OnValidate()
                    begin

                        UpdateBooleanFields;
                    end;
                }
                field("Purchase Order"; Rec."Purchase Order")
                {

                    trigger OnValidate()
                    begin

                        UpdateBooleanFields;
                    end;
                }
                field("Transfer Order"; Rec."Transfer Order")
                {

                    trigger OnValidate()
                    begin

                        UpdateBooleanFields;
                    end;
                }
                field("Warehouse Receipt"; Rec."Warehouse Receipt")
                {

                    trigger OnValidate()
                    begin

                        UpdateBooleanFields;
                    end;
                }
                field("Warehouse Shipment"; Rec."Warehouse Shipment")
                {

                    trigger OnValidate()
                    begin

                        UpdateBooleanFields;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Choose Date")
            {
                Caption = 'Choose Date';
                Enabled = DateAttributeEditableG;
                Image = ChangeDate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AttributeDatePageL: Page "Attribute Date Value";
                    ItemAttributeValue: Record "Item Attribute Value";
                    ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                    ItemAttribute: Record "Item Attribute";
                //ItemAttributeValueSelection: Record "Item Attribute Value Selection";
                begin

                    Clear(AttributeDatePageL);
                    if AttributeDatePageL.RunModal = ACTION::OK then begin
                        if Format(AttributeDatePageL.GetDate) <> '' then begin
                            Rec.Validate(Rec.Value, Format(AttributeDatePageL.GetDate));

                            if not Rec.FindAttributeValue(ItemAttributeValue) then
                                Rec.InsertItemAttributeValue(ItemAttributeValue, Rec);

                            ItemAttributeValueMapping.SetRange("Table ID", DATABASE::Item);
                            ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
                            ItemAttributeValueMapping.SetRange("Item Attribute ID", ItemAttributeValue."Attribute ID");

                            if ItemAttributeValueMapping.FindFirst then begin
                                ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                                OnBeforeItemAttributeValueMappingModify(ItemAttributeValueMapping, ItemAttributeValue, RelatedRecordCode);
                                ItemAttributeValueMapping.Modify;
                            end;

                            ItemAttribute.Get(Rec."Attribute ID");
                            if ItemAttribute.Type <> ItemAttribute.Type::Option then
                                if Rec.FindAttributeValueFromRecord(ItemAttributeValue, xRec) then
                                    if not ItemAttributeValue.HasBeenUsed then
                                        ItemAttributeValue.Delete;

                        end; // IF FORMAT(AttributeDatePageL.GetDate) <> '' THEN
                    end; // IF AttributeDatePageL.RUNMODAL = ACTION::OK THEN
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        DateFieldSecurity;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        DeleteItemAttributeValueMapping(Rec."Attribute ID");
    end;

    trigger OnOpenPage()
    begin

        CurrPage.Editable(true);
    end;

    var
        RelatedRecordCode: Code[20];
        DateAttributeEditableG: Boolean;

    procedure LoadAttributes(ItemNo: Code[20])
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        TempItemAttributeValue: Record "Item Attribute Value" temporary;
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        RelatedRecordCode := ItemNo;
        ItemAttributeValueMapping.SetRange("Table ID", DATABASE::Item);
        ItemAttributeValueMapping.SetRange("No.", ItemNo);
        if ItemAttributeValueMapping.FindSet then
            repeat
                ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID");
                TempItemAttributeValue.TransferFields(ItemAttributeValue);
                TempItemAttributeValue.Insert;
            until ItemAttributeValueMapping.Next = 0;

        // @25_Jun_2021_11_46_AM
        if TempItemAttributeValue.FindSet then
            repeat
                ItemAttributeValueMapping.Reset;
                ItemAttributeValueMapping.SetRange("Item Attribute ID", TempItemAttributeValue."Attribute ID");
                ItemAttributeValueMapping.SetRange("Item Attribute Value ID", TempItemAttributeValue.ID);
                ItemAttributeValueMapping.SetRange("Table ID", 27);
                ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
                if ItemAttributeValueMapping.FindFirst then begin
                    TempItemAttributeValue."Sales Order" := ItemAttributeValueMapping."Sales Order";

                    TempItemAttributeValue."Purchase Order" := ItemAttributeValueMapping."Purchase Order";
                    TempItemAttributeValue."Transfer Order" := ItemAttributeValueMapping."Transfer Order";
                    TempItemAttributeValue."Warehouse Receipt" := ItemAttributeValueMapping."Warehouse Receipt";
                    TempItemAttributeValue."Warehouse Shipment" := ItemAttributeValueMapping."Warehouse Shipment";
                    TempItemAttributeValue.Modify;
                end; // IF ItemAttributeValueMapping.FINDFIRST THEN
            until TempItemAttributeValue.Next = 0;
        TempItemAttributeValue.Reset();
        if TempItemAttributeValue.FindSet() then
            repeat
                InsertRecordM(TempItemAttributeValue, 0, '');
            until TempItemAttributeValue.Next() = 0;
        //Rec.PopulateItemAttributeValueSelection(TempItemAttributeValue);
    end;

    procedure InsertRecordM(var TempItemAttributeValue: Record "Item Attribute Value" temporary; DefinedOnTableID: Integer; DefinedOnKeyValue: Code[20])
    var
        ItemAttribute: Record "Item Attribute";
    begin
        Rec."Attribute ID" := TempItemAttributeValue."Attribute ID";
        ItemAttribute.Get(TempItemAttributeValue."Attribute ID");
        Rec."Attribute Name" := ItemAttribute.Name;
        Rec."Attribute Type" := ItemAttribute.Type;
        Rec.Value := TempItemAttributeValue.GetValueInCurrentLanguageWithoutUnitOfMeasure();
        Rec."Sales Order" := TempItemAttributeValue."Sales Order";
        Rec."Purchase Order" := TempItemAttributeValue."Purchase Order";
        Rec."Transfer Order" := TempItemAttributeValue."Transfer Order";
        Rec."Warehouse Receipt" := TempItemAttributeValue."Warehouse Receipt";
        Rec."Warehouse Shipment" := TempItemAttributeValue."Warehouse Shipment";
        Rec.Blocked := TempItemAttributeValue.Blocked;
        Rec."Unit of Measure" := ItemAttribute."Unit of Measure";
        Rec."Inherited-From Table ID" := DefinedOnTableID;
        Rec."Inherited-From Key Value" := DefinedOnKeyValue;
        Rec.Insert();
    end;

    local procedure DeleteItemAttributeValueMapping(AttributeToDeleteID: Integer)
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttribute: Record "Item Attribute";
    begin
        ItemAttributeValueMapping.SetRange("Table ID", DATABASE::Item);
        ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
        ItemAttributeValueMapping.SetRange("Item Attribute ID", AttributeToDeleteID);
        if ItemAttributeValueMapping.FindFirst then begin
            ItemAttributeValueMapping.Delete;
            OnAfterItemAttributeValueMappingDelete(AttributeToDeleteID, RelatedRecordCode);
        end;

        ItemAttribute.Get(AttributeToDeleteID);
        ItemAttribute.RemoveUnusedArbitraryValues;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterItemAttributeValueMappingDelete(AttributeToDeleteID: Integer; RelatedRecordCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeItemAttributeValueMappingModify(var ItemAttributeValueMapping: Record "Item Attribute Value Mapping"; ItemAttributeValue: Record "Item Attribute Value"; RelatedRecordCode: Code[20])
    begin
    end;

    local procedure UpdateBooleanFields()
    var
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeIDL: Integer;
        ItemAttributeValueIDL: Integer;
        ItemAttributeValueTextL: Text;
        ItemNoL: Text;
        ItemAttributeValueL: Record "Item Attribute Value";
    begin

        ItemAttributeIDL := Rec."Attribute ID";
        ItemAttributeValueIDL := 0;
        ItemAttributeValueTextL := Rec.Value;
        ItemNoL := RelatedRecordCode;

        if (ItemAttributeIDL > 0) then begin
            ItemAttributeValueL.Reset;
            // ItemAttributeValueL.SetCurrentKey("Attribute ID", Value1);
            ItemAttributeValueL.SetCurrentKey("Attribute ID", Value);
            ItemAttributeValueL.SetRange("Attribute ID", ItemAttributeIDL);
            ItemAttributeValueL.SetRange(Value, ItemAttributeValueTextL);
            if ItemAttributeValueL.FindFirst then begin
                ItemAttributeValueIDL := ItemAttributeValueL.ID;
            end; // IF ItemAttributeValueL.FINDFIRST THEN

            if (ItemAttributeIDL > 0) then begin
                ItemAttributeValueMappingL.Reset;
                ItemAttributeValueMappingL.SetRange("Item Attribute ID", ItemAttributeIDL);
                ItemAttributeValueMappingL.SetRange("Item Attribute Value ID", ItemAttributeValueIDL);
                ItemAttributeValueMappingL.SetRange("No.", ItemNoL);
                if ItemAttributeValueMappingL.FindSet then
                    repeat
                        ItemAttributeValueMappingL."Sales Order" := Rec."Sales Order";
                        ItemAttributeValueMappingL."Purchase Order" := Rec."Purchase Order";
                        ItemAttributeValueMappingL."Transfer Order" := Rec."Transfer Order";
                        ItemAttributeValueMappingL."Warehouse Receipt" := Rec."Warehouse Receipt";
                        ItemAttributeValueMappingL."Warehouse Shipment" := Rec."Warehouse Shipment";
                        ItemAttributeValueMappingL.Modify;
                    until ItemAttributeValueMappingL.Next = 0; // IF ItemAttributeValueMappingL.FINDSET THEN
            end; // IF (ItemAttributeIDL > 0) THEN
        end; // IF (ItemAttributeIDL > 0) AND (ItemAttributeValueL <> '') THEN
    end;

    local procedure DateFieldSecurity()
    begin

        DateAttributeEditableG := false;
        if Format(Rec."Attribute Type") = 'Date' then begin
            DateAttributeEditableG := true;
        end; // IF FORMAT("Attribute Type") = 'Date' THEN
    end;
}

