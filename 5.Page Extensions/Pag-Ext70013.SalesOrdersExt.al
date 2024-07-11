pageextension 70013 SalesOrdersExt extends "Sales Orders"           //Created By Mk
{
    actions
    {
        addafter("Show Order")
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
                    // @22_Jun_2021_09_54_AM
                    CLEAR(SOAttributeListL);
                    SOAttributeListL.SetSalesDocumentNo(Rec."No.");
                    SOAttributeListL.EDITABLE(FALSE);
                    SOAttributeListL.RUN;
                end;
            }
        }
    }
}
