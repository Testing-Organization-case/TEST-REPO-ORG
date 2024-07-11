tableextension 70089 "LSC Barcodes Extension" extends "LSC Barcodes"
{
    fields
    {
        field(70000; "Barcode Active"; Boolean)
        {
            Caption = 'Barcode Active';
            DataClassification = ToBeClassified;
        }
        field(70001; ID; Guid)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
        field(70002; "Last Modified User"; Code[50])
        {
            Caption = 'Last Modified User';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    procedure CreateAction(Type: Integer)
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
        ActionsMgt: Codeunit "LSC Actions Management";
    begin
        //CreateActions
        //Type: 0 = INSERT, 1 = MODIFY, 2 = DELETE, 3 = RENAME
        RecRef.GETTABLE(Rec);
        xRecRef.GETTABLE(xRec);
        ActionsMgt.SetCalledByTableTrigger(TRUE);
        ActionsMgt.CreateActionsByRecRef(RecRef, xRecRef, Type);
        RecRef.CLOSE;
    end;

    trigger OnInsert()
    begin
        CreateAction(0);
        Rec.ID := CREATEGUID;
        Rec."Last Modified User" := USERID;
    end;

    trigger OnModify()
    begin
        CreateAction(1);
        "Last Modified User" := USERID;
    end;

    trigger OnDelete()
    begin
        CreateAction(2);
    end;

    trigger OnRename()
    begin
        CreateAction(3);
        "Last Modified User" := USERID;
    end;
}
