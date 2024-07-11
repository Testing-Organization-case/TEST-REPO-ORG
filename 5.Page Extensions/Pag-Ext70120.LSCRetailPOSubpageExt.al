pageextension 70120 "LSC Retail PO Subpage Ext" extends "LSC Retail PO Subpage"
{
    layout
    {
        addafter(XTobeInvoiced)
        {
            field("Quantity Received"; Rec."Quantity Received")
            {
                ApplicationArea = ALl;
            }
            field("Quantity Invoiced"; Rec."Quantity Invoiced")
            {
                ApplicationArea = ALl;
            }
            field(Remark; Rec.Remark)
            {
                ApplicationArea = ALl;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = ALl;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = ALl;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        GetPackAndSize;
    end;

    procedure GetPackAndSize()
    var
        Itemtable: Record Item;
    begin
        Itemtable.RESET();
        Itemtable.SETRANGE("No.", Rec."No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END //Added by HHA
    end;
}
