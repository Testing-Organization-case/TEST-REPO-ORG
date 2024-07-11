tableextension 70049 WhseRcptLineExt extends "Warehouse Receipt Line"
{
    fields
    {
        field(70000; "Attribute Name"; Text[250])
        {
            Caption = 'Attribute Name';
            DataClassification = ToBeClassified;
        }
        field(70001; "Value"; Text[250])
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
        }


        field(70003; "Packaging Info"; Text[30])
        {
            Caption = 'Packaging Info';
            DataClassification = ToBeClassified;
        }
        field(70004; Size; Text[30])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
        }
        field(70005; Remark; Text[30])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70006; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Attribute Type"; Option)
        {
            Caption = 'Attribute Type';
            OptionMembers = Option,Text,Integer,Decimal,Date;
            DataClassification = ToBeClassified;
        }

    }
}
