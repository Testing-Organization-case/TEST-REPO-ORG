tableextension 70055 "Whse. Put-away Request Ext" extends "Whse. Put-away Request"
{
    fields
    {
        field(70000; "Vendor Name"; Text[200])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }
        field(70001; "Warehouse Receipt No."; Code[20])
        {
            Caption = 'Warehouse Receipt No.';
            DataClassification = ToBeClassified;
        }
    }
}
