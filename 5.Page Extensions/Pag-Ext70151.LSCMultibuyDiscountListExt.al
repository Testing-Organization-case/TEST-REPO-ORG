pageextension 70151 "LSC Multibuy Discount List Ext" extends "LSC Multibuy Discount List"
{
    actions
    {
        addafter(EnableButton)
        {
            action("Multi Disable & Archive")
            {
                Caption = 'Multi Disable & Archive';
                ApplicationArea = ALl;
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PeriodDis: Record "LSC Periodic Discount";
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
                        UNTIL PeriodDis.NEXT = 0;     //Modify By MK
                end;

            }
        }
    }
}
