tableextension 70007 PurchaseHeaderExtend extends "Purchase Header"         //Created By MK
{
    fields
    {
        field(70000; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store";
            trigger OnValidate()
            var
                lStores: Record "LSC Store";
            begin
                //LS -
                TESTFIELD(Status, Status::Open);

                "Location Code" := '';
                IF "Store No." <> '' THEN
                    IF lStores.GET("Store No.") THEN BEGIN
                        "Location Code" := lStores."Location Code";
                        VALIDATE("Shortcut Dimension 1 Code", lStores."Global Dimension 1 Code");
                    END;
                //LS +
            end;
        }
        // field(70001; "Item Registration No."; Code[20])
        // {
        //     Caption = 'Item Registration No.';
        //     DataClassification = ToBeClassified;
        // }
        // field(70002; "Version No."; Integer)
        // {
        //     Caption = 'Version No.';
        //     DataClassification = ToBeClassified;
        // }
        // field(70003; "RTC Filter Field"; Option)
        // {
        //     Caption = 'RTC Filter Field';
        //     OptionMembers = " ","Buyer's ID";
        //     DataClassification = ToBeClassified;
        // }
        // field(70004; "Retail Status"; Option)
        // {
        //     Caption = 'Retail Status';
        //     OptionMembers = "New","Sent","Part. receipt","Closed - ok","Closed - difference";
        //     OptionCaption = 'New,Sent,Part. receipt,Closed - ok,Closed - difference';
        //     DataClassification = ToBeClassified;
        // }
        // field(70005; "Reciving/Picking No."; Code[20])
        // {
        //     Caption = 'Reciving/Picking No.';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Posted P/R Counting Header";
        // }
        // field(70006; "Buyer ID"; Code[50])
        // {
        //     Caption = 'Buyer ID';
        //     TableRelation = "LSC Retail User";
        //     DataClassification = EndUserIdentifiableInformation;
        // }
        // field(70007; "Buyer Group Code"; Code[10])
        // {
        //     Caption = 'Buyer Group Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "LSC Buyer Group";
        // }
        // field(70008; "Created By Source Code"; Code[20])
        // {
        //     Caption = 'Created By Source Code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Source Code";
        // }
        // field(70009; "Retail Purchase Dest. Filter"; Option)
        // {
        //     Caption = 'Retail Purchase Dest. Filter';
        //     OptionMembers = ,Warehouse;
        //     DataClassification = ToBeClassified;
        // }
        // field(70010; "Retail Purchase Source Filter"; Option)
        // {
        //     Caption = 'Retail Purchase Source Filter';
        //     OptionMembers = " ",Replenishment;
        //     DataClassification = ToBeClassified;
        // }
        // field(70011; "General Comments"; Text[250])
        // {
        //     Caption = 'General Comments';
        //     DataClassification = ToBeClassified;
        // }
        // field(70012; "Open-to-Buy Date"; Date)
        // {
        //     Caption = 'Open-to-Buy Date';
        //     DataClassification = ToBeClassified;
        // }
        // field(70013; "Last Open-to-Buy Checked"; DateTime)
        // {
        //     Caption = 'Last Open-to-Buy Checked';
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        // field(70014; "Last Open-to-Buy Check Status"; Option)
        // {
        //     Caption = 'Last Open-to-Buy Check Status';
        //     OptionMembers = " ",Passed,Failed;
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        // field(70015; "Customer Order ID"; Code[20])
        // {
        //     Caption = 'Customer Order ID';
        //     DataClassification = ToBeClassified;
        // }
        field(70016; "Vendor Trade Scheme"; Text[100])
        {
            Caption = 'Vendor Trade Scheme';
            DataClassification = ToBeClassified;
        }
        field(70017; "External Document No."; Text[30])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(70018; "FOC PO No."; Text[30])
        {
            Caption = 'FOC PO No.';
            DataClassification = ToBeClassified;
        }
        field(70019; "Minimum Order Quantity"; Integer)
        {
            Caption = 'Minimum Order Quantity';
            DataClassification = ToBeClassified;
        }
        field(70020; "Minimum Order Amount"; Decimal)
        {
            Caption = 'Minimum Order Amount';
            DataClassification = ToBeClassified;
        }
        field(70021; "CPO No."; Text[100])
        {
            Caption = 'CPO No.';
            DataClassification = ToBeClassified;
        }
        field(70022; "CPO Confirm"; Boolean)
        {
            Caption = 'CPO Confirm';
            DataClassification = ToBeClassified;
        }
    }
}
