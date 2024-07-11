query 70000 "Barcodes Entity"
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    EntityName = 'barcodeEntity';
    EntitySetName = 'barcodeEntity';
    QueryType = API;

    elements
    {
        dataitem(Barcodes; "LSC Barcodes")
        {
            column(id; ID)
            {
            }
            column(barcodeNo; "Barcode No.")
            {
            }
            column(itemCode; "Item No.")
            {
            }
            column(displayName; Description)
            {
            }
            column(lastDateModified; "Last Date Modified")
            {
            }
            column(variantCode; "Variant Code")
            {
            }
            column(UOMCode; "Unit of Measure Code")
            {
            }
            column(variantDesc; Description)
            {
            }
        }
    }
}

