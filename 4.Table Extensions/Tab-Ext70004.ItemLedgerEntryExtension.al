tableextension 70004 "Item Ledger Entry Extension" extends "Item Ledger Entry"
{
    fields
    {
        field(70000; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Vendor No." WHERE("No." = FIELD("Item No.")));
        }
        field(70001; "Offer No."; Code[20])
        {
            Caption = 'Offer No.';
            DataClassification = ToBeClassified;
        }
        field(70002; "Batch No."; Code[15])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
        }
        field(70003; "Promotion No."; Code[20])
        {
            Caption = 'Promotion No.';
            DataClassification = ToBeClassified;
        }
        field(70004; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
        }
        field(70005; "Transfer Type"; Option)
        {
            OptionMembers = ,Warehouse,Store;
            Caption = 'Transfer Type';
            DataClassification = ToBeClassified;
        }
        field(70006; "BI Timestamp"; DateTime)
        {
            Caption = 'BI Timestamp';
            DataClassification = ToBeClassified;
        }
        field(70007; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            DataClassification = ToBeClassified;
        }

        field(70009; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
        }
    }
}
