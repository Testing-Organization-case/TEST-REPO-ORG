table 70001 "Item Filter By Tag Buffer"
{

    fields
    {
        field(1; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

