pageextension 70090 PurchasePricesExt extends "Purchase Prices"
{
    layout
    {


        addafter("Item No.")
        {
            field(" Description"; Rec."Description")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        ItemRec: Record Item;
    begin

        ItemRec.RESET;
        ItemRec.SETRANGE("No.", Rec."Item No.");
        IF ItemRec.FINDFIRST THEN BEGIN
            rec."Description" := ItemRec.Description;

        END;



    end;


}


