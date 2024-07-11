page 70046 "Sales Loss Type Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'saleslosstypeentity';
    EntitySetName = 'saleslosstypeentity';
    PageType = API;
    DelayedInsert = false;
    Editable = false;
    SourceTable = "Sales Loss Type";

    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field("code"; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }

    actions
    {
    }
}

