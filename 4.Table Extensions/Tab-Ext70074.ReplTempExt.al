tableextension 70074 ReplJnlDetailsExt extends "LSC Replen. Jrnl. Details"
{
    fields
    {
        field(70000; "Before Rounded Qty"; Decimal)
        {
            Caption = 'Before Rounded Qty';
            DataClassification = ToBeClassified;
        }
         field(70001; "Before Rounded CrossDot Qty"; Decimal)
        {
            Caption = 'Before Rounded CrossDot Qty';
            DataClassification = ToBeClassified;
        }
         field(70002; "Planned Sales Demand"; Boolean)
        {
            Caption = 'Planned Sales Demand';
            DataClassification = ToBeClassified;
        }
    }
}
