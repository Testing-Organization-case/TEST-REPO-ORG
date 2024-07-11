page 70001 PurchaseAttributesList
{
    Caption = 'Attributes';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableTemporary = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    Visible = false;
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

        GeneratePurchaseItemAttributes;
    end;

    var
        PurchaseDocumentNoG: Code[50];

    [Scope('OnPrem')]
    procedure GeneratePurchaseItemAttributes()
    var
        PurchaseLineL: Record "Purchase Line";
        LineCountL: Integer;
        ItemNoL: Code[50];
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeL: Record "Item Attribute";
        ItemAttributeValueL: Record "Item Attribute Value";
    begin
        if PurchaseDocumentNoG <> '' then begin
            PurchaseLineL.Reset();
            PurchaseLineL.SetRange("Document No.", PurchaseDocumentNoG);
            PurchaseLineL.SetRange(Type, PurchaseLineL.Type::Item);
            if PurchaseLineL.FindSet() then
                repeat

                    if PurchaseLineL."No." <> '' then begin

                        LineCountL := 0;

                        ItemNoL := PurchaseLineL."No.";

                        ItemAttributeValueMappingL.Reset();
                        ItemAttributeValueMappingL.SetRange("No.", ItemNoL);
                        ItemAttributeValueMappingL.SetRange("Table ID", 27);
                        // @28_Jun_2021_09_35_AM
                        ItemAttributeValueMappingL.SetRange("Purchase Order", true);

                        LineCountL := ItemAttributeValueMappingL.Count;
                        if LineCountL > 0 then begin
                            if ItemAttributeValueMappingL.FindSet() then
                                repeat
                                    Rec.Init();
                                    Rec.TransferFields(PurchaseLineL);
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
                                        Rec."Line No." := PurchaseLineL."Line No." + LineCountL;
                                    end; // if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin

                                    Rec.Insert;
                                    LineCountL -= 1;
                                until ItemAttributeValueMappingL.Next() = 0;
                        end // if LineCountL > 0 then begin
                            //                ELSE BEGIN
                            //                    Rec.INIT();
                            //                    Rec.TRANSFERFIELDS(PurchaseLineL);
                            //                    Rec.INSERT;
                            //                END;
                    end; // if PurchaseLineL."No." <> '' then begin
                until PurchaseLineL.Next = 0;
        end; // if SQDocumentNoG <> '' then begin
    end;

    [Scope('OnPrem')]
    procedure SetPurchaseDocumentNo(PurchaseNoP: Code[50])
    begin
        PurchaseDocumentNoG := PurchaseNoP;
    end;
}

