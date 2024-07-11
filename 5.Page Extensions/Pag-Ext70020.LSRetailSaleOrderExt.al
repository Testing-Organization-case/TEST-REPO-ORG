pageextension 70020 LSRetailSaleOrderExt extends "LSC Retail Sales Order"       //Created By MK
{
    actions
    {
        addafter("&Additional Salespersons")
        {
            action("Page Attributes")
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SOAttributeListL: Page SalesAttributeList;
                begin
                    CLEAR(SOAttributeListL);
                    SOAttributeListL.SetSalesDocumentNo(Rec."No.");
                    SOAttributeListL.EDITABLE(FALSE);
                    SOAttributeListL.RUN;
                end;
            }
        }
        addafter("&Order Confirmation")
        {
            action("Preview - Order Confirmation")
            {
                Caption = 'Preview - Order Confirmation';
                ApplicationArea = All;
                Image = TestReport;
                trigger OnAction()
                var
                    SalesHeaderR: Record "Sales Header";
                begin
                    SalesHeaderR.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70009, TRUE, FALSE, SalesHeaderR);
                end;
            }
        }
    }
}
