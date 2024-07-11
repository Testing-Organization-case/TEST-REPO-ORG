tableextension 70025 "Purchase Line Archive Ext" extends "Purchase Line Archive"
{
    fields
    {
        field(70008; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
        }
        // field(70001; "Subtotal Excl. VAT"; Decimal)
        // {
        //     Caption = 'Subtotal Excl. VAT';
        //     DataClassification = ToBeClassified;
        // }
    }
}
