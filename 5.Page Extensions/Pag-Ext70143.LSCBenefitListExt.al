pageextension 70143 LSCBenefitListExt extends "LSC Benefit List"        //Created By MK
{
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                ItemR.RESET;
                ItemR.SETRANGE("No.", Rec."No.");
                IF ItemR.FINDFIRST THEN BEGIN
                    Rec.Description := ItemR.Description;
                END;
            end;
        }
    }
    var
        ItemR: Record Item;
}
