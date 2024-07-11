table 70005 "Consolidate PO Worksheet"
{

    fields
    {
        field(1; "Vendor No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Location; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit of Measure Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Direct Unit Cost Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Net Cost Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Total Line Dis AMT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Line Amount Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Scheme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
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

    trigger OnInsert()
    begin
        "Line No." := 1000;

        TempRec.Reset;
        if TempRec.FindLast then begin
            "Line No." := TempRec."Line No." + 1000;
        end
        else begin
            "Line No." := 1000;
        end;
    end;

    var
        TempRec: Record "Consolidate PO Worksheet";
}

