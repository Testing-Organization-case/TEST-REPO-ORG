table 70014 "Truck Registration"
{
    DrillDownPageID = "Truck Registration List";
    LookupPageID = "Truck Registration List";

    fields
    {
        field(1; "Truck No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Modified Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Truck No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin

        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
}

