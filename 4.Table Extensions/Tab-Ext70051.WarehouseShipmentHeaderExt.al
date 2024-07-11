tableextension 70051 "Warehouse Shipment Header Ext" extends "Warehouse Shipment Header"
{
    fields
    {
        field(70000; "Route No."; Code[50])
        {
            Caption = 'Route No.';
            DataClassification = ToBeClassified;
        }
        field(70001; "Sequence No."; Code[50])
        {
            Caption = 'Sequence No.';
            DataClassification = ToBeClassified;
        }
        field(70002; "Expected Arrival"; Time)
        {
            Caption = 'Expected Arrival';
            DataClassification = ToBeClassified;
        }
        field(70003; "Unloading Time"; Time)
        {
            Caption = 'Unloading Time';
            DataClassification = ToBeClassified;
        }
        field(70004; "Actual Arrival Time"; Time)
        {
            Caption = 'Actual Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(70005; "Number of Container"; Integer)
        {
            Caption = 'Number of Container';
            DataClassification = ToBeClassified;
        }
        field(70006; "Number of Bult Units"; Integer)
        {
            Caption = 'Number of Bult Units';
            DataClassification = ToBeClassified;
        }
        field(70007; "Truck ID"; Code[50])
        {
            Caption = 'Truck ID';
            DataClassification = ToBeClassified;
            TableRelation = "Truck Registration";
        }
        field(70008; "Trailer ID"; Code[50])
        {
            Caption = 'Trailer ID';
            DataClassification = ToBeClassified;
            TableRelation = "Trailer Registration";
        }
        field(70009; Driver; Text[100])
        {
            Caption = 'Driver';
            DataClassification = ToBeClassified;
        }
        field(70010; "Service Provider"; Text[100])
        {
            Caption = 'Service Provider';
            DataClassification = ToBeClassified;
        }
        field(70011; "Expected Start Time"; Time)
        {
            Caption = 'Expected Start Time';
            DataClassification = ToBeClassified;
        }
        field(70012; "Expected Return Time"; Time)
        {
            Caption = 'Expected Return Time';
            DataClassification = ToBeClassified;
        }
        field(70013; "Dock/Bay Lane Number"; Code[50])
        {
            Caption = 'Dock/Bay Lane Number';
            DataClassification = ToBeClassified;
        }
        field(70014; Priority; Text[30])
        {
            Caption = 'Priority';
            DataClassification = ToBeClassified;
        }
        field(70015; "Scanning Barcode"; Code[50])
        {
            Caption = 'Scanning Barcode';
            DataClassification = ToBeClassified;
        }
    }
}
