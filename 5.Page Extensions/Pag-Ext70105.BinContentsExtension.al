pageextension 70105 "Bin Contents Extension" extends "Bin Contents"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item  Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
        }

    }
}
