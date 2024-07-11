tableextension 70056 "Whse. Pick Request Extension" extends "Whse. Pick Request"
{
    fields
    {
        field(70000; "Document Status"; Option)
        {
            OptionMembers = ,"Partially Picked","Partially Shipped","Completely Picked","Completely Shipped";
            Caption = 'Document Status';
            FieldClass = FlowField;
            CalcFormula = Lookup("Warehouse Shipment Header"."Document Status" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            trigger OnValidate()
            begin
                CALCFIELDS("Document Status");
            end;
        }
    }
}
