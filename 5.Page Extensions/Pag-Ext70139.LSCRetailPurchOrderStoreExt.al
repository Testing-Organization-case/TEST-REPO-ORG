pageextension 70139 "LSC RetailPurchOrder Store Ext" extends "LSC Retail Purch. Order Store"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Retail Status"; Rec."LSC Retail Status")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(TestReport)
        {
            action("Consolidate PO")
            {
                ApplicationArea = All;
                Image = TestReport;
                Ellipsis = true;
                RunObject = page "Consolidate Purchase Order";
                RunPageOnRec = false;
            }
        }
        addafter(PostBatch)
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
}
