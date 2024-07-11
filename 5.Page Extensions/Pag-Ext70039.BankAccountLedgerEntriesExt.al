pageextension 70039 "BankAccount Ledger Entries Ext" extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
