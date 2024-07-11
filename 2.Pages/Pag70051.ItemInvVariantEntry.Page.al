page 70051 ItemInvVariantEntry
{
    DeleteAllowed = false;
    PageType = CardPart;
    SourceTable = ItemLedEntrySalesNWMM;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Location Filter"; LocationFIlter)
                {
                    TableRelation = Location.Code;
                }
                field("Item No Filter"; ItemNoFIlter)
                {
                    TableRelation = Item."No.";
                }
            }
        }
    }

    actions
    {
    }

    var
        ItemInvVarQU_ItemLedger: Query "Item Inv. VarSerialLot NWMM";
        ItemInvVarQU_TransSalesEntry: Query "Trans Header Trans Sales Entry";
        //POSInventoryJournalLine: Record "POS Inventory Journal Line";
        LocationFIlter: Code[50];
        ItemNoFIlter: Code[50];

    local procedure ItemLedgerEntryInsert()
    begin
    end;

    local procedure TransSalesEntryInsert()
    begin

        ItemInvVarQU_TransSalesEntry.SetFilter(Item_No, Rec."Item No.");
        //ItemInvVarQU_TransSalesEntry.SetFilter(Variant_Code, Rec."Variant Code");
        ItemInvVarQU_TransSalesEntry.SetFilter(Location_Code, Rec."Location Code");
        ItemInvVarQU_TransSalesEntry.Open;
        while ItemInvVarQU_TransSalesEntry.Read do begin
            Rec.TransSalesEntryQty := ItemInvVarQU_TransSalesEntry.Sum_TSE;
        end;
        ItemInvVarQU_TransSalesEntry.Close;
    end;

    [Scope('OnPrem')]
    procedure SetLocationCode(): Code[50]
    begin

        exit(LocationFIlter);
    end;

    [Scope('OnPrem')]
    procedure SetItemCode(): Code[50]
    begin

        exit(ItemNoFIlter);
    end;
}

