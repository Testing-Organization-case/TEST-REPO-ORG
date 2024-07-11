pageextension 70142 LSItem2StatusLinksExt extends "LSC Item/Item Status Links"      //Created By MK
{
    layout
    {
        addafter("Starting Date")
        {
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = all;
            }
        }
        addafter(Comment)
        {
            field("Modified by"; Rec."Modified by")
            {
                ApplicationArea = All;
            }
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.SETRANGE("Item No.", Rec."Item No.");
                    IF Rec.Priority THEN BEGIN

                        Rec.MODIFYALL(Priority, FALSE);

                        Rec.Priority := TRUE;

                    END;
                end;
            }
        }

    }
    trigger OnModifyRecord(): Boolean
    begin
        Rec."Modified by" := UserId;
    end;
}
