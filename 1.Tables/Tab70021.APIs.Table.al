table 70021 APIs
{

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Page ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Page),
                                                                 "Object Subtype" = CONST('API'));
        }
        field(3; "API Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Route; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10; HTTP; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; HTTPS; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        GenerateID;
    end;

    //[Scope('Internal')]
    procedure GenerateID()
    var
        TempRec: Record APIs;
    begin

        ID := 1;

        TempRec.Reset;
        if TempRec.FindLast then begin
            ID := TempRec.ID + 1;
        end;
    end;
}

