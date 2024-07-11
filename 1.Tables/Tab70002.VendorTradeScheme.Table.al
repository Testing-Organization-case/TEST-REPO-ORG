table 70002 "Vendor Trade Scheme"
{
    DrillDownPageID = "Vendor Trade Scheme List";
    LookupPageID = "Vendor Trade Scheme List";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(3; Scheme; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        // field(6; "Variant Code"; Code[20])
        // {
        //     FieldClass = Normal;
        //     TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));

        //     trigger OnValidate()
        //     begin
        //         ItemVariantR.Reset;
        //         ItemVariantR.SetRange(Code, "Variant Code");
        //         ItemVariantR.SetRange("Item No.", "Item No.");
        //         if ItemVariantR.FindFirst then begin
        //             "Variant Description" := ItemVariantR."Description 2";
        //         end;
        //     end;
        // }
        // field(7; "Variant Description"; Text[100])
        // {
        //     FieldClass = Normal;
        // }
        field(8; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Packaging Info"; Text[50])
        {
            CalcFormula = Lookup(Item."Packaging Info" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(50000; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            Description = 'NWMM';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Item No.", Scheme)

        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Vendor No.", Scheme)

        {
            Enabled = false;
        }
    }

    fieldgroups
    {
    }

    var
        Vend: Record Vendor;
        TempRec: Record "Vendor Trade Scheme";
        ItemVariantR: Record "Item Variant";
}

