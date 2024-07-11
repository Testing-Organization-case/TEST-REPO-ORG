pageextension 70082 "Sales Quotes Extension" extends "Sales Quotes"
{
    actions
    {
        addafter(Dimensions)
        {
            action(NAVAttributes)
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    PurchaseAttributeListL: Page PurchaseAttributesList;
                begin
                    // @22_Jun_2021_02_09_PM
                    CLEAR(PurchaseAttributeListL);
                    PurchaseAttributeListL.SetPurchaseDocumentNo(Rec."No.");
                    PurchaseAttributeListL.RUN;
                end;
            }

        }
    }
}
