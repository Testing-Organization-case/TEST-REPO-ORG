pageextension 70140 "LSMix&MatchExt" extends "LSC Mix & Match"      //Created By MK
{
    actions
    {
        modify(DisableButton)
        {
            trigger OnAfterAction()
            begin
                Rec.StatusEnable := false;
            end;
        }
        modify(EnableButton)
        {
            trigger OnAfterAction()
            begin
                Rec.StatusEnable := true;
            end;
        }
    }
}
