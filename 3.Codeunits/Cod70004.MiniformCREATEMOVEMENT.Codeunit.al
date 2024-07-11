

dotnet
{
    assembly(System.Xml)
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';
        type(System.Xml.XmlDocument; XmlDocument) { }
        type(System.Xml.XmlNode; XmlNode) { }
    }

}

codeunit 70004 "Miniform - CREATEMOVEMENT"
{
    // Permissions = TableData  
    //               TableData "Whse. Worksheet Line" = rimd;
    TableNo = "Miniform Header";

    trigger OnRun()
    var
        MiniformMgmt: Codeunit "Miniform Management";

    begin
        MiniformMgmt.Initialize(
          MiniformHeader, Rec, DOMxmlin, ReturnedNode,
          RootNode, XMLDOMMgt, ADCSCommunication, ADCSUserId,
          CurrentCode, StackCode, WhseEmpId, LocationFilter);


        InitCreateMovement;


        if ADCSCommunication.GetNodeAttribute(ReturnedNode, 'RunReturn') = '0' then begin
            if MiniformHeader.Code <> CurrentCode then
                PrepareData //Without Input
            else
                ProcessInput; //With Input
        end else
            PrepareData;

        Clear(DOMxmlin);
    end;

    var
        Text001: Label 'Invalid User ID.';
        Text002: Label 'Invalid Password.';
        Text003: Label 'No input Node found.';
        Text004: Label 'Record not found.';
        MiniformHeader: Record "Miniform Header";
        MiniformHeader2: Record "Miniform Header";
        ADCSUser: Record "ADCS User";
        XMLDOMMgt: Codeunit "XML DOM Management";
        ADCSCommunication: Codeunit "ADCS Communication";
        ADCSMgt: Codeunit "ADCS Management";
        RecRef: RecordRef;
        DOMxmlin: DotNet XmlDocument;
        RootNode: DotNet XmlNode;
        ReturnedNode: DotNet XmlNode;

        ADCSUserId: Text[250];
        WhseEmpId: Text[250];
        LocationFilter: Text[250];
        CurrentCode: Text[250];
        StackCode: Text[250];
        ActiveInputField: Integer;
        "+++Movement Worksheet+++": Integer;
        LotNoG: Text[100];
        FromZoneG: Text[100];
        FromBinG: Text[100];
        ToZoneG: Text[100];
        ToBinG: Text[100];
        QuantityG: Decimal;
        ItemNoG: Text[100];
        ErrorText: Text;
        VariantCodeG: Text[100];
        LotNoExternalG: Text[100];
        WhseWkshLineTemp: Record "Whse. Worksheet Line" temporary;
        ItemDescriptionG: Text;
        "---Movement Worksheet---": Integer;
        WorksheetName: Text;
        WorksheetTemplateName: Text;
        CreateMovementG: Record CreateMovementLinkTable;
        UOMCodeG: Code[20];
        UpKeyOn: Boolean;

    local procedure "+++ ADCS +++"()
    begin
    end;

    local procedure ProcessInput()
    var
        FuncGroup: Record "Miniform Function Group";
        RecId: RecordID;
        TableNo: Integer;
        FldNo: Integer;
        TextValue: Text[250];
        WhseWorksheetLine: Record "Whse. Worksheet Line";
        WarehouseEntryL: Record "Warehouse Entry";
        ItemL: Record Item;
    begin


        ItemDescriptionG := '';
        LotNoG := '';
        ItemNoG := '';
        FromZoneG := '';
        FromBinG := '';
        ToZoneG := '';
        ToBinG := '';
        QuantityG := 0;

        CreateMovementG.Reset;
        CreateMovementG.SetCurrentKey("ADCS User ID");
        CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
        if CreateMovementG.FindFirst then begin

            //LotNoG := CreateMovementG."Lot No.";
            ItemNoG := CreateMovementG."Item No.";
            FromZoneG := CreateMovementG."From Zone Code";
            FromBinG := CreateMovementG."From Bin Code";
            ToZoneG := CreateMovementG."To Zone Code";
            ToBinG := CreateMovementG."To Bin Code";
            //QuantityG := CreateMovementG.Quantity;
            //VariantCodeG := CreateMovementG."Variant Code";

            if ItemNoG <> '' then begin
                ItemL.Get(ItemNoG);
                ItemDescriptionG := ItemL.Description;
            end;

            WarehouseEntryL.Reset;
            WarehouseEntryL.SetFilter("Lot No.", LotNoG);
            WarehouseEntryL.SetFilter("Location Code", LocationFilter);
            WarehouseEntryL.SetFilter("Item No.", ItemNoG);
            WarehouseEntryL.SetFilter("Zone Code", FromZoneG);
            WarehouseEntryL.SetFilter("Bin Code", FromBinG);
            if WarehouseEntryL.FindFirst then
              //REPEAT
              begin //Edited by HMA
                VariantCodeG := WarehouseEntryL."Variant Code";
                //SupplierLotNoG := WarehouseEntryL."Supplier Lot No.";
                //NewSupplierLotNoG := SupplierLotNoG;
                //LotNoExternalG := WarehouseEntryL."NWTH Lot No. External";
            end;
            //UNTIL WarehouseEntryL.NEXT = 0;


        end; // IF CreateMovementG.FINDFIRST THEN

        WorksheetName := 'DEFAULT';
        WorksheetTemplateName := 'MOVEMENT';




        if XMLDOMMgt.FindNode(RootNode, 'Header/Input', ReturnedNode) then
            TextValue := ReturnedNode.InnerText
        else
            Error(Text003); // Output Message in  Telnet


        FuncGroup.KeyDef := ADCSCommunication.GetFunctionKey(MiniformHeader.Code, TextValue);

        ErrorText := '';
        UpKeyOn := false;

        ActiveInputField := 1;
        case FuncGroup.KeyDef of
            FuncGroup.KeyDef::Esc:
                begin
                    ResetCreateMovement;
                    ResetWhseWorksheetLine;
                    ResetWhseItemTrackingLine;
                    ADCSCommunication.RunPreviousMiniform(DOMxmlin);
                end;
            FuncGroup.KeyDef::Input:
                begin
                    Evaluate(FldNo, ADCSCommunication.GetNodeAttribute(ReturnedNode, 'FieldID'));
                    case FldNo of


                        //            // NWMM Modified on 26 Oct 2020 11:18 PM by MMK. Not Used
                        CreateMovementG.FieldNo("From Zone Code"):
                            if (UpperCase(TextValue)) = '' then begin
                                Error('%1 must have value!', CreateMovementG.FieldCaption("From Zone Code"));
                            end
                            else begin
                                if not CheckFromZoneCode(TextValue) then begin
                                    Error(ErrorText);
                                end;
                            end; // IF (UPPERCASE(TextValue)) = '' THEN
                                 // NWMM Modified on 26 Oct 2020 11:18 PM by MMK. Not Used
                        CreateMovementG.FieldNo("Item No."):
                            if (UpperCase(TextValue)) = '' then begin
                                Error('%1 must have value!', CreateMovementG.FieldCaption("Item No."));
                            end
                            else begin
                                if not CheckItemNo(TextValue) then begin
                                    Error(ErrorText);
                                end;
                            end; // IF (UPPERCASE(TextValue)) = '' THEN
                                 // NWMM Modified on 26 Oct 2020 11:18 PM by MMK. Not Used

                        //CreateMovementG.FieldNo("Variant Code"):
                        // if (UpperCase(TextValue)) = '' then begin
                        //     //ERROR('%1 must have value!',CreateMovementG.FIELDCAPTION("Variant Code"));
                        // end
                        // else begin
                        //     if not CheckVariantCode(TextValue) then begin
                        //         Error(ErrorText);
                        //     end;
                        // end; // IF (UPPERCASE(TextValue)) = '' THEN

                        // NWMM Modified on 26 Oct 2020 11:18 PM by MMK. Not Used
                        CreateMovementG.FieldNo(UOM):
                            if (UpperCase(TextValue)) = '' then begin
                                Error('%1 must have value!', CreateMovementG.FieldCaption(UOM));
                            end
                            else begin
                                if not CheckUOM(TextValue) then begin
                                    Error(ErrorText);
                                end;
                            end; // IF (UPPERCASE(TextValue)) = '' THEN
                                 // NWMM Modified on 26 Oct 2020 11:18 PM by MMK. Not Used
                        CreateMovementG.FieldNo("From Bin Code"):
                            if (UpperCase(TextValue)) = '' then begin
                                Error('%1 must have value!', CreateMovementG.FieldCaption("From Bin Code"));
                            end
                            else begin
                                if not CheckFromBinCode(TextValue) then begin
                                    Error(ErrorText);
                                end;

                            end; // IF (UPPERCASE(TextValue)) = '' THEN

                        CreateMovementG.FieldNo("To Zone Code"):
                            if (UpperCase(TextValue)) = '' then begin
                                Error('%1 must have value!', CreateMovementG.FieldCaption("To Zone Code"));
                            end
                            else begin
                                if not CheckToZoneCode(TextValue) then begin
                                    Error(ErrorText);
                                end;
                            end; // IF (UPPERCASE(TextValue)) = '' THEN

                        CreateMovementG.FieldNo("To Bin Code"):
                            if (UpperCase(TextValue)) = '' then begin
                                Error('%1 must have value!', CreateMovementG.FieldCaption("To Bin Code"));
                            end
                            else begin

                                if not CheckToBinCode(TextValue) then begin
                                    Error(ErrorText);
                                end
                                else begin
                                    // NWMMM Modified on 26 Oct 2020 10:06 PM by MMK
                                    //RegisterMovement();
                                end;

                            end; // IF (UPPERCASE(TextValue)) = '' THEN
                                 // NWMM Modified on 26 Oct 2020 11:18 PM by MMK. Not Used
                                 // Quantity Not used in Barcode Scanning.
                        CreateMovementG.FieldNo(Quantity):
                            if (UpperCase(TextValue)) = '' then begin
                                Error('%1 must have value!', CreateMovementG.FieldCaption(Quantity));
                            end
                            else begin
                                if not CheckQuantity(TextValue) then begin
                                    Error(ErrorText);
                                end
                                else begin
                                    RegisterMovement();
                                    PackagingInfo;
                                end;
                            end; // IF (UPPERCASE(TextValue)) = '' THEN

                        else begin
                            //          ADCSCommunication.FieldSetvalue(RecRef,FldNo,TextValue);
                        end;

                    end;


                    ActiveInputField := ADCSCommunication.GetActiveInputNo(CurrentCode, FldNo);
                    if ADCSCommunication.LastEntryField(CurrentCode, FldNo) then begin
                        ADCSCommunication.GetNextMiniForm(MiniformHeader, MiniformHeader2);
                        MiniformHeader2.SaveXMLin(DOMxmlin);
                        CODEUNIT.Run(MiniformHeader2."Handling Codeunit", MiniformHeader2);
                    end else
                        ActiveInputField += 1;


                    // Display Value after User Press Enter

                    RecRef.GetTable(CreateMovementG);
                    ADCSCommunication.SetRecRef(RecRef);
                end;

            //Up Key
            FuncGroup.KeyDef::PgUp:
                begin
                    Evaluate(FldNo, ADCSCommunication.GetNodeAttribute(ReturnedNode, 'FieldID'));
                    UpKeyOn := true;
                    // Display Value
                    RecRef.GetTable(CreateMovementG);
                    ADCSCommunication.SetRecRef(RecRef);
                    ActiveInputField := FldNo - 1;
                end;
            //Down Key
            FuncGroup.KeyDef::PgDn:
                begin
                    Evaluate(FldNo, ADCSCommunication.GetNodeAttribute(ReturnedNode, 'FieldID'));
                    UpKeyOn := true;
                    // Display Value
                    RecRef.GetTable(CreateMovementG);
                    ADCSCommunication.SetRecRef(RecRef);
                    ActiveInputField := FldNo + 1;
                end;

        end;

        if not (FuncGroup.KeyDef in [FuncGroup.KeyDef::Esc]) and
          not ADCSCommunication.LastEntryField(CurrentCode, FldNo)
        then
            SendForm(ActiveInputField);
    end;

    local procedure GetUser(TextValue: Text[250]) ReturnValue: Boolean
    begin
        if ADCSUser.Get(TextValue) then begin
            ADCSUserId := ADCSUser.Name;
            ADCSUser.Password := '';
            if not ADCSCommunication.GetWhseEmployee(ADCSUserId, WhseEmpId, LocationFilter) then begin
                ADCSMgt.SendError(Text001);
                ReturnValue := false;
                exit;
            end;
        end else begin
            ADCSMgt.SendError(Text001);
            ReturnValue := false;
            exit;
        end;
        ReturnValue := true;
    end;

    local procedure CheckPassword(TextValue: Text[250]) ReturnValue: Boolean
    begin
        ADCSUser.Get(ADCSUserId);
        if ADCSUser.Password <> ADCSUser.CalculatePassword(CopyStr(TextValue, 1, 30)) then begin
            ADCSMgt.SendError(Text002);
            ReturnValue := false;
            exit;
        end;
        ReturnValue := true;
    end;

    local procedure PrepareData()
    begin
        ActiveInputField := 1;
        SendForm(ActiveInputField);
    end;

    local procedure SendForm(InputField: Integer)
    begin
        ADCSCommunication.EncodeMiniForm(MiniformHeader, StackCode, DOMxmlin, InputField, '', ADCSUserId); //Error
        ADCSCommunication.GetReturnXML(DOMxmlin);
        ADCSMgt.SendXMLReply(DOMxmlin);
    end;

    local procedure "--- ADCS ---"()
    begin
    end;

    local procedure "+++ Warehouse Worksheet+++"()
    begin
    end;

    local procedure CheckLotNo(LotNoText: Text[200]): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        QuantityL: Decimal;
        ItemL: Record Item;
        WarehouseActivityLineL: Record "Warehouse Activity Line";
        PickedQuantityL: Decimal;
        ItemLedgerEntryL: Record "Item Ledger Entry";
        AdjustmentBinCodeL: Text;
        LocationL: Record Location;
        BinL: Record Bin;
    begin
    end;

    local procedure CheckFromZoneCode(FromZoneText: Text[200]): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        QuantityL: Decimal;
        ZoneL: Record Zone;
    begin
        ReturnValue := false;
        QuantityL := 0;





        ZoneL.Reset;
        ZoneL.SetFilter(Code, FromZoneText);
        if ZoneL.Count = 0 then begin
            ReturnValue := false;
            ErrorText := 'From Zone Code doesn''t exist.';
        end
        else begin
            ReturnValue := true;
        end;

        if ReturnValue then begin


            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            if CreateMovementG.FindFirst then begin
                FromZoneG := FromZoneText;
                CreateMovementG."From Zone Code" := FromZoneText;
                CreateMovementG.Modify;
            end; // IF CreateMovementG.FINDFIRST THEN
        end;
        exit(ReturnValue);
    end;

    local procedure CheckFromBinCode(FromBinCodeText: Text[200]): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        QuantityL: Decimal;
        BinL: Record Bin;
    begin
        ReturnValue := false;
        QuantityL := 0;




        BinL.Reset;
        BinL.SetFilter("Zone Code", FromZoneG);
        BinL.SetFilter(Code, FromBinCodeText);
        if BinL.Count = 0 then begin
            ReturnValue := false;
            ErrorText := 'From Bin Code doesn''t exist.';
        end
        else begin
            ReturnValue := true;
        end;

        if ReturnValue then begin


            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            if CreateMovementG.FindFirst then begin
                FromBinG := FromBinCodeText;
                CreateMovementG."From Bin Code" := FromBinCodeText;
                CreateMovementG.Modify;
            end; // IF CreateMovementG.FINDFIRST THEN

        end;
        exit(ReturnValue);
    end;

    local procedure CheckToZoneCode(ToZoneCodeText: Text[200]): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        QuantityL: Decimal;
        ZoneL: Record Zone;
    begin
        ReturnValue := false;
        QuantityL := 0;


        ZoneL.Reset;
        ZoneL.SetFilter(Code, ToZoneCodeText);
        if ZoneL.Count = 0 then begin
            ReturnValue := false;
            ErrorText := 'To Zone Code doesn''t exist.';
        end
        else begin
            ReturnValue := true;

            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            if CreateMovementG.FindFirst then begin
                ToZoneG := ToZoneCodeText;
                CreateMovementG."To Zone Code" := ToZoneCodeText;
                CreateMovementG.Modify;
            end; // IF CreateMovementG.FINDFIRST THEN
        end;

        exit(ReturnValue);
    end;

    local procedure CheckToBinCode(ToBinCodeText: Text[200]): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        QuantityL: Decimal;
        BinL: Record Bin;
    begin
        ReturnValue := false;
        QuantityL := 0;


        BinL.Reset;
        BinL.SetFilter("Zone Code", ToZoneG);
        BinL.SetFilter(Code, ToBinCodeText);
        if BinL.Count = 0 then begin
            ReturnValue := false;
            ErrorText := 'To Bin Code doesn''t exist.';
        end
        else begin
            ReturnValue := true;


            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            if CreateMovementG.FindFirst then begin
                ToBinG := ToBinCodeText;
                CreateMovementG."To Bin Code" := ToBinCodeText;
                CreateMovementG.Modify;
            end; // IF CreateMovementG.FINDFIRST THEN
        end;

        exit(ReturnValue);
    end;

    local procedure CheckQuantity(QuantityP: Text): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        QuantityL: Decimal;
        BinL: Record Bin;
        ParameterQuantityL: Decimal;
    begin
        ReturnValue := false;
        QuantityL := 0;


        Evaluate(QuantityG, QuantityP);
        if QuantityG <= 0 then begin
            ReturnValue := false;
            ErrorText := StrSubstNo('Quantity must be greater than 0.');
        end else begin
            ReturnValue := true;

            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            if CreateMovementG.FindFirst then begin
                CreateMovementG.Quantity := QuantityG;
                CreateMovementG.Modify;
            end; // IF CreateMovementG.FINDFIRST THEN
        end;

        exit(ReturnValue);
    end;

    local procedure "--- Warehouse Worksheet---"()
    begin
    end;

    [Scope('OnPrem')]
    procedure CreateMovementNoModal(WhseWkshLine: Record "Whse. Worksheet Line" temporary)
    var
        //CreateMovFromWhseSource: Report "Create Document No Req";
        ActualWhseWkshLineL: Record "Whse. Worksheet Line";
    begin

        ActualWhseWkshLineL.Reset;
        ActualWhseWkshLineL.SetFilter(Name, WhseWkshLine.Name);
        ActualWhseWkshLineL.SetFilter("Worksheet Template Name", WhseWkshLine."Worksheet Template Name");
        ActualWhseWkshLineL.SetFilter("Description 2", WhseWkshLine."Description 2");
        ActualWhseWkshLineL.DeleteAll;

        ActualWhseWkshLineL.Reset;
        ActualWhseWkshLineL.TransferFields(WhseWkshLine);
        ActualWhseWkshLineL.Insert;

        // CreateMovFromWhseSource.SetWhseWkshLine(ActualWhseWkshLineL);
        // CreateMovFromWhseSource.SetAssignUserID(GetAssignUserID);
        // CreateMovFromWhseSource.RunModal;

        // // CreateMovFromWhseSource.GetResultMessage(3);
        // Clear(CreateMovFromWhseSource);
    end;

    local procedure InitWarehouseMovement()
    var
        WarehouseEmployeeL: Record "Warehouse Employee";
        WarehouseLocationL: Code[50];
        UOMRec: Record "Item Unit of Measure";
    begin


        CreateMovementG.Reset;
        CreateMovementG.SetCurrentKey("ADCS User ID");
        CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
        if CreateMovementG.FindFirst then begin
            WhseWkshLineTemp.Reset;
            WhseWkshLineTemp.SetFilter(Name, WorksheetName);
            WhseWkshLineTemp.SetFilter("Worksheet Template Name", WorksheetTemplateName);
            WhseWkshLineTemp.SetFilter("Description 2", Format(ADCSUserId));
            WhseWkshLineTemp.DeleteAll;

            WhseWkshLineTemp.Init;
            WhseWkshLineTemp."Worksheet Template Name" := WorksheetTemplateName;
            WhseWkshLineTemp.Name := WorksheetName;
            WhseWkshLineTemp."Location Code" := LocationFilter;
            WhseWkshLineTemp."Line No." := 1;
            WhseWkshLineTemp."Source Type" := 0;
            WhseWkshLineTemp."Source Subtype" := 0;
            WhseWkshLineTemp."Source No." := '';
            WhseWkshLineTemp."Source Line No." := 0;
            WhseWkshLineTemp."Source Subline No." := 0;
            WhseWkshLineTemp."Shelf No." := '';
            WhseWkshLineTemp."Variant Code" := '';
            WhseWkshLineTemp."Sorting Sequence No." := 5000;
            WhseWkshLineTemp."Due Date" := 0D;
            WhseWkshLineTemp."Destination Type" := WhseWkshLineTemp."Destination Type"::" ";
            WhseWkshLineTemp."Destination No." := '';
            WhseWkshLineTemp."Shipping Agent Code" := '';

            WhseWkshLineTemp."Description 2" := Format(ADCSUserId);
            WhseWkshLineTemp.Description := ItemDescriptionG;
            WhseWkshLineTemp."Shipping Agent Service Code" := '';
            WhseWkshLineTemp."Shipping Advice" := WhseWkshLineTemp."Shipping Advice"::Partial;
            WhseWkshLineTemp."Shipment Date" := 0D;
            WhseWkshLineTemp."Whse. Document Type" := WhseWkshLineTemp."Whse. Document Type"::" ";
            WhseWkshLineTemp."Whse. Document Line No." := 0;
            WhseWkshLineTemp."Item No." := CreateMovementG."Item No.";
            WhseWkshLineTemp."Unit of Measure Code" := CreateMovementG.UOM;
            WhseWkshLineTemp."From Unit of Measure Code" := CreateMovementG.UOM;
            //WhseWkshLineTemp."Variant Code" := CreateMovementG."Variant Code";
            if UOMRec.Get(CreateMovementG."Item No.", CreateMovementG.UOM) then begin
                //WhseWkshLineTemp."Qty. per From Unit of Measure" := CreateMovementG."Qty. per From Unit of Measure";
                WhseWkshLineTemp."Qty. per Unit of Measure" := UOMRec."Qty. per Unit of Measure"; //CreateMovementG."Qty. per Unit of Measure";
            end;
            WhseWkshLineTemp."From Zone Code" := CreateMovementG."From Zone Code";
            WhseWkshLineTemp."From Bin Code" := CreateMovementG."From Bin Code";
            WhseWkshLineTemp."To Zone Code" := CreateMovementG."To Zone Code";
            WhseWkshLineTemp."To Bin Code" := CreateMovementG."To Bin Code";
            WhseWkshLineTemp.Quantity := CreateMovementG.Quantity * WhseWkshLineTemp."Qty. per Unit of Measure";
            //    WhseWkshLineTemp."Qty. (Base)" := CreateMovementG."Qty. (Base)";
            //    WhseWkshLineTemp."Qty. Outstanding" := CreateMovementG."Qty. Outstanding";
            //    WhseWkshLineTemp."Qty. Outstanding (Base)" := CreateMovementG."Qty. Outstanding (Base)";
            //    WhseWkshLineTemp."Qty. to Handle" := CreateMovementG."Qty. to Handle";
            //    WhseWkshLineTemp."Qty. to Handle (Base)" := CreateMovementG."Qty. to Handle (Base)";

            WhseWkshLineTemp."Qty. (Base)" := CreateMovementG.Quantity * WhseWkshLineTemp."Qty. per Unit of Measure"; //HMA Editing
            WhseWkshLineTemp."Qty. Outstanding" := CreateMovementG.Quantity * WhseWkshLineTemp."Qty. per Unit of Measure";
            WhseWkshLineTemp."Qty. Outstanding (Base)" := CreateMovementG.Quantity * WhseWkshLineTemp."Qty. per Unit of Measure";
            WhseWkshLineTemp."Qty. to Handle" := CreateMovementG.Quantity * WhseWkshLineTemp."Qty. per Unit of Measure"; //This will be taken from Scanbarcode
            WhseWkshLineTemp."Qty. to Handle (Base)" := CreateMovementG.Quantity * WhseWkshLineTemp."Qty. per Unit of Measure";
            //
            //    WhseWkshLineTemp."Qty. Handled" := 0;
            //    WhseWkshLineTemp."Qty. Handled (Base)" := 0; //HMA Editing
            WhseWkshLineTemp.Insert;
        end; // IF CreateMovementG.FINDFIRST THEN
    end;

    local procedure SetWarehouseItemTrackingLine()
    var
        WhseItemTrackingLineL: Record "Whse. Item Tracking Line";
    begin

        if (LotNoG <> '') and (QuantityG > 0) and (FromBinG <> '') and (FromZoneG <> '') and (ToZoneG <> '') and (ToBinG <> '') then begin
            WhseItemTrackingLineL.Reset;
            WhseItemTrackingLineL.SetRange("Location Code", LocationFilter);
            WhseItemTrackingLineL.SetFilter("Source ID", WorksheetName);
            WhseItemTrackingLineL.SetFilter("Source Batch Name", WorksheetTemplateName);
            WhseItemTrackingLineL.SetFilter("Lot No.", LotNoG);
            WhseItemTrackingLineL.SetFilter("Item No.", ItemNoG);
            WhseItemTrackingLineL.SetFilter(Description, Format(ADCSUserId));
            WhseItemTrackingLineL.DeleteAll;

            WhseItemTrackingLineL.Init;
            WhseItemTrackingLineL."Entry No." := GetNextIdForWarehouseItemTrackingLine;
            WhseItemTrackingLineL."Item No." := ItemNoG;
            WhseItemTrackingLineL."Location Code" := LocationFilter;
            WhseItemTrackingLineL."Quantity (Base)" := QuantityG;
            WhseItemTrackingLineL.Description := Format(ADCSUserId);
            WhseItemTrackingLineL."Source Type" := 7326;
            WhseItemTrackingLineL."Source Subtype" := 0;
            WhseItemTrackingLineL."Source ID" := WorksheetName;
            WhseItemTrackingLineL."Source Batch Name" := WorksheetTemplateName;
            WhseItemTrackingLineL."Source Prod. Order Line" := 0;
            WhseItemTrackingLineL."Source Ref. No." := 1;
            WhseItemTrackingLineL."Serial No." := '';
            WhseItemTrackingLineL."Qty. per Unit of Measure" := 1;
            WhseItemTrackingLineL."Warranty Date" := 0D;
            WhseItemTrackingLineL."Expiration Date" := 0D;
            WhseItemTrackingLineL."Qty. to Handle (Base)" := QuantityG;
            WhseItemTrackingLineL."Qty. to Invoice (Base)" := 0;
            WhseItemTrackingLineL."Quantity Handled (Base)" := 0;
            WhseItemTrackingLineL."Quantity Invoiced (Base)" := 0;
            WhseItemTrackingLineL."Qty. to Handle" := QuantityG;
            WhseItemTrackingLineL."Buffer Status" := WhseItemTrackingLineL."Buffer Status"::" ";
            WhseItemTrackingLineL."Buffer Status2" := WhseItemTrackingLineL."Buffer Status2"::"ExpDate blocked";
            WhseItemTrackingLineL."New Serial No." := '';
            WhseItemTrackingLineL."New Lot No." := '';
            WhseItemTrackingLineL."Qty. Registered (Base)" := 0;
            WhseItemTrackingLineL."Put-away Qty. (Base)" := 0;
            WhseItemTrackingLineL."Pick Qty. (Base)" := 0;
            WhseItemTrackingLineL."Created by Whse. Activity Line" := false;
            WhseItemTrackingLineL."Lot No." := LotNoG;
            WhseItemTrackingLineL."Variant Code" := VariantCodeG;
            WhseItemTrackingLineL."New Expiration Date" := 0D;
            //WhseItemTrackingLineL."Supplier Lot No." := SupplierLotNoG;
            //WhseItemTrackingLineL."New Supplier Lot No." := NewSupplierLotNoG;
            //WhseItemTrackingLineL."NWTH Lot No. External" := '';
            WhseItemTrackingLineL.Insert;
        end;
    end;

    local procedure PostMovementWorksheet()
    begin
    end;

    local procedure GetNextIdForWarehouseItemTrackingLine(): Integer
    var
        ReturnValueL: Integer;
        WhseItemTrackingLineL: Record "Whse. Item Tracking Line";
    begin

        ReturnValueL := 1;

        WhseItemTrackingLineL.Reset;
        if WhseItemTrackingLineL.FindLast then begin
            ReturnValueL := WhseItemTrackingLineL."Entry No." + 1;
        end;

        exit(ReturnValueL);
    end;

    local procedure GetAssignUserID(): Text
    var
        WarehouseEmployeeL: Record "Warehouse Employee";
        ReturnValueL: Text;
    begin

        ReturnValueL := '';
        if ADCSUserId <> '' then begin
            WarehouseEmployeeL.Reset;
            WarehouseEmployeeL.SetFilter("ADCS User", ADCSUserId);
            if WarehouseEmployeeL.FindFirst then begin
                ReturnValueL := WarehouseEmployeeL."User ID";
            end; // IF WarehouseEmployeeL.FINDFIRST THEN
        end; // IF ADCSUserId <> '' THEN

        exit(ReturnValueL);
    end;

    local procedure "+++ CreateMovement +++"()
    begin
    end;

    local procedure ResetCreateMovement()
    begin

        if Format(ADCSUserId) <> '' then begin
            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            CreateMovementG.DeleteAll;
        end;
    end;

    local procedure InitCreateMovement()
    var
        LineNoL: Integer;
    begin

        LineNoL := 1;
        CreateMovementG.Reset;
        if CreateMovementG.FindLast then begin
            LineNoL := CreateMovementG."Line No." + 1;
        end;

        CreateMovementG."ADCS User ID" := ADCSUserId;
        CreateMovementG."Line No." := LineNoL;
        CreateMovementG.Insert;
    end;

    local procedure "--- CreateMovement ---"()
    begin
    end;

    local procedure RegisterMovement()
    begin

        // Create Whse. Worksheet Line
        CreateMovementG.Reset;
        CreateMovementG.SetCurrentKey("ADCS User ID");
        CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
        if CreateMovementG.Count > 0 then begin
            InitWarehouseMovement();
            // Create Warehouse Item Tracking Line
            SetWarehouseItemTrackingLine;
            // Post Whse. Worksheet Line
            WhseWkshLineTemp.Reset;
            WhseWkshLineTemp.SetFilter(Name, WorksheetName);
            WhseWkshLineTemp.SetFilter("Worksheet Template Name", WorksheetTemplateName);
            WhseWkshLineTemp.SetFilter("Description 2", Format(ADCSUserId));
            if WhseWkshLineTemp.FindFirst then begin
                CreateMovementNoModal(WhseWkshLineTemp);
            end;
            // Clean After create movement

            ResetCreateMovement;
        end // IF CreateMovementG.COUNT > 0 THEN
    end;

    local procedure ResetWhseWorksheetLine()
    begin

        if Format(ADCSUserId) <> '' then begin
            WhseWkshLineTemp.Reset;
            WhseWkshLineTemp.SetFilter(Name, WorksheetName);
            WhseWkshLineTemp.SetFilter("Worksheet Template Name", WorksheetTemplateName);
            WhseWkshLineTemp.SetFilter("Description 2", Format(ADCSUserId));
            WhseWkshLineTemp.DeleteAll;
        end;
    end;

    local procedure ResetWhseItemTrackingLine()
    var
        WhseItemTrackingLineL: Record "Whse. Item Tracking Line";
    begin

        if Format(ADCSUserId) <> '' then begin
            WhseItemTrackingLineL.Reset;
            WhseItemTrackingLineL.SetRange("Location Code", LocationFilter);
            WhseItemTrackingLineL.SetFilter("Source ID", WorksheetName);
            WhseItemTrackingLineL.SetFilter("Source Batch Name", WorksheetTemplateName);
            WhseItemTrackingLineL.SetFilter("Lot No.", LotNoG);
            WhseItemTrackingLineL.SetFilter("Item No.", ItemNoG);
            WhseItemTrackingLineL.SetFilter(Description, Format(ADCSUserId));
            WhseItemTrackingLineL.DeleteAll;
        end;
    end;

    local procedure CheckItemNo(ItemBarcodeNoP: Code[20]): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        ItemNoL: Code[20];
        ZoneL: Record Zone;
        ItemR: Record Item;
        BarcodeR: Record "LSC Barcodes";
        VariantR: Record "Item Variant";
    begin
        ReturnValue := true;
        ItemNoL := '';

        if ReturnValue then begin
            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            if CreateMovementG.FindFirst then begin
                BarcodeR.Reset;
                BarcodeR.SetRange("Barcode No.", ItemBarcodeNoP);
                if BarcodeR.FindFirst then begin
                    ItemNoG := BarcodeR."Item No.";
                    CreateMovementG."Item No." := ItemNoG;
                    //CreateMovementG."Variant Code" := BarcodeR."Variant Code";
                    CreateMovementG.UOM := BarcodeR."Unit of Measure Code";

                    VariantR.Reset;
                    VariantR.SetRange(Code, BarcodeR."Variant Code");
                    VariantR.SetRange("Item No.", ItemNoG);
                    if VariantR.FindFirst then
                        //CreateMovementG."Variant Description" := VariantR.Description;

                    CreateMovementG.Modify;
                end;
            end; // IF CreateMovementG.FINDFIRST THEN
        end;
        exit(ReturnValue);
    end;

    local procedure CheckVariantCode(VariantCodeP: Code[20]): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        VariantCodeL: Code[20];
        ZoneL: Record Zone;
    begin
        ReturnValue := true;
        VariantCodeL := '';

        if ReturnValue then begin
            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            if CreateMovementG.FindFirst then begin
                VariantCodeG := VariantCodeP;
                //CreateMovementG."Variant Code" := VariantCodeG;
                CreateMovementG.Modify;
            end; // IF CreateMovementG.FINDFIRST THEN
        end;
        exit(ReturnValue);
    end;

    local procedure CheckUOM(UOMCodeP: Code[20]): Boolean
    var
        ReturnValue: Boolean;
        WarehouseEntryL: Record "Warehouse Entry";
        UOMCodeL: Code[20];
        ZoneL: Record Zone;
    begin
        ReturnValue := true;
        UOMCodeL := '';

        if ReturnValue then begin
            CreateMovementG.Reset;
            CreateMovementG.SetCurrentKey("ADCS User ID");
            CreateMovementG.SetRange("ADCS User ID", ADCSUserId);
            if CreateMovementG.FindFirst then begin
                UOMCodeG := UOMCodeP;
                CreateMovementG.UOM := UOMCodeG;
                CreateMovementG.Modify;
            end; // IF CreateMovementG.FINDFIRST THEN
        end;
        exit(ReturnValue);
    end;

    local procedure PackagingInfo()
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
        WhseActivityLine: Record "Warehouse Activity Line";
        ItemR: Record Item;
        VariantR: Record "Item Variant";
    begin
        WhseActivityHeader.Reset;
        WhseActivityHeader.SetRange("Assignment Date", Today);
        WhseActivityHeader.SetRange(Type, WhseActivityHeader.Type::Movement);
        WhseActivityHeader.SetRange("Assigned User ID", ADCSUserId);
        //WhseActivityHeader.SETRANGE("Location Code","Location Code");
        if WhseActivityHeader.FindSet then
            repeat
                WhseActivityLine.Reset;
                WhseActivityLine.SetRange("No.", WhseActivityHeader."No.");
                if WhseActivityLine.FindSet then
                    repeat
                        if (WhseActivityLine."Packaging Info" = '') and (ItemR.Get(WhseActivityLine."Item No.")) then begin
                            WhseActivityLine."Packaging Info" := ItemR."Packaging Info";
                            WhseActivityLine.Modify(true);
                        end;
                    // if (WhseActivityLine."Variant Description" = '') and (VariantR.Get(WhseActivityLine."Item No.", WhseActivityLine."Variant Code")) then begin
                    //     WhseActivityLine."Variant Description" := VariantR."Description 2";
                    //     WhseActivityLine.Modify(true);
                    // end;
                    until WhseActivityLine.Next = 0;
            until WhseActivityHeader.Next = 0;
    end;

    // trigger DOMxmlin::NodeInserting(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger DOMxmlin::NodeInserted(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger DOMxmlin::NodeRemoving(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger DOMxmlin::NodeRemoved(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger DOMxmlin::NodeChanging(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger DOMxmlin::NodeChanged(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;
}

