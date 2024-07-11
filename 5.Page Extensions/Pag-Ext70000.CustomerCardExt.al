pageextension 70000 CustomerCardExt extends "Customer Card"         //Created By MK
{
    layout
    {
        addafter("Copy Sell-to Addr. to Qte From")
        {
            field("Invoice Copies"; Rec."Invoice Copies")
            {
                ApplicationArea = All;
            }
        }

    }

}
