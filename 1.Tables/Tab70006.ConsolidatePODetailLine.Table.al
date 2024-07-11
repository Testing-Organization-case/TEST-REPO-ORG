table 70006 "Consolidate PO Detail Line"
{
    DrillDownPageID = "Consign PO Detail Lines";
    LookupPageID = "Consign PO Detail Lines";

    fields
    {
        field(1; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Vendor Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Unit of Measure Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(10; "Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Line Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Location Code"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Direct Unit Cost Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Net Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Line Amount Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Child PO No. Update"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Child PO No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Document Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Type; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Document No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Qty per UOM"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            InitValue = 1;
        }
        field(23; MaxUOM; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "UOM Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Sum of Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Scheme; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Temp UOM Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Cross-Reference No."; Code[20])
        {
            AccessByPermission = TableData "Item Reference" = R;
            Caption = 'Cross-Reference No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
            end;

            trigger OnValidate()
            var
            begin

            end;
        }
        field(50000; Remark; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'NWMM';
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

