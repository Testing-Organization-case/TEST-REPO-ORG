tableextension 70015 PurchRcptHeaderExtend extends "Purch. Rcpt. Header"        //Created By MK
{
    fields
    {
        field(70000; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            TableRelation = "LSC Store";
            DataClassification = ToBeClassified;
        }
        field(70004; "Retail Status"; Option)
        {
            Caption = 'Retail Status';
            OptionMembers = New,Sent,"Part. receipt","Closed - ok","Closed - difference";
            DataClassification = ToBeClassified;
        }
        field(70005; "Receiving/Picking No."; Code[20])
        {
            Caption = 'Receiving/Picking No.';
            TableRelation = "LSC Posted P/R Counting Header";
            DataClassification = ToBeClassified;
        }
        field(70012; "Open-to-Buy Date"; Date)
        {
            Caption = 'Open-to-Buy Date';
            DataClassification = ToBeClassified;
        }
        field(70013; "Last Open-to-Buy Checked"; DateTime)
        {
            Caption = 'Last Open-to-Buy Checked';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(70014; "Last Open-to-Buy Check Status"; Option)
        {
            Caption = 'Last Open-to-Buy Check Status';
            OptionMembers = " ",Passed,Failed;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(70015; "Customer Order ID"; Code[20])
        {
            Caption = 'Customer Order ID';
            DataClassification = ToBeClassified;
        }
        field(70021; "Child PO No."; Text[30])
        {
            Caption = 'Child PO No.';
            Editable = false;

            DataClassification = ToBeClassified;
        }
    }
}
