pageextension 70121 LSCStoreInvJnlExt extends "LSC Store Inventory Journal"         //Created By MK
{
    layout
    {
        addafter("Reason Code")
        {

            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = ALl;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
            }
        }

    }



}
