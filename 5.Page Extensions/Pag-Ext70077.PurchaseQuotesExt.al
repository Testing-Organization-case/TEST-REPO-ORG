pageextension 70077 "Purchase Quotes" extends "Purchase Quotes"
{
    actions
    {
        addafter(Approvals)
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
