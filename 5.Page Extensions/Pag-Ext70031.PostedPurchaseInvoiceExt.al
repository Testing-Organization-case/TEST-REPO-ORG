pageextension 70031 "Posted Purchase Invoice Ext" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Order No.")
        {
            field("Child PO No."; Rec."Child PO No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Update Document")
        {
            action("Purchase Invoice Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purch. Inv. Header";
                begin
                    PurchaseHeader.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70022, TRUE, FALSE, PurchaseHeader);
                end;
            }
        }
    }
}
