table 70034 Brand
{
    DrillDownPageID = "Brand List";
    LookupPageID = "Brand List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
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
        key(key2; Description)
        {

        }
    }

    fieldgroups
    {
    }
}

