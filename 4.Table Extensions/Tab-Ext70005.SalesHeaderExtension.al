tableextension 70005 "Sales Header Extension" extends "Sales Header"
{
    fields
    {
        field(70000; "Batch No."; Code[10])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
        }
        field(70001; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store";
        }
        field(70002; "POS ID"; Code[10])
        {
            Caption = 'POS ID';
            DataClassification = ToBeClassified;
        }
        field(70003; "Posting Time"; Time)
        {
            Caption = 'Posting Time';
            DataClassification = ToBeClassified;
        }
        field(70004; "Not Show Dialog"; Boolean)
        {
            Caption = 'Not Show Dialog';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70005; "Sales Type"; Code[20])
        {
            Caption = 'Sales Type';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Sales Type".Code;
        }
        field(70006; "POS Comment"; Text[100])
        {
            Caption = 'POS Comment';
            DataClassification = ToBeClassified;
        }
        field(70007; "Retail Status"; Option)
        {
            OptionMembers = New,Sent,"Part. receipt","Closed - ok","Closed - difference";
            Caption = 'Retail Status';
            DataClassification = ToBeClassified;
        }
        field(70008; "Receiving/Picking No."; Code[20])
        {
            Caption = 'Receiving/Picking No.';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Posted P/R Counting Header";
        }
        field(70009; "Customer Order ID"; Code[20])
        {
            Caption = 'Customer Order ID';
            DataClassification = ToBeClassified;
        }
        field(70010; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            DataClassification = ToBeClassified;
        }
        field(70011; "Member Card No."; Text[100])
        {
            Caption = 'Member Card No.';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Membership Card";
        }
        field(70012; "Created By"; Code[10])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(70013; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
        }
        field(70014; "Modified By"; Code[10])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
        }
        field(70015; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(Key14; "Customer Order ID")
        {
        }
    }
    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created Date" := CREATEDATETIME(WORKDATE, TIME);
        // SystemId := System.CreateGuid();

    end;

    trigger OnModify()
    begin
        "Modified By" := USERID;
        "Modified Date" := CREATEDATETIME(WORKDATE, TIME);
        // SystemId := System.CreateGuid();
        // SystemId := CREATEGUID;
    end;
}
