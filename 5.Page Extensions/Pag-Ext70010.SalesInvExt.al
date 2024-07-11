pageextension 70010 SalesInvExt extends "Sales Invoice"         //Created By MK
{
    layout
    {
        addafter("Direct Debit Mandate ID")
        {
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Test Report")
        {
            action("Sale Invoice")
            {
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Report;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Invoice);
                    SalesHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(70023, TRUE, TRUE, SalesHeader);
                end;
            }
        }
    }
    var
        SalesHeader: Record "Sales Header";
}
