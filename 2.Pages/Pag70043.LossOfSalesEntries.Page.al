page 70043 "Loss Of Sales Entries"
{
    ApplicationArea = All;
    Caption = 'Loss Of Sales Entries';
    //CardPageID = "Loss Of Sales Entries";
    PageType = List;
    SourceTable = "Loss Of Sales Entry";
    SourceTableView = SORTING(Date)
                      ORDER(Descending);
    UsageCategory = Lists;
    CardPageId = "Loss Of Sales Entry Card";

    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field("Transaction No."; Rec."Trans. No.")
                {
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    Enabled = false;
                }
                field("Barcode No."; Rec."Barcode No.")
                {
                    Enabled = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Enabled = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Enabled = false;
                }
                field("Packaging Info"; Rec."Packaging Info")
                {
                    Enabled = false;
                }

                field("Vendor No."; Rec."Vendor No.")
                {
                    Enabled = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Enabled = false;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Base Unit Of Measure"; Rec."Base Unit Of Measure")
                {
                }
                field("Base Qty Per UOM"; Rec."Base Qty Per UOM")
                {
                }
                field("Sales Price"; Rec."Sales Price")
                {
                    Enabled = false;
                }
                field("Entry Status"; Rec."Entry Status")
                {
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    Enabled = false;
                }
                field(Time; Rec.Time)
                {

                }

                field("Tablet User ID"; Rec."Tablet User ID")
                {
                    Caption = 'Tablet User';
                    Enabled = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Enabled = false;
                }
                field("Sales Loss Type"; Rec."Sales Loss Type")
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
        ItemUOMR: Record "Item Unit of Measure";
        ItemR: Record Item;
}

