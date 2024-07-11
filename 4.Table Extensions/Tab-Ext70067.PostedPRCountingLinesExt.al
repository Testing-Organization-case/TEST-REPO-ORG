tableextension 70067 "PostedP/RCountingLinesExt" extends "LSC Posted P/R Counting Lines"
{
    fields
    {
        field(70000; Remark; Text[50])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(70001; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = ToBeClassified;
        }

    }
}
