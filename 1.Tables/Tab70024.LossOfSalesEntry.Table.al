table 70024 "Loss Of Sales Entry"
{

    fields
    {
        field(1; "Transaction No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Transaction Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Barcode No."; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Variant Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code;
        }
        field(7; "Unit Of Measure Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(8; "Catalog Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Entry Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Retail Item","Catalog Item",Comment;
        }
        field(10; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Tablet User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tablet User";
        }
        field(14; "Variant Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Sales Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Sales Loss Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Loss Type";
        }
        field(17; ID; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Location Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(19; "Packaging Info"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Trans. No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Vendor No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(22; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(23; "Base Unit Of Measure"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Base Qty Per UOM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Update from Tablet"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Trans. No.", Date, "Location Code")
        {
            Clustered = true;
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Trans. No." = '' then begin
            Sales_ReceivableSetup.Get;
            Sales_ReceivableSetup.TestField("LOS Nos.");
            "Trans. No." := NoSeriesMgt.GetNextNo(Sales_ReceivableSetup."LOS Nos.", Today, true);
        end;

        ID := CreateGuid;

        "Transaction Code" := 'LOSSOFSALES';
    end;

    var
        TempRec: Record "Loss Of Sales Entry";
        Sales_ReceivableSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

