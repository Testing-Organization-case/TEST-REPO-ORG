table 70025 "Sales Loss Type"
{
    DrillDownPageID = "Sales Loss Type";
    LookupPageID = "Sales Loss Type";

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; ID; Guid)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        ID := CreateGuid;
    end;
}

