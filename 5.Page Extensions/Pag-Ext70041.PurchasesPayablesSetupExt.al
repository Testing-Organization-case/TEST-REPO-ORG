pageextension 70041 "Purchases & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("CPO No."; Rec."CPO No.")
            {
                ApplicationArea = All;

            }
        }
    }
}
