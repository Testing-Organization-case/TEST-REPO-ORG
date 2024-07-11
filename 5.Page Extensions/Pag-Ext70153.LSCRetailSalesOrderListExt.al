pageextension 70153 "LSC Retail Sales Order ListExt" extends "LSC Retail Sales Order List"
{
    actions
    {
        addafter("Post &Batch")
        {
            action("Page Attributes")
            {
                Caption = 'Attributes';
                ApplicationArea = All;
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SOAttributeListL: Page SalesAttributeList;
                    SalesLineL: Record "Sales Line";
                begin
                    // @22_Jun_2021_09_54_AM
                    CLEAR(SOAttributeListL);
                    SOAttributeListL.SetSalesDocumentNo(Rec."No.");
                    SOAttributeListL.EDITABLE(FALSE);
                    SOAttributeListL.RUN;
                end;
            }
        }
        addafter("Order Confirmation")
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
