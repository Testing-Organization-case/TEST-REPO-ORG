pageextension 70123 "LSC Retail Receiving Extension" extends "LSC Retail Receiving"
{
    layout
    {
        addafter("Reference Name")
        {
            field("Retail Status"; Rec."Retail Status")
            {
                ApplicationArea = All;
            }
        }
    }
}
