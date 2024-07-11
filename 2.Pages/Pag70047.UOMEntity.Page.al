page 70047 "UOM Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'uomEntity';
    EntitySetName = 'uomEntity';
    PageType = API;
    DelayedInsert = false;
    Editable = false;
    SourceTable = "Unit of Measure";

    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                // field(id; Id)
                // {
                // }
                field("code"; Rec.Code)
                {
                }
                field(displayName; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

