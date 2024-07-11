tableextension 70024 PurchaseHeaderArchiveExtension extends "Purchase Header Archive"
{
    fields
    {
        field(70012; "Open-to-Buy Date"; Date)
        {
            Caption = 'Open-to-Buy Date';
            DataClassification = ToBeClassified;
        }
        field(70013; "Last Open-to-Buy Checked"; DateTime)
        {
            Caption = 'Last Open-to-Buy Checked';
            DataClassification = ToBeClassified;
        }
        field(70014; "Last Open-to-Buy Check Status"; Option)
        {
            OptionMembers = ,Passed,Failed;
            Caption = 'Last Open-to-Buy Check Status';
            DataClassification = ToBeClassified;
        }
    }
}
