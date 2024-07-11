tableextension 70064 "P/RCountingHeaderExt" extends "LSC P/R Counting Header"
{
    fields
    {
        field(70000; Remark; Text[50])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        // modify("Reference No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         PurchaseLine: Record "Purchase Line";
        //         PickingLine: Record "LSC Picking / Receiving lines";
        //         PRHeader: Record "LSC P/R Counting Header";
        //     begin

        //         PurchaseLine.Reset();
        //         PurchaseLine.SetRange("Document No.", Rec."Reference No.");
        //         if PurchaseLine.FindFirst() then
        //             repeat
        //                 Rec.Remark := PurchaseLine.Remark;
        //                 Rec.Modify();
        //                 Message('%1', PurchaseLine.Remark);
        //             until PurchaseLine.next() = 0;


        //     end;



        //}
    }
}
