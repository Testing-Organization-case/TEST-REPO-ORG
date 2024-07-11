table 70031 PeriodicDiscountNwmm
{

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Disabled,Enabled';
            OptionMembers = Disabled,Enabled;
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Multibuy,Mix&Match,Disc. Offer,Total Discount,Tender Type,Item Point,Line Discount';
            OptionMembers = Multibuy,"Mix&Match","Disc. Offer","Total Discount","Tender Type","Item Point","Line Discount";
        }
        field(5; "Price Group"; Code[10])
        {
            Caption = 'Price Group';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Price Group" WHERE("LSC Retail Price Group" = CONST(true));
        }

        field(9; "Offer Type"; Option)
        {
            Caption = 'Offer Type';
            Editable = false;
            OptionCaption = 'Promotion,Deal,Multibuy,Mix&Match,Disc. Offer,Total Discount,Tender Type,Item Point,Line Discount,Customer,Infocode';
            OptionMembers = Promotion,Deal,Multibuy,"Mix&Match","Disc. Offer","Total Discount","Tender Type","Item Point","Line Discount",Customer,Infocode;
        }
        field(10; "Offer No."; Code[20])
        {
            Caption = 'Offer No.';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Periodic Discount";
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(15; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Block Infocode Discount"; Boolean)
        {
            Caption = 'Block Infocode Discount';
            DataClassification = ToBeClassified;
        }
        field(21; "Block Sales Commission"; Boolean)
        {
            Caption = 'Block Sales Commission';
            DataClassification = ToBeClassified;
        }
        field(25; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
        field(30; "Validation Period ID"; Code[10])
        {
            Caption = 'Validation Period ID';
            DataClassification = ToBeClassified;
            Numeric = true;
            TableRelation = "LSC Validation Period";
        }
        field(31; "Validation Description"; Text[100])
        {
            Caption = 'Validation Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(32; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            Editable = false;
            FieldClass = Normal;
        }
        field(33; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(34; "Use Trans. Line Time"; Boolean)
        {
            Caption = 'Use Trans. Line Time';
            DataClassification = ToBeClassified;
        }
        field(35; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            FieldClass = Normal;
        }
        field(40; "Price Group Filter"; Code[10])
        {
            Caption = 'Price Group Filter';
            FieldClass = Normal;
            TableRelation = "Customer Price Group".Code;
        }
        field(45; "Disc. Validation Period Filter"; Code[10])
        {
            Caption = 'Disc. Validation Period Filter';
            FieldClass = Normal;
            TableRelation = "LSC Validation Period".ID;
        }
        field(85; "Block Periodic Discount"; Boolean)
        {
            Caption = 'Block Periodic Discount';
            DataClassification = ToBeClassified;
        }
        field(100; "Price Group Validation"; Option)
        {
            Caption = 'Price Group Validation';
            DataClassification = ToBeClassified;
            OptionCaption = 'Valid in Store,Matches Trans. Line Price Gr.';
            OptionMembers = "Valid in Store","Matches Trans. Line Price Gr.";
        }
        field(101; "Sales Type Filter"; Code[250])
        {
            Caption = 'Sales Type Filter';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Sales Type".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(200; "Sales (Qty.)"; Decimal)
        {
            Caption = 'Sales (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(201; "Sales (LCY)"; Decimal)
        {
            Caption = 'Sales (LCY)';
            Editable = false;
        }
        field(202; "COGS (LCY)"; Decimal)
        {
            Caption = 'COGS (LCY)';
            Editable = false;
        }
        field(305; "Discount Type"; Option)
        {
            Caption = 'Discount Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Deal Price,Discount %,Discount Amount,Least Expensive,Line spec.';
            OptionMembers = "Deal Price","Discount %","Discount Amount","Least Expensive","Line spec.";
        }
        field(310; "Same/Diff. M&M Lines"; Option)
        {
            Caption = 'Same/Diff. M&M Lines';
            DataClassification = ToBeClassified;
            InitValue = "Same/Diff. M&M Lines";
            OptionCaption = 'Different M&M Lines,Same/Diff. M&M Lines';
            OptionMembers = "Different M&M Lines","Same/Diff. M&M Lines";
        }
        field(315; "No. of Lines to Trigger"; Decimal)
        {
            BlankZero = true;
            Caption = 'No. of Lines to Trigger';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = Normal;
        }
        field(320; "Deal Price Value"; Decimal)
        {
            Caption = 'Deal Price Value';
            DataClassification = ToBeClassified;
        }
        field(325; "Discount % Value"; Decimal)
        {
            Caption = 'Discount % Value';
            DataClassification = ToBeClassified;
        }
        field(330; "Discount Amount Value"; Decimal)
        {
            Caption = 'Discount Amount Value';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(335; "No. of Least Expensive Items"; Integer)
        {
            Caption = 'No. of Least Expensive Items';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(336; "Disc. % of Least Expensive"; Decimal)
        {
            Caption = 'Disc. % of Least Expensive';
            DataClassification = ToBeClassified;
            InitValue = 100;
            MaxValue = 100;
            MinValue = 0;
        }
        field(337; "Skip Least Exp. Customer Opt."; Boolean)
        {
            Caption = 'Skip Least Exp. Customer Opt.';
            DataClassification = ToBeClassified;
        }
        field(350; "No. of Times Applicable"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Times Applicable';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(400; "No. of Line Groups"; Integer)
        {
            Caption = 'No. of Line Groups';
            FieldClass = Normal;
        }
        field(410; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Discount Group";
        }
        field(411; "Amount to Trigger"; Decimal)
        {
            Caption = 'Amount to Trigger';
            DataClassification = ToBeClassified;
        }
        field(412; "Member Value"; Code[10])
        {
            Caption = 'Member Value';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Member Type" = CONST(Scheme)) "LSC Member Scheme"
            ELSE
            IF ("Member Type" = CONST(Club)) "LSC Member Club";
        }
        field(413; "Pop-up Line 1"; Text[80])
        {
            Caption = 'Pop-up Line 1';
            DataClassification = ToBeClassified;
        }
        field(414; "Pop-up Line 2"; Text[80])
        {
            Caption = 'Pop-up Line 2';
            DataClassification = ToBeClassified;
        }
        field(415; "Pop-up Line 3"; Text[80])
        {
            Caption = 'Pop-up Line 3';
            DataClassification = ToBeClassified;
        }
        field(450; "Discount Tracking No."; Code[10])
        {
            Caption = 'Discount Tracking No.';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Discount Tracking Header"."No.";
        }
        field(451; "Valid From Before Exp. Date"; DateFormula)
        {
            Caption = 'Valid From Before Expiration Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CheckExpiryDateFormula("Valid From Before Exp. Date");
            end;
        }
        field(452; "Valid To Before Exp. Date"; DateFormula)
        {
            Caption = 'Valid To Before Expiration Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //CheckExpiryDateFormula("Valid To Before Exp. Date");
            end;
        }
        field(453; "Planned Demand Type"; Option)
        {
            Caption = 'Planned Demand Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Substitute Quantity,Additional Quantity (to Forecast),Additional % Factor (to Forecast)';
            OptionMembers = " ","Substitute Quantity","Additional Quantity (to Forecast)","Additional % Factor (to Forecast)";
        }
        field(454; "Planned Demand"; Decimal)
        {
            Caption = 'Planned Demand';
            DataClassification = ToBeClassified;
        }
        field(500; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(501; "Coupon Code"; Code[10])
        {
            Caption = 'Coupon Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Coupon Header" WHERE("Calculation Type" = CONST("Triggers Offer"));
        }
        field(502; "Coupon Qty Needed"; Decimal)
        {
            Caption = 'Coupon Qty Needed';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(503; "Member Type"; Option)
        {
            Caption = 'Member Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Scheme,Club';
            OptionMembers = Scheme,Club;
        }
        field(504; "Member Attribute"; Code[10])
        {
            Caption = 'Member Attribute';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Member Attribute";
        }
        field(505; "Member Attribute Value"; Text[100])
        {
            Caption = 'Member Attribute Value';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                LookupValue: Text[30];
            begin
            end;
        }
        field(506; "Block Manual Price Change"; Boolean)
        {
            Caption = 'Block Manual Price Change';
            DataClassification = ToBeClassified;
        }
        field(507; "Block Line Discount Offer"; Boolean)
        {
            Caption = 'Block Line Discount Offer';
            DataClassification = ToBeClassified;
        }
        field(508; "Block Total Discount Offer"; Boolean)
        {
            Caption = 'Block Total Discount Offer';
            DataClassification = ToBeClassified;
        }
        field(509; "Block Tender Type Discount"; Boolean)
        {
            Caption = 'Block Tender Type Discount';
            DataClassification = ToBeClassified;
        }
        field(510; "Block Member Points"; Boolean)
        {
            Caption = 'Block Member Points';
            DataClassification = ToBeClassified;
        }
        field(511; "Block Printing"; Boolean)
        {
            Caption = 'Block Printing';
            DataClassification = ToBeClassified;
        }
        field(512; "Buyer ID"; Code[50])
        {
            Caption = 'Buyer ID';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Retail User";
        }
        field(513; "Buyer Group Code"; Code[10])
        {
            Caption = 'Buyer Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Buyer Group";
        }
        field(514; "Maximum Discount Amount"; Decimal)
        {
            Caption = 'Maximum Discount Amount';
            DataClassification = ToBeClassified;
        }
        field(515; "Tender Type Code"; Code[10])
        {
            Caption = 'Tender Type Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "LSC Tender Type Setup".Code;
        }
        field(516; "Tender Type Value"; Code[10])
        {
            Caption = 'Tender Type Value';
            DataClassification = ToBeClassified;
        }
        field(517; "Prompt for Action"; Option)
        {
            Caption = 'Prompt for Action';
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Ask for Tender Type';
            OptionMembers = "None","Ask for Tender Type";
        }
        field(519; "Tender Offer %"; Decimal)
        {
            Caption = 'Tender Offer %';
            DataClassification = ToBeClassified;
        }
        field(520; "Tender Offer Amount"; Decimal)
        {
            Caption = 'Tender Offer Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(530; "Line Discount Group Code"; Code[10])
        {
            Caption = 'Line Discount Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Line Discount Offer Group";

            trigger OnValidate()
            var
            //lLineDiscountOfferGroup: Record "Line Discount Offer Group";
            begin
            end;
        }
        field(531; "Line Discount Execution"; Option)
        {
            Caption = 'Line Discount Execution';
            DataClassification = ToBeClassified;
            OptionCaption = 'Manual-Line,Manual-Trans.,Automatic';
            OptionMembers = "Manual-Line","Manual-Trans.",Automatic;
        }
        field(540; "Sequence Code"; Option)
        {
            Caption = 'Sequence Code';
            DataClassification = ToBeClassified;
            OptionCaption = 'A,B,C,D,E,F,G';
            OptionMembers = A,B,C,D,E,F,G;
        }
        field(541; "Sequence Function"; Option)
        {
            Caption = 'Sequence Function';
            DataClassification = ToBeClassified;
            OptionCaption = 'Highest,Sum,Line';
            OptionMembers = Highest,"Sum",Line;
        }
        field(550; "Member Points"; Decimal)
        {
            Caption = 'Member Points';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
        }
        field(551; ItemNo; Code[30])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                ItemPrice: Record "Sales Price";
                RetailPriceUtil: Codeunit "LSC Retail Price Utils";
            begin
            end;
        }
        field(552; ItemDescription; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(600; "Triggers Pop-up on POS"; Boolean)
        {
            Caption = 'Triggers Pop-up on POS';
            Editable = false;
            FieldClass = Normal;
        }
        field(601; "Small Business Filter"; Code[20])
        {
            Caption = 'Small Business Filter';
            DataClassification = ToBeClassified;
        }
        field(602; "Standard Price Including VAT"; Decimal)
        {
            Caption = 'Standard Price Including VAT';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(603; "Standard Price"; Decimal)
        {
            Caption = 'Standard Price';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(604; "Prod. Group Category"; Code[10])
        {
            Caption = 'Prod. Group Category';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(605; "Line Group"; Code[10])
        {
            Caption = 'Line Group';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Mix & Match Line Groups"."Line Group Code" WHERE("Group No." = FIELD("Offer No."));
        }
        field(606; "No. of Items Needed"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Items Needed';
            DataClassification = ToBeClassified;
        }
        field(607; "Offer Price"; Decimal)
        {
            Caption = 'Offer Price';
            DataClassification = ToBeClassified;
        }
        field(608; "Offer Price Including VAT"; Decimal)
        {
            Caption = 'Offer Price Including VAT';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(609; "Discount Amount Including VAT"; Decimal)
        {
            Caption = 'Discount Amount Including VAT';
            DataClassification = ToBeClassified;
        }
        field(610; "Variant Type"; Option)
        {
            Caption = 'Variant Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Variant,Dimension 1';
            OptionMembers = " ",Variant,"Dimension 1";
        }
        field(611; "Prompt at Scan"; Boolean)
        {
            Caption = 'Prompt at Scan';
            DataClassification = ToBeClassified;
        }
        field(612; "Header Type"; Option)
        {
            Caption = 'Header Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Multibuy,Mix&Match,Disc. Offer,Total Discount,Tender Type,Item Point,Line Discount';
            OptionMembers = Multibuy,"Mix&Match","Disc. Offer","Total Discount","Tender Type","Item Point","Line Discount";
        }
        field(613; Exclude; Boolean)
        {
            Caption = 'Exclude';
            DataClassification = ToBeClassified;
        }
        field(714; "Primary Key"; Code[35])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // "Primary Key" :=
                //  BoUtil.CombineTableKey(2,"Offer No.",BoUtil.IntegerToStr("Line No."),'','','');
            end;
        }
        field(715; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            InitValue = 1;

            trigger OnValidate()
            var
                ItemRec: Record Item;
            begin
                // IF ItemRec.GET("No.") THEN
                //  IF ItemRec."Qty not in Decimal" THEN
                //    IF Quantity <> ROUND(Quantity,1) THEN
                //      ERROR(STRSUBSTNO(Text014, FIELDCAPTION(Quantity)));
            end;
        }
        field(716; "Display Prompt"; Text[30])
        {
            Caption = 'Display Prompt';
            DataClassification = ToBeClassified;
        }
        field(717; "Explanatory Header Text"; Text[30])
        {
            Caption = 'Explanatory Header Text';
            Editable = false;
            FieldClass = Normal;
        }
        field(718; "Min. Selection"; Integer)
        {
            Caption = 'Min. Selection';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            //Offer: Record Offer;
            begin
                // IF "Min. Selection" > 0 THEN BEGIN
                //  IF ("Max. Selection" <> 0) AND ("Max. Selection" < "Min. Selection") THEN
                //    ERROR(Text015,FIELDCAPTION("Min. Selection"),FIELDCAPTION("Max. Selection"));
                //  Offer.GET("Offer No.");
                //  IF Offer."Selection Type" <> Offer."Selection Type"::"Single Modifier" THEN
                //    IF Offer."OK Pressed Action" = Offer."OK Pressed Action"::"Close Form" THEN
                //      ERROR(Text025,FIELDCAPTION("Min. Selection"),Offer.FIELDCAPTION("OK Pressed Action"),FORMAT(Offer."OK Pressed Action"));
                // END;
                // IF "Modifier Added Amount" <> 0 THEN BEGIN
                //  IF ("Min. Selection" = 0) THEN
                //    ERROR(Text023,FIELDCAPTION("Min. Selection"),FIELDCAPTION("Max. Selection"),FIELDCAPTION("Modifier Added Amount"));
                //  IF ("Min. Selection" <> "Max. Selection") THEN
                //    ERROR(Text024,FIELDCAPTION("Min. Selection"),FIELDCAPTION("Max. Selection"),FIELDCAPTION("Modifier Added Amount"));
                // END;
                //
                // IF "Min. Selection" > 1 THEN
                //  "Multiple Selection" := TRUE;
            end;
        }
        field(719; "Max. Selection"; Integer)
        {
            Caption = 'Max. Selection';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF "Max. Selection" > 0 THEN
                //  IF ("Min. Selection" <> 0) AND ("Max. Selection" < "Min. Selection") THEN
                //    ERROR(Text015,FIELDCAPTION("Min. Selection"),FIELDCAPTION("Max. Selection"));
                //
                // IF "Modifier Added Amount" <> 0 THEN BEGIN
                //  IF ("Max. Selection" = 0) THEN
                //    ERROR(Text023,FIELDCAPTION("Min. Selection"),FIELDCAPTION("Max. Selection"),FIELDCAPTION("Modifier Added Amount"));
                //  IF ("Min. Selection" <> "Max. Selection") THEN
                //    ERROR(Text024,FIELDCAPTION("Min. Selection"),FIELDCAPTION("Max. Selection"),FIELDCAPTION("Modifier Added Amount"));
                // END;
                //
                // IF "Max. Selection" > 1 THEN
                //  "Multiple Selection" := TRUE;
                // IF "Max. Selection" = 1 THEN
                //  "Multiple Selection" := FALSE;
                // IF "Max. Selection" = 0 THEN
                //  "Multiple Selection" := TRUE;
            end;
        }
        field(720; "Multiple Selection"; Boolean)
        {
            Caption = 'Multiple Selection';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF "Multiple Selection" THEN BEGIN
                //  "Max. Selection" := 0;
                // END ELSE BEGIN
                //  "Max. Selection" := 1;
                //  IF "Min. Selection" > 1 THEN
                //    VALIDATE("Min. Selection",1);
                // END;
            end;
        }
        field(721; "Selected Deal Line No."; Integer)
        {
            Caption = 'Selected Deal Line No.';
            DataClassification = ToBeClassified;
        }
        field(722; "Selected Modifier Line No."; Integer)
        {
            Caption = 'Selected Modifier Line No.';
            DataClassification = ToBeClassified;
        }
        field(723; "Modifier Added Amount"; Decimal)
        {
            Caption = 'Modifier Added Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            //DealModItem: Record "Deal Modifier Item";
            begin
                // IF (xRec."Modifier Added Amount" = 0 ) AND ("Modifier Added Amount" <> 0) THEN BEGIN
                //  TESTFIELD(Type,Type::"Deal Modifier");
                //  DealModItem.RESET;
                //  DealModItem.SETRANGE("Offer No.","Offer No.");
                //  DealModItem.SETRANGE("Offer Line No.","Line No.");
                //  DealModItem.SETFILTER("Added Amount",'<>%1',0);
                //  IF NOT DealModItem.ISEMPTY THEN BEGIN
                //    IF CONFIRM(STRSUBSTNO(Text019,DealModItem.FIELDCAPTION("Added Amount"),FIELDCAPTION("Modifier Added Amount")),FALSE) THEN
                // BEGIN
                //      IF DealModItem.FIND('-') THEN
                //        REPEAT
                //          DealModItem."Added Amount" := 0;
                //          DealModItem.MODIFY(TRUE);
                //        UNTIL DealModItem.NEXT = 0;
                //    END ELSE BEGIN
                //      "Modifier Added Amount" := xRec."Modifier Added Amount";
                //      EXIT;
                //    END;
                //  END;
                //  IF ("Min. Selection" = 0) OR ("Max. Selection" = 0) THEN
                //    ERROR(Text023,FIELDCAPTION("Min. Selection"),FIELDCAPTION("Max. Selection"),FIELDCAPTION("Modifier Added Amount"));
                //  IF ("Min. Selection" <> "Max. Selection") THEN
                //    ERROR(Text024,FIELDCAPTION("Min. Selection"),FIELDCAPTION("Max. Selection"),FIELDCAPTION("Modifier Added Amount"));
                // END;
            end;
        }
        field(724; "Default Selection"; Boolean)
        {
            Caption = 'Default Selection';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            //OfferLine2: Record "Offer Line";
            begin
                // IF "Default Selection" THEN BEGIN
                //  DiscountOffer.GET("Offer No.");
                //
                //  TESTFIELD(Type,Type::"Deal Modifier");
                //  TESTFIELD("Show on Extra Request Only",FALSE);
                //  IF NOT (DiscountOffer."Selection Type" = DiscountOffer."Selection Type"::"Single Modifier") THEN
                //    ERROR(
                //      Text016,FIELDCAPTION("Default Selection"),
                //      DiscountOffer.FIELDCAPTION("Selection Type"),FORMAT(DiscountOffer."Selection Type"));
                //
                //  IF NOT (DiscountOffer."When Deal Pressed" = DiscountOffer."When Deal Pressed"::"Insert Default Selection") THEN
                //    ERROR(
                //      Text016,FIELDCAPTION("Default Selection"),
                //      DiscountOffer.FIELDCAPTION("When Deal Pressed"),FORMAT(DiscountOffer."When Deal Pressed"));
                //  OfferLine2.RESET;
                //  OfferLine2.SETRANGE("Offer No.","Offer No.");
                //  OfferLine2.SETFILTER("Line No.",'<>%1',"Line No.");
                //  OfferLine2.SETRANGE("Default Selection",TRUE);
                //  IF NOT OfferLine2.ISEMPTY THEN
                //    ERROR(Text017,FIELDCAPTION("Default Selection"));
                // END;
            end;
        }
        field(725; "Show on Extra Request Only"; Boolean)
        {
            Caption = 'Show on Extra Request Only';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF "Show on Extra Request Only" THEN
                //  TESTFIELD(Type,Type::"Deal Modifier");
            end;
        }
        field(726; "Line Added Amount"; Decimal)
        {
            Caption = 'Line Added Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                // IF "Modifier Added Amount" > 0 THEN
                //  TESTFIELD(Type,Type::"Deal Modifier");
            end;
        }
        field(727; "Deal Mod. Items with Min. Sel."; Integer)
        {
            Caption = 'Deal Mod. Items with Min. Sel.';
            Editable = false;
            FieldClass = Normal;
        }
        field(728; "Deal Modifier Size Group"; Code[10])
        {
            Caption = 'Deal Modifier Size Group';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Deal Modifier Size Group".Code;
        }
        field(729; "Deal Mod. Size Gr. Index"; Integer)
        {
            Caption = 'Deal Mod. Size Gr. Index';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            //OfferLine2: Record "Offer Line";
            begin
                // IF "Deal Modifier Size Group" <> '' THEN BEGIN
                //    TESTFIELD("Deal Mod. Size Gr. Index");
                //  OfferLine2.RESET;
                //  OfferLine2.SETRANGE("Offer No.","Offer No.");
                //  OfferLine2.SETFILTER("Line No.",'<>%1',"Line No.");
                //  OfferLine2.SETRANGE(OfferLine2."Deal Modifier Size Group","Deal Modifier Size Group");
                //  OfferLine2.SETRANGE("Deal Mod. Size Gr. Index","Deal Mod. Size Gr. Index");
                //  IF NOT OfferLine2.ISEMPTY THEN
                //    ERROR(
                //      Text027,FIELDCAPTION("Deal Modifier Size Group"),"Deal Modifier Size Group",
                //      FIELDCAPTION("Deal Mod. Size Gr. Index"),"Deal Mod. Size Gr. Index");
                // END;
            end;
        }
        field(730; "Receipt Printing"; Option)
        {
            Caption = 'Receipt Printing';
            DataClassification = ToBeClassified;
            OptionCaption = 'Modifier Descr. & Amt. Only,All Modifier Lines';
            OptionMembers = "Modifier Descr. & Amt. Only","All Modifier Lines";

            trigger OnValidate()
            var
            //Offer: Record Offer;
            begin
                // IF "Receipt Printing" = "Receipt Printing"::"All Modifier Lines" THEN BEGIN
                //  Offer.GET("Offer No.");
                //  IF (Offer."Deal Lines Printing" = Offer."Deal Lines Printing"::"Header Only") OR
                //     (Offer."Deal Lines Printing" = Offer."Deal Lines Printing"::"Items w/Added Amt. Only")
                //  THEN
                //    Offer.FIELDERROR("Deal Lines Printing");
                // END;
            end;
        }
        field(731; "Mobile - Display Required"; Boolean)
        {
            Caption = 'Mobile - Display Required';
            DataClassification = ToBeClassified;
        }
        field(800; "Line Specific"; Boolean)
        {
            Caption = 'Line Specific';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF NOT "Line Specific" THEN
                //  IF CONFIRM(Text007,TRUE) THEN BEGIN
                //    "Value Type" := "Value Type"::Factor;
                //    Value := 0;
                //    ModifyValuesInLines;
                //  END ELSE
                //    ERROR(Text008);
            end;
        }
        field(801; "Value Type"; Option)
        {
            Caption = 'Value Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Factor,Additional per unit,Replacement per unit';
            OptionMembers = Factor,"Additional per unit","Replacement per unit";

            trigger OnValidate()
            begin
                // IF "Line Specific" THEN //Only visible in RTC
                //  ERROR(Text009);
                // ModifyValuesInLines;
            end;
        }
        field(802; Value; Decimal)
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                // IF "Line Specific" THEN //Only visible in RTC
                //  ERROR(Text009);
                // ModifyValuesInLines;
            end;
        }
        field(803; DiscountTypeH; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Deal Price","Discount %","Discount Amount","Least Expensive","Line spec.";
        }
        field(804; BenefitCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(805; BenefitDescription; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(806; "Trigger Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(807; InfoDescription; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(808; BenefitType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Discount,Item,"Item-List",Coupon,"Member Points";
        }
        field(809; "Finished Mark"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        //ArchiveHeader: Record "Archived Periodic Discount";
        PeriodDiscount1: Record CustomerItemSalesOld;
}

