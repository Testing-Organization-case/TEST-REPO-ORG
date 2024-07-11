tableextension 70023 "Purchases & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(70000; "CPO No."; Code[20])
        {
            Caption = 'CPO No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
