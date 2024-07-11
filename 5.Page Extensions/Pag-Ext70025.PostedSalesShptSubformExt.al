pageextension 70025 "Posted Sales Shpt. Subform Ext" extends "Posted Sales Shpt. Subform"
{
    layout
    {

        addafter("Return Reason Code")
        {
            field("POS Received No."; Rec."POS Received No.")
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
