pageextension 70122 "LSCStore InvtWorksheetCard Ext" extends "LSC Store Invt. Worksheet Card"
{
    layout
    {
        addafter("Label Function Code")
        {
            field("Change UoM Allowed"; Rec."Change UoM Allowed")
            {
                ApplicationArea = All;
            }
        }
    }
}
