tableextension 70017 PurchInvHeaderExt extends "Purch. Inv. Header"         //Created By MK
{
    fields
    {
        field(70000; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            TableRelation = "LSC Store";
            DataClassification = ToBeClassified;
        }
        field(70001; "Item Registration No."; Code[20])
        {
            Caption = 'Item Registration No.';
            DataClassification = ToBeClassified;
        }
        field(700012; "Open-to-Buy Date"; Date)
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
            DataClassification = ToBeClassified;
        }
    }
}
