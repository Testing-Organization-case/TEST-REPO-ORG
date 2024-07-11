pageextension 70085 "PostedReturnShip.SubExt" extends "Posted Return Shipment Subform"
{
    layout
    {


        addafter(Correction)
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
