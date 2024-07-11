page 70039 "APIs List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = APIs;
    UsageCategory = Lists;
    ApplicationArea = ALl;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    Visible = false;
                }
                field("Page ID"; Rec."Page ID")
                {
                }
                field("API Name"; Rec."API Name")
                {
                }
                field(Route; Rec.Route)
                {
                }
                field(HTTP; Rec.HTTP)
                {
                }
                field(HTTPS; Rec.HTTPS)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Generate APIs")
            {
                Caption = 'Generate APIs';
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    GenerateAPIs;
                end;
            }
            action("Clear API")
            {
                Caption = 'Clear API';
                Image = RemoveLine;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    ClearAPIs;
                end;
            }
        }
    }

    local procedure GenerateAPIs()
    var
        AllObjWithCaptionL: Record AllObjWithCaption;
        APIsL: Record APIs;
        TabletUsersByIDL: Page TabletUsersByID;
        RecordRefL: RecordRef;
        TEST: Record "Key";
        PageMetaDataL: Record "Page Metadata";
        DMSSetupL: Record "DMS Setup";
        SessionL: Record Session;
        ODataUtilityL: Codeunit ODataUtility;
        DMSAPIMgmtL: Codeunit "DMS - API Management";
        HttpL: Text;
        HttpsL: Text;
        WebServicePortL: Text;
        CurrentCompanyL: Record Company;
        CompanyGUID: Text;
        ServerInstanceL: Record "Server Instance";
        CompanyName: Text;
        ServerNameL: Code[50];
        InstanceNameL: Code[50];
    begin


        if not Confirm('Are you sure!') then begin
            exit;
        end;


        // @09_Jul_2021_03_50_PM

        GenerateODATA_API;

        APIsL.Reset;
        APIsL.DeleteAll;

        AllObjWithCaptionL.Reset;

        DMSSetupL.Reset;
        DMSSetupL.Get;

        DMSSetupL.ValidateFields;


        if DMSSetupL."API Port" = 0 then begin
            WebServicePortL := DMSAPIMgmtL.GetWebServicePort;
        end
        else begin
            WebServicePortL := Format(DMSSetupL."API Port");
        end;

        CurrentCompanyL.Reset;
        CurrentCompanyL.SetRange(Name, Rec.CurrentCompany);
        if CurrentCompanyL.FindFirst then begin
            CompanyGUID := CurrentCompanyL.Id;
            CompanyName := CurrentCompanyL.Name;
        end; // IF CurrentCompanyL.FINDFIRST THEN


        if CompanyGUID <> '' then begin
            CompanyGUID := DMSAPIMgmtL.ReplaceString(CompanyGUID, '{', '');
            CompanyGUID := DMSAPIMgmtL.ReplaceString(CompanyGUID, '}', '');
        end;


        if DMSSetupL."Server Name" = '' then begin
            ServerInstanceL.Reset;
            if ServerInstanceL.FindFirst then begin
                ServerNameL := ServerInstanceL."Server Computer Name";
            end;
        end
        else begin
            ServerNameL := DMSSetupL."Server Name";
        end;

        if DMSSetupL."Instance Name" = '' then begin
            ServerInstanceL.Reset;
            if ServerInstanceL.FindFirst then begin
                InstanceNameL := ServerInstanceL."Server Instance Name";
            end;
        end
        else begin
            InstanceNameL := DMSSetupL."Instance Name";
        end;

        // http://mmkteamleader:9048/BC140/ODataV4/Company('CRONUS%20International%20Ltd.')/TabletUsersByID
        // ODATA API
        HttpL := 'http://' + ServerNameL + ':' + WebServicePortL + '/' + InstanceNameL + '/ODataV4' + '/Company(''' + CompanyName + ''')';
        HttpsL := 'https://' + ServerNameL + ':' + WebServicePortL + '/' + InstanceNameL + '/ODataV4' + '/Company(''' + CompanyName + ''')';

        PageMetaDataL.Reset;
        PageMetaDataL.SetRange(APIPublisher, DMSSetupL.APIPublisher);
        PageMetaDataL.SetRange(APIGroup, DMSSetupL.APIGroup);
        PageMetaDataL.SetRange(APIVersion, DMSSetupL.APIVersion);
        if PageMetaDataL.FindSet then
            repeat
                HttpL += '/' + PageMetaDataL.EntityName;
                HttpsL += '/' + PageMetaDataL.EntityName;

                APIsL.Reset;

                APIsL.Init;
                APIsL.GenerateID;
                APIsL."API Name" := PageMetaDataL.EntityName;
                APIsL.Route := PageMetaDataL.EntityName;
                APIsL.HTTP := HttpL;
                APIsL.HTTPS := HttpsL;
                APIsL."Page ID" := PageMetaDataL.ID;
                APIsL.Insert;
            until PageMetaDataL.Next = 0;
    end;

    local procedure ClearAPIs()
    var
        APIsL: Record APIs;
    begin

        if not Confirm('Do you want to remove all APIs?') then
            exit;
        APIsL.Reset;
        APIsL.DeleteAll;
    end;

    local procedure GenerateODATA_API()
    var
        PageMetaDataL: Record "Page Metadata";
        DMSSetupL: Record "DMS Setup";
        WebServiceL: Record "Web Service";
    begin


        DMSSetupL.Get;

        PageMetaDataL.Reset;
        PageMetaDataL.SetRange(APIPublisher, DMSSetupL.APIPublisher);
        PageMetaDataL.SetRange(APIGroup, DMSSetupL.APIGroup);
        PageMetaDataL.SetRange(APIVersion, DMSSetupL.APIVersion);
        if PageMetaDataL.FindSet then
            repeat
                WebServiceL.Reset;
                WebServiceL.SetRange("Object ID", PageMetaDataL.ID);
                WebServiceL.SetRange("Object Type", WebServiceL."Object Type"::Page);
                if WebServiceL.Count = 0 then begin
                    WebServiceL.Init;
                    WebServiceL."Object ID" := PageMetaDataL.ID;
                    WebServiceL."Object Type" := WebServiceL."Object Type"::Page;
                    WebServiceL.Validate("Service Name", PageMetaDataL.EntityName);
                    WebServiceL.Validate(Published, true);
                    WebServiceL.Insert;
                end;
            until PageMetaDataL.Next = 0;
    end;
}

