tableextension 70010 ItemJnlLineExtend extends "Item Journal Line"          //Created By MK
{
    fields
    {
        field(70000; "Packaging Info"; Text[30])
        {
            Caption = 'Packaging Info';
            DataClassification = ToBeClassified;
        }
        field(70001; Size; Text[30])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
        }
        field(70002; "Offer No."; Code[20])
        {
            Caption = 'Offer No.';
            DataClassification = ToBeClassified;
        }
        field(70003; "Batch No."; Code[15])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
        }
        field(70004; Barcode; Code[20])
        {
            Caption = 'Barcode';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                EnteredBarcode: Code[20];
                BarcodeMgmt: Codeunit "LSC Barcode Management";
                Item: Record Item;
                Barcodes: Record "LSC Barcodes";
                Qty: Decimal;
            begin
                IF Barcode = '' THEN
                    EXIT;

                EnteredBarcode := Barcode;

                IF BarcodeMgmt.FindBarcodeDetails(EnteredBarcode, Item, Barcodes, Amount, Qty) THEN BEGIN
                    VALIDATE("Item No.", Item."No.");
                    // IF Barcodes."Variant Code" <> '' THEN
                    //     VALIDATE("Variant Code", Barcodes."Variant Code");
                    IF Barcodes."Unit of Measure Code" <> '' THEN
                        VALIDATE("Unit of Measure Code", Barcodes."Unit of Measure Code");
                    Barcode := Barcodes."Barcode No.";
                    IF Qty <> 0 THEN
                        VALIDATE(Quantity, Qty);
                END
                ELSE BEGIN
                    IF Item.GET(Barcode) THEN BEGIN
                        VALIDATE("Item No.", Item."No.");
                        Barcode := Item."No.";
                        VALIDATE(Quantity, 1);
                    END
                    ELSE
                        VALIDATE("Item No.", Barcode);
                END;
            end;
        }
        field(70005; "Retail Product Code"; Code[20])
        {
            Caption = 'Retail Product Code';
            TableRelation = "LSC Retail Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70006; "Inv. Adjust Group"; Code[10])
        {
            Caption = 'Inv. Adjust Group';
            TableRelation = "LSC Inventory Adjustment Group";
            DataClassification = ToBeClassified;
        }
        field(70007; Division; Code[10])
        {
            Caption = 'Division';
            TableRelation = "LSC Division";
            DataClassification = ToBeClassified;
        }
        field(70008; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(70009; "Promotion No."; Code[20])
        {
            Caption = 'Promotion No.';
            DataClassification = ToBeClassified;
        }
        field(70010; "Create Source"; Option)
        {
            Caption = 'Create Source';
            OptionMembers = Manual,Batch,"RF-live","RF-TransQ";
            DataClassification = ToBeClassified;
        }
        field(70011; "Create DateTime"; DateTime)
        {
            Caption = 'Create DateTime';
            DataClassification = ToBeClassified;
        }
        field(70012; "Create UserID"; Code[50])
        {
            Caption = 'Create UserID';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70013; "Modify Source"; Option)
        {
            Caption = 'Modify Source';
            OptionMembers = Manual,Batch,"RF-live","RF-TransQ";
            DataClassification = ToBeClassified;
        }
        field(70014; "Modify DateTime"; DateTime)
        {
            Caption = 'Modify DateTime';
            DataClassification = ToBeClassified;
        }
        field(70015; "Modify UserID"; Code[50])
        {
            Caption = 'Modify UserID';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70016; "Temp Source"; Option)
        {
            Caption = 'Temp Source';
            OptionMembers = None,Manual,Batch,"RF-live","RF-TransQ";
            DataClassification = ToBeClassified;
        }
        field(70017; "Temp UserID"; Code[50])
        {
            Caption = 'Temp UserID';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70018; "InStore-Created Entry"; Boolean)
        {
            Caption = 'InStore-Created Entry';
            DataClassification = ToBeClassified;
        }
        field(70019; "Standalone Store Action"; Option)
        {
            Caption = 'Standalone Store Action';
            OptionMembers = " ","No Mirroring",Opposite,"Stock Count";
            DataClassification = ToBeClassified;
        }
        field(70020; "BO Doc. No."; Code[100])
        {
            Caption = 'BO Doc. No.';
            DataClassification = ToBeClassified;
        }

    }
}
