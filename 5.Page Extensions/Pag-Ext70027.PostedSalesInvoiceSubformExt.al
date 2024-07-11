pageextension 70027 "Posted SalesInvoiceSubform Ext" extends "Posted Sales Invoice Subform"
{
    layout
    {


        addafter("Return Reason Code")
        {
            field("POS Received No."; Rec."POS Received No.")
            {
                ApplicationArea = All;
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
    trigger OnAfterGetRecord()

    begin
        // Itemtable.RESET();
        // Itemtable.SETRANGE("No.", Rec."No.");
        // IF Itemtable.FindSet() THEN
        //     repeat

        //         Rec."Packaging Info" := Itemtable."Packaging Info";
        //         Rec.Size := Itemtable.Size;
        //         Rec.Modify();
        //     until Itemtable.Next() = 0;
        // GetPackAndSize;
    end;

    // procedure GetPackAndSize()
    // var
    //     Itemtable: Record Item;
    // begin
    //     Itemtable.RESET();
    //     Itemtable.SETRANGE("No.", Rec."No.");
    //     IF Itemtable.FindSet() THEN
    //         repeat

    //             Rec."Packaging Info" := Itemtable."Packaging Info";
    //             Rec.Size := Itemtable.Size;
    //             Rec.Modify();
    //         until Itemtable.Next() = 0;
    // end;

    var
        Itemtable: Record Item;
        SaleInvoiceLine: Record "Sales Invoice Line";
}

