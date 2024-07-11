table 70023 "DMS Active Sessions"
{

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "User ID"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "User Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Device Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Device Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "IMEI Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Login At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Expired At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Token; Text[250])
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

    [Scope('OnPrem')]
    procedure GenerateToken(): Text
    var
        RandomTokenL: Text[250];
    begin
        RandomTokenL := '';
        RandomTokenL := CreateGuid;
        RandomTokenL := DelChr(RandomTokenL, '=', '{}-01');
        exit(RandomTokenL);
    end;

    //[Scope('Internal')]
    procedure GenerateID()
    var
        TempRecL: Record "DMS Active Sessions";
    begin

        ID := 1;

        TempRecL.Reset;
        if TempRecL.FindLast then begin
            ID := TempRecL.ID + 1;
        end;
    end;
}

