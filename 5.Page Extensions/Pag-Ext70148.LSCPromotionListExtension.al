pageextension 70148 "LSC Promotion List Extension" extends "LSC Promotion List"
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
                    OfferLineR: Record "LSC Offer";
                begin
                    OfferLineR.RESET;
                    OfferLineR.SETFILTER("No.", Rec."No.");
                    CurrPage.SETSELECTIONFILTER(OfferLineR);
                    IF OfferLineR.FINDFIRST THEN
                        REPEAT
                            OfferLineR.ToggleEnabled;
                        //    IF OfferLineR.Status =  PeriodDis.Status::Disabled THEN BEGIN
                        //      PeriodDis.Status := PeriodDis.Status::Enabled;
                        //      PeriodDis.MODIFY
                        //    END ELSE BEGIN
                        //      PeriodDis.Status := PeriodDis.Status::Disabled;
                        //      PeriodDis.MODIFY;
                        //    END;
                        //PeriodicDiscountsUtility_l.ArchivePeriodicDisc(PeriodDis);
                        UNTIL OfferLineR.NEXT = 0;     //Modify By MK
                end;
            }
        }
    }
}
