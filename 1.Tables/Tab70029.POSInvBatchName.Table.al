table 70029 "POS Inv. Batch Name"
{
    // LookupPageID = "POS Inv. Batch Name List";

    fields
    {
        field(1; "Batch Name"; Text[30])
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
}

