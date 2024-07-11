tableextension 70008 PurchaseLineExtend extends "Purchase Line"         //Created By MK
{
    fields
    {
        field(70000; "Attribute Name"; Text[250])
        {
            Caption = 'Attribute Name';
            DataClassification = ToBeClassified;
            Description = 'NWMM';
        }
        field(70001; "Value"; Text[250])
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
            Description = 'NWMM';
        }
        field(70002; "Attribute Type"; Option)
        {
            Caption = 'Attribute Type';
            OptionMembers = Option,Text,Integer,Decimal,Date;
            DataClassification = ToBeClassified;
            Description = 'NWMM';
        }
        field(70003; "Packaging Info"; Text[30])
        {
            Caption = 'Packaging Info';
            DataClassification = ToBeClassified;
            Description = 'NWMM';
        }
        field(70004; Size; Text[30])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
            Description = 'NWMM';
        }
        field(70005; Remark; Text[30])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
            Description = 'NWMM';
        }
        field(70006; "Collection Item No."; Code[20])
        {
            Caption = 'Collection Item No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Collection Line No."; Integer)
        {
            Caption = 'Collection Line No.';
            DataClassification = ToBeClassified;
        }
        field(70008; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            DataClassification = CustomerContent;
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
        }
        field(70009; Division; Code[10])
        {
            Caption = 'Division';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Division";
        }
        field(70010; "Original Quantity"; Decimal)
        {
            Caption = 'Original Quantity';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                VALIDATE("Quantity Difference", Quantity - "Original Quantity"); //LS
            end;
        }
        field(70011; "Original Quantity (base)"; Decimal)
        {
            Caption = 'Original Quantity (base)';
            DataClassification = ToBeClassified;
        }
        field(70012; "Quantity Difference"; Decimal)
        {
            Caption = 'Quantity Difference';
            DataClassification = ToBeClassified;
        }
        field(70013; "Cross Doc. Difference"; Decimal)
        {
            Caption = 'Cross Doc. Difference';
            DataClassification = ToBeClassified;
        }
        field(70014; "PO Status"; Option)
        {
            Caption = 'PO Status';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            DataClassification = ToBeClassified;
        }
        field(70015; "Net Cost Price."; Decimal)
        {
            Caption = 'Net Cost Price.';
            DataClassification = ToBeClassified;
        }
        field(70016; "Minimum Order Quantity"; Integer)
        {
            Caption = 'Minimum Order Quantity';
            DataClassification = ToBeClassified;
        }
        field(70017; "Minimum Order Amount"; Decimal)
        {
            Caption = 'Minimum Order Amount';
            DataClassification = ToBeClassified;
        }
        field(70018; "Net Price"; Decimal)
        {
            Caption = 'Net Price';
            DataClassification = ToBeClassified;
        }

        field(70020; Scheme; Text[100])
        {
            Caption = 'Scheme';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Trade Scheme".Scheme WHERE(Active = CONST(true), "Item No." = FIELD("No."), "Vendor No." = FIELD("Buy-from Vendor No."));
            

        }
        field(70021; "External Document No"; Code[35])
        {
            Caption = 'External Document No';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."External Document No." WHERE("No." = FIELD("Document No.")));

        }
    }
}
