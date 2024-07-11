pageextension 70049 "Purchase Return Order List Ext" extends "Purchase Return Order List"
{
    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action("PrintNWMMM")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurchaseHeaderR: Record "Purchase Header";
                begin
                    PurchaseHeaderR.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70011, TRUE, FALSE, PurchaseHeaderR);
                end;
            }
        }
    }
}

