tableextension 70085 "LSC POS Terminal Extension" extends "LSC POS Terminal"
{
    fields
    {
        field(70000; "Show VAT Code in Receipt Line"; Boolean)
        {
            Caption = 'Show VAT Code in Receipt Line';
            DataClassification = ToBeClassified;
        }
        field(70001; "Show Price Check Line"; Boolean)
        {
            Caption = 'Show Price Check Line';
            DataClassification = ToBeClassified;
        }
    }
}
