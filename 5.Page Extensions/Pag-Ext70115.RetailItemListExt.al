pageextension 70115 "Retail Item List Ext" extends "LSC Retail Item List"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
            field("Variant Framework Code"; Rec."LSC Variant Framework Code")
            {
                ApplicationArea = All;
            }
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
            }
            field("Item Family Code"; Rec."LSC Item Family Code")
            {
                ApplicationArea = All;
            }
            field(Ingredient; Rec.Ingredient)
            {
                ApplicationArea = All;
                //MultiLine = true;
            }
            field(Usage; Rec.Usage)
            {
                ApplicationArea = All;
                //MultiLine = true;
            }
            field(Allergy; Rec.Allergy)
            {
                ApplicationArea = All;
                //MultiLine = true;
            }
            field("Available in POS"; Rec."Available in POS")
            {
                ApplicationArea = All;
            }
            field("Complication and Side Effects"; Rec."Complication and Side Effects")
            {
                ApplicationArea = All;
                //MultiLine = true;
            }
            field("Mode of Application"; Rec."Mode of Application")
            {
                Caption = 'Mode of Administration';
                ApplicationArea = All;
                //MultiLine = true;
            }
            field("Search Descriptions"; Rec."Search Description")
            {
                ApplicationArea = All;
                // MultiLine = true;
            }

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
            // field("Item Catg Code Name"; Rec."Item Catg Code Name")
            // {
            //     ApplicationArea = All;
            // }
        }
        addafter("Retail Product Code")
        {
            field("Retail Product Code Description"; Rec."Retail Product CodeDescription")
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Description")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = All;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
            }
            field("Brand Code"; Rec."Brand Code")
            {
                ApplicationArea = All;
            }
            field("Brand Name"; Rec."Brand Name")
            {
                ApplicationArea = All;
            }
        }

        // addafter(Control1900383207)
        // {
        //     part(ItemAttributesFactbox; "Item Attributes Factbox")
        //     {
        //         ApplicationArea = All;

        //     }
        // }
        addafter(Control1900383207)
        {
            part(ItemAttributesFactbox; "Item Attributes Factbox")
            {
                ApplicationArea = All;
                //Visible = false;

            }
            part(itemstatusfactbox; "LSC Item Status Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = FIELD("No.");
            }
            // part(iteminvfactbox; "LSC Item Inventory FactBox")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "No." = FIELD("No."),
            //                   "Date Filter" = FIELD("Date Filter"),
            //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
            //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter"),
            //                   "LSC Store Filter" = FIELD("LSC Store Filter"),
            //                   "Location Filter" = FIELD("Location Filter"),
            //                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
            //                   "Bin Filter" = FIELD("Bin Filter"),
            //                   "Variant Filter" = FIELD("Variant Filter"),
            //                   "Lot No. Filter" = FIELD("Lot No. Filter"),
            //                   "Serial No. Filter" = FIELD("Serial No. Filter");
            // }
            part(planning; "Item Planning FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
            part(warehouse; "Item Warehouse FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }

        }
        modify(Control1906840407)
        {
            Visible = false;
        }
        modify(Control1901796907)
        {
            Visible = false;
        }
    }

    actions
    {
        addafter("&Units of Measure")
        {
            action("NAVAttributes")
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PAGE.RUNMODAL(PAGE::"Item Attribute ValueEditorNWMM", Rec);
                    CurrPage.SAVERECORD;
                    // @22_Jun_2021_09_54_AM
                    CurrPage.ItemAttributesFactbox.PAGE.LoadItemAttributesData(Rec."No.");
                end;
            }

            action("NAVFilterByAttributes")
            {
                Caption = 'NAV Filter by Attributes';
                ApplicationArea = All;
                Image = EditFilter;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    FilterPageID: Integer;
                    ClientTypeManagement: Codeunit "Client Type Management";
                    CloseAction: Action;
                    TempFilterItemAttributesBuffer: Record "Filter Item Attributes Buffer" temporary;
                    ItemAttributeManagement: Codeunit "Item Attribute Management";
                    TempItemFilteredFromAttributes: Record Item temporary;
                    ParameterCount: Integer;
                    TypeHelper: Codeunit "Type Helper";
                    FilterText: Text;
                    TempFilteredItem: Record "LSC Offer Item Buffer" temporary;
                    AttributeUtils: Codeunit "LSC Attribute Utils";
                    AttributeFilterBuffer: Record "LSC Attribute Filter Buffer" temporary;

                begin
                    FilterPageID := PAGE::"Filter Items by Attribute";
                    IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone THEN
                        FilterPageID := PAGE::"Filter Items by Att. Phone";

                    CloseAction := PAGE.RUNMODAL(FilterPageID, TempFilterItemAttributesBuffer);
                    IF (ClientTypeManagement.GetCurrentClientType <> CLIENTTYPE::Phone) AND (CloseAction <> ACTION::LookupOK) THEN
                        EXIT;

                    IF TempFilterItemAttributesBuffer.ISEMPTY THEN BEGIN
                        ClearAttributesFilter;
                        EXIT;
                    END;

                    ItemAttributeManagement.FindItemsByAttributes(TempFilterItemAttributesBuffer, TempItemFilteredFromAttributes);

                    if PAGE.RunModal(Page::"LSC Attribute Filter", AttributeFilterBuffer) = ACTION::LookupOK then begin
                        AttributeUtils.FindItemsByAttribute(AttributeFilterBuffer, TempFilteredItem);
                        if TempFilteredItem.Count < TypeHelper.GetMaxNumberOfParametersInSQLQuery - 100 then begin
                            FilterText := AttributeUtils.GetItemsByAttributeFilterText(TempFilteredItem);
                            Rec.FilterGroup(0);
                            Rec.MarkedOnly(false);
                            Rec.SetFilter("No.", FilterText);
                        end else
                            if TempFilteredItem.FindSet then begin
                                Rec.ClearMarks;
                                Rec.Reset;
                                repeat
                                    Rec.Get(TempFilteredItem."Item No.");
                                    Rec.Mark(true);
                                until TempFilteredItem.Next = 0;
                                TempFilteredItem.FindFirst;
                                Rec.Get(TempFilteredItem."Item No.");
                                Rec.MarkedOnly(true);
                            end;
                    end;
                end;

            }

            action("NAVClearAttributes")
            {
                ApplicationArea = All;
                Caption = 'NAV Clear Attributes Filter';
                Image = RemoveFilterLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    TempItemFilteredFromAttributes: Record Item temporary;
                    RunOnTempRec: Boolean;
                begin
                    ClearAttributesFilter;
                    TempItemFilteredFromAttributes.RESET;
                    TempItemFilteredFromAttributes.DELETEALL;
                    RunOnTempRec := FALSE;

                    RestoreTempItemFilteredFromAttributes;
                end;
            }
            action("Missing Price & UOM Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = ALl;
                trigger OnAction()
                var
                    ItemR: Record Item;
                begin
                    REPORT.RUNMODAL(70025, TRUE, FALSE, ItemR);
                end;
            }

        }
        modify("&Prices")
        {
            Caption = 'Purchase Prices';
            ApplicationArea = All;
        }
        modify(Action1100409080)
        {
            Caption = 'Sales Prices';
            ApplicationArea = All;
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.ItemAttributesFactbox.Page.LoadItemAttributesData((Rec."No."));



    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Item Catg Code Description");
        Rec.CalcFields("Division Code Description");

    end;

    procedure ShowCodeDescription()
    var
        ItemR: Record Item;
        DivisionR: Record "LSC Division";
        ItemCategoryR: Record "Item Category";
        RetailProductR: Record "LSC Retail Product Group";
        retil: page "LSC Retail Item List";
    begin

        // ItemJournalTemplateLC.RESET;
        // IF ItemJournalTemplateLC.FINDSET THEN
        //  REPEAT
        //    ItemJournalTemplateLC.Remark := Rec.Remark;
        //    ItemJournalTemplateLC.MODIFY(TRUE);
        //  UNTIL ItemJournalTemplateLC.NEXT = 0

        ItemR.RESET;
        IF ItemR.FINDSET THEN
            REPEAT
                DivisionR.RESET;
                DivisionR.SETRANGE(Code, ItemR."LSC Division Code");
                IF DivisionR.FINDFIRST THEN BEGIN
                    //ItemR."Division Code Name" := DivisionR.Description;
                    ItemR."Division Code Description" := DivisionR.Description;
                END;

                ItemCategoryR.RESET;
                ItemCategoryR.SETRANGE(Code, ItemR."Item Category Code");
                IF ItemCategoryR.FINDFIRST THEN BEGIN
                    //ItemR."Item Catg Code Name" := ItemCategoryR.Description;
                    ItemR."Item Catg Code Description" := ItemCategoryR.Description;
                END;

                RetailProductR.RESET;
                RetailProductR.SETRANGE(Code, ItemR."LSC Retail Product Code");
                IF RetailProductR.FINDFIRST THEN BEGIN
                    //ItemR."Retail Product Code Name" := RetailProductR.Description;
                    ItemR."Retail Product CodeDescription" := RetailProductR.Description;
                END;
                ItemR.MODIFY(TRUE);
            UNTIL ItemR.NEXT = 0;
        //ItemR.SETRANGE

    end;

    local procedure RestoreTempItemFilteredFromAttributes()
    var
        TempItemFilteredFromAttributes: Record Item temporary;
        RunOnPickItem: Boolean;
        RunOnTempRec: Boolean;
        TempItemFilteredFromPickItem: Record Item temporary;
    begin
        IF NOT RunOnPickItem THEN
            EXIT;

        TempItemFilteredFromAttributes.RESET;
        TempItemFilteredFromAttributes.DELETEALL;
        RunOnTempRec := TRUE;

        IF TempItemFilteredFromPickItem.FINDSET THEN
            REPEAT
                TempItemFilteredFromAttributes := TempItemFilteredFromPickItem;
                TempItemFilteredFromAttributes.INSERT;
            UNTIL TempItemFilteredFromPickItem.NEXT = 0;

    end;

    local procedure ClearAttributesFilter()
    var
        TempFilterItemAttributesBuffer: Record Item temporary;
    begin
        Rec.CLEARMARKS;
        Rec.MARKEDONLY(FALSE);
        TempFilterItemAttributesBuffer.RESET;
        TempFilterItemAttributesBuffer.DELETEALL;
        Rec.FILTERGROUP(0);
        Rec.SETRANGE("No.");

    end;



}
