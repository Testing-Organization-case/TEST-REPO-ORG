table 70026 ItemInvVarSerialLot
{

    fields
    {
        field(1; "Item No."; Code[20])
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
        field(8; "Item Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Qty; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  Description = FIELD("Item Description")));
            FieldClass = FlowField;
        }
        field(17; "Modifed Date"; DateTime)
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

    trigger OnInsert()
    begin
        "Modifed Date" := CreateDateTime(WorkDate, Time);
    end;

    trigger OnModify()
    begin
        "Modifed Date" := CreateDateTime(WorkDate, Time);
    end;
}

