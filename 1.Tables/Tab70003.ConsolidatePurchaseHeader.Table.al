table 70003 "Consolidate Purchase Header"
{
    LookupPageID = "Consolidate PO List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ConPOLine: Record "Consolidate Purchase Line";
                ConPoDetailLine: Record "Consolidate PO Detail Line";
            begin
                if "No." <> xRec."No." then begin
                    RMSetup.Get;
                    NoSeriesMgt.TestManual(RMSetup."CPO No.");
                    "No. Series" := '';
                end;

                Rec.Reset;
                Rec.SetRange("No.", "No.");
                if Rec.FindSet then
                    repeat
                        Rec.Delete;
                    until Rec.Next = 0;


                ConPOLine.Reset;
                ConPOLine.SetRange("Document No.", Rec."No.");
                if ConPOLine.FindSet then
                    repeat
                        ConPOLine.Delete;
                    until ConPOLine.Next = 0;

                ConPoDetailLine.Reset;
                ConPoDetailLine.SetRange("Document No.", Rec."No.");
                if ConPoDetailLine.FindSet then
                    repeat
                        ConPoDetailLine.Delete;
                    until ConPoDetailLine.Next = 0;
            end;
        }
        field(2; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(3; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "External Document No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "FOC PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Consolidate Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Consolidate Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Location Code"; Code[250])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                NoOnLookUp;
            end;

            trigger OnValidate()
            var
                LocationR: Record Location;
            begin
            end;
        }
        field(10; "Total Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Total Line Amount Excl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Comment; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Invoice Discount %"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Invoice Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "0% Invoice Discount"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Posting Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            RMSetup.Get;
            RMSetup.TestField("CPO No.");
            NoSeriesMgt.InitSeries(RMSetup."CPO No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        RMSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ConPOHeader: Record "Consolidate Purchase Header";
        OldConPOHeader: Record "Consolidate Purchase Header";

    local procedure NoOnLookUp()
    var
        LocationR: Record Location;
        PeriodicDiscountLine: Record "LSC Periodic Discount Line";
        //BOUtils: Codeunit "LSC BO Utils";
        CuzFunction: Codeunit CustomizeFunctions;   // Change 'LSC BO Utils' to 'CustomizeFunctions' //Jan/25/2024
    begin

        LocationR.Reset;
        if "Location Code" <> '' then begin
            LocationR.SetRange(Code, "Location Code");
            //LS-12255 IF ProductGroup.FIND('-') THEN;
            if LocationR.FindFirst then;  //LS-12255
        end;
        LocationR.Reset;
        LocationR.Code := "Location Code";


        if PAGE.RunModal(CuzFunction.getLookupForm(15), LocationR) = ACTION::LookupOK then begin        // Change 'LSC BO Utils' to 'CustomizeFunctions' //Jan/25/2024
            //PeriodicDiscountLine."Prod. Group Category" := ProductGroup."Item Category Code";
            "Location Code" := LocationR.Code;


        end;

        //END;


        // Validate("Location Code");
    end;

    procedure AssistEdit(OldConPOHeader: Record "Consolidate Purchase Header"): Boolean
    begin

        with ConPOHeader do begin
            ConPOHeader := Rec;
            RMSetup.Get;
            RMSetup.TestField("CPO No.");
            if NoSeriesMgt.SelectSeries(RMSetup."CPO No.", OldConPOHeader."No. Series", "No. Series") then begin
                RMSetup.Get;
                RMSetup.TestField("CPO No.");
                NoSeriesMgt.SetSeries("No.");
                Rec := ConPOHeader;
                exit(true);
            end;
        end;
    end;
}

