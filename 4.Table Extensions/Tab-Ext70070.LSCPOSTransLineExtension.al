tableextension 70070 "LSC POS Trans. Line Extension" extends "LSC POS Trans. Line"
{
    fields
    {
        field(70000; "Packing Info"; Text[30])
        {
            Caption = 'Packing Info';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Packaging Info" WHERE("No." = FIELD(Number)));
        }
    }
}
