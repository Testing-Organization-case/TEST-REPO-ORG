tableextension 70087 "LSC Periodic Discount Line Ext" extends "LSC Periodic Discount Line"
{
    fields
    {
        field(70000; ID; Guid)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
        field(70001; "Finished Mark"; Boolean)
        {
            Caption = 'Finished Mark';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        Rec.ID := CreateGuid();
    end;
}
