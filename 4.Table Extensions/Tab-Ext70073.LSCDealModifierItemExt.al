tableextension 70073 "LSC Deal Modifier Item Ext" extends "LSC Deal Modifier Item"
{
    procedure CreateAction(Type: Integer)
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
        ActionsMgt: Codeunit "LSC Actions Management";
    begin
        //CreateAction
        //Type: 0 = INSERT, 1 = MODIFY, 2 = DELETE, 3 = RENAME
        RecRef.GETTABLE(Rec);
        xRecRef.GETTABLE(xRec);
        ActionsMgt.SetCalledByTableTrigger(TRUE);
        ActionsMgt.CreateActionsByRecRef(RecRef, xRecRef, Type);
        RecRef.CLOSE;
        xRecRef.CLOSE;
    end;

    trigger OnInsert()
    begin
        CreateAction(0);
    end;

    trigger OnModify()
    begin
        CreateAction(1);
    end;

    trigger OnDelete()
    begin
        CreateAction(2);
    end;

    trigger OnRename()
    begin
        CreateAction(3);
    end;
}

