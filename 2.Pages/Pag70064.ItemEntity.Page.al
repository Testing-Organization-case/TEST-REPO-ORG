page 70064 "Item Entity"
{
    Caption = 'items', Locked = true;
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    EntityName = 'item';
    EntitySetName = 'items';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    ApplicationArea = All;
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Number', Locked = true;
                }
                field(displayName; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'DisplayName', Locked = true;
                    ToolTip = 'Specifies the Description for the Item.';

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Description));
                    end;
                }
                field(type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type', Locked = true;
                    ToolTip = 'Specifies the Type for the Item. Possible values are Inventory and Service.';

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Type));
                    end;
                }
                field(itemCategoryId; Rec."Item Category Id")
                {
                    ApplicationArea = All;
                    Caption = 'ItemCategoryId', Locked = true;

                    trigger OnValidate()
                    begin
                        if Rec."Item Category Id" = BlankGUID then
                            Rec."Item Category Code" := ''
                        else begin
                            ItemCategory.SetRange(SystemId, Rec."Item Category Id");
                            if not ItemCategory.FindFirst then
                                Error(ItemCategoryIdDoesNotMatchAnItemCategoryGroupErr);

                            Rec."Item Category Code" := ItemCategory.Code;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Item Category Code"));
                        RegisterFieldSet(Rec.FieldNo("Item Category Id"));
                    end;
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'ItemCategoryCode', Locked = true;

                    trigger OnValidate()
                    begin
                        if ItemCategory.Code <> '' then begin
                            if ItemCategory.Code <> Rec."Item Category Code" then
                                Error(ItemCategoriesValuesDontMatchErr);
                            exit;
                        end;

                        if Rec."Item Category Code" = '' then
                            Rec."Item Category Id" := BlankGUID
                        else begin
                            if not ItemCategory.Get(Rec."Item Category Code") then
                                Error(ItemCategoryCodeDoesNotMatchATaxGroupErr);

                            Rec."Item Category Id" := ItemCategory.SystemId;
                        end;
                    end;
                }
                field(blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Caption = 'Blocked', Locked = true;
                    ToolTip = 'Specifies whether the item is blocked.';

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Blocked));
                    end;
                }
                field(availableInPOS; Rec."Available in POS")
                {
                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Rec."Available in POS"));
                    end;

                }
                field(baseUnitOfMeasureId; BaseUnitOfMeasureId)
                {
                    ApplicationArea = All;
                    Caption = 'BaseUnitOfMeasureId', Locked = true;

                    trigger OnValidate()
                    begin
                        if BaseUnitOfMeasureId = BlankGUID then
                            BaseUnitOfMeasureCode := ''
                        else begin
                            ValidateUnitOfMeasure.SetRange(SystemId, BaseUnitOfMeasureId);
                            if not ValidateUnitOfMeasure.FindFirst then
                                Error(UnitOfMeasureIdDoesNotMatchAUnitOfMeasureErr);

                            BaseUnitOfMeasureCode := ValidateUnitOfMeasure.Code;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Unit of Measure Id"));
                        RegisterFieldSet(Rec.FieldNo("Base Unit of Measure"));
                    end;
                }
                field(baseUnitOfMeasure; BaseUnitOfMeasureJSONText)
                {
                    ApplicationArea = All;
                    Caption = 'BaseUnitOfMeasure', Locked = true;
                    ODataEDMType = 'ITEM-UOM';
                    ToolTip = 'Specifies the Base Unit of Measure.';

                    trigger OnValidate()
                    var
                        UnitOfMeasureFromJSON: Record "Unit of Measure";
                    begin
                        RegisterFieldSet(Rec.FieldNo("Unit of Measure Id"));
                        RegisterFieldSet(Rec.FieldNo("Base Unit of Measure"));

                        if BaseUnitOfMeasureJSONText = 'null' then
                            exit;

                        GraphCollectionMgtItem.ParseJSONToUnitOfMeasure(BaseUnitOfMeasureJSONText, UnitOfMeasureFromJSON);

                        if (ValidateUnitOfMeasure.Code <> '') and
                           (ValidateUnitOfMeasure.Code <> UnitOfMeasureFromJSON.Code)
                        then
                            Error(UnitOfMeasureValuesDontMatchErr);
                    end;
                }
                field(gtin; Rec.GTIN)
                {
                    ApplicationArea = All;
                    Caption = 'GTIN', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(GTIN));
                    end;
                }
                field(inventory; InventoryValue)
                {
                    ApplicationArea = All;
                    Caption = 'Inventory', Locked = true;
                    ToolTip = 'Specifies the inventory for the item.';

                    trigger OnValidate()
                    begin
                        Rec.Validate(Inventory, InventoryValue);
                        RegisterFieldSet(Rec.FieldNo(Inventory));
                    end;
                }
                field(unitPrice; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'UnitPrice', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Unit Price"));
                    end;
                }
                field(priceIncludesTax; Rec."Price Includes VAT")
                {
                    ApplicationArea = All;
                    Caption = 'PriceIncludesTax', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Price Includes VAT"));
                    end;
                }
                field(unitCost; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'UnitCost', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Unit Cost"));
                    end;
                }
                field(taxGroupId; Rec."Tax Group Id")
                {
                    ApplicationArea = All;
                    Caption = 'TaxGroupId', Locked = true;
                    ToolTip = 'Specifies the ID of the tax group.';

                    trigger OnValidate()
                    begin
                        if Rec."Tax Group Id" = BlankGUID then
                            Rec."Tax Group Code" := ''
                        else begin
                            TaxGroup.SetRange(SystemId, Rec."Tax Group Id");
                            if not TaxGroup.FindFirst then
                                Error(TaxGroupIdDoesNotMatchATaxGroupErr);

                            Rec."Tax Group Code" := TaxGroup.Code;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Tax Group Code"));
                        RegisterFieldSet(Rec.FieldNo("Tax Group Id"));
                    end;
                }
                field(ingredient; Rec.Ingredient)
                {
                    Caption = 'Ingredient';
                }
                field(usage; Rec.Usage)
                {
                    Caption = 'Usage';
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'TaxGroupCode', Locked = true;

                    trigger OnValidate()
                    begin
                        if TaxGroup.Code <> '' then begin
                            if TaxGroup.Code <> Rec."Tax Group Code" then
                                Error(TaxGroupValuesDontMatchErr);
                            exit;
                        end;

                        if Rec."Tax Group Code" = '' then
                            Rec."Tax Group Id" := BlankGUID
                        else begin
                            if not TaxGroup.Get(Rec."Tax Group Code") then
                                Error(TaxGroupCodeDoesNotMatchATaxGroupErr);

                            Rec."Tax Group Id" := TaxGroup.SystemId;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Tax Group Code"));
                        RegisterFieldSet(Rec.FieldNo("Tax Group Id"));
                    end;
                }
                field(lastModifiedDateTime; Rec."Last DateTime Modified")
                {
                    ApplicationArea = All;
                    Caption = 'LastModifiedDateTime', Locked = true;
                    Editable = false;
                }
                field(packInfo; Rec."Packaging Info")
                {
                }
                field(vendorNo; Rec."Vendor No.")
                {
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetCalculatedFields;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        GraphCollectionMgtItem: Codeunit "Graph Collection Mgt - Item";
    begin
        if TempFieldSet.Get(DATABASE::Item, Rec.FieldNo("Base Unit of Measure")) then
            if BaseUnitOfMeasureJSONText = '' then
                BaseUnitOfMeasureJSONText := GraphCollectionMgtItem.ItemUnitOfMeasureToJSON(Rec, BaseUnitOfMeasureCode);

        GraphCollectionMgtItem.InsertItem(Rec, TempFieldSet, BaseUnitOfMeasureJSONText);

        SetCalculatedFields;
        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    var
        Item: Record Item;
        GraphCollectionMgtItem: Codeunit "Graph Collection Mgt - Item";
    begin
        if TempFieldSet.Get(DATABASE::Item, Rec.FieldNo("Base Unit of Measure")) then
            Rec.Validate("Base Unit of Measure", BaseUnitOfMeasureCode);

        Item.SetRange(SystemId, Rec.SystemId);
        Item.FindFirst;

        GraphCollectionMgtItem.ProcessComplexTypes(
          Rec,
          BaseUnitOfMeasureJSONText
          );

        if Rec."No." = Item."No." then
            Rec.Modify(true)
        else begin
            Item.TransferFields(Rec, false);
            Item.Rename(Rec."No.");
            Rec.TransferFields(Item, true);
        end;

        SetCalculatedFields;

        exit(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearCalculatedFields;
    end;

    var
        TempFieldSet: Record "Field" temporary;
        ValidateUnitOfMeasure: Record "Unit of Measure";
        ItemCategory: Record "Item Category";
        TaxGroup: Record "Tax Group";
        GraphCollectionMgtItem: Codeunit "Graph Collection Mgt - Item";
        BaseUnitOfMeasureCode: Code[10];
        BaseUnitOfMeasureJSONText: Text;
        InventoryValue: Decimal;
        UnitOfMeasureValuesDontMatchErr: Label 'The unit of measure values do not match to a specific Unit of Measure.', Locked = true;
        UnitOfMeasureIdDoesNotMatchAUnitOfMeasureErr: Label 'The "unitOfMeasureId" does not match to a Unit of Measure.', Locked = true;
        BaseUnitOfMeasureId: Guid;
        BlankGUID: Guid;
        TaxGroupValuesDontMatchErr: Label 'The tax group values do not match to a specific Tax Group.', Locked = true;
        TaxGroupIdDoesNotMatchATaxGroupErr: Label 'The "taxGroupId" does not match to a Tax Group.', Locked = true;
        TaxGroupCodeDoesNotMatchATaxGroupErr: Label 'The "taxGroupCode" does not match to a Tax Group.', Locked = true;
        ItemCategoryIdDoesNotMatchAnItemCategoryGroupErr: Label 'The "itemCategoryId" does not match to a specific ItemCategory group.', Locked = true;
        ItemCategoriesValuesDontMatchErr: Label 'The item categories values do not match to a specific item category.';
        ItemCategoryCodeDoesNotMatchATaxGroupErr: Label 'The "itemCategoryCode" does not match to a Item Category.', Locked = true;

    local procedure SetCalculatedFields()
    var
        UnitOfMeasure: Record "Unit of Measure";
        GraphCollectionMgtItem: Codeunit "Graph Collection Mgt - Item";
    begin
        // UOM
        BaseUnitOfMeasureJSONText := GraphCollectionMgtItem.ItemUnitOfMeasureToJSON(Rec, Rec."Base Unit of Measure");
        BaseUnitOfMeasureCode := Rec."Base Unit of Measure";
        if UnitOfMeasure.Get(BaseUnitOfMeasureCode) then
            BaseUnitOfMeasureId := UnitOfMeasure.SystemId
        else
            BaseUnitOfMeasureId := BlankGUID;

        // Inventory
        Rec.CalcFields(Inventory);
        InventoryValue := Rec.Inventory;
    end;

    local procedure ClearCalculatedFields()
    begin
        Clear(Rec.SystemId);
        Clear(BaseUnitOfMeasureId);
        Clear(BaseUnitOfMeasureCode);
        Clear(BaseUnitOfMeasureJSONText);
        Clear(InventoryValue);
        TempFieldSet.DeleteAll;
    end;

    local procedure RegisterFieldSet(FieldNo: Integer)
    begin
        if TempFieldSet.Get(DATABASE::Item, FieldNo) then
            exit;

        TempFieldSet.Init;
        TempFieldSet.TableNo := DATABASE::Item;
        TempFieldSet.Validate("No.", FieldNo);
        TempFieldSet.Insert(true);
    end;
}

