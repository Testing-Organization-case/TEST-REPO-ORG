table 70013 "Details Packaging Info."
{

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Tracking No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Packaging Reference No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Credit Memos";
        }
        field(4; "Packaging Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Packaging Type";
        }
        field(5; Length; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Width; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Height; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Total Width"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Assigned User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Warehouse Employee";
        }
        field(10; "Shipping Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Modified Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Warehouse Shipment Header";
        }
    }

    keys
    {
        key(Key1; "No.", "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "No." := 1;

        TempRec.Reset;
        if TempRec.FindLast then begin

            "No." := TempRec."No." + 1;

        end;

        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin

        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;

    var
        TempRec: Record "Details Packaging Info.";
}

