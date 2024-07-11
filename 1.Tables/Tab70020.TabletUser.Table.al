table 70020 "Tablet User"
{
    Scope = OnPrem;
    fields
    {
        field(1; ID; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "User Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; Password; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Password);
                Password := CalculatePassword(CopyStr(Password, 1, 30));
            end;
        }
        field(4; "IMEI Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Email; Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(6; Image; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Phone Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Address; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "User Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'User,Administrator';
            OptionMembers = User,Administrator;
        }
        field(10; "Check IMEI"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Address 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Number; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Sales Person Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(14; "Location Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "User Name")
        {
            Clustered = true;
        }
        key(Key2; ID)
        {
        }
        key(Key3; "IMEI Number")
        {
        }
        key(Key4; Password)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User Name", "Sales Person Code")
        {
        }
    }

    trigger OnInsert()
    begin

        GenerateGUID;
    end;

    [Scope('OnPrem')]
    procedure CalculatePassword(Input: Text[30]) HashedValue: Text[250]
    var
        Convert: DotNet Convert;
        CryptoProvider: DotNet SHA512Managed;
        Encoding: DotNet Encoding;
    begin
        CryptoProvider := CryptoProvider.SHA512Managed;
        HashedValue := Convert.ToBase64String(CryptoProvider.ComputeHash(Encoding.Unicode.GetBytes(Input + "User Name")));
        CryptoProvider.Clear;
        CryptoProvider.Dispose;
    end;

    local procedure GenerateGUID()
    var
        TempRec: Record "Tablet User";
    begin

        // ID := 1;
        // TempRec.RESET;
        // IF TempRec.FINDLAST THEN
        //  BEGIN
        //    ID := TempRec.ID + 1;
        //  END;

        ID := CreateGuid;
    end;

    [Scope('OnPrem')]
    procedure CheckDuplicateUserName(UserNameP: Code[100])
    var
        TabletUserL: Record "Tablet User";
    begin

        TabletUserL.Reset;
        TabletUserL.SetRange("User Name", UserNameP);
        if TabletUserL.Count > 0 then begin
            Error('Already Exist with User Name %1', UserNameP);
        end;
    end;
}

