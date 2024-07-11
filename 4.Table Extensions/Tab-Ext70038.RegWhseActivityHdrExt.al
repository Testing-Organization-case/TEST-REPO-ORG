tableextension 70038 RegWhseActivityHdrExt extends "Registered Whse. Activity Hdr."     //Created By MK
{
    fields
    {
        field(70000; "Warehouse Shipment No."; Code[50])
        {
            Caption = 'Warehouse Shipment No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Registered Whse. Activity Line"."Whse. Document No." WHERE("No." = FIELD("No.")));
        }
        field(70001; "ADCS User ID"; Code[50])
        {
            Caption = 'ADCS User ID';
            FieldClass = FlowField;
            CalcFormula = Lookup("Warehouse Employee"."ADCS User" WHERE("User ID" = FIELD("Assigned User ID")));
        }
    }
}
