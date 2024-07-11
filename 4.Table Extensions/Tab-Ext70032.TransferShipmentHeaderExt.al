tableextension 70032 "Transfer Shipment Header Ext" extends "Transfer Shipment Header"
{
    fields
    {
        field(70002; "Store-to"; Code[10])
        {
            Caption = 'Store-to';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store";
        }
        field(70003; "Store-from"; Code[10])
        {
            Caption = 'Store-from';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store";
        }
        field(70004; "Customer Order ID"; Code[20])
        {
            Caption = 'Customer Order ID';
            DataClassification = ToBeClassified;
        }
        field(70005; "Retail Status"; Option)
        {
            OptionMembers = New,Sent,"Part. receipt","Closed - ok","Closed - difference";
            Caption = 'Retail Status';
            DataClassification = ToBeClassified;
        }
        field(70006; "Reciving/Picking No."; Code[20])
        {
            Caption = 'Reciving/Picking No.';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Posted P/R Counting Header";
        }
        field(70007; "Shipment No"; Code[20])
        {
            Caption = 'Shipment No';
            FieldClass = FlowField;
            CalcFormula = Lookup("Posted Whse. Shipment Line"."Whse. Shipment No." WHERE("Posted Source No." = FIELD("No.")));
            Editable = false;
            trigger OnValidate()
            begin
                CALCFIELDS("Shipment No");
            end;
        }
    }
}
