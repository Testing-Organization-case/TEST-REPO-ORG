page 70025 "Truck Registration List"
{
    SourceTable = "Truck Registration";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field("Truck No."; Rec."Truck No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

