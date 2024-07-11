tableextension 70044 SalesPriceExt extends "Sales Price"
{
    fields
    {
        // field(70000; "Markup %"; Decimal)
        // {
        //     Caption = 'Markup %';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         LocalItem: Record Item;
        //         Price, CurrencyFactor : Decimal;
        //         ItemUnitofMeasure: Record "Item Unit of Measure";
        //     begin
        //         LocalItem.GET("Item No.");
        //         IF (LocalItem."Price/Profit Calculation" = LocalItem."Price/Profit Calculation"::"Profit=Price-Cost") OR
        //            (LocalItem."Price/Profit Calculation" = LocalItem."Price/Profit Calculation"::"No Relationship") THEN BEGIN
        //             ;
        //             Price := LocalItem."Unit Cost" * (1 + "Markup %" / 100);
        //             IF "Unit of Measure Code" <> '' THEN BEGIN
        //                 ItemUnitofMeasure.GET("Item No.", "Unit of Measure Code");
        //                 Price := Price * ItemUnitofMeasure."Qty. per Unit of Measure";
        //             END;
        //             IF "Currency Code" <> '' THEN BEGIN
        //                 ;
        //                 CurrencyFactor := CurrencyExchangeRate.ExchangeRate(TODAY(), "Currency Code");
        //                 Price := CurrencyExchangeRate.ExchangeAmtLCYToFCY(TODAY(), "Currency Code", Price, CurrencyFactor);
        //             END;
        //             IF "Price Includes VAT" THEN BEGIN
        //                 ;
        //                 VATPostingSetup.GET("VAT Bus. Posting Gr. (Price)", LocalItem."VAT Prod. Posting Group");
        //                 CASE VATPostingSetup."VAT Calculation Type" OF
        //                     VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
        //                         VATPostingSetup."VAT %" := 0;
        //                     VATPostingSetup."VAT Calculation Type"::"Sales Tax":
        //                         ERROR(Text1000701 +
        //                               Text1000702, VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
        //                               VATPostingSetup."VAT Calculation Type");
        //                 END;
        //                 Price := Price * (1 + VATPostingSetup."VAT %" / 100);
        //             END;
        //             IF "Price Includes VAT" THEN
        //                 "Unit Price" := "Amount Rounding".InvoiceRound("Currency Code", Price)
        //             ELSE
        //                 "Unit Price" := "Amount Rounding".UnitAmountRound("Currency Code", Price);
        //         END;

        //         //LS-12335 "Calculate Prices"(Item,FIELDNO("Markup %"));
        //         //LS-12856 ProductExt.CalculatePrices(Rec,Item,FIELDNO("Markup %")); //LS-12335
        //         ProductExt.CalculatePrices(Rec, LocalItem, FIELDNO("Markup %")); //LS-12856
        //     end;
        // }
        // field(70001; "Profit %"; Decimal)
        // {
        //     Caption = 'Profit %';
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         LocalItem: Record Item;
        //     begin
        //         //LS
        //         LocalItem.GET("Item No.");
        //         "Markup %" := ROUND("Profit %" / (100 - "Profit %") * 100, 0.00001);
        //         //LS-12335 "Calculate Prices"(Item,FIELDNO("Profit %"));
        //         //LS-12856 ProductExt.CalculatePrices(Rec,Item,FIELDNO("Profit %")); //LS-12335
        //         ProductExt.CalculatePrices(Rec, LocalItem, FIELDNO("Profit %")); //LS-12856
        //     end;
        // }
        // field(70002; "Profit (LCY)"; Decimal)
        // {
        //     Caption = 'Profit (LCY)';
        //     Editable = false;
        //     DataClassification = ToBeClassified;
        // }
        // field(70003; "Unit Price Including VAT"; Decimal)
        // {
        //     Caption = 'Unit Price Including VAT';
        //     AutoFormatExpression = "Currency Code";
        //     DataClassification = ToBeClassified;
        //     trigger OnValidate()
        //     var
        //         LocalItem: Record Item;
        //     begin
        //         //LS
        //         LocalItem.GET("Item No.");
        //         IF NOT "Price Includes VAT" THEN BEGIN
        //             IF NOT VATPostingSetup.GET("VAT Bus. Posting Gr. (Price)", LocalItem."VAT Prod. Posting Group") THEN
        //                 VATPostingSetup.INIT;
        //             CASE VATPostingSetup."VAT Calculation Type" OF
        //                 VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
        //                     VATPostingSetup."VAT %" := 0;
        //                 VATPostingSetup."VAT Calculation Type"::"Sales Tax":
        //                     ERROR(
        //                       Text99001450 +
        //                       Text99001451, VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
        //                       VATPostingSetup."VAT Calculation Type");
        //             END;
        //             "Unit Price" := ROUND("Unit Price Including VAT" / (1 + (VATPostingSetup."VAT %" / 100)), 0.00001);
        //         END ELSE
        //             "Unit Price" := "Unit Price Including VAT";

        //         //LS-12335 "Calculate Prices"(Item,FIELDNO("Unit Price Including VAT"));
        //         //LS-12856 ProductExt.CalculatePrices(Rec,Item,FIELDNO("Unit Price Including VAT")); //LS-12335
        //         ProductExt.CalculatePrices(Rec, LocalItem, FIELDNO("Unit Price Including VAT")); //LS-12856
        //     end;
        // }
        field(70004; "Item Description"; Text[150])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
        }

        field(70005; "Variant Description"; Text[150])
        {
            Caption = 'Variant Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant"."Description 2" WHERE(Code = FIELD("Variant Code"), "Item No." = FIELD("Item No.")));
        }



    }
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        VATPostingSetup: Record "VAT Posting Setup";
        Text1000701: TextConst ENU = 'Prices including VAT cannot be calculated when';
        Text1000702: TextConst ENU = '%1 is %2.';
        Text99001450: TextConst ENU = 'Prices including VAT cannot be calculated when ';
        "Amount Rounding": Codeunit "LSC Helper";
        Text99001451: TextConst ENU = '%1 is %2.';
        ProductExt: Codeunit "LSC Product Ext.";
}
