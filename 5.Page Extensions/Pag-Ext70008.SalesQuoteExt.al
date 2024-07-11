pageextension 70008 SalesQuoteExt extends "Sales Quote"         //Created By MK
{
    actions
    {
        addafter("C&ontact")
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
    }
}
