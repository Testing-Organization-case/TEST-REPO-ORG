pageextension 70060 PostedTransferShipExt extends "Posted Transfer Shipment"
{
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

                    TransShptHeader.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70006, TRUE, FALSE, TransShptHeader);

                end;
            }
        }

    }
}
