pageextension 70006 ItemLedgerEntryExt extends "Item Ledger Entries"
{
    actions
    {
        addafter("Application Worksheet")
        {
            action("Stock Balance Report")
            {
                ApplicationArea = All;
                RunObject = report "Stock Balance Data Report";
                Image = TestReport;
            }
        }
    }
}
