pageextension 70019 LSRetailTransferOrderExt extends "LSC Retail Transfer Order"        //Created By MK
{
    actions
    {
        addafter("Document &Groups")
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
                    TransferAttributeListL: Page TransferAttributesList;
                begin
                    CLEAR(TransferAttributeListL);
                    TransferAttributeListL.SetTransferDocumentNo(Rec."No.");
                    TransferAttributeListL.EDITABLE(FALSE);
                    TransferAttributeListL.RUN;
                end;
            }
        }


    }

}
