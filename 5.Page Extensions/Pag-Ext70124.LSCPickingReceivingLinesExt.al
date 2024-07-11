pageextension 70124 "LSC Picking/ReceivingLines Ext" extends "LSC Picking/Receiving Lines"
{
    layout
    {

        addafter(Quantity)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
            }
            field("Cross-Reference No."; Rec."Cross-Reference No.")
            {
                ApplicationArea = All;
            }
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        PickingLine: Record "LSC Picking / Receiving lines";
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetCurrentKey("Line No.");
        PurchaseLine.SetRange("Document No.", Rec."Reference No.");
        //PurchaseLine.SetRange("No.", Rec."Item No.");
        PurchaseLine.SetRange("Line No.", Rec."Line No.");
        if PurchaseLine.FindSet() then
            repeat
                Rec.Remark := PurchaseLine.Remark;
                Rec.Modify();
            
            until PurchaseLine.next() = 0;
    end;
}
