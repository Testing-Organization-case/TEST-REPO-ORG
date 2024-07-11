page 70021 "Packaging Type List"
{
    SourceTable = "Packaging Type";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
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

