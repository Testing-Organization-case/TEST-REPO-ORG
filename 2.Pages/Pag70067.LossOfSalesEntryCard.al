page 70067 "Loss Of Sales Entry Card"
{
    ApplicationArea = All;
    Caption = 'Loss Of Sales Entry Card';
    PageType = Card;
    SourceTable = "Loss Of Sales Entry";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Trans. No."; Rec."Trans. No.")
                {
                    ToolTip = 'Specifies the value of the Trans. No. field.';
                    Enabled = false;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ToolTip = 'Specifies the value of the Transaction No. field.';
                }
                field("Barcode No."; Rec."Barcode No.")
                {
                    ToolTip = 'Specifies the value of the Barcode No. field.';
                }
                field("Base Qty Per UOM"; Rec."Base Qty Per UOM")
                {
                    ToolTip = 'Specifies the value of the Base Qty Per UOM field.';
                }
                field("Base Unit Of Measure"; Rec."Base Unit Of Measure")
                {
                    ToolTip = 'Specifies the value of the Base Unit Of Measure field.';
                }
                field("Catalog Item No."; Rec."Catalog Item No.")
                {
                    ToolTip = 'Specifies the value of the Catalog Item No. field.';
                    Visible = false;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Time"; Rec."Time")
                {
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field("Entry Status"; Rec."Entry Status")
                {
                    ToolTip = 'Specifies the value of the Entry Status field.';
                }
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';

                    trigger OnValidate()
                    var
                        ItemL: Record Item;
                    begin

                        ItemL.Reset();
                        ItemL.SetRange("No.", Rec."Item No.");
                        if ItemL.FindSet() then
                            repeat

                                Rec."Item Description" := ItemL.Description;
                                Rec."Packaging Info" := ItemL."Packaging Info";

                            until ItemL.Next() = 0;
                    end;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                    Enabled = false;
                }
                field("Packaging Info"; Rec."Packaging Info")
                {
                    ToolTip = 'Specifies the value of the Packaging Info field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }

                field("Sales Loss Type"; Rec."Sales Loss Type")
                {
                    ToolTip = 'Specifies the value of the Sales Loss Type field.';
                }
                field("Sales Price"; Rec."Sales Price")
                {
                    ToolTip = 'Specifies the value of the Sales Price field.';
                }
                field("Tablet User ID"; Rec."Tablet User ID")
                {
                    ToolTip = 'Specifies the value of the Tablet User ID field.';
                }


                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.';
                }

                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Variant Description"; Rec."Variant Description")
                {
                    ToolTip = 'Specifies the value of the Variant Description field.';
                }


            }
        }
    }
}
