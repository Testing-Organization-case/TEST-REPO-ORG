pageextension 70037 "Posted Purchase Credit Memos" extends "Posted Purchase Credit Memos"
{
    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        addafter("&Print")
        {
            action("PrintNWMM")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                begin
                    PurchCrMemoHdr.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70012, TRUE, FALSE, PurchCrMemoHdr);
                end;
            }
        }
    }
}
