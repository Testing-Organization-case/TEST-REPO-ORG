pageextension 70044 "Default Dimensions" extends "Default Dimensions"
{
    layout
    {
        addbefore("Dimension Code")
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;

            }
        }
    }
}
