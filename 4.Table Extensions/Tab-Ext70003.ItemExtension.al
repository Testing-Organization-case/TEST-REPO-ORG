tableextension 70003 "Item Extension" extends Item
{
    fields
    {
        field(70000; Ingredient; Text[2048])
        {
            Caption = 'Ingredient';
            DataClassification = ToBeClassified;
        }
        field(70001; Usage; Text[2048])
        {
            Caption = 'Usage';
            DataClassification = ToBeClassified;
        }
        field(70002; Allergy; Text[2048])
        {
            Caption = 'Allergy';
            DataClassification = ToBeClassified;
        }
        field(70003; "Complication and Side Effects"; Text[2048])
        {
            Caption = 'Complication and Side Effects';
            DataClassification = ToBeClassified;
        }
        field(70004; "Tag Filter"; Text[2048])
        {
            Caption = 'Tag Filter';
            DataClassification = ToBeClassified;
        }
        // field(70005; "Search Descriptions"; Text[2048])
        // {
        //     Caption = 'Search Descriptions';
        //     DataClassification = ToBeClassified;
        // }
        field(70006; "Packaging Info"; Text[30])
        {
            Caption = 'Packaging Info';
            DataClassification = ToBeClassified;
        }
        field(70007; Size; Text[30])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
        }
        field(70008; "Item Catg Code Description"; Text[150])
        {
            Caption = 'Item Catg Code Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD("Item Category Code")));
        }

        field(70009; "Division Code Description"; Text[150])
        {
            Caption = 'Division Code Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("LSC Division".Description WHERE(Code = FIELD("LSC Division Code")));

        }
        field(70010; "Retail Product CodeDescription"; Text[150])
        {
            Caption = 'Retail Product Code Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("LSC Retail Product Group".Description WHERE(Code = FIELD("LSC Retail Product Code")));
        }
        field(70011; "Vendor Name"; Text[150])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
        }
        // field(70012; "Enable Lead Time Calc"; Boolean)
        // {
        //     Caption = 'Enable Lead Time Calc';
        //     DataClassification = ToBeClassified;
        // }

        field(70017; "Distributor Name"; Text[150])
        {
            Caption = 'Distributor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD(Distributor)));
        }
        field(70018; "Manufacturer Name"; Text[150])
        {
            Caption = 'Manufacturer Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD(Manufacturer)));
        }
        field(70019; "Available in POS"; Boolean)
        {
            Caption = 'Available in POS';
            DataClassification = ToBeClassified;
        }
        // field(70020; "Date Created"; Date)
        // {
        //     Caption = 'Date Created';
        //     DataClassification = ToBeClassified;
        // }
        // field(70021; "Created by User"; Code[50])
        // {
        //     Caption = 'Created by User';
        //     DataClassification = ToBeClassified;
        // }

        // field(70023; "Retail Product Code"; Code[20])
        // {
        //     Caption = 'Retail Product Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = IF ("Item Category Code" = FILTER(<> '')) "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code")) ELSE
        //     "LSC Retail Product Group".Code;
        //     ValidateTableRelation = false;
        // }
        // field(70024; "Special Group Code"; Code[20])
        // {
        //     Caption = 'Special Group Code';
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup("LSC Item/Special Group Link"."Special Group Code" WHERE("Item No." = FIELD("No.")));
        //     Editable = false;
        //     trigger OnValidate()
        //     var
        //         ItemSpecialGr: Record "LSC Item/Special Group Link";
        //         ItemSpecialGrPage: Page "LSC Item/Special Group Links";
        //     begin
        //         //LS
        //         CLEAR(ItemSpecialGrPage);
        //         ItemSpecialGr.RESET;
        //         ItemSpecialGr.SETRANGE(ItemSpecialGr."Item No.", "No.");
        //         ItemSpecialGrPage.SETTABLEVIEW(ItemSpecialGr);
        //         ItemSpecialGrPage.RUNMODAL;
        //         CALCFIELDS("Special Group Code");

        //     end;
        // }
        field(70025; "Store Filter"; Code[10])
        {
            Caption = 'Store Filter';
            FieldClass = FlowFilter;
            TableRelation = "LSC Store";
            trigger OnValidate()
            var
                ProductExt: Codeunit "LSC Product Ext.";
            begin
                //LS
                IF GETFILTER("Store Filter") = '' THEN
                    SETRANGE("Location Filter");
                //LS-12335 CombineStoreLocationFilter(Rec);
                ProductExt.CombineStoreLocationFilter(Rec); //LS-12335
            end;
        }
        // field(70026; "Last Modified by User"; Code[50])
        // {
        //     Caption = 'Last Modified by User';
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        // field(70027; "Item Error Check Code"; Code[10])
        // {
        //     Caption = 'Item Error Check Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Item Error Check";
        // }
        // field(70028; "Item Error Check Status"; Option)
        // {
        //     OptionMembers = Unchecked,Passed,Failed;
        //     Caption = 'Item Error Check Status';
        //     DataClassification = ToBeClassified;
        // }
        // field(70029; "Suggested Qty. on POS"; Decimal)
        // {
        //     Caption = 'Suggested Qty. on POS';
        //     DataClassification = ToBeClassified;
        // }
        // field(70030; "Item Capacity Value"; Decimal)
        // {
        //     Caption = 'Item Capacity Value';
        //     DataClassification = ToBeClassified;
        // }
        // field(70031; "Qty not in Decimal"; Boolean)
        // {
        //     Caption = 'Qty not in Decimal';
        //     DataClassification = ToBeClassified;
        // }
        // field(70032; "Warranty Card"; Boolean)
        // {
        //     Caption = 'Warranty Card';
        //     DataClassification = ToBeClassified;
        // }
        // field(70033; "Def. Ordered by"; Option)
        // {
        //     OptionMembers = Store,Central;
        //     Caption = 'Def. Ordered by';
        //     DataClassification = ToBeClassified;
        // }
        // field(70034; "Def. Ordering Method"; Option)
        // {
        //     OptionMembers = "By hand",Calculate;
        //     Caption = 'Def. Ordering Method';
        //     DataClassification = ToBeClassified;
        // }
        // field(70035; "Original Vendor No."; Code[20])
        // {
        //     Caption = 'Original Vendor No.';
        //     DataClassification = ToBeClassified;
        //     TableRelation = Vendor;
        //     ValidateTableRelation = true;
        //     //TestTableRelation = true;
        // }
        // field(70036; "Original Vendor Item No."; Text[20])
        // {
        //     Caption = 'Original Vendor Item No.';
        //     DataClassification = ToBeClassified;
        // }
        // field(70037; "BOM Method"; Option)
        // {
        //     OptionMembers = "No Exploding","Explode at Entry","Explode at Posting",Produce;
        //     Caption = 'BOM Method';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         CASE "BOM Method" OF
        //             "BOM Method"::"No Exploding":
        //                 "Explode BOM in Statem. Posting" := FALSE;
        //             "BOM Method"::"Explode at Posting":
        //                 "Explode BOM in Statem. Posting" := TRUE;
        //             "BOM Method"::"Explode at Entry":
        //                 "Explode BOM in Statem. Posting" := FALSE;
        //             "BOM Method"::Produce:
        //                 "Explode BOM in Statem. Posting" := FALSE;
        //         END;
        //     end;
        // }
        // field(70038; "BOM Receipt Print"; Option)
        // {
        //     OptionMembers = Normal,Compressed;
        //     Caption = 'BOM Receipt Print';
        //     DataClassification = ToBeClassified;
        // }
        // field(70039; "Recipe Version Code"; Code[20])
        // {
        //     Caption = 'Recipe Version Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC BOM Version";
        //     trigger OnValidate()
        //     var
        //         BomComp: Record "BOM Component";
        //         BomVerComp: Record "LSC BOM Version Component";
        //         NxtLine: Integer;
        //     begin
        //         //LS
        //         IF xRec."Recipe Version Code" <> '' THEN BEGIN
        //             BomComp.RESET;
        //             BomComp.SETRANGE("Parent Item No.", "No.");
        //             BomComp.SETRANGE("LSC Recipe Version Code", xRec."Recipe Version Code");
        //             BomComp.DELETEALL(TRUE);
        //         END;

        //         IF "Recipe Version Code" <> '' THEN BEGIN
        //             BomComp.RESET;
        //             BomComp.SETRANGE("Parent Item No.", "No.");
        //             IF BomComp.FIND('+') THEN
        //                 NxtLine := BomComp."Line No." + 10000
        //             ELSE
        //                 NxtLine := 10000;

        //             BomVerComp.SETRANGE("Parent Item No.", "No.");
        //             BomVerComp.SETRANGE("Recipe Version Code", "Recipe Version Code");
        //             IF BomVerComp.FINDFIRST THEN
        //                 REPEAT
        //                     BomComp.INIT;
        //                     BomComp."Parent Item No." := "No.";
        //                     BomComp."Line No." := NxtLine;
        //                     BomComp.VALIDATE(Type, BomVerComp.Type);
        //                     BomComp.VALIDATE("No.", BomVerComp."No.");
        //                     BomComp."LSC BOM Component Type" := BomVerComp."BOM Component Type";
        //                     BomComp."LSC Wastage %" := BomVerComp."Wastage %";
        //                     BomComp."Quantity per" := BomVerComp."Quantity per";
        //                     //LS -
        //                     BomComp."LSC Exclude from Menu Req." := BomVerComp."Exclude from Menu Requisition";
        //                     BomComp."LSC Qty. pr Recipe No.of Port." := BomVerComp."Qty. per Recipe No.of Portions";
        //                     BomComp."LSC Exclusion" := BomVerComp."Pop-up Exclusion";
        //                     //LS +
        //                     BomComp.VALIDATE("Unit of Measure Code", BomVerComp."Unit of Measure Code");
        //                     BomComp."LSC Recipe Version Code" := BomVerComp."Recipe Version Code";
        //                     BomComp."LSC BOM Recipe Version Code" := BomVerComp."BOM Recipe Version Code";
        //                     BomComp."LSC Excluded from Portion Wght" := BomVerComp."Excluded from Portion Weight";
        //                     BomComp."LSC Unaff. by Multipl. Factor" := BomVerComp."Unaff. by Multipl. Factor";

        //                     BomComp."LSC Item No." := BomVerComp."No.";
        //                     BomComp.VALIDATE("Quantity per");   //LS

        //                     BomComp.INSERT(TRUE);
        //                     NxtLine := NxtLine + 10000;
        //                 UNTIL BomVerComp.NEXT = 0;
        //         END;
        //     end;
        // }
        // field(70040; "Recipe Item Type"; Option)
        // {
        //     OptionMembers = ,Ingredient,Recipe;
        //     Caption = 'Recipe Item Type';
        //     DataClassification = ToBeClassified;
        // }
        // field(70041; "BOM Cost Price Distribution"; Option)
        // {
        //     OptionMembers = Quantity,Defined;
        //     Caption = 'BOM Cost Price Distribution';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         lRetailBOMComp: Codeunit "LSC Retail BOM Components";
        //         LSPlanningAssignment: Record "Planning Assignment";
        //         LSItemCostManagement: Codeunit ItemCostManagement;
        //     begin
        //         //LS -
        //         IF (xRec."BOM Cost Price Distribution" <> "BOM Cost Price Distribution") AND
        //           ("BOM Cost Price Distribution" = "BOM Cost Price Distribution"::Quantity) AND
        //           ("BOM Type" = "BOM Type"::Prepack)
        //         THEN
        //             lRetailBOMComp.UpdBOMWeight("No.");

        //         //LS-13105 PlanningAssignment.RoutingReplace(Rec,xRec."Routing No.");
        //         LSPlanningAssignment.RoutingReplace(Rec, xRec."Routing No."); //LS-13105
        //         IF "Routing No." <> xRec."Routing No." THEN
        //             //LS-13105   ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,FALSE,FALSE,TRUE,FIELDNO("Routing No."));
        //             LSItemCostManagement.UpdateUnitCost(Rec, '', '', 0, 0, FALSE, FALSE, TRUE, FIELDNO("Routing No.")); //LS-13105
        //                                                                                                                 //LS +

        //     end;
        // }
        // field(70042; "BOM Type"; Option)
        // {
        //     OptionMembers = ,Recipe,Prepack;
        //     Caption = 'BOM Type';
        //     DataClassification = ToBeClassified;
        // }
        // field(70043; "BOM Receiving Explode"; Option)
        // {
        //     OptionMembers = ,Store,Whse,Both;
        //     Caption = 'BOM Receiving Explode';
        //     DataClassification = ToBeClassified;
        // }
        // field(70044; "External Item No."; Code[20])
        // {
        //     Caption = 'External Item No.';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC External Item";
        // }
        // field(70045; "Extern. Size+Crust"; Code[10])
        // {
        //     Caption = 'Extern. Size+Crust';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC External Size+Crust";
        // }
        // field(70046; "Variant Framework Code"; Code[20])
        // {
        //     Caption = 'Variant Framework Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Variant FW Setup"."Framework Code";
        //     trigger OnValidate()
        //     var
        //         "Variant reg": Record "LSC Item Variant Registration";
        //         ExtVariantDim: Record "LSC Extd. Variant Dimensions";
        //         VariantSetup: Record "LSC Variant FW Setup";
        //         RegVariants: Codeunit "LSC Item Variants Functions";
        //         UpdateNCPrimaryVariantDimension_l: Boolean;
        //     begin
        //         //LS
        //         UpdateNCPrimaryVariantDimension_l := FALSE;
        //         IF ("Variant Framework Code" = '') OR
        //           ("Variant Framework Code" <> xRec."Variant Framework Code")
        //         THEN BEGIN
        //             "Variant reg".SETRANGE("Variant reg"."Item No.", "No.");
        //             UpdateNCPrimaryVariantDimension_l := TRUE;
        //             IF "Variant reg".FIND('-') THEN BEGIN
        //                 IF CONFIRM(Text10000000, FALSE) THEN
        //                     REPEAT
        //                         "Variant reg".DELETE(TRUE);
        //                         COMMIT;
        //                     UNTIL "Variant reg".NEXT() = 0
        //                 ELSE BEGIN
        //                     "Variant Framework Code" := xRec."Variant Framework Code";
        //                     MESSAGE(Text10000001);
        //                     EXIT;
        //                 END;
        //             END;

        //             "Variant reg".SETRANGE("Variant reg"."Item No.", "No.");
        //             IF "Variant reg".ISEMPTY THEN BEGIN
        //                 ExtVariantDim.RESET;
        //                 ExtVariantDim.SETCURRENTKEY(ExtVariantDim.Item);
        //                 ExtVariantDim.SETRANGE(ExtVariantDim.Item, "No.");
        //                 IF ExtVariantDim.FIND('-') THEN
        //                     REPEAT
        //                         ExtVariantDim.DELETE(TRUE);
        //                     UNTIL ExtVariantDim.NEXT = 0;
        //             END;

        //             IF ("Variant Framework Code" <> '') AND
        //               (VariantSetup.GET("Variant Framework Code"))
        //             THEN BEGIN
        //                 IF (VariantSetup."Registration Type" = VariantSetup."Registration Type"::Automatic) OR
        //                    (VariantSetup."Registration Type" = VariantSetup."Registration Type"::"Automatic Selection")
        //                 THEN
        //                     RegVariants.RUN(Rec);
        //             END;
        //         END;

        //         //   //LS
        //         // IF UpdateNCPrimaryVariantDimension_l THEN BEGIN
        //         //                     CLEAR("xNC Primary Variant Dimension");
        //         //                     VALIDATE("xNC Primary Variant Dimension");
        //         //                 END;
        //         //  //LS
        //     end;
        // }
        // field(70047; "Season Code"; Code[10])
        // {
        //     Caption = 'Season Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Season";
        //     trigger OnValidate()
        //     var
        //         Seasons: Record "LSC Season";
        //         ItemSpecialGroupLink: Record "LSC Item/Special Group Link";
        //     begin
        //         //LS
        //         IF "Season Code" = '' THEN BEGIN
        //             IF xRec."Season Code" <> '' THEN BEGIN
        //                 Seasons.GET(xRec."Season Code");
        //                 IF Seasons."Special Group Code" <> '' THEN
        //                     IF ItemSpecialGroupLink.GET("No.", Seasons."Special Group Code") THEN
        //                         ItemSpecialGroupLink.DELETE(TRUE);
        //             END;
        //         END ELSE BEGIN
        //             IF xRec."Season Code" = '' THEN BEGIN
        //                 Seasons.GET("Season Code");
        //                 IF Seasons."Special Group Code" <> '' THEN BEGIN
        //                     ItemSpecialGroupLink.INIT;
        //                     ItemSpecialGroupLink."Item No." := "No.";
        //                     ItemSpecialGroupLink."Special Group Code" := Seasons."Special Group Code";
        //                     IF ItemSpecialGroupLink.INSERT(TRUE) THEN;
        //                 END;
        //             END ELSE BEGIN
        //                 IF xRec."Special Group Code" <> "Special Group Code" THEN BEGIN
        //                     Seasons.GET(xRec."Season Code");
        //                     IF Seasons."Special Group Code" <> '' THEN
        //                         IF ItemSpecialGroupLink.GET("No.", Seasons."Special Group Code") THEN
        //                             ItemSpecialGroupLink.DELETE(TRUE);

        //                     Seasons.GET("Season Code");
        //                     IF Seasons."Special Group Code" <> '' THEN BEGIN
        //                         ItemSpecialGroupLink.INIT;
        //                         ItemSpecialGroupLink."Item No." := "No.";
        //                         ItemSpecialGroupLink."Special Group Code" := Seasons."Special Group Code";
        //                         IF ItemSpecialGroupLink.INSERT(TRUE) THEN;
        //                     END;
        //                 END;
        //             END;

        //             //LS-8785-
        //             Seasons.GET("Season Code");
        //             IF (Seasons."Update Item Lifecycle Start" = Seasons."Update Item Lifecycle Start"::Yes) OR
        //                ((Seasons."Update Item Lifecycle Start" = Seasons."Update Item Lifecycle Start"::"Yes (If field is empty)") AND
        //                ("Lifecycle Starting Date" = 0D))
        //             THEN
        //                 VALIDATE("Lifecycle Starting Date", Seasons."Starting Date");

        //             IF (Seasons."Update Item Lifecycle End" = Seasons."Update Item Lifecycle End"::Yes) OR
        //                ((Seasons."Update Item Lifecycle End" = Seasons."Update Item Lifecycle End"::"Yes (If field is empty)") AND
        //                ("Lifecycle Ending Date" = 0D))
        //             THEN
        //                 VALIDATE("Lifecycle Ending Date", Seasons."Ending Date");
        //             //LS-8785+
        //         END;

        //     end;
        // }
        // field(70048; "Lifecycle Length"; DateFormula)
        // {
        //     Caption = 'Lifecycle Length';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         IF FORMAT("Lifecycle Length") = '' THEN BEGIN
        //             "Lifecycle Starting Date" := 0D;
        //             "Lifecycle Ending Date" := 0D;
        //         END ELSE BEGIN
        //             IF "Lifecycle Starting Date" <> 0D THEN
        //                 "Lifecycle Ending Date" := CALCDATE("Lifecycle Length", "Lifecycle Starting Date");
        //         END;
        //     end;
        // }
        // field(70049; "Lifecycle Starting Date"; Date)
        // {
        //     Caption = 'Lifecycle Starting Date';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         IF "Lifecycle Starting Date" = 0D THEN
        //             "Lifecycle Ending Date" := 0D
        //         ELSE
        //             IF FORMAT("Lifecycle Length") <> '' THEN
        //                 "Lifecycle Ending Date" := CALCDATE("Lifecycle Length", "Lifecycle Starting Date");
        //     end;
        // }
        // field(70050; "Lifecycle Ending Date"; Date)
        // {
        //     Caption = 'Lifecycle Ending Date';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         IF "Lifecycle Ending Date" = 0D THEN
        //             IF FORMAT("Lifecycle Length") <> '' THEN
        //                 "Lifecycle Starting Date" := 0D;
        //     end;
        // }
        // field(70051; "Error Check Internal Usage"; Boolean)
        // {
        //     Caption = 'Error Check Internal Usage';
        //     DataClassification = ToBeClassified;
        // }
        // field(70052; "Attrib 1 Code"; Text[30])
        // {
        //     Caption = 'Attrib 1 Code';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         AttributeUtils_g.SoftAttributeMgmt("No.", '', '', 0, 1, "Attrib 1 Code", '');
        //     end;

        //     trigger OnLookup()
        //     var
        //         AttributeSetup: Record "LSC Attribute Setup";
        //         lAnswer: Text[250];
        //         lActionReturned: Action;
        //     begin
        //         //LS
        //         AttributeSetup.GET;
        //         lAnswer := AttributeUtils_g.LookupOptionValues(0, AttributeSetup."Item Attrib. 1 Code", lActionReturned);
        //         IF lActionReturned = ACTION::LookupOK THEN
        //             VALIDATE("Attrib 1 Code", COPYSTR(lAnswer, 1, 30));
        //     end;
        // }
        // field(70053; "Attrib 2 Code"; Text[30])
        // {
        //     Caption = 'Attrib 2 Code';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         AttributeUtils_g.SoftAttributeMgmt("No.", '', '', 0, 2, "Attrib 2 Code", '');
        //     end;

        //     trigger OnLookup()
        //     var
        //         AttributeSetup: Record "LSC Attribute Setup";
        //         lAnswer: Text[250];
        //         lActionReturned: Action;
        //     begin
        //         //LS
        //         AttributeSetup.GET;
        //         lAnswer := AttributeUtils_g.LookupOptionValues(0, AttributeSetup."Item Attrib. 2 Code", lActionReturned);
        //         IF lActionReturned = ACTION::LookupOK THEN
        //             VALIDATE("Attrib 2 Code", COPYSTR(lAnswer, 1, 30));
        //         //LS +

        //     end;
        // }
        // field(70054; "Attrib 3 Code"; Text[30])
        // {
        //     Caption = 'Attrib 3 Code';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         AttributeUtils_g.SoftAttributeMgmt("No.", '', '', 0, 3, "Attrib 3 Code", '');
        //     end;

        //     trigger OnLookup()
        //     var
        //         AttributeSetup: Record "LSC Attribute Setup";
        //         lAnswer: Text[250];
        //         lActionReturned: Action;
        //     begin
        //         //LS
        //         AttributeSetup.GET;
        //         lAnswer := AttributeUtils_g.LookupOptionValues(0, AttributeSetup."Item Attrib. 3 Code", lActionReturned);
        //         IF lActionReturned = ACTION::LookupOK THEN
        //             VALIDATE("Attrib 3 Code", COPYSTR(lAnswer, 1, 30));
        //         //LS +

        //     end;
        // }
        // field(70055; "Attrib 4 Code"; Text[30])
        // {
        //     Caption = 'Attrib 4 Code';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         AttributeUtils_g.SoftAttributeMgmt("No.", '', '', 0, 4, "Attrib 4 Code", '');
        //     end;

        //     trigger OnLookup()
        //     var
        //         AttributeSetup: Record "LSC Attribute Setup";
        //         lAnswer: Text[250];
        //         lActionReturned: Action;
        //     begin
        //         //LS
        //         AttributeSetup.GET;
        //         lAnswer := AttributeUtils_g.LookupOptionValues(0, AttributeSetup."Item Attrib. 4 Code", lActionReturned);
        //         IF lActionReturned = ACTION::LookupOK THEN
        //             VALIDATE("Attrib 4 Code", COPYSTR(lAnswer, 1, 30));
        //     end;
        // }
        // field(70056; "Attrib 5 Code"; Text[30])
        // {
        //     Caption = 'Attrib 5 Code';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS
        //         AttributeUtils_g.SoftAttributeMgmt("No.", '', '', 0, 5, "Attrib 5 Code", '');
        //     end;

        //     trigger OnLookup()
        //     var
        //         AttributeSetup: Record "LSC Attribute Setup";
        //         lAnswer: Text[250];
        //         lActionReturned: Action;
        //     begin
        //         //LS
        //         AttributeSetup.GET;
        //         lAnswer := AttributeUtils_g.LookupOptionValues(0, AttributeSetup."Item Attrib. 5 Code", lActionReturned);
        //         IF lActionReturned = ACTION::LookupOK THEN
        //             VALIDATE("Attrib 5 Code", COPYSTR(lAnswer, 1, 30));
        //     end;
        // }
        // field(70057; "ABC Sales"; Option)
        // {
        //     OptionMembers = ,A,B,C,D,E;
        //     Caption = 'ABC Sales';
        //     DataClassification = ToBeClassified;
        // }
        // field(70058; "ABC Profit"; Option)
        // {
        //     OptionMembers = ,A,B,C,D,E;
        //     Caption = 'ABC Profit';
        //     DataClassification = ToBeClassified;
        // }
        // field(70059; "Wastage %"; Decimal)
        // {
        //     Caption = 'Wastage %';
        //     DataClassification = ToBeClassified;
        // }
        // field(70060; "Included in Other Recipes"; Boolean)
        // {
        //     Caption = 'Included in Other Recipes';
        //     DataClassification = ToBeClassified;
        // }
        // field(70061; "Excluded from Portion Weight"; Boolean)
        // {
        //     Caption = 'Excluded from Portion Weight';
        //     DataClassification = ToBeClassified;
        // }
        // field(70062; "Unaff. by Multipl. Factor"; Boolean)
        // {
        //     Caption = 'Unaff. by Multipl. Factor';
        //     DataClassification = ToBeClassified;
        // }
        // field(70063; "Portion Weight"; Decimal)
        // {
        //     Caption = 'Portion Weight';
        //     DataClassification = ToBeClassified;
        // }
        // field(70064; "Portion Cost"; Decimal)
        // {
        //     Caption = 'Portion Cost';
        //     DataClassification = ToBeClassified;
        // }
        // field(70065; "Exclude from Menu Requisition"; Boolean)
        // {
        //     Caption = 'Exclude from Menu Requisition';
        //     DataClassification = ToBeClassified;
        // }
        // field(70066; "Recipe No. of Portions"; Integer)
        // {
        //     Caption = 'Recipe No. of Portions';
        //     DataClassification = ToBeClassified;
        // }
        // field(70067; "Max. Modifiers No Price"; Integer)
        // {
        //     Caption = 'Max. Modifiers No Price';
        //     DataClassification = ToBeClassified;
        // }
        // field(70068; "Max. Ingr. Removed No Price"; Integer)
        // {
        //     Caption = 'Max. Ingr. Removed No Price';
        //     DataClassification = ToBeClassified;
        // }
        field(70069; "Max.f Ingr. + Modifiers"; Integer)
        {
            Caption = 'Max.f Ingr. + Modifiers';
            DataClassification = ToBeClassified;
        }
        // field(70070; "Production Time (Min.)"; Decimal)
        // {
        //     Caption = 'Production Time (Min.)';
        //     DataClassification = ToBeClassified;
        // }
        // field(70071; "Recipe Main Ingredient"; Code[10])
        // {
        //     Caption = 'Recipe Main Ingredient';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Recipe Grouping".Code WHERE(Type = CONST("Recipe Main Ingredients"));
        // }
        // field(70072; "Recipe Style"; Code[10])
        // {
        //     Caption = 'Recipe Style';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Recipe Grouping".Code WHERE(Type = CONST("Recipe Styles"));
        // }
        // field(70073; "Recipe Category"; Code[10])
        // {
        //     Caption = 'Recipe Category';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Recipe Grouping".Code WHERE(Type = CONST("Recipe Categories"));
        // }
        // field(70074; "Available as Dish"; Boolean)
        // {
        //     Caption = 'Available as Dish';
        //     DataClassification = ToBeClassified;
        // }
        // field(70075; "UOM Pop-up on POS"; Boolean)
        // {
        //     Caption = 'UOM Pop-up on POS';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         ItemUnitOfMeasure: record "Item Unit of Measure";
        //         ItemUnitOfMeasure2: Record "Item Unit of Measure";
        //         FirstSortOrderNo: Integer;
        //         LastSortOrderNo: Integer;
        //     begin
        //         //LS -
        //         IF "UOM Pop-up on POS" THEN BEGIN
        //             ItemUnitOfMeasure.RESET;
        //             ItemUnitOfMeasure.SETCURRENTKEY("Item No.", "Qty. per Unit of Measure");
        //             ItemUnitOfMeasure.SETRANGE("Item No.", "No.");
        //             ItemUnitOfMeasure.SETFILTER("LSC Order", '0');
        //             IF ItemUnitOfMeasure.FINDFIRST THEN BEGIN
        //                 FirstSortOrderNo := 0;
        //                 LastSortOrderNo := 0;
        //                 ItemUnitOfMeasure2.RESET;
        //                 ItemUnitOfMeasure2.SETRANGE("Item No.", "No.");
        //                 IF ItemUnitOfMeasure2.FINDSET THEN
        //                     REPEAT
        //                         IF (FirstSortOrderNo = 0) AND (ItemUnitOfMeasure2."LSC Order" > 0) THEN
        //                             FirstSortOrderNo := ItemUnitOfMeasure2."LSC Order";
        //                         IF ItemUnitOfMeasure2."LSC Order" > LastSortOrderNo THEN
        //                             LastSortOrderNo := ItemUnitOfMeasure2."LSC Order";
        //                     UNTIL ItemUnitOfMeasure2.NEXT = 0;
        //                 IF ItemUnitOfMeasure2.GET("No.", "Sales Unit of Measure") THEN
        //                     IF ItemUnitOfMeasure2."LSC Order" = 0 THEN BEGIN
        //                         IF FirstSortOrderNo > 2 THEN
        //                             ItemUnitOfMeasure2."LSC Order" := ROUND(FirstSortOrderNo / 2, 1)
        //                         ELSE BEGIN
        //                             LastSortOrderNo := LastSortOrderNo + 100;
        //                             ItemUnitOfMeasure2."LSC Order" := LastSortOrderNo;
        //                         END;
        //                         ItemUnitOfMeasure2.MODIFY(TRUE);
        //                     END;
        //                 ItemUnitOfMeasure.RESET;
        //                 ItemUnitOfMeasure.SETCURRENTKEY("Item No.", "Qty. per Unit of Measure");
        //                 ItemUnitOfMeasure.SETRANGE("Item No.", "No.");
        //                 ItemUnitOfMeasure.SETFILTER("LSC Order", '0');
        //                 IF ItemUnitOfMeasure.FINDSET THEN
        //                     REPEAT
        //                         LastSortOrderNo := LastSortOrderNo + 100;
        //                         ItemUnitOfMeasure."LSC Order" := LastSortOrderNo;
        //                         ItemUnitOfMeasure.MODIFY(TRUE);
        //                     UNTIL ItemUnitOfMeasure.NEXT = 0;
        //             END;
        //         END;
        //         //LS +
        //     end;
        // }
        // field(70076; "Replenishment Calculation Type"; Option)
        // {
        //     OptionMembers = "Automatic - From Data Profile","Average Usage","Manual Estimate","Stock Levels","Like for Like","LS Forecast";
        //     Caption = 'Replenishment Calculation Type';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         //LS-6910-
        //         IF NOT ("Replenishment Calculation Type" IN ["Replenishment Calculation Type"::"Average Usage", "Replenishment Calculation Type"::"Manual Estimate"]) THEN BEGIN
        //             "Store Coverage Days Profile" := '';
        //             "Wareh Coverage Days Profile" := '';
        //         END;
        //         //LS-6910+
        //     end;
        // }
        // field(70077; "Manual Estimated Daily Sale"; Decimal)
        // {
        //     Caption = 'Manual Estimated Daily Sale';
        //     DataClassification = ToBeClassified;
        // }
        // field(70078; "Store Stock Cover Reqd (Days)"; Decimal)
        // {
        //     Caption = 'Store Stock Cover Reqd (Days)';
        //     DataClassification = ToBeClassified;
        // }
        // field(70079; "Wareh Stock Cover Reqd (Days)"; Decimal)
        // {
        //     Caption = 'Wareh Stock Cover Reqd (Days)';
        //     DataClassification = ToBeClassified;
        // }
        // field(70080; "Replenishment Sales Profile"; Code[10])
        // {
        //     Caption = 'Replenishment Sales Profile';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Replen. Sales Profile";
        // }
        // field(70081; "Replenishment Grade Code"; Code[10])
        // {
        //     Caption = 'Replenishment Grade Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Replen. Grade";
        // }
        // field(70082; "Exclude from Replenishment"; Boolean)
        // {
        //     Caption = 'Exclude from Replenishment';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     begin
        //         Rec.ToggleExcludeFromReplenishmentNwmm("Exclude from Replenishment");
        //     end;
        // }
        // field(70083; "Transfer Multiple"; Decimal)
        // {
        //     Caption = 'Transfer Multiple';
        //     DataClassification = ToBeClassified;
        // }
        // field(70084; "Store Forward Sales Profile"; Code[10])
        // {
        //     Caption = 'Store Forward Sales Profile';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Replen. Forw Sales Profile";
        // }
        // field(70085; "Wareh. Forward Sales Profile"; Code[10])
        // {
        //     Caption = 'Wareh. Forward Sales Profile';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Replen. Forw Sales Profile";
        // }
        // field(70086; "Purch. Order Delivery"; Option)
        // {
        //     OptionMembers = "To Warehouse","To Store";
        //     Caption = 'Purch. Order Delivery';
        //     DataClassification = ToBeClassified;
        // }
        // field(70087; "Replenish as Item No."; Code[20])
        // {
        //     Caption = 'Replenish as Item No.';
        //     DataClassification = ToBeClassified;
        //     TableRelation = Item;
        // }
        // field(70088; "Profit Goal %"; Decimal)
        // {
        //     Caption = 'Profit Goal %';
        //     DataClassification = ToBeClassified;
        // }
        // field(70089; "Replen. Data Profile"; Code[20])
        // {
        //     Caption = 'Replen. Data Profile';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Replen. Data Profile";
        //     trigger OnValidate()
        //     var
        //         ReplenDataProfLinks: record "LSC Replen. Data Prof. Links";
        //     begin
        //         //LS
        //         IF "Replen. Data Profile" <> xRec."Replen. Data Profile" THEN
        //             IF xRec."Replen. Data Profile" <> '' THEN BEGIN
        //                 ReplenDataProfLinks.RESET;
        //                 ReplenDataProfLinks.SETRANGE("Data Profile Code", xRec."Replen. Data Profile");
        //                 ReplenDataProfLinks.SETRANGE(Type, ReplenDataProfLinks.Type::Item);
        //                 ReplenDataProfLinks.SETRANGE(Key1, "No.");
        //                 IF ReplenDataProfLinks.FINDFIRST THEN
        //                     ReplenDataProfLinks.DELETE;
        //             END;
        //         IF "Replen. Data Profile" <> '' THEN BEGIN
        //             CLEAR(ReplenDataProfLinks);
        //             ReplenDataProfLinks."Data Profile Code" := Rec."Replen. Data Profile";
        //             ReplenDataProfLinks.Type := ReplenDataProfLinks.Type::Item;
        //             ReplenDataProfLinks.Key1 := "No.";
        //             IF ReplenDataProfLinks.INSERT THEN;
        //         END;
        //     end;
        // }
        // field(70090; "Like for Like Replen. Method"; Option)
        // {
        //     OptionMembers = ,Transfer,"PO to Store","PO w/XDock";
        //     Caption = 'Like for Like Replen. Method';
        //     DataClassification = ToBeClassified;
        // }
        // field(70091; "Like for Like Process Method"; Option)
        // {
        //     OptionMembers = ,"Replen. Job",Manual;
        //     Caption = 'Like for Like Process Method';
        //     DataClassification = ToBeClassified;
        // }
        // field(70092; "Replenish as Item No - Method"; Option)
        // {
        //     OptionMembers = Total,Substitute;
        //     Caption = 'Replenish as Item No - Method';
        //     DataClassification = ToBeClassified;
        // }
        // field(70093; "Replen. Transfer Rule Code"; Code[10])
        // {
        //     Caption = 'Replen. Transfer Rule Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Replen. Transfer Rule Hdr";
        // }
        // field(70094; "Select Lowest Price Vendor"; Boolean)
        // {
        //     Caption = 'Select Lowest Price Vendor';
        //     DataClassification = ToBeClassified;
        // }
        // field(70095; "Effective Inv. Sales Order"; Option)
        // {
        //     OptionMembers = Include,Exclude,Coverage;
        //     Caption = 'Effective Inv. Sales Order';
        //     DataClassification = ToBeClassified;
        // }
        // field(70096; "Effective Inv. Purchase Ord."; Option)
        // {
        //     OptionMembers = Include,Exclude,Coverage;
        //     Caption = 'Effective Inv. Purchase Ord.';
        //     DataClassification = ToBeClassified;
        // }
        // field(70097; "Effective Inv. Transfer Inb."; Option)
        // {
        //     OptionMembers = Include,Exclude,Coverage;
        //     Caption = 'Effective Inv. Transfer Inb.';
        //     DataClassification = ToBeClassified;
        // }
        // field(70098; "Effective Inv. Transfer Outb."; Option)
        // {
        //     OptionMembers = Include,Exclude,Coverage;
        //     Caption = 'Effective Inv. Transfer Outb.';
        //     DataClassification = ToBeClassified;
        // }
        // field(70099; "Replen Item Store Recs"; Integer)
        // {
        //     Caption = 'Replen Item Store Recs';
        //     FieldClass = FlowField;
        //     CalcFormula = Count("LSC Replen. Item Store Rec" WHERE("Item No." = FIELD("No.")));
        // }
        // field(70100; "Replen Item Quantities"; Integer)
        // {
        //     Caption = 'Replen Item Quantities';
        //     FieldClass = FlowField;
        //     CalcFormula = Count("LSC Replen. Item Quantity" WHERE("Item No." = FIELD("No.")));
        // }
        // field(70101; "Replen Sales Hist. Adj."; Integer)
        // {
        //     Caption = 'Replen Sales Hist. Adj.';
        //     FieldClass = FlowField;
        //     CalcFormula = Count("LSC Replen. Sales Hist. Adj." WHERE("Item No." = FIELD("No.")));
        // }
        // field(70102; "Planned Sales Demand"; Integer)
        // {
        //     Caption = 'Planned Sales Demand';
        //     FieldClass = FlowField;
        //     CalcFormula = Count("LSC Replen. Planned Sales Dem." WHERE("Item No." = FIELD("No."), Status = CONST(Enabled)));
        // }
        // field(70103; "Planned Stock Demand"; Integer)
        // {
        //     Caption = 'Planned Stock Demand';
        //     FieldClass = FlowField;
        //     CalcFormula = Count("LSC Replen. Planned Sales Dem." WHERE("Item No." = FIELD("No.")));
        // }
        // field(70104; "Unavailable Stock"; Integer)
        // {
        //     Caption = 'Unavailable Stock';
        //     FieldClass = FlowField;
        //     CalcFormula = Count("LSC Replen. Unavailable Stock" WHERE("Item No." = FIELD("No.")));
        // }
        // field(70105; "Out of Stock Days"; Integer)
        // {
        //     Caption = 'Out of Stock Days';
        //     FieldClass = FlowField;
        //     CalcFormula = Count("LSC Replen. Out of Stock Log" WHERE("Item No." = FIELD("No.")));
        // }
        // field(70106; "LS Forecast Method"; Option)
        // {
        //     OptionMembers = Auto,Arima,Sarima,AddBlended,MultBlended;
        //     Caption = 'LS Forecast Method';
        //     DataClassification = ToBeClassified;
        // }
        // field(70107; "LS Forecast Calc. Horizon"; Integer)
        // {
        //     Caption = 'LS Forecast Calc. Horizon';
        //     DataClassification = ToBeClassified;
        // }
        // field(70108; "Fuel Item"; Boolean)
        // {
        //     Caption = 'Fuel Item';
        //     DataClassification = ToBeClassified;
        // }
        // field(70109; "Options Exist"; Boolean)
        // {
        //     Caption = 'Options Exist';
        //     DataClassification = ToBeClassified;
        // }

        // field(70110; "Item Family Code"; Code[20])
        // {
        //     Caption = 'Item Family Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Item Family".Code;
        // }
        // field(70111; "Unit Price Including VAT"; Decimal)
        // {
        //     Caption = 'Unit Price Including VAT';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         VATPostingSetupRec: record "VAT Posting Setup";
        //         GeneralLedgerSetup: Record "General Ledger Setup";
        //     begin
        //         //LS
        //         IF NOT "Price Includes VAT" THEN BEGIN
        //             IF NOT VATPostingSetupRec.GET("VAT Bus. Posting Gr. (Price)", "VAT Prod. Posting Group") THEN
        //                 VATPostingSetupRec.INIT;
        //             CASE VATPostingSetupRec."VAT Calculation Type" OF
        //                 VATPostingSetupRec."VAT Calculation Type"::"Reverse Charge VAT":
        //                     VATPostingSetupRec."VAT %" := 0;
        //                 VATPostingSetupRec."VAT Calculation Type"::"Sales Tax":
        //                     ERROR(
        //                       Text99001507,
        //                       FIELDCAPTION("Unit Price Including VAT"),
        //                       VATPostingSetupRec.FIELDCAPTION("VAT Calculation Type"),
        //                       VATPostingSetupRec."VAT Calculation Type");
        //             END;
        //             //LS-12507 GetGLSetup;
        //             //LS-12507-
        //             IF NOT GeneralLedgerSetup.GET THEN
        //                 CLEAR(GeneralLedgerSetup);
        //             //LS-12507+
        //             //LS-12507  "Unit Price" := ROUND("Unit Price Including VAT" / (1 + (VATPostingSetupRec."VAT %" / 100)),
        //             //LS-12507    GLSetup."Unit-Amount Rounding Precision");
        //             "Unit Price" := ROUND("Unit Price Including VAT" / (1 + (VATPostingSetupRec."VAT %" / 100)), GeneralLedgerSetup."Unit-Amount Rounding Precision"); //LS-12507
        //         END ELSE
        //             "Unit Price" := "Unit Price Including VAT";

        //         VALIDATE("Price/Profit Calculation");
        //     end;
        // }
        // field(70112; "POS Cost Calculation"; Option)
        // {
        //     OptionMembers = "Item Based","Product Group Based","Item Cat. Based";
        //     Caption = 'POS Cost Calculation';
        //     DataClassification = ToBeClassified;
        // }
        field(70113; "No Stock Posting"; Boolean)
        {
            Caption = 'No Stock Posting';
            DataClassification = ToBeClassified;
        }
        // field(70114; "Zero Price Valid"; Boolean)
        // {
        //     Caption = 'Zero Price Valid';
        //     DataClassification = ToBeClassified;
        // }
        // field(70115; "Qty. Becomes Negative"; Boolean)
        // {
        //     Caption = 'Qty. Becomes Negative';
        //     DataClassification = ToBeClassified;
        // }
        // field(70116; "No Discount Allowed"; Boolean)
        // {
        //     Caption = 'No Discount Allowed';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         OfferCode: Code[20];
        //         OfferType: Option Multibuy,"Mix&Match","Disc. Offer";
        //         ProductExt: Codeunit "LSC Product Ext.";
        //     begin
        //         //LS
        //         IF "No Discount Allowed" THEN BEGIN
        //             //LS-12335 IF FindActiveOffer(OfferCode,OfferType) > 0 THEN
        //             IF ProductExt.FindActiveOffer("No.", OfferCode, OfferType) > 0 THEN //LS-12335
        //                 ERROR(Text99001513, Rec.FIELDCAPTION("No Discount Allowed"), "No.", FORMAT(OfferType), OfferCode);

        //             InformationSubcode.SETCURRENTKEY("Trigger Function", "Trigger Code");
        //             InformationSubcode.SETRANGE("Trigger Function", InformationSubcode."Trigger Function"::Item);
        //             InformationSubcode.SETRANGE("Trigger Code", "No.");
        //             InformationSubcode.SETRANGE("Price Type", InformationSubcode."Price Type"::Percent);
        //             IF InformationSubcode.FIND('-') THEN
        //                 ERROR(Text99001514, FIELDCAPTION("No Discount Allowed"), "No.", InformationSubcode.TABLECAPTION,
        //                                    InformationSubcode.Code, InformationSubcode.Subcode);
        //         END;
        //     end;
        // }
        // field(70117; "Keying in Price"; Option)
        // {
        //     OptionMembers = "Not Mandatory","Must Key in New Price","Must Key in Higher/Equal Price","Must Key in Lower/Equal Price","Must not Key in Price";
        //     Caption = 'Keying in Price';
        //     DataClassification = ToBeClassified;
        // }
        // field(70118; "Scale Item"; Boolean)
        // {
        //     Caption = 'Scale Item';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         UOM: Record "Unit of Measure";
        //     begin
        //         //LS
        //         IF "Scale Item" THEN BEGIN
        //             UOM.SETRANGE("Weight Unit Of Measure", TRUE);
        //             IF UOM.FIND('-') THEN
        //                 IF "Sales Unit of Measure" = '' THEN
        //                     "Sales Unit of Measure" := UOM.Code
        //                 ELSE
        //                     IF "Sales Unit of Measure" <> UOM.Code THEN
        //                         ERROR(STRSUBSTNO(Text99001502, FIELDCAPTION("Sales Unit of Measure")
        //                                                                                   , UOM.FIELDCAPTION(UOM."Weight Unit Of Measure")
        //                                                                                   , UOM.TABLECAPTION));
        //         END;
        //     end;
        // }
        // field(70119; "Keying in Quantity"; Boolean)
        // {
        //     Caption = 'Keying in Quantity';
        //     DataClassification = ToBeClassified;
        // }
        // field(70120; "Skip Compression When Scanned"; Boolean)
        // {
        //     Caption = 'Skip Compression When Scanned';
        //     DataClassification = ToBeClassified;
        // }
        // field(70121; "Skip Compression When Printed"; Boolean)
        // {
        //     Caption = 'Skip Compression When Printed';
        //     DataClassification = ToBeClassified;
        // }
        field(70122; "xTime Filter"; Time)
        {
            Caption = 'xTime Filter';
            DataClassification = ToBeClassified;
        }
        // field(70123; "Qty. Sold (POS)"; Decimal)
        // {
        //     Caption = 'Qty. Sold (POS)';
        //     DataClassification = ToBeClassified;
        // }
        // field(70124; "Sales Amount (POS)"; Decimal)
        // {
        //     Caption = 'Sales Amount (POS)';
        //     DataClassification = ToBeClassified;
        // }
        // field(70125; "Disc. Amount (POS)"; Decimal)
        // {
        //     Caption = 'Disc. Amount (POS)';
        //     DataClassification = ToBeClassified;
        // }
        // field(70126; "VAT Amount (POS)"; Decimal)
        // {
        //     Caption = 'VAT Amount (POS)';
        //     DataClassification = ToBeClassified;
        // }
        // field(70127; "Barcode Mask"; Code[22])
        // {
        //     Caption = 'Barcode Mask';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         BarcodeMgt: Codeunit "LSC Barcode Management";
        //     begin
        //         //LS
        //         IF "Barcode Mask" <> '' THEN
        //             //BarcodeMgt.CheckItemMask("Barcode Mask", Rec);
        //             Rec.CheckItemMaskNwmm("Barcode Mask", Rec);
        //     end;

        //     trigger OnLookup()
        //     var
        //         BarcodeMask: Record "LSC Barcode Mask";
        //     begin
        //         //LS
        //         BarcodeMask.RESET;
        //         IF PAGE.RUNMODAL(PAGE::"LSC Barcode Mask List", BarcodeMask) = ACTION::LookupOK THEN
        //             VALIDATE("Barcode Mask", BarcodeMask.Mask);
        //     end;
        // }
        // field(70128; "Use EAN Standard Barc."; Boolean)
        // {
        //     Caption = 'Use EAN Standard Barc.';
        //     DataClassification = ToBeClassified;
        // }
        field(70129; "Qty. per Base Comp. Unit"; Decimal)
        {
            Caption = 'Qty. per Base Comp. Unit';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //LS
                VALIDATE("Comp. Price Incl. VAT");
            end;
        }
        field(70130; "Base Comp. Unit Code"; Code[10])
        {
            Caption = 'Base Comp. Unit Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Comparison Unit of Measure".Code;
            trigger OnValidate()
            begin
                //LS
                VALIDATE("Comp. Price Incl. VAT");
            end;
        }
        field(70131; "Comparison Unit Code"; Code[10])
        {
            Caption = 'Comparison Unit Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Conversion Value"."Comparison Unit Code" WHERE("Base Unit Code" = FIELD("Base Comp. Unit Code"));
            trigger OnValidate()
            begin
                //LS
                VALIDATE("Comp. Price Incl. VAT");
            end;
        }
        field(70132; "Comp. Price Incl. VAT"; Decimal)
        {
            Caption = 'Comp. Price Incl. VAT';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                ComparisonUnitFactor: Record "LSC Conversion Value";
            begin
                //LS
                // IF "Qty. per Base Comp. Unit" <> 0 THEN BEGIN
                //     IF ComparisonUnitFactor.GET("Base Comp. Unit Code", "Comparison Unit Code") THEN
                //         IF ComparisonUnitFactor."Conversion Factor" <> 0 THEN
                //             "Comp. Price Incl. VAT" :=
                //               ROUND(
                //                 "Unit Price Including VAT" /
                //                 (ComparisonUnitFactor."Conversion Factor" * "Qty. per Base Comp. Unit"))
                //         ELSE
                //             "Comp. Price Incl. VAT" := 0
                //     ELSE
                //         "Comp. Price Incl. VAT" := 0;
                // END ELSE
                //     "Comp. Price Incl. VAT" := 0;
            end;
        }
        // field(70133; "Explode BOM in Statem. Posting"; Boolean)
        // {
        //     Caption = 'Explode BOM in Statem. Posting';
        //     DataClassification = ToBeClassified;
        // }
        // field(70134; "Dispense Printer Group"; Code[10])
        // {
        //     Caption = 'Dispense Printer Group';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC POS Dispense Print. Groups".ID;
        // }
        // field(70135; "Print Variants Shelf Labels"; Boolean)
        // {
        //     Caption = 'Print Variants Shelf Labels';
        //     DataClassification = ToBeClassified;
        // }
        // field(70136; "Tare Weight"; Decimal)
        // {
        //     Caption = 'Tare Weight';
        //     DataClassification = ToBeClassified;
        // }
        // field(70137; "Lifecycle Curve Code"; Code[20])
        // {
        //     Caption = 'Lifecycle Curve Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Lifecycle Curve";
        //     trigger OnValidate()
        //     var
        //         LifecycleCurve: Record "LSC Lifecycle Curve";
        //     begin
        //         //LS-8785 New
        //         IF LifecycleCurve.GET("Lifecycle Curve Code") THEN
        //             IF LifecycleCurve."No. of Periods" > 0 THEN BEGIN
        //                 IF LifecycleCurve."Period Type" = LifecycleCurve."Period Type"::Day THEN
        //                     EVALUATE("Lifecycle Length", '<' + FORMAT(LifecycleCurve."No. of Periods") + 'D>')
        //                 ELSE
        //                     IF LifecycleCurve."Period Type" = LifecycleCurve."Period Type"::Week THEN
        //                         EVALUATE("Lifecycle Length", '<' + FORMAT(LifecycleCurve."No. of Periods") + 'W>')
        //                     ELSE
        //                         EVALUATE("Lifecycle Length", '<' + FORMAT(LifecycleCurve."No. of Periods") + 'M>');

        //                 VALIDATE("Lifecycle Length");
        //             END;
        //     end;
        // }
        // field(70138; "Dimension Pattern Code"; Code[20])
        // {
        //     Caption = 'Dimension Pattern Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Dimension Pattern";
        //     trigger OnValidate()
        //     var
        //         ItemDimensionPatternLink: Record "LSC Item Dimens. Pattern Link";
        //         ItemDistribution: Record "LSC Item Distribution";
        //         RecordFound: array[2] of Boolean;

        //     begin
        //         //LS-6913-
        //         IF "Dimension Pattern Code" = xRec."Dimension Pattern Code" THEN
        //             EXIT;
        //         IF "Dimension Pattern Code" <> '' THEN
        //             // IF NOT AllocationPlanUtils_g.DimensionPatternOkForVFC("No.", "Dimension Pattern Code") THEN
        //             //     EXIT;
        //             if not DimensionPatternOkForVFCNWMM("No.", "Dimension Pattern Code") then           //fix by MK cause protection Level
        //                 exit;

        //         ItemDistribution.SETRANGE("Item No.", "No.");
        //         ItemDistribution.SETRANGE("Dimension Pattern Code", xRec."Dimension Pattern Code");
        //         RecordFound[1] := NOT ItemDistribution.ISEMPTY;

        //         ItemDimensionPatternLink.SETRANGE("Item No.", "No.");
        //         ItemDimensionPatternLink.SETRANGE("Dimension Pattern Code", xRec."Dimension Pattern Code");
        //         RecordFound[2] := NOT ItemDimensionPatternLink.ISEMPTY;

        //         IF RecordFound[1] OR RecordFound[2] THEN
        //             IF CONFIRM(STRSUBSTNO(UpdateFieldQst, ItemDistribution.FIELDCAPTION("Dimension Pattern Code"), ItemDistribution.TABLECAPTION,
        //                ItemDimensionPatternLink.TABLECAPTION))
        //             THEN BEGIN
        //                 IF RecordFound[1] THEN
        //                     ItemDistribution.MODIFYALL("Dimension Pattern Code", "Dimension Pattern Code", TRUE);

        //                 IF RecordFound[2] THEN
        //                     ItemDimensionPatternLink.MODIFYALL("Dimension Pattern Code", "Dimension Pattern Code", TRUE);
        //             END;
        //         //LS-6913+
        //     end;
        // }
        // field(70139; "Upd. Cost and Weight w/Posting"; Boolean)
        // {
        //     Caption = 'Upd. Cost and Weight w/Posting';
        //     DataClassification = ToBeClassified;
        // }
        // field(70140; "Store Coverage Days Profile"; Code[10])
        // {
        //     Caption = 'Store Coverage Days Profile';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Replen. Cov. Days Profile" WHERE(Type = CONST(Store));
        //     trigger OnValidate()
        //     begin
        //         //LS-6910-
        //         IF "Store Coverage Days Profile" <> '' THEN
        //             "Store Stock Cover Reqd (Days)" := 0;
        //         //LS-6910+
        //     end;
        // }
        // field(70141; "Wareh Coverage Days Profile"; Code[10])
        // {
        //     Caption = 'Wareh Coverage Days Profile';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Replen. Cov. Days Profile" WHERE(Type = CONST(Warehouse));
        //     trigger OnValidate()
        //     begin
        //         //LS-6910-
        //         IF "Wareh Coverage Days Profile" <> '' THEN
        //             "Wareh Stock Cover Reqd (Days)" := 0;
        //         //LS-6910+
        //     end;
        // }
        field(70142; "FDA Registration No."; Code[20])
        {
            Caption = 'FDA Registration No.';
            DataClassification = ToBeClassified;
        }
        field(70143; "FDA Reg. Date"; Date)
        {
            Caption = 'FDA Reg. Date';
            DataClassification = ToBeClassified;
        }
        field(70144; "Brand Code"; Text[30])
        {
            Caption = 'Brand Code';
            DataClassification = ToBeClassified;
            TableRelation = Brand;
        }
        // field(70145; "Item Catg Code Name"; Text[150])
        // {
        //     Caption = 'Item Catg Code Name';
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        // field(70146; "Division Code Name"; Text[150])
        // {
        //     Caption = 'Division Code Name';
        //     DataClassification = ToBeClassified;
        // }
        // field(70147; "Retail Product Code Name"; Text[150])
        // {
        //     Caption = 'Retail Product Code Name';
        //     DataClassification = ToBeClassified;
        // }
        field(70148; "Mode of Application"; Text[2040])
        {
            Caption = 'Mode of Application';
            DataClassification = ToBeClassified;
        }
        field(70149; "E-Commerce"; Boolean)
        {
            Caption = 'E-Commerce';
            DataClassification = ToBeClassified;
        }
        field(70150; Distributor; Code[50])
        {
            Caption = 'Distributor';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(70151; Manufacturer; Code[50])
        {
            Caption = 'Manufacturer';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(70152; "Brand Name"; Text[150])
        {
            Caption = 'Brand Name';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        // key(Key20; "Item Family Code")
        // {
        // }
        // key(Key21; "Season Code")
        // {
        // }
        // key(Key22; "Lifecycle Starting Date", "Lifecycle Ending Date")
        // {
        // }
        // key(Key23; "LSC Division Code")
        // {
        // }
        // key(Key24; "Date Created")
        // {
        // }
        // key(Key25; "ABC Sales")
        // {
        // }
        // key(Key26; "ABC Profit")
        // {
        // }
        // key(Key27; "External Item No.", "Extern. Size+Crust")
        // {
        // }
        // key(Key28; "Retail Product Code")
        // {
        // }
        key(Key29; "Available in POS")
        {
        }
    }
    var
        Text10000000: Textconst ENU = 'Are you sure?\Current Item Variant Framework and Variants will be deleted.';
        Text10000001: Textconst ENU = 'Variant Framework not changed.';
        AttributeUtils_g: Codeunit "LSC Attribute Utils";
        Text99001507: TextConst ENU = '%1 cannot be calculated when %2 is %3.';
        Text99001513: TextConst ENU = 'You cannot enable %1 for Item %2 since it is member of %3 %4.';
        InformationSubcode: Record "LSC Information Subcode";
        Text99001514: TextConst ENU = 'You cannot enable %1 for Item %2 since it has a discount associated with %3 %4 %5';
        Text99001502: TextConst ENU = 'The %1 must be the %2 from the %3 table';

        //AllocationPlanUtils_g: Codeunit "LSC Alloc. Plan Utils";
        UpdateFieldQst: TextConst ENU = 'Do you want to update the %1 in %2 and %3?';

        BackOfficeSetup: Record "LSC Retail Setup";
        BarcMaskChar: Record "LSC Barcode Mask Character";
        BarcMask: Record "LSC Barcode Mask";
        PosFunctions: Codeunit "LSC POS Functions";
        BarcodeType: Text[30];
        Lchar: Text[1];
        Ichar: Text[1];
        Xchar: Text[1];
        Schar: Text[1];
        Zchar: Text[1];
        Cchar: Text[1];
        Mchar: Text[1];
        Pchar: Text[1];
        Qchar: Text[1];
        Echar: Text[1];
        Uchar: Text[1];
        Achar: Text[1];
        NSchar: Text[1];
        Tchar: Text[1];
        VChar: Text[1];
        Lpos: Integer;
        Lnum: Integer;
        Ipos: Integer;
        Inum: Integer;
        Spos: Integer;
        Snum: Integer;
        Zpos: Integer;
        Znum: Integer;
        Cpos: Integer;
        Cnum: Integer;
        Mpos: Integer;
        Ppos: Integer;
        Pnum: Integer;
        Qpos: Integer;
        Qnum: Integer;
        Epos: Integer;
        Enum: Integer;
        Upos: Integer;
        Unum: Integer;
        Apos: Integer;
        Anum: Integer;
        NSPos: Integer;
        NSnum: Integer;
        TPos: Integer;
        Tnum: Integer;
        VPos: Integer;
        VNum: Integer;
        RetailVariants: Boolean;
        BarEan: Boolean;
        BarcodeMask: Boolean;
        DoNotAskForConfirmation: Boolean;
        EANBarcode: Boolean;
        Text012: Label 'Character %1 in the %2 is invalid.';
        Text037: Label '%1 is missing.';
        Text062: Label 'Use number series masks to construct barcodes.';

    procedure UpdateVendorItemLibraryNwmm(VAR Item_p: Record Item)
    var
        lVendorItemLibrary: Record "LSC Vendor Item Library";
    begin
        //UpdateVendorItemLibrary
        //LS-12335 New function
        IF lVendorItemLibrary.GET(Item_p."No.") THEN BEGIN
            lVendorItemLibrary."Division Code" := Item_p."LSC Division Code";
            lVendorItemLibrary."Item Category Code" := Item_p."Item Category Code";
            //LS-12322// lVendorItemLibrary."Product Group Code" := Item_p."Product Group Code";
            lVendorItemLibrary."Retail Product Code" := Item_p."LSC Retail Product Code"; //LS-12322
            lVendorItemLibrary."Item Family Code" := Item_p."LSC Item Family Code";
            lVendorItemLibrary.MODIFY(TRUE);
        end;
    END;

    procedure UpdatePhysInvCountingPeriodNwmm(VAR Item_p: Record Item)
    var
        ProductGroup: Record "LSC Retail Product Group";
        ItemCategory: Record "Item Category";
        Division: Record "LSC Division";
    begin
        //UpdatePhysInvCountingPeriod
        //LS-12335 New function
        //LS-12322// IF Item_p."Product Group Code" <> '' THEN
        //LS-12322// IF ProductGroup.GET(Item_p."Item Category Code",Item_p."Product Group Code") THEN
        IF Item_p."LSC Retail Product Code" <> '' THEN //LS-12322
            IF ProductGroup.GET(Item_p."Item Category Code", Item_p."LSC Retail Product Code") THEN //LS-12322
                IF ProductGroup."Phys Invt Counting Period Code" <> '' THEN BEGIN
                    Item_p.VALIDATE("Phys Invt Counting Period Code", ProductGroup."Phys Invt Counting Period Code");
                    EXIT;
                END;

        IF Item_p."Item Category Code" <> '' THEN
            IF ItemCategory.GET(Item_p."Item Category Code") THEN
                IF ItemCategory."LSC Phys Invt Count. Per. Code" <> '' THEN BEGIN
                    Item_p.VALIDATE("Phys Invt Counting Period Code", ItemCategory."LSC Phys Invt Count. Per. Code");
                    EXIT;
                END;

        IF Item_p."LSC Division Code" <> '' THEN
            IF Division.GET(Item_p."LSC Division Code") THEN
                IF Division."Phys Invt Counting Period Code" <> '' THEN BEGIN
                    Item_p.VALIDATE("Phys Invt Counting Period Code", Division."Phys Invt Counting Period Code");
                    EXIT;
                END;
    end;

    procedure ToggleExcludeFromReplenishmentNwmm(Exclude_p: Boolean)
    var
        ReplenItemStoreRec: Record "LSC Replen. Item Store Rec";
        ExcludeText: Text;
        Text029: TextConst ENU = 'Exclude all Item Store Records automatically?';
        Text030: TextConst ENU = 'Remove Exclude from all Item Store Records automatically?';
    begin
        //LS
        ReplenItemStoreRec.RESET;
        ReplenItemStoreRec.SETRANGE("Item No.", "No.");
        ReplenItemStoreRec.SETRANGE("Exclude from Replenishment", NOT Exclude_p);
        IF ReplenItemStoreRec.ISEMPTY THEN
            EXIT;
        IF Exclude_p THEN
            ExcludeText := Text029
        ELSE
            ExcludeText := Text030;
        IF CONFIRM(ExcludeText, TRUE) THEN
            ReplenItemStoreRec.MODIFYALL("Exclude from Replenishment", Exclude_p);
    end;

    procedure CheckItemMaskNwmm(Mask: Code[22]; Item: Record Item)
    var
        BarEan: Boolean;
    begin
        DoNotAllowPriceOrQtyInMaskNwmm(Mask);

        BarEan := Item."LSC Use EAN Standard Barc.";
        CheckMaskCharNwmm(Mask);
    end;

    procedure DoNotAllowPriceOrQtyInMaskNwmm(BarcodeMask: Code[22])
    var
        BarcodeMaskChar: Record "LSC Barcode Mask Character";
        Ix: Integer;
        Text060: Label 'It is not possible to assign a Barcode Mask containing the Price or Quantity characters here.';
    begin
        if BarcodeMask = '' then
            exit;
        BarcodeMaskChar.Reset;
        BarcodeMaskChar.SetCurrentKey(Character);
        for Ix := 1 to StrLen(BarcodeMask) do begin
            BarcodeMaskChar.SetRange(Character, CopyStr(BarcodeMask, Ix, 1));
            if BarcodeMaskChar.FindFirst then
                if BarcodeMaskChar."Character Type" in [BarcodeMaskChar."Character Type"::Price, BarcodeMaskChar."Character Type"::Quantity] then
                    Error(Text060);
        end;
    end;

    procedure CheckMaskCharNwmm(Mask: Code[22])
    var
        LastPos: Text[1];
        Char: Text[1];
        i: Integer;
        Text061: Label 'Number Series must be continuous in the mask.';
        Text036: Label 'Length of a standard EAN barcode mask must be 13.';
        Text038: Label 'Licence No. must be continuous in the mask.';
        Text039: Label 'Color must be continuous in the mask.';
        Text040: Label 'Style must be continuous in the mask.';
        Text041: Label 'Size must be continuous in the mask.';
        Text042: Label 'Item No. must be continuous in the mask.';
        Text043: Label 'The mask is not a standard 13 digit EAN mask, it cannot have a check digit.';
        Text044: Label 'Modulus Check Digit must be digit no. %1 in the mask.';
        Text045: Label 'Character %1 is not registered in the %2 table.';
        Text046: Label 'Character number %1 in the mask must be a modulus check digit - %2.';
        Text047: Label 'The length of the %1 is %2.\The mask must contain the same number of digits.';
        Text063: Label 'Lot No. must be continuous in the mask.';
        Text064: Label 'Serial No. must be continuous in the mask.';
        BarEan: Boolean;
        BackOfficeSetup: Record "LSC Retail Setup";
        Text037: Label '%1 is missing.';
    begin
        if BarEan then
            if StrLen(Mask) <> 13 then
                Error(Text036);
        if not BackOfficeSetup.Get then
            Error(Text037, BackOfficeSetup.TableCaption);
        LastPos := '';
        InitMaskCharactersNwmm;
        for i := 1 to StrLen(Mask) do begin
            Char := CopyStr(Mask, i, 1);
            case Char of
                '0' .. '9', Xchar:
                    LastPos := Char;
                Lchar:
                    begin
                        Lnum := Lnum + 1;
                        if Lpos = 0 then begin
                            LastPos := Char;
                            Lpos := i;
                        end else
                            if LastPos <> Char then
                                Error(Text038);
                    end;
                Cchar:
                    if Cpos = 0 then begin
                        LastPos := Char;
                        Cpos := i;
                    end else
                        if LastPos <> Char then
                            Error(Text039);
                Schar:
                    if Spos = 0 then begin
                        LastPos := Char;
                        Spos := i;
                    end else
                        if LastPos <> Char then
                            Error(Text040);
                Zchar:
                    if Zpos = 0 then begin
                        LastPos := Char;
                        Zpos := i;
                    end else
                        if LastPos <> Char then
                            Error(Text041);
                Ichar:
                    if Ipos = 0 then begin
                        LastPos := Char;
                        Ipos := i;
                    end else
                        if LastPos <> Char then
                            Error(Text042);
                NSchar:
                    if NSPos = 0 then begin
                        LastPos := Char;
                        NSPos := i;
                    end else
                        if LastPos <> Char then
                            Error(Text061);
                Tchar:
                    if TPos = 0 then begin
                        LastPos := Char;
                        TPos := i;
                    end else
                        if LastPos <> Char then
                            Error(Text063);
                VChar:
                    if VPos = 0 then begin
                        LastPos := Char;
                        VPos := i;
                    end else
                        if LastPos <> Char then
                            Error(Text064);
                Mchar:
                    begin
                        if not BarEan then
                            Error(Text043);
                        if i <> Mpos then
                            Error(Text044, Mpos);
                        LastPos := Char;
                    end;
                else
                    Error(Text045, Char, BarcMaskChar.TableCaption);
            end;
        end;
        if BarEan then
            if StrPos(Mask, Mchar) = 0 then
                Error(Text046, Mpos, Mchar);
        if Lpos > 0 then begin
            BackOfficeSetup.TestField("EAN License No.");
            if StrLen(BackOfficeSetup."EAN License No.") <> Lnum then
                Error(Text047, BackOfficeSetup.FieldCaption("EAN License No."), StrLen(BackOfficeSetup."EAN License No."));
        end;
    end;

    procedure InitMaskCharactersNwmm()
    var
        MaskChar: array[20] of Text[1];
        i: Integer;
        Text048: Label 'Not all %2s are represented by a %1 in the %3 table.';
    begin
        for i := 0 to 14 do begin
            if (i >= 3) and (i <= 5) then
                BarcMaskChar.Character := ' '
            else
                if not BarcMaskChar.Get(i) then
                    Error(
                      Text048,
                      BarcMaskChar.FieldCaption(Character), BarcMaskChar.FieldCaption("Character Type"),
                      BarcMaskChar.TableCaption);
            MaskChar[i + 1] := BarcMaskChar.Character;
        end;

        Ichar := MaskChar[1]; // Item No.
        Xchar := MaskChar[2]; // Any Char.
        Mchar := MaskChar[3]; // Check Digit
        Zchar := MaskChar[4]; // Size
        Cchar := MaskChar[5]; // Color
        Schar := MaskChar[6]; // Style
        Lchar := MaskChar[7]; // EAN Lice Color
        Pchar := MaskChar[8]; // Price
        Qchar := MaskChar[9]; // Quantity
        Echar := MaskChar[10]; // Employee
        Uchar := MaskChar[11]; // Customer
        Achar := MaskChar[12]; // Application Entry
        NSchar := MaskChar[13]; // Number Series
        Tchar := MaskChar[14]; //Lot No.
        VChar := MaskChar[15]; //Serial No.

        Lpos := 0;
        Ipos := 0;
        Mpos := 13;
        Cpos := 0;
        Zpos := 0;
        Spos := 0;
        Lpos := 0;
        Ppos := 0;
        Qpos := 0;
        Epos := 0;
        Upos := 0;
        Apos := 0;
        TPos := 0;
        VPos := 0;

        Lnum := 0;
        Inum := 0;
        Cnum := 0;
        Znum := 0;
        Snum := 0;
        Lnum := 0;
        Pnum := 0;
        Qnum := 0;
        Enum := 0;
        Unum := 0;
        Anum := 0;
        Tnum := 0;
        VNum := 0;
    end;

    local procedure DimensionPatternOkForVFCNWMM(pItemNo: Code[20]; pDimPattern: Code[20]): Boolean
    var
        lVariantDimensionPatternLink: Record "LSC Variant Dim. Pattern Link";
        lItem: Record Item;
        Text008: TextConst ENU = 'Dimension Pattern ''%1'' not valid in Variant Framework ''%2''.';
    begin
        lItem.GET(pItemNo);
        lVariantDimensionPatternLink.RESET;
        lVariantDimensionPatternLink.SETRANGE("Variant Framework", lItem."LSC Variant Framework Code");
        IF lVariantDimensionPatternLink.FINDSET THEN
            REPEAT
                IF lVariantDimensionPatternLink."Dimension Pattern Code" = pDimPattern THEN
                    EXIT(TRUE);
            UNTIL lVariantDimensionPatternLink.NEXT = 0;
        ERROR(Text008, pDimPattern, lItem."LSC Variant Framework Code");
        EXIT(FALSE);
    end;

}
