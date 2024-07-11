tableextension 70029 "Nonstock Item Extension" extends "Nonstock Item"
{
    fields
    {
        field(70000; "Chemical Name"; Text[250])
        {
            Caption = 'Chemical Name';
            DataClassification = ToBeClassified;
        }
        field(70001; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
        }
    }
}
