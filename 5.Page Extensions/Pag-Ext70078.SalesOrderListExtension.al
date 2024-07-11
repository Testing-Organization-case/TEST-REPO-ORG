pageextension 70078 "Sales Order List Extension" extends "Sales Order List"
{
    actions
    {
        addafter("Co&mments")
        {
            action(NAVAttributes)
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    PurchaseAttributeListL: Page PurchaseAttributesList;
                begin
                    // @22_Jun_2021_02_09_PM
                    CLEAR(PurchaseAttributeListL);
                    PurchaseAttributeListL.SetPurchaseDocumentNo(Rec."No.");
                    PurchaseAttributeListL.RUN;
                end;
            }

        }
        modify("&Print")
        {
            Visible = false;
        }
        addafter("Sales Reservation Avail.")
        {
            action("Preview - Order Confirmation")
            {
                ApplicationArea = ALl;
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
