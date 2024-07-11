table 70019 CreateMovementLinkTable
{

    fields
    {
        field(1; "From Zone Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "From Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; UOM; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "To Zone Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "To Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "ADCS User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
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
    begin
        // TempRec.RESET;
        // IF TempRec.FINDLAST THEN
        //  BEGIN
        //    "Line No." := TempRec."Line No." + 1;
        //  END; // IF TempRec.FINDLAST THEN
    end;

    var
        TempRec: Record CreateMovementLinkTable;
}

