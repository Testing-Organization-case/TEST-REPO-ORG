tableextension 70062 HierarchyRelationExt extends "LSC Hierar. Relation"
{
    fields
    {
        field(70000; "Last Modified User"; Code[50])
        {
            Caption = 'Last Modified User';
            DataClassification = ToBeClassified;
        }
        field(70001; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = ToBeClassified;
        }
    }

    trigger OnModify()
    begin
        "Last Modified User" := USERID; //Modified Date 4-Sep-2023
        "Last Modified Date"  := CURRENTDATETIME; //Modified Date 4-Sep-2023
    end;
}
