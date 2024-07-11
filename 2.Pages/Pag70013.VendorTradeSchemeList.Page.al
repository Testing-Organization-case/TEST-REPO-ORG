page 70013 "Vendor Trade Scheme List"
{
    PageType = List;
    SourceTable = "Vendor Trade Scheme";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field(Scheme; Rec.Scheme)
                {
                }
                field(Active; Rec.Active)
                {
                }
            }
        }
    }

    actions
    {
    }
}

