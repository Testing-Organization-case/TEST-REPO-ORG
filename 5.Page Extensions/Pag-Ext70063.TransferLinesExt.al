pageextension 70063 TransferLinesExt extends "Transfer Lines"
{
    layout{
        addafter("Unit of Measure")
        {
            field("External Document No";Rec."External Document No")
            {
                ApplicationArea = All;
            }
        }

    }
}
