pageextension 70087 PostedReturnReceiptSubExt extends "Posted Return Receipt Subform"
{
    layout
    {

        addafter("Shortcut Dimension 2 Code")
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
