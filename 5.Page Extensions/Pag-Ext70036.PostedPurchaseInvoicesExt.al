pageextension 70036 "Posted Purchase Invoices Ext" extends "Posted Purchase Invoices"
{
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
    procedure GetSelectionFilter(VAR PurchaseInvoiceHeader: Record "Purch. Inv. Header")
    var
        SelectionFilterManagement: Codeunit "LSC ApplicationMgt Ext.";
    begin
        //LS -
        CurrPage.SETSELECTIONFILTER(PurchaseInvoiceHeader);
        SelectionFilterManagement.GetSelectionFilterForPurchaseInvoiceHeader(PurchaseInvoiceHeader); //LS-10352
                                                                                                     //LS +
    end;
}
