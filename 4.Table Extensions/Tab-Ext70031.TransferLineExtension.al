tableextension 70031 "Transfer Line Extension" extends "Transfer Line"
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
        field(70005; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
        }
        field(70006; Division; Code[10])
        {
            Caption = 'Division';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Division";
        }
        field(70007; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code".Code;
        }
        field(70008; "Transfer Type"; Option)
        {
            OptionMembers = ,"Planned Cross Docking","Buyer's Push",Replenishment,"Stock Recall","Special Order";
            Caption = 'Transfer Type';
            DataClassification = ToBeClassified;
        }
        field(70009; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = ToBeClassified;
        }


        field(70011; "Item Family Code"; Code[50])
        {
            Caption = 'Item Family Code';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."LSC Item Family Code" WHERE("No." = FIELD("Item No.")));
        }
        field(70012; "External Document No"; Code[35])
        {
            Caption = 'External Document No';
            FieldClass = FlowField;
            CalcFormula = Lookup("Transfer Header"."External Document No." WHERE("No." = FIELD("Document No.")));
            Editable = false;
        }
    }
}
