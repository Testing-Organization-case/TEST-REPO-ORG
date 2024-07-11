tableextension 70077 "LSC Label Functions" extends "LSC Label Functions"
{
    fields
    {
        field(70000; "Run Reports"; Integer)
        {
            Caption = 'Run Reports';
            DataClassification = ToBeClassified;
            TableRelation = Object.ID WHERE(Type = CONST(Report));
        }
    }
}
