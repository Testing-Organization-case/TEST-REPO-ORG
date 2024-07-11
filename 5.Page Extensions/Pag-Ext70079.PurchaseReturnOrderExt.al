pageextension 70079 "Purchase Return Order Ext" extends "Purchase Return Order"
{
    actions

    {
        modify("&Print")
        {
            Visible = false;
        }

        addafter("Re&lease")
        {
            action("&PrintNWMM")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurchaseHeaderR: Record "Purchase Header";
                begin
                    // DocPrint.PrintPurchHeader(Rec);
                    PurchaseHeaderR.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70011, TRUE, FALSE, PurchaseHeaderR);
                end;
            }
        }

    }

}
