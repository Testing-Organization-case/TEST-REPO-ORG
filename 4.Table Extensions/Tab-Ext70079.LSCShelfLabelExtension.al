tableextension 70079 "LSC Shelf Label Extension" extends "LSC Shelf Label"
{
    fields
    {
        field(70000; "Standard Price Incl.VAT"; Decimal)
        {
            Caption = 'Standard Price Incl.VAT';
            DataClassification = ToBeClassified;
        }
        field(70001; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DataClassification = ToBeClassified;
        }
        field(70002; PromotionNo; Code[20])
        {
            Caption = 'PromotionNo';
            DataClassification = ToBeClassified;
        }
        field(70003; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(70004; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = ToBeClassified;
        }
    }
}
