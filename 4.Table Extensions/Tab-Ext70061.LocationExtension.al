tableextension 70061 "Location Extension" extends Location
{
    fields
    {
        field(70000; Latitude; Decimal)
        {
            Caption = 'Latitude';
            DataClassification = ToBeClassified;
            MinValue = -180;
            MaxValue = 180;
        }
        field(70001; Longitude; Decimal)
        {
            Caption = 'Longitude';
            DataClassification = ToBeClassified;
            MinValue = -180;
            MaxValue = 180;
        }
        field(70002; "Replenishment Group"; Code[10])
        {
            Caption = 'Replenishment Group';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Replen. Store Group";
            trigger OnValidate()
            begin
                //LS -
                IF "Replenishment Group" <> '' THEN
                    "Use Planned Cross Docking" := TRUE
                ELSE
                    "Use Planned Cross Docking" := FALSE;
                //LS +

            end;
        }
        field(70003; "Default Weight"; Decimal)
        {
            Caption = 'Default Weight';
            DataClassification = ToBeClassified;
        }
        field(70004; "Use Planned Cross Docking"; Boolean)
        {
            Caption = 'Use Planned Cross Docking';
            DataClassification = ToBeClassified;
        }
        field(70005; "Active for Autom. Replenishm."; Boolean)
        {
            Caption = 'Active for Autom. Replenishm.';
            DataClassification = ToBeClassified;
        }
        field(70006; "Default Replenishm. Grade Code"; Code[10])
        {
            Caption = 'Default Replenishm. Grade Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Replen. Grade";
        }
        field(70007; "Location is a Warehouse"; Boolean)
        {
            Caption = 'Location is a Warehouse';
            DataClassification = ToBeClassified;
        }
        field(70008; "Replenish as Location Code"; Code[10])
        {
            Caption = 'Replenish as Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
            trigger OnValidate()
            var
                Text99001450: TextConst ENU = 'The %1 can not be equal to the %2.';
            begin
                //LS -
                IF "Replenish as Location Code" = Code THEN
                    ERROR(Text99001450, FIELDCAPTION("Replenish as Location Code"), FIELDCAPTION(Code));
                //LS +
            end;
        }
        field(70009; "Active for LS Forecast"; Boolean)
        {
            Caption = 'Active for LS Forecast';
            DataClassification = ToBeClassified;
        }
        field(70010; "Data Source"; Option)
        {
            OptionMembers = "Local Company","Local Company (from Child Locations)","Other Company","Calculated (from Item Ledger Entries)";
            Caption = 'Data Source';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                lLocation: Record Location;
            begin
                //LS-8344 New
                IF "Data Source" <> xRec."Data Source" THEN BEGIN
                    IF xRec."Data Source" = xRec."Data Source"::"Local Company (from Child Locations)" THEN BEGIN
                        lLocation.RESET;
                        lLocation.SETRANGE("Master Location", Code);
                        IF NOT lLocation.ISEMPTY THEN
                            lLocation.MODIFYALL("Master Location", '');
                    END ELSE
                        IF (xRec."Data Source" = xRec."Data Source"::"Local Company") AND ("Master Location" <> '') THEN
                            CLEAR("Master Location");
                    CLEAR("Data Source Company");
                    CLEAR("Customer No.");
                END;
            end;
        }
        field(70011; "Data Source Company"; Text[30])
        {
            Caption = 'Data Source Company';
            DataClassification = ToBeClassified;
            TableRelation = Company;
        }
        field(70012; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(70013; "Master Location"; Code[10])
        {
            Caption = 'Master Location';
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Data Source" = CONST("Local Company (from Child Locations)"));
        }
        field(70014; "CO Will Ship orders"; Boolean)
        {
            Caption = 'CO Will Ship orders';
            DataClassification = ToBeClassified;
        }
        field(70015; "CO Orders can be Collected"; Boolean)
        {
            Caption = 'CO Orders can be Collected';
            DataClassification = ToBeClassified;
        }
        field(70016; "CO Lead Time Calculation"; DateFormula)
        {
            Caption = 'CO Lead Time Calculation';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeadTimeMgt: Codeunit "Lead-Time Management";
            begin
                LeadTimeMgt.CheckLeadTimeIsNotNegative("CO Lead Time Calculation");
            end;
        }
        field(70017; "CO Priority"; Integer)
        {
            Caption = 'CO Priority';
            DataClassification = ToBeClassified;
            InitValue = 1;
            MinValue = 1;
        }
    }
}
