page 70008 "Vendor Trade Scheme"
{
    PageType = List;
    SourceTable = "Vendor Trade Scheme";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                }
                field(Scheme; Rec.Scheme)
                {
                }
                field(Active; Rec.Active)
                {
                }
                // field("Variant Code"; Rec."Variant Code")
                // {
                // }
                // field("Variant Description"; Rec."Variant Description")
                // {
                //     Editable = false;
                // }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field("Packaging Info"; Rec."Packaging Info")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

   
    var
        ItemR: Record Item;
}

