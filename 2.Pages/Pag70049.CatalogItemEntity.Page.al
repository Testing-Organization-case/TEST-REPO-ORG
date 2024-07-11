page 70049 "Catalog Item Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'catItemEntity';
    EntitySetName = 'catItemEntity';
    PageType = API;
    DelayedInsert = false;
    Editable = false;
    SourceTable = "Nonstock Item";

    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field(entryNo; Rec."Entry No.")
                {
                }
                field(vendorNo; Rec."Vendor No.")
                {
                }
                field(desc; Rec.Description)
                {
                }
                field(uom; Rec."Unit of Measure")
                {
                }
                field(unitPrice; Rec."Unit Price")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(vendorName; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                }
            }
        }
    }

    actions
    {
    }
}

