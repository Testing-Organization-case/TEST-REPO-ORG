page 70002 TransferAttributesList
{
    Caption = 'Attributes';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = false;
    SourceTable = "Transfer Line";
    SourceTableTemporary = true;
    ApplicationArea = ALl;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
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
                field("Transfer Type"; Rec."Transfer Type")
                {
                    Editable = false;
                    Visible = false;
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

        //Rec.RESET;
        //Rec.SETRANGE(Value,'<>%1','');

        //GenerateTransferItemAttributes;
        // Rec.RESET;
        // Rec.SETFILTER("Attribute Name",'<>%1','');
        GenTransItemAtt;
    end;

    var
        TransferDocumentNoG: Code[50];

    [Scope('OnPrem')]
    procedure GenerateTransferItemAttributes()
    var
        TransferLineL: Record "Transfer Line";
        LineCountL: Integer;
        ItemNoL: Code[50];
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeL: Record "Item Attribute";
        ItemAttributeValueL: Record "Item Attribute Value";
    begin
        if TransferDocumentNoG <> '' then begin
            TransferLineL.Reset();
            TransferLineL.SetRange("Document No.", TransferDocumentNoG);

            if TransferLineL.FindSet() then
                repeat

                    if TransferLineL."Item No." <> '' then begin

                        LineCountL := 0;

                        ItemNoL := TransferLineL."Item No.";

                        ItemAttributeValueMappingL.Reset();
                        ItemAttributeValueMappingL.SetRange("No.", ItemNoL);
                        ItemAttributeValueMappingL.SetRange("Table ID", 27);
                        ItemAttributeValueMappingL.SetRange("Transfer Order", true);
                        // @28_Jun_2021_09_35_AM

                        //  MESSAGE('%1',ItemAttributeValueMappingL.COUNT);
                        LineCountL := ItemAttributeValueMappingL.Count;
                        //  MESSAGE('%1',LineCountL);
                        if LineCountL > 0 then begin
                            if ItemAttributeValueMappingL.FindSet() then
                                repeat
                                    Rec.Init();
                                    Rec.TransferFields(TransferLineL);
                                    if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin
                                        //  MESSAGE('%1',ItemAttributeValueMappingL.COUNT);
                                        ItemAttributeL.Reset();
                                        ItemAttributeL.Get(ItemAttributeValueMappingL."Item Attribute ID");
                                        //                                ItemAttributeL.SETRANGE(Name,'<>%1','');
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
                                        Rec."Line No." := TransferLineL."Line No." + LineCountL;
                                    end; // if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin



                                    Rec.Insert;
                                    //                             IF Rec."Attribute Name" <> '' THEN
                                    //                             BEGIN
                                    //                               MESSAGE('%1',Rec."Item No.");
                                    //                               END;
                                    LineCountL -= 1;
                                until ItemAttributeValueMappingL.Next() = 0;
                        end // if LineCountL > 0 then begin
                        else begin
                            Rec.Init();
                            Rec.TransferFields(TransferLineL);
                            Rec.Insert;
                        end;
                    end; // if TransferLineL."No." <> '' then begin
                until TransferLineL.Next = 0;
        end; // if SQDocumentNoG <> '' then begin
    end;

    [Scope('OnPrem')]
    procedure SetTransferDocumentNo(TransferNoP: Code[50])
    begin
        TransferDocumentNoG := TransferNoP;
    end;

    local procedure GenTransItemAtt()
    var
        TransferLineL: Record "Transfer Line";
        LineCountL: Integer;
        ItemNoL: Code[50];
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeL: Record "Item Attribute";
        ItemAttributeValueL: Record "Item Attribute Value";
    begin
        if TransferDocumentNoG <> '' then begin
            TransferLineL.Reset();
            TransferLineL.SetRange("Document No.", TransferDocumentNoG);

            if TransferLineL.FindSet() then
                repeat

                    if TransferLineL."Item No." <> '' then begin

                        LineCountL := 0;

                        ItemNoL := TransferLineL."Item No.";

                        ItemAttributeValueMappingL.Reset();
                        ItemAttributeValueMappingL.SetRange("No.", ItemNoL);
                        ItemAttributeValueMappingL.SetRange("Table ID", 27);
                        ItemAttributeValueMappingL.SetRange("Transfer Order", true);
                        // @28_Jun_2021_09_35_AM

                        //  MESSAGE('%1',ItemAttributeValueMappingL.COUNT);
                        LineCountL := ItemAttributeValueMappingL.Count;
                        //  MESSAGE('%1',LineCountL);
                        if LineCountL > 0 then begin
                            if ItemAttributeValueMappingL.FindSet() then
                                repeat
                                    Rec.Init();
                                    Rec.TransferFields(TransferLineL);
                                    if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin
                                        //  MESSAGE('%1',ItemAttributeValueMappingL.COUNT);
                                        ItemAttributeL.Reset();
                                        ItemAttributeL.Get(ItemAttributeValueMappingL."Item Attribute ID");
                                        //                                ItemAttributeL.SETRANGE(Name,'<>%1','');
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
                                        Rec."Line No." := TransferLineL."Line No." + LineCountL;
                                    end; // if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin



                                    Rec.Insert;
                                    //                             IF Rec."Attribute Name" <> '' THEN
                                    //                             BEGIN
                                    //                               MESSAGE('%1',Rec."Item No.");
                                    //                               END;
                                    LineCountL -= 1;
                                until ItemAttributeValueMappingL.Next() = 0;
                        end; // if LineCountL > 0 then begin
                             //                ELSE BEGIN
                             //                    Rec.INIT();
                             //                    Rec.TRANSFERFIELDS(TransferLineL);
                             //                    Rec.INSERT;
                             //                END;
                    end; // if TransferLineL."No." <> '' then begin
                until TransferLineL.Next = 0;
        end; // if SQDocumentNoG <> '' then begin
    end;
}

