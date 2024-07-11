pageextension 70028 "Posted Sales CrMemo SubformExt" extends "Posted Sales Cr. Memo Subform"
{
    layout
    {


        addafter("Return Reason Code")
        {
            field("POS Received N0."; Rec."POS Received N0.")
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
