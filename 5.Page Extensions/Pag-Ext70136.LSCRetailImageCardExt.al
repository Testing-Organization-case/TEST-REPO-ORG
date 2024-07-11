pageextension 70136 "LSC Retail Image Card Ext" extends "LSC Retail Image Card"
{
    layout
    {
        addafter(Code)
        {
            // field(Type; Rec.Type)
            // {
            //     ApplicationArea = All;
            // }

        }
        addafter(Description)
        {
            field("Image Name"; Rec."Image Name")
            {
                ApplicationArea = All;
            }
        }
    }
}
