page 70050 ItemInvVarSerialLot
{
    Editable = false;
    PageType = List;
    SourceTable = ItemInvVarSerialLot;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Location Filter"; LocationCodeG)
                {
                }
                field("Item Filter"; ItemNoG)
                {
                }
            }
            repeater("<Control10014514>")
            {
                Caption = '<Control10014514>';
                field("Modifed Date"; Rec."Modifed Date")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                // field("Variant Code"; Rec."Variant Code")
                // {
                // }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Serial No."; Rec."Serial No.")
                {
                }
                field("Lot No."; Rec."Lot No.")
                {
                }
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field(Quantity; Rec."Sum Quantity")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Calculation)
            {
                action("Refresh Calculation")
                {
                    Visible = false;

                    trigger OnAction()
                    begin

                        // ItemLedEntry.RESET;
                        // ItemLedEntry.SETRANGE("Item No.",ItemVariantTable."Item No.");
                        // ItemLedEntry.SETRANGE("Variant Code",ItemVariantTable."Variant Code");
                        // ItemLedEntry.SETRANGE("Location Code",ItemVariantTable."Location Code");
                        // IF ItemLedEntry.FINDSET THEN
                        //  REPEAT
                        //    MESSAGE('%1',ItemVariantTable.COUNT);
                        //    ItemLedEntry.CALCSUMS(Quantity);
                        //     ItemVariantTable."Sum Quantity" := ItemLedEntry.Quantity;
                        //     ItemVariantTable.MODIFY(TRUE);
                        //    UNTIL ItemLedEntry.NEXT = 0;
                        //    MESSAGE('Success');
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        ItemNoG := '';
        LocationCodeG := '';

        // ItemLedEntrySalesNWMMR.RESET;
        // GetLocation_ItemNoPage.SETRECORD(ItemLedEntrySalesNWMMR);
        // GetLocation_ItemNoPage.EDITABLE(TRUE);
        // GetLocation_ItemNoPage.LOOKUPMODE(TRUE);
        if GetLocation_ItemNoPage.RunModal = ACTION::LookupCancel then begin
            Clear(GetLocation_ItemNoPage);
            Error('Please,enter Item No OR Location!');
        end

        else begin

            GetLocation_ItemNoPage.GetRecord(ItemLedEntrySalesNWMMR);
            ItemNoG := GetLocation_ItemNoPage.SetItemCode;
            LocationCodeG := GetLocation_ItemNoPage.SetLocationCode;

        end;


        if ItemNoG <> '' then
            ItemInvVarSerialLotQU.SetFilter(ItemInvVarSerialLotQU.Item_No, ItemNoG);

        if LocationCodeG <> '' then
            ItemInvVarSerialLotQU.SetFilter(ItemInvVarSerialLotQU.Location_Code, LocationCodeG);
        ItemInvVarSerialLotQU.Open;
        while ItemInvVarSerialLotQU.Read do begin

            Rec.Init;
            Rec."No." := Rec."No." + 1;
            Rec."Item No." := ItemInvVarSerialLotQU.Item_No;

            ItemR.Reset;
            ItemR.SetRange("No.", Rec."Item No.");
            if ItemR.FindFirst then begin

                Rec."Item Description" := ItemR.Description;

            end;

            //Rec."Variant Code" := ItemInvVarSerialLotQU.Variant_Code;
            Rec."Location Code" := ItemInvVarSerialLotQU.Location_Code;
            Rec."Serial No." := ItemInvVarSerialLotQU.Serial_No;
            Rec."Lot No." := ItemInvVarSerialLotQU.Lot_No;
            Rec."Sum Quantity" := ItemInvVarSerialLotQU.Sum_Quantity;
            Rec."Modifed Date" := CurrentDateTime;
            Rec.Insert;

        end;

        ItemInvVarSerialLotQU.Close;
    end;

    var
        ItemInvVarSerialLotQU: Query "LSC Item Inv. VarSerialLot";
        ItemLedEntry: Record "Item Ledger Entry";
        ItemVariantTable: Record ItemInvVarSerialLot;
        ItemR: Record Item;
        GetLocation_ItemNoPage: Page ItemInvVariantEntry;
        ItemNoG: Code[100];
        LocationCodeG: Code[100];
        ItemLedEntrySalesNWMMR: Record ItemLedEntrySalesNWMM;
        NoG: Integer;
}

