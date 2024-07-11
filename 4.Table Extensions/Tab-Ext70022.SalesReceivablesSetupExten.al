tableextension 70022 "Sales&ReceivablesSetupExten" extends "Sales & Receivables Setup"
{
    fields
    {
        field(70000; "LOS Nos."; Code[50])
        {
            Caption = 'LOS Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
