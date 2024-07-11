pageextension 70011 SalesListExt extends "Sales List"       //Created By MK
{
    actions
    {
        addafter(ShowDocument)
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
