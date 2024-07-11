tableextension 70006 "Sales Line Extension" extends "Sales Line"
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
        field(70002; "Attribute Type"; Option)
        {
            OptionMembers = Option,Text,Integer,Decimal,Date;
            Caption = 'Attribute Type';
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
        field(70005; "Collection Item No."; Code[20])
        {
            Caption = 'Collection Item No.';
            DataClassification = ToBeClassified;
        }
        field(70006; "Collection Line No."; Integer)
        {
            Caption = 'Collection Line No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
        }
        field(70008; Division; Code[10])
        {
            Caption = 'Division';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Division";
        }
        field(70009; "Offer No."; Code[20])
        {
            Caption = 'Offer No.';
            DataClassification = ToBeClassified;
        }
        field(70010; "Promotion No."; Code[20])
        {
            Caption = 'Promotion No.';
            DataClassification = ToBeClassified;
        }
        field(70011; "Alloc. Plan Purc. Order No."; Code[20])
        {
            Caption = 'Alloc. Plan Purc. Order No.';
            DataClassification = ToBeClassified;
        }
        field(70012; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }

        field(70014; "POS Received N0."; Code[50])
        {
            Caption = 'POS Received N0.';
            DataClassification = ToBeClassified;
        }
        field(70015; "External Document No"; Code[35])
        {
            Caption = 'External Document No';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."External Document No." WHERE("No." = FIELD("Document No.")));
        }
    }
}
