table 70004 "Consolidate Purchase Line"
{
    DrillDownPageID = "Consolidate Purchase Lines";
    LookupPageID = "Consolidate Purchase Lines";

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Unit of Measure Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Direct Unit Cost Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Net Cost Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Total Dis AMT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Line Amount Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Scheme Code"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Trade Scheme".Scheme WHERE(Active = CONST(true),
                                                                "Vendor No." = FIELD("Vendor No."),
                                                                "Item No." = FIELD("Item No."));
        }
        field(11; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Total Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Total Line Amount Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Location Code"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Retrieve Purchase Lines"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Consolidate Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Consolidate End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Total Discount Amt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Total Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; TotalAmountLoc; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(25; SumofQty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; MaxQtyperUOM; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Lock PO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Posting Date"; Date)
        {
        }
        field(30; "Cross-Reference No."; Code[20])
        {
            AccessByPermission = TableData "Item Reference" = R;
            Caption = 'Cross-Reference No.';
            DataClassification = ToBeClassified;

        }
        field(50000; Remark; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'NWMM';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Vendor No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

    end;

    var
        TempRec: Record "Consolidate Purchase Line";

    [Scope('OnPrem')]
    local procedure AssitEdit()
    begin
        PAGE.Run(54);
    end;
}

