page 70066 "Transaction Sales Entries"
{
    ApplicationArea = All;
    Caption = 'Trans Sales Entries';
    DataCaptionExpression = SetDataCaptionFieldsExp;
    Editable = false;
    PageType = List;
    SourceTable = "LSC Trans. Sales Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Barcode No."; Rec."Barcode No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.OpenRetailItemCard();
                    end;

                    trigger OnDrillDown()
                    begin
                        Rec.OpenRetailItemCard();
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = All;
                }
                field("POS Terminal No."; Rec."POS Terminal No.")
                {
                    ApplicationArea = All;
                }
                field("Staff ID"; Rec."Staff ID")
                {
                    ApplicationArea = All;
                }
                field("Sales Staff"; Rec."Sales Staff")
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field("Infocode Discount"; Rec."Infocode Discount")
                {
                    ApplicationArea = All;
                }
                field("Total Discount"; Rec."Total Discount")
                {
                    ApplicationArea = All;
                }
                field("Line Discount"; Rec."Line Discount")
                {
                    ApplicationArea = All;
                }
                field("Periodic Discount"; Rec."Periodic Discount")
                {
                    ApplicationArea = All;
                }
                field("Customer Discount"; Rec."Customer Discount")
                {
                    ApplicationArea = All;
                }
                field("Keyboard Item Entry"; Rec."Keyboard Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Price in Barcode"; Rec."Price in Barcode")
                {
                    ApplicationArea = All;
                }
                field("Line was Discounted"; Rec."Line was Discounted")
                {
                    ApplicationArea = All;
                }
                field("Item Number Scanned"; Rec."Item Number Scanned")
                {
                    ApplicationArea = All;
                }
                field("Scale Item"; Rec."Scale Item")
                {
                    ApplicationArea = All;
                }
                field("Weight Manually Entered"; Rec."Weight Manually Entered")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Recommended Item"; Rec."Recommended Item")
                {
                    ApplicationArea = All;
                }
            }
            // group(Control27)
            // {
            //     ShowCaption = false;
            //     field("Item Description"; ItemName)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Item Description';
            //         Editable = false;
            //     }
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&ntry")
            {
                Caption = 'E&ntry';
                action("T&ransaction Card")
                {
                    ApplicationArea = All;
                    Caption = 'T&ransaction Card';
                    Image = Entries;
                    RunObject = Page "LSC Transaction Card";
                    RunPageLink = "Store No." = FIELD("Store No."),
                                  "POS Terminal No." = FIELD("POS Terminal No."),
                                  "Transaction No." = FIELD("Transaction No.");
                }
                action("Infoco&de Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Infoco&de Entries';
                    Image = CodesList;
                    RunObject = Page "LSC Trans. Infocode Entries";
                    RunPageLink = "Store No." = FIELD("Store No."),
                                  "POS Terminal No." = FIELD("POS Terminal No."),
                                  "Transaction No." = FIELD("Transaction No."),
                                  "Transaction Type" = CONST("Sales Entry"),
                                  "Line No." = FIELD("Line No.");
                    ShortCutKey = 'Shift+Ctrl+N';
                }
                action("Retail &Item Card")
                {
                    ApplicationArea = All;
                    Caption = 'Retail &Item Card';
                    Image = ItemLedger;
                    RunObject = Page "LSC Retail Item Card";
                    RunPageLink = "No." = FIELD("Item No.");
                }
                action("Additi&onal Salespersons")
                {
                    ApplicationArea = All;
                    Caption = 'Additi&onal Salespersons';
                    Image = SalesPerson;
                    RunObject = Page "LSC Trans. Add. Salesperson";
                    RunPageLink = "Store No." = FIELD("Store No."),
                                  "POS Terminal No." = FIELD("POS Terminal No."),
                                  "Transaction No." = FIELD("Transaction No."),
                                  "Line No." = FIELD("Line No.");
                }
                action("&Discount Entry")
                {
                    ApplicationArea = All;
                    Caption = '&Discount Entry';
                    Image = Discount;
                    RunObject = Page "LSC Trans. Discount Entries";
                    RunPageLink = "Store No." = FIELD("Store No."),
                                  "POS Terminal No." = FIELD("POS Terminal No."),
                                  "Transaction No." = FIELD("Transaction No."),
                                  "Line No." = FIELD("Line No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AfterGetCurrRecord;
    end;

    var
        Item: Record Item;
        ItemName: Text[100];

    local procedure AfterGetCurrRecord()
    begin
        xRec := Rec;
        if Item.Get(Rec."Item No.") then begin
            ItemName := Item.Description;
        end else
            Clear(ItemName);
    end;

    internal procedure SetDataCaptionFieldsExp(): Text;
    begin
        exit(Rec."Store No." + ' ∙ ' + Rec."POS Terminal No." + ' ∙ ' + Format(Rec."Transaction No."));
    end;
}
