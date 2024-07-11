pageextension 70138 "LSC Item Status Factbox Ext" extends "LSC Item Status Factbox"
{
    layout
    {
        addafter("Starting Date")
        {
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = All;
            }

            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("Store Group Code"; Rec."Store Group Code")
            {
                ApplicationArea = All;
            }

        }
        addafter("Block From Recommendation")
        {
            field("Modified by"; Rec."Modified by")
            {
                ApplicationArea = All;

            }
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
            }
        }
    }
}
