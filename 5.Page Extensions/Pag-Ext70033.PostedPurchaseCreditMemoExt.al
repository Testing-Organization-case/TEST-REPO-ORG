pageextension 70033 "Posted Purchase CreditMemo Ext" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Vendor Cr. Memo No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }

    }
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
                    PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
                begin
                    PurchCrMemoHeader.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70012, TRUE, FALSE, PurchCrMemoHeader);
                end;
            }
        }
    }

}
