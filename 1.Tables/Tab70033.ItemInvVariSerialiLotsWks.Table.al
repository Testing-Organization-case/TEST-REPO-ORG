table 70033 ItemInvVariSerialiLotsWks
{

    fields
    {
        field(1; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Location Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Item No Filter"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Location Code Filter"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Variant Code Filter"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code;
        }
        field(9; No; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Serial No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Sum Qty"; Decimal)
        {
        }
        field(12; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Item Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Item Ledger Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Tran Sale Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Lot No."; Code[50])
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
}

