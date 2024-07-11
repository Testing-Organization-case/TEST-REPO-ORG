tableextension 70048 WhseRcptHdrExt extends "Warehouse Receipt Header"
{
    fields
    {
        field(70000; "Scanning Barcode"; Code[50])
        {
            Caption = 'Scanning Barcode';
            DataClassification = ToBeClassified;
        }
    }
}
