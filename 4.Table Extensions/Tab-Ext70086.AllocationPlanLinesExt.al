tableextension 70086 ForceSetupExt extends "LSC Forec. Setup"
{
    fields
    {
        field(70000; "Forecast Quantity (Upper)";Decimal)
        {
            Caption = 'Forecast Quantity (Upper)';
            DataClassification = ToBeClassified;
        }
        field(70001; "Forecast Quantity";Decimal)
        {
            Caption = 'Forecast Quantity';
            DataClassification = ToBeClassified;
        }
    }
}
