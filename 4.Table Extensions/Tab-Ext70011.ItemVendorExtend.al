tableextension 70011 ItemVendorExtend extends "Item Vendor"     //Created By MK
{
    fields
    {
        field(70000; Description; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(70001; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
        }
    }
}
