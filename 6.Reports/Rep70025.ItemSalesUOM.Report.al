report 70025 "Item Sales UOM"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/ItemSalesUOM.rdl';
    Caption = 'Missing Price & UOM Report';
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(VendorNo; Item."Vendor No.")
            {
            }
            column(VendorName; Item."Vendor Name")
            {
            }
            dataitem("Item Unit of Measure"; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = FIELD("No.");
                column(Code_ItemUnitofMeasure; "Item Unit of Measure".Code)
                {
                }
                dataitem("Sales Price"; "Sales Price")
                {
                    DataItemLink = "Item No." = FIELD("Item No."), "Unit of Measure Code" = FIELD(Code);
                    column(UnitofMeasureCode_SalesPrice; "Sales Price"."Unit of Measure Code")
                    {
                    }
                    column(StartingDate_SalesPrice; "Sales Price"."Starting Date")
                    {
                    }
                    column(EndingDate_SalesPrice; "Sales Price"."Ending Date")
                    {
                    }
                    column(VariantCode_SalesPrice; "Sales Price"."Variant Code")
                    {
                    }
                    column(HideUOM; HideUOM)
                    {
                    }
                    column(HideUOM1; HideUOM1)
                    {
                    }
                    column(HideUOM2; HideUOM2)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        HideUOM := 0;
                        HideUOM1 := 0;
                        HideUOM2 := 0;

                        repeat

                            if ("Sales Price"."Starting Date" = 0D) and ("Sales Price"."Ending Date" = 0D) then
                                HideUOM := 1;

                            if "Sales Price"."Ending Date" <> 0D then
                                if ("Sales Price"."Ending Date" >= Today) then
                                    HideUOM1 := 1;

                            if ("Sales Price"."Starting Date" <> 0D) and ("Sales Price"."Ending Date" = 0D) then
                                HideUOM2 := 1;

                        until "Sales Price".Next = 0;
                    end;
                }
            }

            trigger OnPreDataItem()
            begin

                if AvailableInPOS = true then begin

                    Item.SetRange("Available in POS", true);

                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Available In POS"; AvailableInPOS)
                    {
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin

            AvailableInPOS := true;
        end;
    }

    labels
    {
    }

    var
        HideUOM: Integer;
        HideUOM1: Integer;
        HideUOM2: Integer;
        SalesPrice: Record "Sales Price";
        AvailableInPOS: Boolean;
}

