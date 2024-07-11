table 70000 CreateMovement
{

    fields
    {
        field(1; "Lot No."; Code[50])
        {
        }
        field(2; "To Zone Code"; Code[50])
        {
        }
        field(3; "To Bin Code"; Code[50])
        {
        }
        field(4; "Item No."; Code[50])
        {
        }
        field(5; "From Zone Code"; Code[50])
        {
        }
        field(6; "From Bin Code"; Code[50])
        {
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; "ADCS User ID"; Code[50])
        {
        }
        field(9; "Created At"; DateTime)
        {
        }
        field(10; "Created By"; Code[50])
        {
        }
        field(11; "Modified At"; DateTime)
        {
        }
        field(12; "Modified By"; Code[50])
        {
        }
        field(13; "Line No."; Integer)
        {
        }
        field(14; "Variant Code"; Code[50])
        {
        }
        field(15; "NWTH Lot No. External"; Text[50])
        {
        }
        field(16; "Supplier Lot No."; Text[50])
        {
        }
        field(17; "Unit of Measure Code"; Code[50])
        {
        }
        field(18; "From Unit of Measure Code"; Code[50])
        {
        }
        field(19; "Qty. per From Unit of Measure"; Decimal)
        {
        }
        field(20; "Qty. per Unit of Measure"; Decimal)
        {
        }
        field(21; "Location Code"; Code[50])
        {
        }
        field(22; "Qty. (Base)"; Decimal)
        {
        }
        field(23; "Qty. Outstanding"; Decimal)
        {
        }
        field(24; "Qty. Outstanding (Base)"; Decimal)
        {
        }
        field(25; "Qty. to Handle"; Decimal)
        {
        }
        field(26; "Qty. to Handle (Base)"; Decimal)
        {
        }
        field(27; "Qty. Handled"; Decimal)
        {
        }
        field(28; "Qty. Handled (Base)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "ADCS User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        TempRec: Record CreateMovement;
    begin

        TempRec.Reset;
        if TempRec.FindLast then begin
            "Line No." := TempRec."Line No." + 1;
        end; // IF TempRec.FINDLAST THEN
    end;
}

