pageextension 70035 "Posted Sales Invoices Ext" extends "Posted Sales Invoices"
{
    actions
    {
        addafter(Customer)
        {
            action("Sales Invoice Report")
            {
                ApplicationArea = Basic, Suite;
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Category5;
                Scope = Repeater;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70010, TRUE, FALSE, SalesInvHeader);
                end;

            }
        }
    }
}
