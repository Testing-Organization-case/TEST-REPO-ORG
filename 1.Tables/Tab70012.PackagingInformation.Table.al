table 70012 "Packaging Information"
{
    DataCaptionFields = "Packaging Ref No.", "Packaging Type";
    DrillDownPageID = "Packaging Information List";
    LookupPageID = "Packaging Information List";

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Packaging Ref No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Credit Memos";
        }
        field(3; "Packaging Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Packaging Type";
        }
        field(4; "Reason Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Pckg Reason Code";
        }
        field(5; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Modified Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'From Purchase Line';
            TableRelation = "Warehouse Shipment Header";
        }
        field(11; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(12; Description; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.", "Document No.", "Item No.")
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
        TempRec: Record "Packaging Information";
}

