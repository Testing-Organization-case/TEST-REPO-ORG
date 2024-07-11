pageextension 70016 PurchListExt extends "Purchase List"        //Created By MK
{
    actions
    {
        addafter(ShowDocument)
        {
            action(NAVAttributes)
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
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
    var
        SelectionFilterManagement: Codeunit "LSC ApplicationMgt Ext.";

    procedure GetSelectionFilter()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        //LS -
        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
        SelectionFilterManagement.GetSelectionFilterForPurchaseHeader(PurchaseHeader); //LS-10352
        //LS 
    end;
}
