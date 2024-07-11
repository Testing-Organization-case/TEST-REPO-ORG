tableextension 70088 "LSC Periodic Discount Ext" extends "LSC Periodic Discount"
{
    fields
    {
        field(70000; ID; Guid)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
        field(70001; StatusEnable; Boolean)
        {
            Caption = 'StatusEnable';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        Rec.ID := CreateGuid();
    end;
}
