pageextension 70045 "Item Variants Extension" extends "Item Variants"
{
    layout
    {
        addafter("Description 2")
        {
            field(ImageSet; ImageSet)
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter(Translations)
        {
            action("&Offers")
            {
                Caption = 'Offers';
                ApplicationArea = Planning;
                Image = Discount;
                trigger OnAction()
                var
                    tmpPerDiscPri: Record "LSC Periodic Discount";
                begin
                    //LS -
                    tmpPerDiscPri.Priority := 1;
                    tmpPerDiscPri."No." := Rec."Item No.";
                    tmpPerDiscPri."Validation Period ID" := Rec.Code;
                    tmpPerDiscPri.INSERT;
                    PAGE.RUN(99001844, tmpPerDiscPri);
                    //LS +
                end;

            }
            action("&Images")
            {
                RunPageMode = View;
                ApplicationArea = Planning;
                Image = Picture;
                trigger OnAction()
                var
                    RecRef: RecordRef;
                    CustomizeFun: Codeunit CustomizeFunctions; //BOUtils_l: Codeunit "LSC BO Utils";
                begin
                    //LS -
                    RecRef.GETTABLE(Rec);
                    CustomizeFun.DisplayRetailImageNwmm(RecRef); //BOUtils_l.DisplayRetailImage(RecRef);       //Modify BY MK
                    //LS +
                end;

            }
        }
    }
    procedure ImageSet(): Text
    var
        RetailImageLink: Record "LSC Retail Image Link";
        RecRef: RecordRef;
    begin
        //LS
        RetailImageLink.RESET;
        RecRef.GETTABLE(Rec);
        RetailImageLink.SETRANGE("Record Id", FORMAT(RecRef.RECORDID));
        IF RetailImageLink.FINDFIRST THEN
            EXIT(RetailImageLink."Image Id");
        EXIT('');
    end;


}
