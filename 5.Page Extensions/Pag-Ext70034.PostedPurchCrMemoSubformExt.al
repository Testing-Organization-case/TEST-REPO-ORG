pageextension 70034 "Posted PurchCrMemo Subform Ext" extends "Posted Purch. Cr. Memo Subform"
{

    layout
    {


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
