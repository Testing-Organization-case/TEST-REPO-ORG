report 70030 "Stock Balance Data Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/StockBalanceDataReport.rdl';
    ApplicationArea = All;


    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(DocumentType; "Item Ledger Entry"."Document Type")
            {
            }
            column(ItemNo; "Item Ledger Entry"."Item No.")
            {
            }
            column(VendorNo; "Item Ledger Entry"."Vendor No.")
            {
            }
            column(ItemDesc; "Item Ledger Entry".Description)
            {
            }
            column(LocationCode; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity; "Item Ledger Entry".Quantity)
            {
            }
            column(VCode; "Item Ledger Entry"."Variant Code")
            {
            }
            column(PurchQty; purchQty)
            {
            }
            column(SalesQty; salesQty)
            {
            }
            column(PurchRetQty; purchRetrunQty)
            {
            }
            column(SalesRetQty; salesReturnQty)
            {
            }
            column(BaseUOM; baseUOM)
            {
            }
            column(PackingInfo; packInfo)
            {
            }
            column(VenName; vendorName)
            {
            }
            column(VarDesc; varDesc)
            {
            }
            column(ReasonCode; reasonCode)
            {
            }

            trigger OnAfterGetRecord()
            begin
                purchQty := 0;
                salesQty := 0;
                purchRetrunQty := 0;
                salesReturnQty := 0;
                vendorName := '';
                reasonCode := '';
                ItemLedger.Reset;
                ItemLedger.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                ItemLedger.SetRange("Location Code", "Item Ledger Entry"."Location Code");
                ItemLedger.SetRange("Variant Code", "Item Ledger Entry"."Variant Code");
                ItemLedger.SetFilter("Entry Type", '%1|%2', "Item Ledger Entry"."Entry Type"::Sale, "Item Ledger Entry"."Entry Type"::Purchase);
                ItemLedger.SetRange("Posting Date", startingDate, endingDate);
                if ItemLedger.FindSet then
                    repeat
                        with ItemLedger do begin
                            case "Document Type" of
                                "Document Type"::"Purchase Receipt":
                                    purchQty += ItemLedger.Quantity;
                                "Document Type"::"Sales Shipment":
                                    salesQty += ItemLedger.Quantity;
                                "Document Type"::"Purchase Return Shipment":
                                    begin
                                        if ItemLedger."Return Reason Code" <> '' then begin
                                            if reasonCode = '' then
                                                reasonCode := ItemLedger."Return Reason Code";
                                        end;
                                        purchRetrunQty += ItemLedger.Quantity;
                                    end;
                                "Document Type"::"Sales Return Receipt":
                                    salesReturnQty += ItemLedger.Quantity;
                                "Document Type"::" ":
                                    begin
                                        if "Entry Type" = "Entry Type"::Sale then
                                            salesQty += ItemLedger.Quantity;
                                    end;
                            end;
                        end;

                    until ItemLedger.Next = 0;
                getUOM;
                getVendorName;
                getVariantDesc;
            end;

            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SetFilter("Entry Type", '%1|%2', "Item Ledger Entry"."Entry Type"::Sale, "Item Ledger Entry"."Entry Type"::Purchase);
                if Item <> '' then
                    "Item Ledger Entry".SetRange("Item No.", Item);
                if location <> '' then
                    "Item Ledger Entry".SetRange("Location Code", location);
                if (startingDate <> 0D) and (endingDate <> 0D) then
                    "Item Ledger Entry".SetRange("Posting Date", startingDate, endingDate)
                else
                    Error('The Report could not be created! Starting Date & Ending Date must have value');

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control10014500)
                {
                    ShowCaption = false;
                    field(Item; Item)
                    {
                        Caption = 'Item No';
                        TableRelation = Item;
                    }
                    field(location; location)
                    {
                        Caption = 'Location';
                        TableRelation = Location;
                    }
                    field(startingDate; startingDate)
                    {
                        Caption = 'Starting Date';
                        ShowMandatory = true;
                    }
                    field(endingDate; endingDate)
                    {
                        Caption = 'Ending Date';
                        ShowMandatory = true;
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

    var
        Item: Code[50];
        location: Code[50];
        vendor: Code[20];
        startingDate: Date;
        endingDate: Date;
        ItemLedger: Record "Item Ledger Entry";
        purchQty: Decimal;
        salesQty: Decimal;
        purchRetrunQty: Decimal;
        salesReturnQty: Decimal;
        baseUOM: Code[10];
        packInfo: Text[30];
        vendorName: Text[100];
        varDesc: Text[100];
        reasonCode: Code[100];

    local procedure getUOM()
    var
        ItemR: Record Item;
    begin
        ItemR.Reset;
        ItemR."No." := "Item Ledger Entry"."Item No.";
        if ItemR.Find('=') then begin
            baseUOM := ItemR."Base Unit of Measure";
            packInfo := ItemR."Packaging Info";
        end;

    end;

    local procedure getVendorName()
    var
        VendorR: Record Vendor;
    begin
        VendorR.Reset;
        VendorR."No." := "Item Ledger Entry"."Vendor No.";
        if VendorR.Find('=') then
            vendorName := VendorR.Name;
    end;

    local procedure getVariantDesc()
    var
        ItemVar: Record "Item Variant";
    begin
        ItemVar.Reset;
        ItemVar.SetRange(Code, "Item Ledger Entry"."Variant Code");
        ItemVar.SetRange("Item No.", "Item Ledger Entry"."Item No.");
        if ItemVar.FindFirst then
            varDesc := ItemVar."Description 2";
    end;
}

