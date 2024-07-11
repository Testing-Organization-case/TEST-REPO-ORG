pageextension 70080 "Sales Invoice List Extension" extends "Sales Invoice List"
{
    actions
    {
        modify("Posted Sales Invoices")
        {
            Visible = false;
        }
        addafter("Test Report")
        {
            action("Sale Invoice")
            {
                ApplicationArea = All;
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Invoice);
                    SalesHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(70023, TRUE, TRUE, SalesHeader);
                end;
            }
        }
    }
}
