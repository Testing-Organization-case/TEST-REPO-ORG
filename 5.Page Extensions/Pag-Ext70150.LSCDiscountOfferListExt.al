pageextension 70150 "LSC Discount Offer List Ext" extends "LSC Discount Offer List"
{
    actions
    {
        addafter(EnableButton)
        {
            action("Insert Promotions Lines")
            {
                Caption = 'Insert Promotions Lines';
                Image = LineDiscount;
                ApplicationArea = All;

                trigger OnAction()

                begin
                    // ControlButton;
                    // PeriodDiscount.DELETEALL;
                    PeriodDiscount.RESET;
                    IF PeriodDiscount.FINDLAST THEN BEGIN
                        LineNo := PeriodDiscount.No;
                    END;


                    //For Archived Periodic Disc.Line
                    ArchivePeriodDisLine.RESET;
                    ArchivePeriodDisLine.SETRANGE("Finished Mark", FALSE);
                    IF ArchivePeriodDisLine.FINDFIRST THEN
                        REPEAT
                            LineNo += 1000;
                            PeriodDiscount.INIT;
                            PeriodDiscount.No := LineNo;
                            PeriodDiscount."Offer No." := ArchivePeriodDisLine."Offer No.";
                            IF PeriodDiscount."Offer No." <> '' THEN BEGIN
                                ArchivedPeriodicDisHeader.RESET;
                                ArchivedPeriodicDisHeader.SETRANGE("No.", PeriodDiscount."Offer No.");
                                IF ArchivedPeriodicDisHeader.FINDFIRST THEN
                                    REPEAT

                                        PeriodDiscount.Description := ArchivedPeriodicDisHeader.Description;
                                        ArchivedPeriodicDisHeader.CALCFIELDS("Starting Date", "Ending Date");
                                        PeriodDiscount."Starting Date" := ArchivedPeriodicDisHeader."Starting Date";
                                        PeriodDiscount."Ending Date" := ArchivedPeriodicDisHeader."Ending Date";
                                        PeriodDiscount."Discount Amount Value" := ArchivedPeriodicDisHeader."Discount Amount Value";   //Modify At 1/3/2024
                                        PeriodDiscount."Discount % Value" := ArchivedPeriodicDisHeader."Discount % Value";           //Modify At 1/5/2024
                                        PeriodDiscount."Disc. % of Least Expensive" := ArchivedPeriodicDisHeader."Disc. % of Least Expensive";  //Modify At 1/19/24
                                        PeriodDiscount.Type := ArchivedPeriodicDisHeader.Type;
                                        PeriodDiscount."Deal Price Value" := ArchivedPeriodicDisHeader."Deal Price Value";     //Modify By 30/Jan/24
                                        PeriodDiscount.DiscountTypeH := ArchivedPeriodicDisHeader."Discount Type";
                                        PeriodDiscount.Priority := ArchivedPeriodicDisHeader.Priority;
                                        PeriodDiscount."Validation Period ID" := ArchivedPeriodicDisHeader."Validation Period ID";       //Modify by MK 
                                        IF PeriodDiscount."Validation Period ID" <> '' THEN BEGIN
                                            ValPeriod.GET(PeriodDiscount."Validation Period ID");
                                            PeriodDiscount."Validation Description" := ValPeriod.Description;
                                        END;
                                    UNTIL ArchivedPeriodicDisHeader.NEXT = 0;
                            END;
                            //PeriodDiscount.Type := ArchivePeriodDisLine.Type;
                            PeriodDiscount.ItemNo := ArchivePeriodDisLine."No.";

                            PeriodDiscount.ItemDescription := ArchivePeriodDisLine.Description;
                            PeriodDiscount."Standard Price Including VAT" := ArchivePeriodDisLine."Standard Price Including VAT";
                            PeriodDiscount."Standard Price" := ArchivePeriodDisLine."Standard Price";
                            //PeriodDiscount."Deal Price Value" := ArchivePeriodDisLine."Deal Price/Disc. %";
                            PeriodDiscount."Price Group" := ArchivePeriodDisLine."Price Group";
                            PeriodDiscount."Currency Code" := ArchivePeriodDisLine."Currency Code";
                            PeriodDiscount."Unit of Measure" := ArchivePeriodDisLine."Unit of Measure";
                            PeriodDiscount."Prod. Group Category" := ArchivePeriodDisLine."Prod. Group Category";
                            PeriodDiscount."Line Group" := ArchivePeriodDisLine."Line Group";
                            PeriodDiscount."No. of Items Needed" := ArchivePeriodDisLine."No. of Items Needed";
                            PeriodDiscount."Discount Type" := ArchivePeriodDisLine."Disc. Type";
                            //PeriodDiscount."Discount Amount Including VAT" := ArchivePeriodDisLine."Discount Amount";
                            PeriodDiscount."Offer Price" := ArchivePeriodDisLine."Offer Price";
                            PeriodDiscount."Offer Price Including VAT" := ArchivePeriodDisLine."Offer Price Including VAT";
                            //PeriodDiscount."Discount Amount Value" := ArchivePeriodDisLine."Discount Amount";
                            PeriodDiscount."Discount Amount Including VAT" := ArchivePeriodDisLine."Discount Amount Including VAT";
                            PeriodDiscount.Status := ArchivePeriodDisLine.Status;
                            PeriodDiscount."Triggers Pop-up on POS" := ArchivePeriodDisLine."Trigger Pop-up on POS";
                            PeriodDiscount."Variant Type" := ArchivePeriodDisLine."Variant Type";
                            PeriodDiscount.Exclude := ArchivePeriodDisLine.Exclude;
                            PeriodDiscount."Member Points" := ArchivePeriodDisLine."Member Points";
                            PeriodDiscount."Prompt at Scan" := ArchivePeriodDisLine."Prompt at Scan";
                            PeriodDiscount."Header Type" := ArchivePeriodDisLine."Header Type";
                            PeriodDiscount."Small Business Filter" := ArchivePeriodDisLine."Small Business Filter";
                            PeriodDiscount."Finished Mark" := TRUE;
                            PeriodDiscount.INSERT;

                        UNTIL ArchivePeriodDisLine.NEXT = 0; //IF ArchivePeriodDisLine.FINDFIRST THEN


                    MemberPointOffer.RESET;
                    MemberPointOffer.SETRANGE("Finiished Mark", FALSE);
                    IF MemberPointOffer.FINDFIRST THEN
                        REPEAT

                            LineNo += 1000;
                            PeriodDiscount.INIT;
                            PeriodDiscount.No := LineNo;
                            PeriodDiscount."Offer No." := MemberPointOffer."No.";
                            PeriodDiscount.Description := MemberPointOffer.Description;
                            PeriodDiscount.Status := MemberPointOffer.Status;
                            PeriodDiscount.Priority := MemberPointOffer.Priority;
                            PeriodDiscount."Price Group" := MemberPointOffer."Price Group";
                            PeriodDiscount."Currency Code" := MemberPointOffer."Currency Code";
                            PeriodDiscount."No. Series" := MemberPointOffer."No. Series";
                            PeriodDiscount."Validation Period ID" := MemberPointOffer."Validation Period ID";
                            MemberPointOffer.CALCFIELDS("Validation Description", "Starting Date", "Ending Date");
                            PeriodDiscount."Validation Description" := MemberPointOffer."Validation Description";
                            PeriodDiscount."Starting Date" := MemberPointOffer."Starting Date";
                            PeriodDiscount."Ending Date" := MemberPointOffer."Ending Date";
                            PeriodDiscount."Customer Disc. Group" := MemberPointOffer."Customer Discount Group";
                            PeriodDiscount."Last Date Modified" := MemberPointOffer."Last Date Modified";
                            PeriodDiscount."Member Type" := MemberPointOffer."Member Type";
                            PeriodDiscount."Member Value" := MemberPointOffer."Member Value";
                            PeriodDiscount."Member Attribute" := MemberPointOffer."Member Attribute";
                            PeriodDiscount."Member Attribute Value" := MemberPointOffer."Member Attribute Value";
                            PeriodDiscount."Sales Type Filter" := MemberPointOffer."Sales Type Filter";
                            PeriodDiscount."Price Group Validation" := MemberPointOffer."Price Group Validation";
                            PeriodDiscount."Buyer ID" := MemberPointOffer."Buyer ID";
                            PeriodDiscount."Buyer Group Code" := MemberPointOffer."Buyer Group Code";
                            PeriodDiscount."Line Specific" := MemberPointOffer."Line Specific";
                            PeriodDiscount.Value := MemberPointOffer.Value;
                            PeriodDiscount."Value Type" := MemberPointOffer."Value Type";
                            PeriodDiscount."Finished Mark" := TRUE;
                            PeriodDiscount.INSERT;

                        UNTIL PeriodDiscount.NEXT = 0; //IF MemberPointOffer.FINDSET THEN


                    //For Offer Line
                    OfferLine.RESET;
                    OfferLine.SETRANGE("Finished Mark", FALSE);
                    IF OfferLine.FINDFIRST THEN
                        REPEAT

                            LineNo += 1000;
                            PeriodDiscount.INIT;
                            PeriodDiscount.No := LineNo;
                            PeriodDiscount."Offer No." := OfferLine."Offer No.";
                            PeriodDiscount.Type := OfferLine.Type;
                            PeriodDiscount.ItemNo := OfferLine."No.";

                            PeriodDiscount.ItemDescription := OfferLine.Description;
                            PeriodDiscount."Standard Price Including VAT" := OfferLine."Standard Price Including VAT";
                            PeriodDiscount."Standard Price" := OfferLine."Standard Price";
                            PeriodDiscount."Discount % Value" := OfferLine."Disc. %";
                            PeriodDiscount."Discount Amount Value" := OfferLine."Discount Amount";
                            PeriodDiscount."Offer Price" := OfferLine."Offer Price";
                            PeriodDiscount."Offer Price Including VAT" := OfferLine."Offer Price Including VAT";
                            PeriodDiscount."Discount Amount Including VAT" := OfferLine."Discount Amount Including VAT";
                            PeriodDiscount."Primary Key" := OfferLine."Primary Key";
                            PeriodDiscount."Price Group" := OfferLine."Price Group";
                            PeriodDiscount."Currency Code" := OfferLine."Currency Code";
                            PeriodDiscount."Unit of Measure" := OfferLine."Unit of Measure";

                            PeriodDiscount.Quantity := OfferLine.Quantity;
                            PeriodDiscount."Display Prompt" := OfferLine."Display Prompt";
                            OfferLine.CALCFIELDS("Explanatory Header Text");
                            PeriodDiscount."Explanatory Header Text" := OfferLine."Explanatory Header Text";
                            PeriodDiscount."Min. Selection" := OfferLine."Min. Selection";
                            PeriodDiscount."Max. Selection" := OfferLine."Max. Selection";
                            PeriodDiscount."Multiple Selection" := OfferLine."Multiple Selection";
                            PeriodDiscount."Selected Deal Line No." := OfferLine."Selected Deal Line No.";
                            PeriodDiscount."Selected Modifier Line No." := OfferLine."Selected Modifier Line No.";
                            PeriodDiscount."Modifier Added Amount" := OfferLine."Modifier Added Amount";
                            PeriodDiscount."Default Selection" := OfferLine."Default Selection";
                            PeriodDiscount."Show on Extra Request Only" := OfferLine."Show on Extra Request Only";
                            PeriodDiscount."Line Added Amount" := OfferLine."Line Added Amount";
                            OfferLine.CALCFIELDS("Deal Mod. Items with Min. Sel.");
                            PeriodDiscount."Deal Mod. Items with Min. Sel." := OfferLine."Deal Mod. Items with Min. Sel.";
                            PeriodDiscount."Deal Modifier Size Group" := OfferLine."Deal Modifier Size Group";
                            PeriodDiscount."Deal Mod. Size Gr. Index" := OfferLine."Deal Mod. Size Gr. Index";
                            PeriodDiscount."Mobile - Display Required" := OfferLine."Mobile - Display Required";
                            PeriodDiscount."Variant Type" := OfferLine."Variant Type";
                            PeriodDiscount.Exclude := OfferLine.Exclude;
                            PeriodDiscount."Finished Mark" := TRUE;
                            PeriodDiscount.INSERT;

                        UNTIL PeriodDiscount.NEXT = 0; //IF OfferLine.FINDSET THEN



                    // For PeriodDiscount Line
                    PeriodDisLine.RESET;
                    PeriodDisLine.SETRANGE("Finished Mark", FALSE);
                    IF PeriodDisLine.FINDSET THEN
                        REPEAT

                            //  PerBnfitDis.RESET;                        
                            //  PerBnfitDis.SETRANGE("Offer No.",PeriodDisLine."Offer No.");            
                            //  IF PerBnfitDis.FINDFIRST THEN 
                            //    REPEAT
                            LineNo += 1000;
                            PeriodDiscount.INIT;
                            PeriodDiscount.No := LineNo;
                            PeriodDiscount."Offer No." := PeriodDisLine."Offer No.";
                            IF PeriodDiscount."Offer No." <> '' THEN BEGIN
                                PeriodicDiscontHeader.RESET;
                                PeriodicDiscontHeader.SETRANGE("No.", PeriodDiscount."Offer No.");
                                IF PeriodicDiscontHeader.FINDFIRST THEN
                                    REPEAT

                                        PeriodDiscount.Description := PeriodicDiscontHeader.Description;
                                        PeriodicDiscontHeader.CALCFIELDS("Starting Date", "Ending Date");
                                        PeriodDiscount."Starting Date" := PeriodicDiscontHeader."Starting Date";
                                        PeriodDiscount."Ending Date" := PeriodicDiscontHeader."Ending Date";
                                        PeriodDiscount."Discount Amount Value" := PeriodicDiscontHeader."Discount Amount Value";     //Modify At 1/3/2024
                                        PeriodDiscount."Discount % Value" := PeriodicDiscontHeader."Discount % Value";               //Modify At 1/5/2024
                                        PeriodDiscount.DiscountTypeH := PeriodicDiscontHeader."Discount Type";
                                        PeriodDiscount."Disc. % of Least Expensive" := PeriodicDiscontHeader."Disc. % of Least Expensive"; //Modify At 1/19/24
                                        PeriodDiscount.Priority := PeriodicDiscontHeader.Priority;
                                        PeriodDiscount."Validation Period ID" := PeriodicDiscontHeader."Validation Period ID";       //Modify by MK 
                                        IF PeriodDiscount."Validation Period ID" <> '' THEN BEGIN
                                            ValPeriod.GET(PeriodDiscount."Validation Period ID");
                                            PeriodDiscount."Validation Description" := ValPeriod.Description;
                                        END;
                                        PeriodDiscount."Tender Offer %" := PeriodicDiscontHeader."Tender Offer %";
                                        PeriodDiscount."Tender Offer Amount" := PeriodicDiscontHeader."Tender Offer Amount";
                                        PeriodDiscount."Tender Type Code" := PeriodicDiscontHeader."Tender Type Code";
                                        PeriodDiscount."Tender Type Value" := PeriodicDiscontHeader."Tender Type Value";       //Add 26/Jan24 by requirment
                                        PeriodDiscount.Type := PeriodicDiscontHeader.Type;
                                    UNTIL PeriodicDiscontHeader.NEXT = 0;
                            END;

                            // *****For Additional Benefits Lines  
                            PerBnfitDis.RESET;
                            PerBnfitDis.SETRANGE("Offer No.", PeriodDisLine."Offer No.");
                            IF PerBnfitDis.FINDFIRST THEN
                                REPEAT
                                    PeriodDiscount.BenefitCode := PerBnfitDis."No.";
                                    PeriodDiscount.BenefitType := PerBnfitDis.Type;
                                    PeriodDiscount.BenefitDescription := PerBnfitDis.Description;
                                    IF PeriodDiscount.BenefitCode <> '' THEN BEGIN
                                        InfoSubCode.RESET;
                                        InfoSubCode.SETRANGE(Code, PeriodDiscount.BenefitCode);
                                        IF InfoSubCode.FINDFIRST THEN BEGIN

                                            PeriodDiscount."Trigger Code" := InfoSubCode."Trigger Code";
                                            PeriodDiscount.InfoDescription := InfoSubCode.Description;

                                        END; //IF InfoSubCode.FINDFIRST THEN
                                    END; //IF PeriodDiscount.BenefitCode <> '' THEN BEGIN
                                UNTIL PerBnfitDis.NEXT = 0; //IF PerBnfitDis.FINDFIRST THEN 
                                                            // *****For Additional Benefits Lines


                            PeriodDiscount.ItemNo := PeriodDisLine."No.";
                            PeriodDiscount.ItemDescription := PeriodDisLine.Description;

                            PeriodDiscount."Standard Price Including VAT" := PeriodDisLine."Standard Price Including VAT";
                            PeriodDiscount."Standard Price" := PeriodDisLine."Standard Price";
                            //PeriodDiscount."Deal Price Value" := PeriodDisLine."Deal Price/Disc. %";
                            PeriodDiscount."Price Group" := PeriodDisLine."Price Group";
                            PeriodDiscount."Currency Code" := PeriodDisLine."Currency Code";
                            PeriodDiscount."Unit of Measure" := PeriodDisLine."Unit of Measure";
                            PeriodDiscount."Prod. Group Category" := PeriodDisLine."Prod. Group Category";
                            PeriodDiscount."Valid From Before Exp. Date" := PeriodDisLine."Valid From Before Exp. Date";
                            PeriodDiscount."Valid To Before Exp. Date" := PeriodDisLine."Valid To Before Exp. Date";
                            PeriodDiscount."Line Group" := PeriodDisLine."Line Group";
                            PeriodDiscount."No. of Items Needed" := PeriodDisLine."No. of Items Needed";
                            PeriodDiscount."Discount Type" := PeriodDisLine."Disc. Type";
                            //PeriodDiscount."Discount Amount Value" := PeriodDisLine."Discount Amount";
                            PeriodDiscount."Offer Price" := PeriodDisLine."Offer Price";
                            PeriodDiscount."Offer Price Including VAT" := PeriodDisLine."Offer Price Including VAT";
                            PeriodDiscount."Discount Amount Including VAT" := PeriodDisLine."Discount Amount Including VAT";
                            PeriodDisLine.CALCFIELDS(Status);
                            PeriodDiscount.Status := PeriodDisLine.Status;
                            PeriodDiscount."Triggers Pop-up on POS" := PeriodDisLine."Trigger Pop-up on POS";
                            PeriodDiscount."Variant Type" := PeriodDisLine."Variant Type";
                            PeriodDiscount.Exclude := PeriodDisLine.Exclude;
                            PeriodDiscount."Member Points" := PeriodDisLine."Member Points";
                            PeriodDiscount."Prompt at Scan" := PeriodDisLine."Prompt at Scan";
                            PeriodDiscount."Header Type" := PeriodDisLine."Header Type";
                            PeriodDiscount."Planned Demand Type" := PeriodDisLine."Planned Demand Type";
                            PeriodDiscount."Planned Demand" := PeriodDisLine."Planned Demand";
                            PeriodDiscount."Finished Mark" := TRUE;
                            PeriodDiscount.INSERT;

                        UNTIL PeriodDisLine.NEXT = 0;

                    UpdateButton;
                    MESSAGE(' Inserted Successfully!');
                end;
            }
            action("Delete Promotions Lines")
            {
                Caption = 'Delete Promotions Lines';
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    PeriodDiscount.DELETEALL;
                    ControlButton;
                    MESSAGE('Deleted Successfully!');
                end;
            }
            action("Promotion Lines")
            {
                Caption = 'Promotion Lines';
                ApplicationArea = All;
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PromoLines: Page PeriodicDiscountNwmm;
                begin

                    PromoLines.RUN;

                end;
            }
            action("Multi Disable & Archive")
            {
                Caption = 'Multi Disable & Archive';
                ApplicationArea = All;
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
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
                            //PeriodDis.ToggleEnabled;
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
    procedure UpdateButton()
    begin
        ArchivePeriodDisLine.RESET;
        IF ArchivePeriodDisLine.FINDFIRST THEN
            REPEAT
                ArchivePeriodDisLine."Finished Mark" := TRUE;
                ArchivePeriodDisLine.MODIFY;
            UNTIL ArchivePeriodDisLine.NEXT = 0;

        ArchivePeriDiscount.RESET;
        IF ArchivePeriDiscount.FINDFIRST THEN
            REPEAT
                ArchivePeriDiscount."Finished Mark" := TRUE;
                ArchivePeriDiscount.MODIFY;
            UNTIL ArchivePeriDiscount.NEXT = 0;

        OfferLine.RESET;
        IF OfferLine.FINDFIRST THEN
            REPEAT
                OfferLine."Finished Mark" := TRUE;
                OfferLine.MODIFY;
            UNTIL OfferLine.NEXT = 0;

        PeriodDisLine.RESET;
        IF PeriodDisLine.FINDFIRST THEN
            REPEAT
                PeriodDisLine."Finished Mark" := TRUE;
                PeriodDisLine.MODIFY;
            UNTIL PeriodDisLine.NEXT = 0;


        MemberPointOffer.RESET;
        IF MemberPointOffer.FINDFIRST THEN
            REPEAT
                MemberPointOffer."Finiished Mark" := TRUE;
                MemberPointOffer.MODIFY;
            UNTIL MemberPointOffer.NEXT = 0;
    end;

    procedure ControlButton()
    begin
        ArchivePeriodDisLine.RESET;
        IF ArchivePeriodDisLine.FINDFIRST THEN
            REPEAT
                ArchivePeriodDisLine."Finished Mark" := FALSE;
                ArchivePeriodDisLine.MODIFY;
            UNTIL ArchivePeriodDisLine.NEXT = 0;


        ArchivePeriDiscount.RESET;
        IF ArchivePeriDiscount.FINDFIRST THEN
            REPEAT
                ArchivePeriDiscount."Finished Mark" := FALSE;
                ArchivePeriDiscount.MODIFY;
            UNTIL ArchivePeriDiscount.NEXT = 0;

        OfferLine.RESET;
        IF OfferLine.FINDFIRST THEN
            REPEAT

                OfferLine."Finished Mark" := FALSE;
                OfferLine.MODIFY;

            UNTIL OfferLine.NEXT = 0;


        PeriodDisLine.RESET;
        IF PeriodDisLine.FINDFIRST THEN
            REPEAT
                PeriodDisLine."Finished Mark" := FALSE;
                PeriodDisLine.MODIFY;
            UNTIL PeriodDisLine.NEXT = 0;


        MemberPointOffer.RESET;
        IF MemberPointOffer.FINDFIRST THEN
            REPEAT
                MemberPointOffer."Finiished Mark" := FALSE;
                MemberPointOffer.MODIFY;
            UNTIL MemberPointOffer.NEXT = 0;


        // PeriodDiscount1.RESET;
        // IF PeriodDiscount1.FINDFIRST THEN
        // REPEAT
        // 
        //    PeriodDiscount1."Finished Mark" := FALSE;
        //    PeriodDiscount1.MODIFY;
        // 
        //  UNTIL PeriodDiscount1.NEXT =0;
    end;


    var
        PeriodDiscount: Record PeriodicDiscountNwmm;
        LineNo: Integer;
        ArchivePeriodDisLine: Record "LSC Arch Periodic Disc. Line";
        ArchivedPeriodicDisHeader: Record "LSC Arch Periodic Discount";
        MemberPointOffer: Record "LSC Member Point Offer";
        OfferLine: Record "LSC Offer Line";
        PeriodDisLine: Record "LSC Periodic Discount Line";
        PeriodicDiscontHeader: Record "LSC Periodic Discount";
        PerBnfitDis: Record "LSC Periodic Discount Benefits";
        InfoSubCode: Record "LSC Information Subcode";
        ValPeriod: Record "LSC Validation Period";
        ArchivePeriDiscount: Record "LSC Arch Periodic Discount";

}
