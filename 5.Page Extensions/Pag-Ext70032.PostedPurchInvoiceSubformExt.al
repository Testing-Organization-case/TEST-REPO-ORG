pageextension 70032 "Posted PurchInvoice SubformExt" extends "Posted Purch. Invoice Subform"
{

    layout
    {

        addafter(Quantity)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("PO Status"; Rec."PO Status")
            {
                ApplicationArea = All;
            }
            field("Net Price"; Rec."Net Price")
            {

            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = All;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
            }
        }
    }

}
