page 70004 WhseShpAttributesList
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Warehouse Shipment Line";
    SourceTableTemporary = true;
    ApplicationArea = ALl;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Attribute Name"; Rec."Attribute Name")
                {
                    Editable = false;
                }
                field(Value; Rec.Value)
                {
                    Editable = false;
                }
                field("Attribute Type"; Rec."Attribute Type")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Item Description';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        GenerateWarehouseItemAttributes;
    end;

    var
        WarehouseDocumentNoG: Code[50];

    [Scope('OnPrem')]
    procedure GenerateWarehouseItemAttributes()
    var
        WarehouseShipmentLineL: Record "Warehouse Shipment Line";
        LineCountL: Integer;
        ItemNoL: Code[50];
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeL: Record "Item Attribute";
        ItemAttributeValueL: Record "Item Attribute Value";
    begin
        if WarehouseDocumentNoG <> '' then begin
            WarehouseShipmentLineL.Reset();
            WarehouseShipmentLineL.SetRange("No.", WarehouseDocumentNoG);
            if WarehouseShipmentLineL.FindSet() then
                repeat

                    if WarehouseShipmentLineL."Item No." <> '' then begin

                        LineCountL := 0;

                        ItemNoL := WarehouseShipmentLineL."Item No.";

                        ItemAttributeValueMappingL.Reset();
                        ItemAttributeValueMappingL.SetRange("No.", ItemNoL);
                        ItemAttributeValueMappingL.SetRange("Table ID", 27);
                        // @28_Jun_2021_09_35_AM
                        ItemAttributeValueMappingL.SetRange("Warehouse Shipment", true);
                        LineCountL := ItemAttributeValueMappingL.Count;
                        if LineCountL > 0 then begin
                            if ItemAttributeValueMappingL.FindSet() then
                                repeat
                                    Rec.Init();
                                    Rec.TransferFields(WarehouseShipmentLineL);
                                    if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin
                                        ItemAttributeL.Reset();
                                        ItemAttributeL.Get(ItemAttributeValueMappingL."Item Attribute ID");
                                        Rec."Attribute Name" := ItemAttributeL.Name;
                                        Rec."Attribute Type" := ItemAttributeL.Type;

                                        if ItemAttributeValueMappingL."Item Attribute Value ID" > 0 then begin
                                            ItemAttributeValueL.Reset();
                                            ItemAttributeValueL.SetCurrentKey("Attribute ID", ID);
                                            ItemAttributeValueL.SetRange("Attribute ID", ItemAttributeValueMappingL."Item Attribute ID");
                                            ItemAttributeValueL.SetRange(ID, ItemAttributeValueMappingL."Item Attribute Value ID");
                                            if ItemAttributeValueL.Count > 0 then begin
                                                ItemAttributeValueL.FindFirst();
                                                Rec.Value := Format(ItemAttributeValueL.Value);
                                            end;
                                        end;
                                        Rec."Line No." := WarehouseShipmentLineL."Line No." + LineCountL;
                                    end; // if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin

                                    Rec.Insert;
                                    LineCountL -= 1;
                                until ItemAttributeValueMappingL.Next() = 0;
                        end // if LineCountL > 0 then begin
                            //                ELSE BEGIN
                            //                    Rec.INIT();
                            //                    Rec.TRANSFERFIELDS(WarehouseShipmentLineL);
                            //                    Rec.INSERT;
                            //                END;
                    end; // if TransferLineL."No." <> '' then begin
                until WarehouseShipmentLineL.Next = 0;
        end; // if SQDocumentNoG <> '' then begin
    end;

    [Scope('OnPrem')]
    procedure SetWarehouseDocumentNo(WarehouseNoP: Code[50])
    begin
        WarehouseDocumentNoG := WarehouseNoP;
    end;
}

