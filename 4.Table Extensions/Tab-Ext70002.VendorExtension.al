tableextension 70002 "Vendor Extension" extends Vendor
{
    fields
    {
        field(70000; "RTC Filter Field"; Option)
        {
            OptionMembers = " ","Buyer's ID";
            Caption = 'RTC Filter Field';
            DataClassification = ToBeClassified;
        }
        field(70001; "Buyer Group Code"; Code[10])
        {
            Caption = 'Buyer Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Buyer Group";
        }
        field(70002; "Buyer ID"; Code[50])
        {
            Caption = 'Buyer ID';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Retail User";
        }
        field(70003; "Minimum Order Amount"; Decimal)
        {
            Caption = 'Minimum Order Amount';
            DataClassification = ToBeClassified;
        }
    }
}
