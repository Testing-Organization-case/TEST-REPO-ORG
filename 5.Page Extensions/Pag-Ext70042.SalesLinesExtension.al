pageextension 70042 "Sales Lines Extension" extends "Sales Lines"
{
    layout
    {
        addafter("No.")
        {
            field("External Document No"; Rec."External Document No")
            {
                ApplicationArea = All;
            }

        }

    }
}
