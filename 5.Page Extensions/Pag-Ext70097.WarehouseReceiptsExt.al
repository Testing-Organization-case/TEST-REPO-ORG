pageextension 70097 WarehouseReceiptsExt extends "Warehouse Receipts"
{
    actions
    {
        addafter("Posted &Whse. Receipts")
        {
            action("PageAttributes")
            {
                Image = Category;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Attributes';
                trigger OnAction()
                var WarehouseAttributeListL:page WhseRcptAttributesList;
                begin
                    // @22_Jun_2021_09_54_AM
                    CLEAR(WarehouseAttributeListL);
                    WarehouseAttributeListL.SetWarehouseDocumentNo(Rec."No.");
                    WarehouseAttributeListL.EDITABLE(FALSE);
                    WarehouseAttributeListL.RUN;
                end;
            }
        }
    }
}
