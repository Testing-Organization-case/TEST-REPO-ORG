report 70018 ItemInvVariSerialLotsWks
{
    ProcessingOnly = true;
    UseRequestPage = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field(ItemNoFilter; ItemNoFilter)
                    {
                        Caption = 'ItemNoFilter';
                        TableRelation = Item."No.";

                        // trigger OnLookup(var Text: Text): Boolean
                        // var
                        //     ItemList: Page "POS Inv Item List";
                        // begin
                        //     Clear(ItemList);
                        //     ItemList.LookupMode := true;
                        //     if ItemList.RunModal = ACTION::LookupOK then
                        //         Text := ItemList.GetSelectionFilter
                        //     else
                        //         exit(false);
                        //     exit(true)
                        // end;
                    }
                    field(LocationCodeFilter; LocationCodeFilter)
                    {
                        TableRelation = Location.Code;

                        // trigger OnLookup(var Text: Text): Boolean
                        // var
                        //     LocationList: Page "POS Inv. Location List";
                        // begin
                        //     Clear(LocationList);
                        //     LocationList.LookupMode := true;
                        //     if LocationList.RunModal = ACTION::LookupOK then
                        //         Text := LocationList.GetSelectionFilter
                        //     else
                        //         exit(false);
                        //     exit(true)
                        // end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if (ItemNoFilter <> '') or (LocationCodeFilter <> '') then begin
            CurrPage.Run;
        end else
            exit;

        GetInfo1;
    end;

    var
        ItemNoFilter: Code[250];
        LocationCodeFilter: Code[250];
        VariantCodeFilter: Code[50];
        ItemR: Record Item;
        ItemEntryR: Record "Item Ledger Entry" temporary;
        CurrPage: Page ItemInvVarSerialLotsWksPage;
        LineNoL: Integer;
        ItemInvR: Record ItemInvVariSerialiLotsWks;
        ItemLedEntryR: Record "Item Ledger Entry";
        ItemInvVarR: Record ItemInvVariSerialiLotsWks;
        ItemLedEntryRec: Record "Item Ledger Entry";

    local procedure GetInfo1()
    begin
        ItemInvVarR.DeleteAll;
        //ItemInvVarR."Item No Filter":='';
        LineNoL := 1;

        if (ItemNoFilter <> '') and (LocationCodeFilter = '') then begin
            ItemLedEntryRec.Reset;
            //                ItemLedEntryRec.SETRANGE("Item No.",ItemNoFilter);
            ItemLedEntryRec.SetFilter("Item No.", ItemNoFilter);

            if ItemLedEntryRec.FindSet then
                repeat
                    ItemInvVarR.Reset;
                    if ItemInvVarR.FindLast then begin
                        LineNoL := ItemInvVarR.No + 1;
                    end; // IF ItemInvVarR.FINDLAST

                    ItemInvR.Init;
                    ItemInvR.No := LineNoL;
                    ItemInvR."Item No." := ItemLedEntryRec."Item No.";
                    ItemInvR.Description := ItemLedEntryRec.Description;

                    ItemInvR."Location Code" := ItemLedEntryRec."Location Code";
                    ItemInvR."Serial No." := ItemLedEntryRec."Serial No.";
                    ItemInvR."Item No Filter" := ItemNoFilter;


                    ItemLedEntryR.Reset;
                    ItemLedEntryR.SetRange("Item No.", ItemInvR."Item No.");
                    ItemLedEntryR.SetRange("Location Code", ItemInvR."Location Code");

                    if ItemLedEntryR.FindSet then
                        repeat
                            ItemLedEntryR.CalcSums(Quantity);
                            ItemInvR."Sum Qty" := ItemLedEntryR.Quantity;
                        until ItemLedEntryR.Next = 0; //IF ItemLedEntryR.FINDSET

                    ItemInvR.Reset;
                    ItemInvR.SetRange("Item No.", ItemInvR."Item No.");
                    ItemInvR.SetRange("Location Code", ItemInvR."Location Code");

                    if ItemInvR.FindSet then
                        repeat
                            ItemInvR.Delete;
                        until ItemInvR.Next = 0; // IF ItemInvR.FINDSET

                    ItemInvR.Insert;

                until ItemLedEntryRec.Next = 0; // IF ItemLedEntryRec.FINDSET
        end; //IF (ItemNoFilter <> '') AND (LocationCodeFilter = '') THEN

        if (ItemNoFilter <> '') and (LocationCodeFilter <> '') then begin

            ItemLedEntryRec.Reset;
            ItemLedEntryRec.SetFilter("Item No.", ItemNoFilter);
            ItemLedEntryRec.SetFilter("Location Code", LocationCodeFilter);
            if ItemLedEntryRec.FindSet then
                repeat
                    ItemInvVarR.Reset;
                    if ItemInvVarR.FindLast then begin
                        LineNoL := ItemInvVarR.No + 1;
                    end;

                    ItemInvR.Init;
                    ItemInvR.No := LineNoL;
                    ItemInvR."Item No." := ItemLedEntryRec."Item No.";
                    ItemInvR.Description := ItemLedEntryRec.Description;
                    ItemInvR."Location Code" := ItemLedEntryRec."Location Code";
                    ItemInvR."Serial No." := ItemLedEntryRec."Serial No.";
                    ItemInvR."Item No Filter" := ItemNoFilter;
                    ItemInvR."Location Code Filter" := LocationCodeFilter;


                    ItemLedEntryR.Reset;
                    ItemLedEntryR.SetRange("Item No.", ItemInvR."Item No.");
                    ItemLedEntryR.SetRange("Location Code", ItemInvR."Location Code");
                    if ItemLedEntryR.FindSet then
                        repeat
                            ItemLedEntryR.CalcSums(Quantity);
                            ItemInvR."Sum Qty" := ItemLedEntryR.Quantity;
                        until ItemLedEntryR.Next = 0;
                    ItemInvR.Reset;
                    ItemInvR.SetRange("Item No.", ItemInvR."Item No.");
                    ItemInvR.SetRange("Location Code", ItemInvR."Location Code");
                    if ItemInvR.FindSet then
                        repeat
                            ItemInvR.Delete;
                        until ItemInvR.Next = 0;


                    ItemInvR.Insert;

                until ItemLedEntryRec.Next = 0;
        end;
    end;
}

