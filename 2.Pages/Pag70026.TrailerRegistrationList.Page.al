page 70026 "Trailer Registration List"
{
    SourceTable = "Trailer Registration";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field("Trailer No."; Rec."Trailer No.")
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

