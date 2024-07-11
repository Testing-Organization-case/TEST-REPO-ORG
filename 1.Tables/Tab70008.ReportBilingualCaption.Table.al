table 70008 "Report Bilingual Caption"
{

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ID = 0 then begin
                    gRec_ReportCaption.SetCurrentKey("Label Type", "Report ID", ID);
                    gRec_ReportCaption.SetRange("Label Type", "Label Type");
                    gRec_ReportCaption.SetRange("Report ID", "Report ID");
                    if gRec_ReportCaption.FindLast then
                        ID := gRec_ReportCaption.ID;
                    ID += 1;
                end;
            end;
        }
        field(2; "Parent ID"; Integer)
        {
            Caption = 'Parent ID';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Parent ID" = 0 then
                    "Parent ID" := ID;
            end;
        }
        field(3; "Label Type"; Option)
        {
            Caption = 'Label Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(4; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            DataClassification = ToBeClassified;
            TableRelation = Object.ID WHERE(Type = CONST(Report));
        }
        field(5; "Vietnamese Caption"; Text[150])
        {
            Caption = 'Vietnamese Caption';
            DataClassification = ToBeClassified;
        }
        field(6; "Bilingual Caption"; Text[200])
        {
            Caption = 'Bilingual Caption';
            DataClassification = ToBeClassified;
        }
        field(8; "Report Name"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Report ID")));
            Caption = 'Report Name';
            Editable = false;
            FieldClass = FlowField;
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

        if ID = 0 then begin
            gRec_ReportCaption.SetCurrentKey("Label Type", "Report ID", ID);
            gRec_ReportCaption.SetRange("Label Type", "Label Type");
            gRec_ReportCaption.SetRange("Report ID", "Report ID");
            if gRec_ReportCaption.FindLast then
                ID := gRec_ReportCaption.ID;
            ID += 1;
            Validate("Parent ID");
        end;
    end;

    var
        gRec_ReportCaption: Record "Report Bilingual Caption";
}

