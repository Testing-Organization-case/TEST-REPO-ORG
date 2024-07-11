pageextension 70026 "Posted Sales Invoice Extension" extends "Posted Sales Invoice"
{

    actions
    {
        addafter(Customer)
        {

            action("Sales Invoice Report")
            {
                ApplicationArea = All;
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Category5;
                Scope = Repeater;
                trigger OnAction()
                begin
                    SalesInvHeader.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70010, TRUE, FALSE, SalesInvHeader);
                end;
            }
        }
    }
}
