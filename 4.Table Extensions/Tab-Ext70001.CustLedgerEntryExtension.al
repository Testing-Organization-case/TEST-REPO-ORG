tableextension 70001 "Cust. Ledger Entry Extension" extends "Cust. Ledger Entry"
{
    fields
    {
        field(70000; "Batch No."; Code[10])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
        }
        field(70001; "AmountInt"; Decimal)
        {
            Caption = 'AmountInt';
            DataClassification = ToBeClassified;
        }
        field(70002; "RemainingAmountInt"; Decimal)
        {
            Caption = 'RemainingAmountInt';
            DataClassification = ToBeClassified;
        }
        field(70003; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            DataClassification = ToBeClassified;
        }
        field(70004; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact."No.";
        }
    }
}
