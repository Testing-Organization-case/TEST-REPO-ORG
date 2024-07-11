pageextension 70147 LSItemPointOfferListExt extends "LSC Item Point Offer List"     //Created By MK
{
    actions
    {
        addafter(EnableButton)
        {
            action("Multi Disable & Archive")
            {
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PeriodicDiscountsUtility_l: Codeunit "LSC Periodic Discounts Utility";
                begin
                    PeriodDis.RESET;
                    PeriodDis.SETFILTER("No.", Rec."No.");
                    CurrPage.SETSELECTIONFILTER(PeriodDis);
                    IF PeriodDis.FINDFIRST THEN
                        REPEAT
                            //ToggleEnabled;
                            IF PeriodDis.Status = PeriodDis.Status::Disabled THEN BEGIN
                                PeriodDis.Status := PeriodDis.Status::Enabled;
                                PeriodDis.MODIFY
                            END ELSE BEGIN
                                PeriodDis.Status := PeriodDis.Status::Disabled;
                                PeriodDis.MODIFY;
                            END;
                            PeriodicDiscountsUtility_l.ArchivePeriodicDisc(PeriodDis);
                        UNTIL PeriodDis.NEXT = 0;
                end;
            }
        }
    }
    var
        PeriodDis: Record "LSC Periodic Discount";
}
