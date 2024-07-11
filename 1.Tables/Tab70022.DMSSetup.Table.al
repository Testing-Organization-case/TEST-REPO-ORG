table 70022 "DMS Setup"
{

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; APIPublisher; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; APIGroup; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; APIVersion; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Session Timeout Interval"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Server Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Instance Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "API Port"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    [Scope('OnPrem')]
    procedure ValidateFields()
    var
        ErrorTxt: Text;
    begin

        ErrorTxt := '';

        if APIPublisher = '' then begin
            ErrorTxt := 'APIPublisher';
        end;

        if APIGroup = '' then begin
            if ErrorTxt <> '' then begin
                ErrorTxt += ', APIGroup';
            end
            else begin
                ErrorTxt := 'APIGroup';
            end;
        end;

        if APIVersion = '' then begin
            if ErrorTxt <> '' then begin
                ErrorTxt += ', APIVersion';
            end
            else begin
                ErrorTxt := 'APIVersion';
            end;
        end;

        if ErrorTxt <> '' then begin
            ErrorTxt := 'In DMS Setup, ' + ErrorTxt + ' must have value!';
            Error(ErrorTxt);
        end; // IF ErrorTxt <> '' THEN
    end;
}

