pageextension 70007 ItemJnlExt extends "Item Journal"       //Created BY MK
{
    layout
    {
        addafter(ShortcutDimCode8)
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
