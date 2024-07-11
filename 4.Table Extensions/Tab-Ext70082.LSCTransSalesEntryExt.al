tableextension 70082 "LSC Trans. Sales Entry Ext" extends "LSC Trans. Sales Entry"
{
    fields
    {
        field(70000; "Location Code"; Code[50])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            FieldClass = FlowField;
            CalcFormula = Lookup("LSC Store"."Location Code" WHERE("No." = FIELD("Store No.")));
        }
    }
    trigger OnInsert()
    begin
        CALCFIELDS("Location Code");
    end;
}
