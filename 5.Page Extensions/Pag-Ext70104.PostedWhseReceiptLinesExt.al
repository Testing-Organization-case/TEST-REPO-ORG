pageextension 70104 PostedWhseRecptLinesExt extends "Whse. Receipt Lines"
{
    layout
    {
        addafter(Quantity)
        {
            field(Remark;Rec.Remark)
            {
                ApplicationArea = All;
            }
            field("Cross-Reference No.";Rec."Cross-Reference No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
