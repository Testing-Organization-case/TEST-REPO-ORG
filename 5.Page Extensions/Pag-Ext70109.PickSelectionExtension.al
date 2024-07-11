pageextension 70109 "Pick Selection Extension" extends "Pick Selection"
{
    layout
    {
        addafter("Location Code")
        {
            field("Document Status"; Rec."Document Status")
            {
                ApplicationArea = ALl;
            }
        }
    }
}
