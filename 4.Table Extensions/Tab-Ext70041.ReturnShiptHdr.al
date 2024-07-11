tableextension 70041 ReturnShiptHdr extends "Return Shipment Header"
{
    fields
    {
        field(70000; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
        }
        field(70004; "Retail Status"; Option)
        {
            Caption = 'Retail Status';
            OptionMembers = New,Sent,"Part. receipt","Closed - ok","Closed - difference";
            DataClassification = ToBeClassified;
        }
        field(70005; "Reciving/Picking No."; Code[20])
        {
            Caption = 'Receiving/Picking No.';
            TableRelation = "LSC Posted P/R Counting Header";
            DataClassification = ToBeClassified;
        }
        field(70017; "External Document No."; Text[30])
        {
            Caption = 'External Document No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
}
