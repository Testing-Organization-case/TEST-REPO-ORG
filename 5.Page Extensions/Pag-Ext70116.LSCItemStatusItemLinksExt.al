pageextension 70116 "LSC Item Status/Item Links Ext" extends "LSC Item Status/Item Links"
{
    layout
    {

        addafter("Starting Date")
        {
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = All;
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
            }
        }
    }
}
