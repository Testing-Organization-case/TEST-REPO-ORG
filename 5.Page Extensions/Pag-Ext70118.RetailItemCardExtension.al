pageextension 70118 "Retail Item Card Extension" extends "LSC Retail Item Card"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }

        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field(Ingredient; Rec.Ingredient)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            // field("Ingredient 1"; Rec."Ingredient 1")
            // {
            //     ApplicationArea = All;
            // }
            // field("Ingredient 2"; Rec."Ingredient 2")
            // {
            //     ApplicationArea = All;
            // }
            // field("Ingredient 3"; Rec."Ingredient 3")
            // {
            //     ApplicationArea = All;
            // }
            // field("Ingredient 4"; Rec."Ingredient 4")
            // {
            //     ApplicationArea = All;
            // }
            field(Usage; Rec.Usage)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field(Allergy; Rec.Allergy)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Complication and Side Effects"; Rec."Complication and Side Effects")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Mode of Application"; Rec."Mode of Application")
            {
                Caption = 'Mode of Administration';
                ApplicationArea = All;
                MultiLine = true;
            }
            // field("Division Code"; Rec."Division Code")
            // {

            // }
        }
        addafter("Division Code")
        {
            field("Division Code Description"; Rec."Division Code Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item Category Code")
        {
            field("Item Catg Code Description"; Rec."Item Catg Code Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("Retail Product Code")
        {
            field("Retail Product Code Description"; Rec."Retail Product CodeDescription")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Price Including VAT")
        {
            field("E-Commerce"; Rec."E-Commerce")
            {
                ApplicationArea = All;
            }
            field("FDA Registration No."; Rec."FDA Registration No.")
            {
                ApplicationArea = All;
            }
            field("FDA Reg. Date"; Rec."FDA Reg. Date")
            {
                ApplicationArea = All;
            }

        }
        addafter("Common Item No.")
        {
            field("Brand Code"; Rec."Brand Code")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    BrandR: Record Brand;
                begin
                    BrandR.RESET;
                    BrandR.SETRANGE(Code, Rec."Brand Code");
                    IF BrandR.FINDFIRST THEN
                        REPEAT
                            Rec."Brand Name" := BrandR.Description;
                            Rec.MODIFY;
                        UNTIL BrandR.NEXT = 0;
                    IF Rec."Brand Code" = '' THEN
                        Rec."Brand Name" := '';
                end;
            }
            field("Brand Name"; Rec."Brand Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Automatic Ext. Texts")
        {
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = All;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
            }
        }
        addafter("Profit %")
        {
            field("No Stock Posting"; Rec."No Stock Posting")
            {
                ApplicationArea = All;
            }
        }
        addafter("Base Unit of Measure")
        {
            field("Base Comp. Unit Code"; Rec."Base Comp. Unit Code")
            {
                ApplicationArea = All;
            }
            field("Qty. per Base Comp. Unit"; Rec."Qty. per Base Comp. Unit")
            {
                ApplicationArea = All;
            }
            field("Comparison Unit Code"; Rec."Comparison Unit Code")
            {
                ApplicationArea = All;
            }
            field("Comp. Price Incl. VAT"; Rec."Comp. Price Incl. VAT")
            {
                ApplicationArea = All;
            }
        }
        addafter("Vendor No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purch. Unit of Measure")
        {
            field(Distributor; Rec.Distributor)
            {
                ApplicationArea = All;
            }
            field("Distributor Name"; Rec."Distributor Name")
            {
                ApplicationArea = All;
            }
            field(Manufacturer; Rec.Manufacturer)
            {
                ApplicationArea = All;
            }
            field("Manufacturer Name"; Rec."Manufacturer Name")
            {
                ApplicationArea = All;
            }
            // field("Reorder Point"; Rec."Reorder Point")
            // {
            //     ApplicationArea = All;
            // }
            // field("Reorder Quantity"; Rec."Reorder Quantity")
            // {
            //     ApplicationArea = All;
            // }
            // field("Reordering Policy"; Rec."Reordering Policy")
            // {
            //     ApplicationArea = All;
            // }
            // field("Safety Lead Time"; Rec."Safety Lead Time")
            // {
            //     ApplicationArea = All;
            // }
            // field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
            // {
            //     ApplicationArea = All;
            // }
            // field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
            // {
            //     ApplicationArea = All;
            // }
            // field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
            // {

            // }
            // field("Order Multiple"; Rec."Order Multiple")
            // {
            //     ApplicationArea = All;
            // }
        }
        addafter("Qty not in Decimal")
        {
            field("Available in POS"; Rec."Available in POS")
            {
                ApplicationArea = ALl;
            }
        }

        addafter(Control1100409002)
        {
            part(ItemAttributesFactboxCard; "Item Attributes Factbox")
            {
                ApplicationArea = All;
                Visible = false;

            }
        }
        addafter(ItemAttributesFactboxCard)
        {
            part(ItemStatusFactbox; "LSC Item Status Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = FIELD("No.");
            }
            part(ItemInvFactbox; "LSC Item Inventory FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter"),
                              "LSC Store Filter" = FIELD("LSC Store Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
            }

            part(planningcard; "Item Planning FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(warehousecard; "Item Warehouse FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }

        }
        modify(Control1100409034)
        {
            Visible = false;
        }
        modify(Control1100409003)
        {
            Visible = false;
        }
        // modify("Division Code")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         Division: Record "LSC Division";
        //     begin
        //         if Rec."LSC Division Code" <> '' then begin
        //             Division.Reset();
        //             Division.SetRange(Code, Rec."LSC Division Code");
        //             If Division.FindFirst() then
        //                 repeat
        //                     // Rec.CALCFIELDS("Division Code Description");
        //                     //Rec."Division Code Description" := Division.Description;
        //                     //Rec."Item Catg Code Description" := '';
        //                     //Rec."Retail Product CodeDescription" := '';

        //                     Rec.Modify();
        //                 until Division.Next() = 0;

        //         end
        //         else
        //             Rec."Division Code Description" := '';

        //     end;
        // }
        // modify("Item Category Code")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         ItemCategory: Record "Item Category";
        //     begin
        //         ItemCategory.Reset();
        //         ItemCategory.SetRange(Code, Rec."Item Category Code");
        //         If ItemCategory.FindFirst() then
        //             repeat
        //                 Rec."Item Catg Code Description" := ItemCategory.Description;
        //                 Rec.Modify();
        //             until ItemCategory.Next() = 0;
        //     end;
        // }

    }
    actions
    {
        addafter("Page Item Units of Measure")
        {
            action(NAVAttributes)
            {
                Caption = 'Attributes';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PAGE.RUNMODAL(PAGE::"Item Attribute ValueEditorNWMM", Rec);
                    CurrPage.SAVERECORD;
                    // @22_Jun_2021_09_54_AM
                    CurrPage.ItemAttributesFactbox.PAGE.LoadItemAttributesData(Rec."No.");
                end;
            }
        }
        addafter(Translations)
        {
            action(Picture)
            {
                Caption = 'Picture';
                ApplicationArea = All;
                Image = Picture;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "Item Picture";
                RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter"), "Bin Filter" = FIELD("Bin Filter");
            }
        }
        addafter("Item HTML Web")
        {
            action("Item HTML Windows")
            {
                Caption = 'Item& HTML';
                Image = ElectronicDoc;
                Visible = VisibleInWinClient;
                RunObject = page "LSC Item HTML";
                RunPageLink = "Item No." = FIELD("No.");
            }
        }
        addafter("Substituti&ons")
        {
            action("Page Item Cross Reference Entries")
            {
                Caption = 'Cross Re&ferences';
                ApplicationArea = ALl;
                Image = Change;
                RunObject = page "Item Reference Entries";
                RunPageLink = "Item No." = FIELD("No.");
            }
            action("Page Item Identifiers")
            {
                ApplicationArea = ALl;
                Caption = 'Identifiers';
                Image = BarCode;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "Item Identifiers";
                RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                RunPageLink = "Item No." = FIELD("No.");
            }
        }
        addafter("BOM Level")
        {
            action(Timeline)
            {
                ApplicationArea = ALl;
                Image = Timeline;
                trigger OnAction()
                begin
                    Rec.ShowTimelineFromItem(Rec);
                end;
            }
        }
        addafter("Skilled Resources")
        {
            action("Add Item to Catalog")
            {
                ApplicationArea = All;
                trigger OnAction()
                // var
                //     LSRecommendsFunctions: Codeunit "LS Recommends Functions";
                begin
                    // LSRecommendsFunctions.Initialize(FALSE);
                    // LSRecommendsFunctions.AddItemToCatalog(Rec);
                end;
            }
        }
        modify("&Prices")
        {
            Caption = 'Purchase Prices';
            ApplicationArea = All;
        }
        modify(Action1100409148)
        {
            Caption = 'Sales Prices';
            ApplicationArea = All;
        }
    }

    var
        VisibleInWinClient: Boolean;

}

