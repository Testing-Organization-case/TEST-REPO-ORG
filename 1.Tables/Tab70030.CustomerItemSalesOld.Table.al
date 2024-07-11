table 70030 CustomerItemSalesOld
{

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Invoiced Quantity"; Decimal)
        {
            FieldClass = Normal;
        }
        field(5; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Profit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Profit %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Customer No."; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Customer Name"; Text[250])
        {
        }
        field(12; "Variant Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Variant Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Total Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; CustomerInfo; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Posting Date"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

