pageextension 70149 "LSC Mix&Match Offer List Ext" extends "LSC Mix&Match Offer List"
{
    layout
    {
        addafter("Triggers Pop-up on POS")
        {
            field(StatusEnable; Rec.StatusEnable)
            {
                ApplicationArea = All;
            }
            field(ID; Rec.ID)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(EnableButton)
        {
            action("CreateGUID")
            {
                Caption = 'CreateGUID';
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    PeriodicDisc: Record "LSC Periodic Discount";
                begin

                    IF (Rec.Status = Rec.Status::Enabled) OR (Rec.Status = Rec.Status::Disabled) THEN BEGIN
                        PeriodicDisc.RESET;
                        IF PeriodicDisc.FINDSET THEN
                            REPEAT
                                //CustomerR.Latitude := 1;
                                PeriodicDisc.ID := CREATEGUID;
                                PeriodicDisc.MODIFY(TRUE);
                            UNTIL PeriodicDisc.NEXT = 0;
                    END;

                    CurrPage.UPDATE;
                end;

            }
            action("Multi Disable & Archive")
            {
                Caption = 'Multi Disable & Archive';
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
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
    trigger OnAfterGetRecord()
    var
        PeriodicDis: Record "LSC Periodic Discount";
    begin
        PeriodicDis.RESET;
        IF PeriodicDis.FINDSET THEN
            REPEAT
                IF PeriodicDis.Status = PeriodicDis.Status::Enabled THEN BEGIN

                    PeriodicDis.StatusEnable := TRUE;
                    //PeriodicDis.MODIFY(TRUE);
                END
                ELSE BEGIN

                    PeriodicDis.StatusEnable := FALSE;
                    //PeriodicDis.MODIFY(TRUE);
                END;
            UNTIL PeriodicDis.NEXT = 0;
    end;

}
