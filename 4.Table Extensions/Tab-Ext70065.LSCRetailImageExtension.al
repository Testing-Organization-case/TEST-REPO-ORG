tableextension 70065 "LSC Retail Image Extension" extends "LSC Retail Image"
{
    fields
    {
        field(70000; "Image Name"; Text[100])
        {
            Caption = 'Image Name';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        //"Last Date Modified" := CREATEDATETIME(TODAY, TIME);
        SystemModifiedAt := CREATEDATETIME(TODAY, TIME);
        CreateAction(0);
        UpdateImageBlob;
        UpdateItemPicture(0);
    end;

    trigger OnModify()
    begin
        //"Last Date Modified" := CREATEDATETIME(TODAY, TIME);
        SystemModifiedAt := CREATEDATETIME(TODAY, TIME);
        CreateAction(1);
        UpdateImageBlob;
        UpdateItemPicture(1);
    end;

    trigger OnRename()
    begin
        //"Last Date Modified" := CREATEDATETIME(TODAY,TIME);
        SystemModifiedAt := CREATEDATETIME(TODAY, TIME);
        CreateAction(3);
        RenameUris();
    end;

    procedure CreateAction(Type: Integer)
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
        ActionsMgt: Codeunit "LSC Actions Management";
    begin
        //Type: 0 = INSERT, 1 = MODIFY, 2 = DELETE, 3 = RENAME
        RecRef.GETTABLE(Rec);
        xRecRef.GETTABLE(xRec);
        ActionsMgt.SetCalledByTableTrigger(TRUE);
        ActionsMgt.CreateActionsByRecRef(RecRef, xRecRef, Type);
        RecRef.CLOSE;
        xRecRef.CLOSE;
    end;

    procedure RenameUris()
    var
        OldUri: Text;
        NewUri: Text;
        POSSession: Codeunit "LSC POS Session";
        RecRef: RecordRef;
        xRecRef: RecordRef;

    begin
        RecRef.GETTABLE(Rec);
        xRecRef.GETTABLE(xRec);
        OldUri := POSSession.GetImageURL(xRecRef.RECORDID, 4);
        NewUri := POSSession.GetImageURL(RecRef.RECORDID, 4);

        RenameInTable(OldUri, NewUri, DATABASE::"LSC POS Media Playlist Line", 3);
        RenameInTable(OldUri, NewUri, DATABASE::"LSC POS Menu Line", 917);
        RenameInTable(OldUri, NewUri, DATABASE::"LSC Search Index Table", 30);
        RenameInTable(OldUri, NewUri, DATABASE::"LSC POS Menu Header", 62);
        RenameInTable(OldUri, NewUri, DATABASE::"LSC Dining Area Layout", 21);
    end;

    procedure RenameInTable(OldUri: Text; NewUri: Text; TableNo: Integer; FieldNo: Integer)
    var
        RecRef: RecordRef;
        FieldRef: fieldref;

    begin
        RecRef.OPEN(TableNo);
        FieldRef := RecRef.FIELD(FieldNo);
        FieldRef.SETFILTER(OldUri);
        IF RecRef.FIND('-') THEN
            REPEAT
                FieldRef := RecRef.FIELD(FieldNo);
                FieldRef.VALUE := NewUri;
                RecRef.MODIFY;
            UNTIL RecRef.NEXT = 0;
    end;

    procedure UpdateImageBlob()
    var
        TenantMedia: Record "Tenant Media";
    begin
        ReturnTenantMediaRec(TenantMedia);
        IF TenantMedia.Content.HASVALUE THEN
            "Image Blob" := TenantMedia.Content;
    end;

    procedure UpdateItemPicture(Type: Integer)
    var
        Item: Record Item;
        RetailImageLinkTemp: Record "LSC Retail Image Link";
        RetailImageLink: Record "LSC Retail Image Link";
        TableNo: Integer;
    begin
        //UpdateItemPicture
        //Type: 0 = INSERT, 1 = MODIFY, 2 = DELETE, 3 = RENAME
        RetailImageLinkTemp.RESET;
        RetailImageLinkTemp.DELETEALL;

        RetailImageLink.SETCURRENTKEY("Image Id");
        RetailImageLink.SETRANGE("Image Id", Code);
        IF RetailImageLink.FINDSET THEN
            REPEAT
                TableNo := Rec.ReturnTableNo(RetailImageLink.TableName);
                IF (TableNo = 27) AND (RetailImageLink."Display Order" = 0) THEN BEGIN
                    RetailImageLinkTemp.INIT;
                    RetailImageLinkTemp := RetailImageLink;
                    RetailImageLinkTemp.INSERT;
                END;
            UNTIL RetailImageLink.NEXT = 0;

        RetailImageLinkTemp.RESET;
        IF RetailImageLinkTemp.FINDSET THEN
            REPEAT
                IF Item.GET(RetailImageLinkTemp.KeyValue) THEN BEGIN
                    IF Type = 2 THEN BEGIN
                        CLEAR(Item.Picture);
                        Item.MODIFY(TRUE);
                    END ELSE BEGIN
                        IF "Image Mediaset".COUNT > 0 THEN BEGIN
                            Item.Picture := "Image Mediaset";
                            Item.MODIFY(TRUE);
                        END;
                    END;
                END;
            UNTIL RetailImageLinkTemp.NEXT = 0;
    end;

    procedure ReturnTableNo(TableName: Text): Integer
    var
        Object_l: Record AllObjWithCaption;
    begin
        Object_l.RESET;
        //LS-9791 Object_l.SETRANGE(Type,Object_l.Type::Table);
        //LS-9791 Object_l.SETRANGE(Name,TableName);
        Object_l.SETRANGE("Object Type", Object_l."Object Type"::Table);//LS-9791
        Object_l.SETRANGE("Object Name", TableName);//LS-9791
        IF Object_l.FINDFIRST THEN
            //LS-9791  EXIT(Object_l.ID);
            EXIT(Object_l."Object ID");//LS-9791
    end;
}
