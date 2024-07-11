page 70045 "Sales Loss Type"
{
    PageType = List;
    SourceTable = "Sales Loss Type";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field(Code; Rec.Code)
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

