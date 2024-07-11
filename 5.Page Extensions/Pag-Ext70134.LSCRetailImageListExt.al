pageextension 70134 "LSC Retail Image List Ext" extends "LSC Retail Image List"
{
    layout
    {
        addafter(Code)
        {
            // field(Type; Rec.Type)
            // {
            //     ApplicationArea = All;
            // }
        }
        addafter("Image Mediaset")
        {
            field("Image Name"; Rec."Image Name")
            {
                ApplicationArea = ALl;
            }
        }
    }
    /*actions
    {
        addafter("Where Used")
        {
            action("Upload Images by Name")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                trigger OnAction()
                var
                    FileMgmtL: Codeunit "File Management";
                    ClientFileNameL: Text;
                    FileL: Text;
                    ClientFolderPathL: Text;
                    ClientFileToTempBuffer: Record "Name/Value Buffer";
                    RetailImageL: Record "LSC Retail Image";
                    Instream: InStream;
                    ServerFolderNameL: Text;
                    ServerFileToTempBufferL: Record "Name/Value Buffer";
                    ServerFileNameL: Text;
                    TempServerFileNameL: Text;
                    DialogBoxL: Dialog;
                    NextL: Integer;
                    NoOfRecordL: Integer;
                    ProgressBarL: Text;
                    Msg1: Text;
                    Msg2: Text;
                begin
                    ClientFolderPathL := FileMgmtL.BrowseForFolderDialog('Choose Folder to upload', '*.*', TRUE);

                    IF (ClientFolderPathL <> '') AND (ClientFolderPathL <> '*.*') THEN BEGIN
                        NextL := 0;
                        NoOfRecordL := 0;
                        ClientFileToTempBuffer.RESET;
                        ClientFileToTempBuffer.DELETEALL;
                        FileMgmtL.GetClientDirectoryFilesList(ClientFileToTempBuffer, ClientFolderPathL);

                        // Client Folder to Server Folder
                        IF NOT FileMgmtL.ServerDirectoryExists(TEMPORARYPATH + 'Retail Image') THEN BEGIN
                            FileMgmtL.ServerCreateDirectory(TEMPORARYPATH + 'Retail Image');
                        END;
                        ServerFolderNameL := TEMPORARYPATH + 'Retail Image\';


                        NoOfRecordL := ClientFileToTempBuffer.COUNT;
                        Msg1 := 'Buffer ID : #1######\';
                        Msg2 := 'File Name : #2######\';
                        ProgressBarL := 'Client to Server Process from 0 to ' + FORMAT(NoOfRecordL) + '@3@@@@@@';
                        DialogBoxL.OPEN(Msg1 + Msg2 + ProgressBarL);

                        IF ClientFileToTempBuffer.FINDSET THEN
                            REPEAT
                                TempServerFileNameL := FileMgmtL.UploadFileSilentToServerPath(ClientFileToTempBuffer.Name, ServerFolderNameL);
                                FileMgmtL.MoveFile(TempServerFileNameL, ServerFolderNameL + FileMgmtL.GetFileName(ClientFileToTempBuffer.Name));


                                NextL := NextL + 1;
                                DialogBoxL.UPDATE(1, ClientFileToTempBuffer.ID);
                                DialogBoxL.UPDATE(2, FileMgmtL.GetFileName(ClientFileToTempBuffer.Name));

                                IF NoOfRecordL <= 100 THEN
                                    DialogBoxL.UPDATE(3, (NextL / NoOfRecordL * 10000) DIV 1)
                                ELSE
                                    IF NextL MOD (NoOfRecordL DIV 100) = 0 THEN
                                        DialogBoxL.UPDATE(3, (NextL / NoOfRecordL * 10000) DIV 1);

                            UNTIL ClientFileToTempBuffer.NEXT = 0;

                        IF ServerFolderNameL <> '' THEN BEGIN
                            NextL := 0;
                            NoOfRecordL := 0;
                            ServerFileToTempBufferL.RESET;
                            ServerFileToTempBufferL.DELETEALL;
                            FileMgmtL.GetClientDirectoryFilesList(ServerFileToTempBufferL, ServerFolderNameL);

                            NoOfRecordL := ServerFileToTempBufferL.COUNT;
                            Msg1 := 'Buffer ID : #1######\';
                            Msg2 := 'File Name : #2######\';
                            ProgressBarL := 'Server to Retail Image Process from 0 to ' + FORMAT(NoOfRecordL) + '@3@@@@@@';
                            DialogBoxL.OPEN(Msg1 + Msg2 + ProgressBarL);

                            IF ServerFileToTempBufferL.FINDSET THEN
                                REPEAT
                                    ServerFileNameL := FileMgmtL.GetFileName(ServerFileToTempBufferL.Name);
                                    ServerFileNameL := ReplaceString(ServerFileNameL, '.jpg', '');
                                    ServerFileNameL := ReplaceString(ServerFileNameL, '.png', '');
                                    ServerFileNameL := ReplaceString(ServerFileNameL, '.tif', '');
                                    ServerFileNameL := ReplaceString(ServerFileNameL, '.jpeg', '');
                                    ServerFileNameL := ReplaceString(ServerFileNameL, '.jfif', '');
                                    ServerFileNameL := ReplaceString(ServerFileNameL, '.gif', '');

                                    RetailImageL.RESET;
                                    RetailImageL.SETFILTER("Image Name", '%1', ServerFileNameL);
                                    IF RetailImageL.FINDFIRST THEN BEGIN
                                        FileL.OPEN(ServerFileToTempBufferL.Name);
                                        FileL.CREATEINSTREAM(Instream);

                                        CLEAR(RetailImageL."Image Mediaset");
                                        RetailImageL."Image Mediaset".IMPORTSTREAM(Instream, ServerFileToTempBufferL.Name);
                                        RetailImageL."Image Location" := ServerFileToTempBufferL.Name;
                                        RetailImageL."Image Blob".CREATEINSTREAM(Instream);
                                        RetailImageL.MODIFY(TRUE);

                                        FileL.CLOSE;
                                    END; // IF RetailImageL.FINDFIRST THEN

                                    NextL := NextL + 1;
                                    DialogBoxL.UPDATE(1, ServerFileToTempBufferL.ID);
                                    DialogBoxL.UPDATE(2, FileMgmtL.GetFileName(ServerFileToTempBufferL.Name));

                                    IF NoOfRecordL <= 100 THEN
                                        DialogBoxL.UPDATE(3, (NextL / NoOfRecordL * 10000) DIV 1)
                                    ELSE
                                        IF NextL MOD (NoOfRecordL DIV 100) = 0 THEN
                                            DialogBoxL.UPDATE(3, (NextL / NoOfRecordL * 10000) DIV 1);

                                    FileMgmtL.DeleteServerFile(ServerFileToTempBufferL.Name);
                                UNTIL ServerFileToTempBufferL.NEXT = 0;
                        END; // IF ServerFolderNameL <> '' THEN
                    END; // IF ClientFolderPathL <> '' THEN

                end;
            }

        }
    }*/
    procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250]
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;
}
