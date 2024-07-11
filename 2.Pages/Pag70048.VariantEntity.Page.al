page 70048 "Variant Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'variantEntity';
    EntitySetName = 'variantEntity';
    PageType = API;
    DelayedInsert = false;
    Editable = false;
    SourceTable = "Item Variant";

    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field(variantCode; Rec.Code)
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantDesc; Rec."Description 2")
                {
                }
            }
        }
    }

    actions
    {
    }
}

