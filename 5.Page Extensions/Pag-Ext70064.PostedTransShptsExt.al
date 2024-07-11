pageextension 70064 "PostedTrans.ShptsExt" extends "Posted Transfer Shipments"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
            }

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

        addbefore("&Navigate")
        {
            action("&PrintNWMM")
            {
                ApplicationArea = Location;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    TransShptHeader: Record "Transfer Shipment Header";
                begin
                    // CurrPage.SetSelectionFilter(TransShptHeader);
                    // TransShptHeader.PrintRecords(true);

                    TransShptHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(TransShptHeader);
                    REPORT.RUNMODAL(70006, TRUE, FALSE, TransShptHeader);
                end;
            }
        }
    }
}
