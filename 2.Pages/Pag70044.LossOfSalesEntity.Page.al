page 70044 "Loss Of Sales Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'LossOfSalesEntity';
    EntitySetName = 'LossOfSalesEntity';
    DelayedInsert = true;           // add for API type
    PageType = API;
    SourceTable = "Loss Of Sales Entry";
    SourceTableView = SORTING(Date)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(transactionNo; Rec."Trans. No.")
                {
                    Caption = 'Transaction No';
                }
                field(transactionCode; Rec."Transaction Code")
                {
                    Caption = 'Transaction Code';
                }
                field(barcode_No; Rec."Barcode No.")
                {
                    Caption = 'Barcode No';
                }
                field(item_No; Rec."Item No.")
                {
                    Caption = 'Item No';
                }
                field(item_Desc; Rec."Item Description")
                {
                    Caption = 'Item Description';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(variant_Desc; Rec."Variant Description")
                {
                    Caption = 'Variant  Description';
                }
                field(sales_prices; Rec."Sales Price")
                {
                    Caption = 'Sales Prices';
                }
                field(UOMCode; Rec."Unit Of Measure Code")
                {
                    Caption = 'UOM Code';
                }
                field(catalog_itemCode; Rec."Catalog Item No.")
                {
                    Caption = 'Catalog Item Code';
                }
                field(entry_status; Rec."Entry Status")
                {
                    Caption = 'Entry Status';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(date; Rec.Date)
                {
                    Caption = 'Date';
                }
                field(time; Rec.Time)
                {
                    Caption = 'Time';
                }

                field(tablet_user_id; Rec."Tablet User ID")
                {
                    Caption = 'Tablet User ID';
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(sales_loss_types; Rec."Sales Loss Type")
                {
                    Caption = 'Sales Loss Types';
                }
                field(packInfo; Rec."Packaging Info")
                {
                    Caption = 'Packaging Info';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        // "Transaction No." := 1;
        //
        // TempRec.RESET;
        // IF TempRec.FINDLAST THEN
        //  BEGIN
        //
        //      "Transaction No." := TempRec."Transaction No." + 1;
        //
        //    END;

        Rec.ID := CreateGuid;

        Rec."Transaction Code" := 'LOSSOFSALES';


        ItemR.Reset;
        ItemR.SetRange("No.", Rec."Item No.");
        if ItemR.FindSet then
            repeat

                Rec."Base Unit Of Measure" := ItemR."Base Unit of Measure";
                ItemUOMR.Reset;
                ItemUOMR.SetRange("Item No.", ItemR."No.");
                ItemUOMR.SetRange(Code, Rec."Unit Of Measure Code");
                if ItemUOMR.FindSet then
                    repeat

                        Rec."Base Qty Per UOM" := ItemUOMR."Qty. per Unit of Measure" * Rec.Quantity;

                    until ItemUOMR.Next = 0;

            until ItemR.Next = 0;
    end;

    var
        TempRec: Record "Loss Of Sales Entry";
        ItemUOMR: Record "Item Unit of Measure";
        ItemR: Record Item;
}

