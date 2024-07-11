tableextension 70009 GenJournalLineExtend extends "Gen. Journal Line"       //Created By MK
{
    fields
    {
        field(70000; "Batch No."; Code[10])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
        }
        field(70001; "InStore-Created Entry"; Boolean)
        {
            Caption = 'InStore-Created Entry';
            DataClassification = ToBeClassified;
        }
        field(70002; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            DataClassification = ToBeClassified;
        }
        field(70003; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';
            DataClassification = ToBeClassified;
        }


    }


}




