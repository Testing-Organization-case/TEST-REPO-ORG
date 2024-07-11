pageextension 70053 ItemSubEntryExt extends "Item Substitution Entry"
{
    layout{
        addbefore("Variant Code")
        {
        field("No.";Rec."No.")
        {
            ApplicationArea = All;
        }
        }
    }
}
