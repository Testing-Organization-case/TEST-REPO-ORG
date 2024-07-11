pageextension 70113 "Replen. Out of Stock Days Ext" extends "LSC Replen. Out of Stock Days"
{
    layout
    {
        addafter("Location Code")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }


            field("Division Name"; Rec."Division Name")
            {
                ApplicationArea = All;
            }
        }

        addafter("Item Category Code")
        {
            field("Item Category Name"; Rec."Item Category Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Retail Product Code")
        {
            field("Retail Product Name"; Rec."Retail Product Name")
            {
                ApplicationArea = All;
            }
        }
    }
}
