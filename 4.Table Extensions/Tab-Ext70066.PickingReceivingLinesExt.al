tableextension 70066 "Picking/ReceivingLinesExt" extends "LSC Picking / Receiving lines"
{
    fields
    {
        field(70000; "Remark"; Text[50])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;

        }
        field(70001; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = ToBeClassified;
        }
        field(70002; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("LSC P/R Counting Header"."Reference No." WHERE("No." = FIELD("Document No.")));
        }

    }
}
