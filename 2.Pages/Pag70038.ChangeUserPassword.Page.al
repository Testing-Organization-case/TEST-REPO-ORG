page 70038 "Change User Password"
{
    PageType = StandardDialog;
    SourceTable = "Tablet User";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Password; Rec.Password)
                {
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    actions
    {
    }
}

