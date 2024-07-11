tableextension 70040 ValueEntryExt extends "Value Entry"
{
    fields
    {
        field(70000; "Offer No."; Code[20])
        {
            Caption = 'Offer No.';
            DataClassification = ToBeClassified;
        }
        field(70001; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            TableRelation = "LSC Retail Product Group".Code;
            DataClassification = ToBeClassified;
        }
        field(70002; "Item Category"; Code[20])
        {
            Caption = 'Item Category';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
        field(70003; "Batch No."; Code[15])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
        }
        field(70004; "Inv. Adjust. Group"; Code[10])
        {
            Caption = 'Inv. Adjust. Group';
            DataClassification = ToBeClassified;
        }
        field(70005; Division; Code[10])
        {
            Caption = 'Division';
            TableRelation = "LSC Division";
            DataClassification = ToBeClassified;
        }
        field(70006; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Promotion No."; Code[20])
        {
            Caption = 'Promotion No.';
            DataClassification = ToBeClassified;
        }
        field(70008; "BI Timestamp"; DateTime)
        {
            Caption = 'BI Timestamp';
            DataClassification = ToBeClassified;
        }
    }
}
