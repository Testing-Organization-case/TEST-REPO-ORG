page 70037 TabletUsersByID
{
    APIGroup = 'DMS';
    APIPublisher = 'NWMM';
    APIVersion = 'v1.0';
    Caption = 'TabletUsersByID';
    DataCaptionFields = ID;
    EntityName = 'TabletUsersByID';
    EntitySetName = 'TabletUsersByID';
    ODataKeyFields = ID;
    DelayedInsert = true;           // add for API type
    PageType = API;
    SourceTable = "Tablet User";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Rec.ID)
                {
                }
                field(username; Rec."User Name")
                {
                }
                field(password; Rec.Password)
                {
                }
                field(imeinumber; Rec."IMEI Number")
                {
                    Caption = 'IMEI Number';
                }
                field(email; Rec.Email)
                {
                }
                field(image; Rec.Image)
                {
                }
                field(phonenumber; Rec."Phone Number")
                {
                }
                field(address; Rec.Address)
                {
                }
                field(usertype; Rec."User Type")
                {
                }
                field(checkimei; Rec."Check IMEI")
                {
                }
                field(address2; Rec."Address 2")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        TabletUserL: Record "Tablet User";
    begin
    end;

    trigger OnDeleteRecord(): Boolean
    var
        TabletUserL: Record "Tablet User";
    begin
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin


        Rec.ID := CreateGuid;
        Rec.Insert(true);
        Rec.Modify(true);
        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    var
        TabletUserL: Record "Tablet User";
    begin

        TabletUserL.Reset;
        TabletUserL.SetRange(ID, Rec.ID);
        TabletUserL.FindFirst;
        if (Rec."User Name" <> TabletUserL."User Name") then begin
            TabletUserL.TransferFields(Rec, false);
            TabletUserL.Rename(Rec."User Name");
            Rec.TransferFields(TabletUserL);
        end;
    end;

    trigger OnOpenPage()
    begin

        UserNameFilterG := Rec.GetFilter("User Name");
        PasswordFilterG := Rec.GetFilter(Password);
        if PasswordFilterG <> '' then begin
            PasswordFilterG := APICalculatePassword(CopyStr(PasswordFilterG, 1, 30), UserNameFilterG);
            Rec.SetFilter(Password, '%1', PasswordFilterG);
        end;

        CheckIMEINumberG := false;

        TabletUserG.Reset;
        TabletUserG.SetRange("User Name", UserNameFilterG);
        if TabletUserG.FindFirst then begin
            CheckIMEINumberG := TabletUserG."Check IMEI";
        end;

        if not CheckIMEINumberG then begin
            Rec.SetFilter("IMEI Number", '%1|<>%2', '', '');
        end;
    end;

    var
        TempFieldBuffer: Record "Field Buffer" temporary;
        PublisherG: Text;
        CurrentGroupG: Integer;
        PasswordFilterG: Text;
        UserNameFilterG: Text;
        TabletUserG: Record "Tablet User";
        CheckIMEINumberG: Boolean;

    [Scope('OnPrem')]
    procedure APICalculatePassword(Input: Text[30]; UserName: Text[50]) HashedValue: Text[250]
    var
        Convert: DotNet Convert;

        //CryptoProvider: DotNet SHA512Managed;
        CryptoProvider: DotNet SHA512Managed;

        Encoding: DotNet Encoding;

    begin
        CryptoProvider := CryptoProvider.SHA512Managed;
        HashedValue := Convert.ToBase64String(CryptoProvider.ComputeHash(Encoding.Unicode.GetBytes(Input + UserName)));
        CryptoProvider.Clear;
        CryptoProvider.Dispose;
    end;

    [ServiceEnabled]
    procedure TabletLogout(): Text
    begin
        exit('TTT');
    end;

    local procedure ReturnNow(): Text
    begin
        exit('test');
    end;

    [Scope('OnPrem')]
    procedure SetActionResponse(var ActionContext: WebServiceActionContext; var TabletUser: Record "Tablet User")
    var
        ODataActionManagement: Codeunit "OData Action Management";
    begin
        // ODataActionManagement.AddKey(Rec.FieldNo(ID), Rec.ID);
        // ODataActionManagement.SetUpdatedPageResponse(ActionContext, PAGE::TabletUsersByID)
        ActionContext.SetObjectType(ObjectType::Page);
        ActionContext.SetObjectId(Page::TabletUsersByID);
        ActionContext.AddEntityKey(Rec.FieldNo(Id), Rec.ID);
        ActionContext.SetResultCode(WebServiceActionResultCode::Deleted);
    end;

    [ServiceEnabled]
    procedure TabletLogin() TokenR: Text
    var
        DMSActiveSessionL: Record "DMS Active Sessions";
        SessionTimeOutMinutesL: Integer;
        DMSSetupL: Record "DMS Setup";

    begin
        TokenR := '';


        if Rec.Count > 0 then begin

            DMSActiveSessionL.Reset;
            DMSActiveSessionL.SetRange("User Name", Rec."User Name");
            DMSActiveSessionL.SetRange("User ID", Rec.ID);
            DMSActiveSessionL.SetFilter("Expired At", '>%1', CurrentDateTime);
            if DMSActiveSessionL.Count > 0 then begin
                DMSActiveSessionL.FindFirst;
                TokenR := DMSActiveSessionL.Token;
            end
            else begin
                DMSActiveSessionL.DeleteAll;


                SessionTimeOutMinutesL := 10;

                DMSSetupL.Get;

                if DMSSetupL."Session Timeout Interval" > 0 then begin
                    SessionTimeOutMinutesL := DMSSetupL."Session Timeout Interval";
                end;




                DMSActiveSessionL.Init;
                DMSActiveSessionL.GenerateID;
                DMSActiveSessionL.Token := DMSActiveSessionL.GenerateToken;
                DMSActiveSessionL."User ID" := Rec.ID;
                DMSActiveSessionL."User Name" := Rec."User Name";
                DMSActiveSessionL."IMEI Number" := Rec."IMEI Number";
                DMSActiveSessionL."Login At" := CurrentDateTime;
                DMSActiveSessionL."Expired At" := CurrentDateTime + (SessionTimeOutMinutesL * 60 * 1000);
                DMSActiveSessionL.Insert;

                TokenR := DMSActiveSessionL.Token;

            end;


            //    SetActionResponse(ActionContext,Rec);
        end; // IF Rec.COUNT > 0 THEN

        exit(TokenR);
    end;
}


dotnet
{
    assembly(mscorlib)
    {
        type(System.Convert; Convert) { }
        type(System.Security.Cryptography.SHA512Managed; SHA512Managed) { }


    }



}




