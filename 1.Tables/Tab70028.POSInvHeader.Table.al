table 70028 "POS Inv. Header"
{

    fields
    {
        field(1; "Batch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Calculated Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Location Code"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Batch Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Calculated Date & Time" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Calculated Date & Time" := CurrentDateTime;
    end;
}

