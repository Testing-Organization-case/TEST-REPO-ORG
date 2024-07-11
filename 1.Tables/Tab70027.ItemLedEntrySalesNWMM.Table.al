table 70027 ItemLedEntrySalesNWMM
{

    fields
    {
        field(1; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Variant Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Serial No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Sum Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; ItemLedgerEntryQty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; TransSalesEntryQty; Decimal)
        {
            FieldClass = Normal;
        }
        field(10; Description; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(11; "Variant Description"; Text[100])
        {
            CalcFormula = Lookup("Item Variant".Description WHERE(Code = FIELD("Variant Code"),
                                                                   "Item No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(12; "Balance Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Store Code"; Code[20])
        {
            CalcFormula = Lookup("LSC Store"."No." WHERE("Location Code" = FIELD("Location Code")));
            FieldClass = FlowField;
        }
        field(14; "Batch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Item Filter"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Location Filter"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Batch Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

