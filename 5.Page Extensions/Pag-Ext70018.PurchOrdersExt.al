pageextension 70018 PurchOrdersExt extends "Purchase Orders"        //Created by MK
{
    actions
    {
        addafter("Reservation Entries")
        {
            action(NAVAttributes)
            {
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
