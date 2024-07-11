pageextension 70125 LSCStoreInvWrkshBuffExt extends "LSC Store Inv. Wrksh. Buffer"          //Created By MK
{
    actions
    {

        addafter("Process/Post")
        {
            action("Process/Print")
            {

                ApplicationArea = All;
                Caption = '&Process/Print';
                Image = Continue;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    StoreInventoryWorksheet: Record "LSC Store Inventory Worksheet";
                    StoreInvMgt_g: Codeunit "LSC Store Inventory Mgt Ext";
                begin

                    StoreInventoryWorksheet.GET(Rec.WorksheetSeqNo);
                    StoreInvMgt_g.PrintShelfLabel_NWMM(StoreInventoryWorksheet);
                end;
            }
        }
    }

}
