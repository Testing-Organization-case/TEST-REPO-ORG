pageextension 70030 "Posted Purchase RcptSubformExt" extends "Posted Purchase Rcpt. Subform"
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
        addafter("Unit of Measure")
        {
            field("Net Price"; Rec."Net Price")
            {
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = All;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
            }
        }
    }

}
