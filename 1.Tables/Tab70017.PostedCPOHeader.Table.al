dotnet
{
    assembly(mscorlib)
    {
        type(System.IO.BinaryReader; BinaryReader) { }
        type(System.IO.BinaryWriter; BinaryWriter) { }
        type(System.Text.Encoding; Encoding) { }


    }

}
table 70017 "Posted CPO Header"
{

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

    trigger OnDelete()
    begin
        ConPOLine.Reset;
        ConPOLine.SetRange("Document No.", Rec."No.");
        if ConPOLine.FindSet then
            repeat
                ConPOLine.DeleteAll;
            until ConPOLine.Next = 0;

        ConPODetailLines.Reset;
        ConPODetailLines.SetRange("Document No.", Rec."No.");
        if ConPODetailLines.FindSet then
            repeat
                ConPODetailLines.DeleteAll;
            until ConPODetailLines.Next = 0;

        PurchHeader.Reset;
        PurchHeader.SetRange("CPO Confirm", true);
        PurchHeader.SetRange("CPO No.", Rec."No.");
        if PurchHeader.FindSet then
            repeat
                PurchHeader."CPO Confirm" := false;
                PurchHeader."CPO No." := '';
                PurchHeader.Modify(true);
            until PurchHeader.Next = 0;
    end;

    var
        InStr: InStream;
        BinaryReader: DotNet BinaryReader;
        BinaryWriter: DotNet BinaryWriter;
        Encoding: DotNet Encoding;
        MyText: Text;
        InputLongTextTest: Page InputLongTextTest;
        NewText: Text;
        OutStr: OutStream;
        ConPODetailLines: Record "Consolidate PO Detail Line";
        ConPOLine: Record "Posted CPO Lines";
        PurchHeader: Record "Purchase Header";

}

