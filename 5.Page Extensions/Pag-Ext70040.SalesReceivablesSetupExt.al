pageextension 70040 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Direct Debit Mandate Nos.")
        {
            field("LOS Nos."; Rec."LOS Nos.")
            {
                ApplicationArea = All;

            }
        }

    }
}
