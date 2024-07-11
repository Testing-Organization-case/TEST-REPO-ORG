pageextension 70107 "Put-away Worksheet extension" extends "Put-away Worksheet"
{
    layout
    {
        addafter(Quantity)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
            }
        }
    }
}
