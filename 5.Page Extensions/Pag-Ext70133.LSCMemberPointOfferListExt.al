pageextension 70133 "LSC Member Point OfferList Ext" extends "LSC Member Point Offer List"
{
    actions
    {
        addafter(EnableButton)
        {
            action("Multi Disable & Archive")
            {
                Caption = 'Multi Disable & Archive';
                ApplicationArea = All;
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    MemPointOffer: Record "LSC Member Point Offer";
                begin
                    MemPointOffer.RESET;
                    MemPointOffer.SETFILTER("No.", Rec."No.");
                    CurrPage.SETSELECTIONFILTER(MemPointOffer);
                    IF MemPointOffer.FINDFIRST THEN
                        REPEAT
                            ToggleEnabled();
                        //    IF PeriodDis.Status =  PeriodDis.Status::Disabled THEN BEGIN
                        //      PeriodDis.Status := PeriodDis.Status::Enabled;
                        //      PeriodDis.MODIFY
                        //    END ELSE BEGIN
                        //      PeriodDis.Status := PeriodDis.Status::Disabled;
                        //      PeriodDis.MODIFY;
                        //    END;
                        //    PeriodicDiscountsUtility_l.ArchivePeriodicDisc(PeriodDis);
                        UNTIL MemPointOffer.NEXT = 0;     //Modify By MK
                end;
            }
        }
    }
    procedure ToggleEnabled()
    begin
        IF Rec.Status = Rec.Status::Disabled THEN
            Rec.Status := Rec.Status::Enabled
        ELSE
            Rec.Status := Rec.Status::Disabled;
        Rec.MODIFY;
        //LS-13397 CreateActions(1);
    end;

}
