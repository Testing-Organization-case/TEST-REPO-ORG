codeunit 70003 "VAS Management"
{
    // YYYYMMDD Version        Sign  Proj.Ref.     Description
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 20160616 NWV-VAS9.0     NWV                 NWV-VAS9.0


    trigger OnRun()
    var
        lRec_RptCaption: Record "Report Bilingual Caption";
    begin
        with lRec_RptCaption do begin
            if FindSet(false, false) then
                repeat
                    "Parent ID" := ID;
                    Modify;
                until Next = 0;
        end;
    end;

    var
        gUserSetup: Record "User Setup";
        gCompanyInfo: Record "Company Information";
        Text001: Label 'Do you want to approve?';
        Text002: Label 'Do you want to send the approval request?';
        Text003: Label 'Do you want to cancel the approval request?';
        Text004: Label 'The Status has been changed to %1';
        ErrText000: Label 'Status must not be %1.';
        ErrText001: Label 'The balance Amount of Account No. %1 is not enough for payment.';
        ErrText002: Label 'The Amount %1 cannot be exceeded Cash limited %2.';
        ErrText003: Label 'The User ID %1 must be declared in the Approval User Setup.';
        ErrText004: Label 'The Approver ID must be declared for User ID %1 in the Approval User Setup.';
        ErrText005: Label 'The voucher %1 needs to be approved before posting. Please check again.';
        ErrText006: Label 'Duplicate External Document No.';
        ErrText007: Label 'The Quantity of Item %1 in Location %2 must not be greater than %3 on %4 in Document No. %5 Line No. %6';
        ErrText008: Label 'The Quantity of Item %1 must not be zero in Template Name %2, Batch Name %3, Document No %4 and Line No. %1';
        ErrText009: Label 'The Quantity of Item %1 in Location %2 must not be greater than %3 on %4 in the Template Name %5, Batch Name %6, Document No %7 and Line No. %8.';
        ErrText010: Label 'The Item No. %1 in Location Code %2, Template Name %3, Batch Name %4 must be inputted in one line.';
        ErrText011: Label 'Duplicate External Document No.';
        ErrText012: Label 'Duplicate Vendor Cr. Memo No.';
        ErrText013: Label 'The Quantity of Item %1 in Location %2 must not be greater than %3 on %4 in Document No. %5 Line No. %6';
        ErrText014: Label 'The Quantity of Item %1 must not be greater than Item Inventory %2 on %3 in Line No. %4.';
        gFilter: array[10] of Text;
        gRecRef: RecordRef;

    [Scope('OnPrem')]
    procedure CheckisVN(): Boolean
    begin
        //IF gVASSetup.GET THEN
        //EXIT(gVASSetup."Use VAS");
    end;

    [Scope('OnPrem')]
    procedure ReturnRptCaption(pRec_RptCaption: Record "Report Bilingual Caption"): Text
    begin
        //gVASSetup.GET;
        with pRec_RptCaption do begin
            //IF NOT gVASSetup."Use Bilingual Caption" THEN
            //EXIT("Vietnamese Caption");
            exit("Bilingual Caption")
        end;
    end;

    [Scope('OnPrem')]
    procedure FillRptLabelCaptions(pCaptionType: Option Internal,External; pReportID: Integer; var pCaption: array[200] of Text)
    var
        lRec_RptCaption: Record "Report Bilingual Caption";
    begin
        // CaptionType = 0 --> Internal label caption
        // CaptionType = 1 --> External label caption

        with lRec_RptCaption do begin
            Reset;
            SetRange("Label Type", pCaptionType);

            if pCaptionType = pCaptionType::Internal then
                SetRange("Report ID", pReportID)
            else
                SetRange("Report ID", 0);

            if FindSet(false, false) then
                repeat
                    pCaption["Parent ID"] += ReturnRptCaption(lRec_RptCaption);
                until Next = 0;
        end;
    end;

    [Scope('OnPrem')]
    procedure ReturnCompanyName(): Text[200]
    begin
        gCompanyInfo.Get;
        exit(gCompanyInfo.Name);
    end;

    [Scope('OnPrem')]
    procedure ReturnCompanyAddress(): Text[101]
    begin
        gCompanyInfo.Get;
        exit(gCompanyInfo.Address + ' ' + gCompanyInfo."Address 2");
    end;

    [Scope('OnPrem')]
    procedure ReturnVATRegistration(): Text[100]
    begin
        gCompanyInfo.Get;
        exit(gCompanyInfo."VAT Registration No.");
    end;

    [Scope('OnPrem')]
    procedure ReturnCompanyPhoneNo(): Text[100]
    begin
        gCompanyInfo.Get;
        exit(gCompanyInfo."Phone No.");
    end;

    [Scope('OnPrem')]
    procedure ReturnCompanyFaxNo(): Text[100]
    begin
        gCompanyInfo.Get;
        exit(gCompanyInfo."Fax No.");
    end;

    [Scope('OnPrem')]
    procedure ReturnCompanyLogo(var pLogo: Integer): Text[100]
    begin
        gCompanyInfo.Get;
    end;

    [Scope('OnPrem')]
    procedure MakeCurrencyUnit(pCurrencyCode: Code[10]; var pUnit: array[2] of Text[30])
    begin
        //lAmoutInWord.InitUnitWord(pCurrencyCode,pUnit);
    end;

    [Scope('OnPrem')]
    procedure UseBilingualCaption(): Boolean
    begin
        //gVASSetup.GET;
        exit(true);
    end;

    // [Scope('OnPrem')]
    // procedure MakeDateFilter(var pDateFilter: Text; var pStartDate: Date; var pEndDate: Date)
    // var
    //     ApplicationManagement: Codeunit TextManagement;
    //     lDataBuffer: Record "Temporary Data Buffer";
    // begin
    //     if ApplicationManagement.MakeDateFilter(pDateFilter) = 0 then;
    //     lDataBuffer.SetFilter("Date Filter", pDateFilter);
    //     pDateFilter := lDataBuffer.GetFilter("Date Filter");
    //     if pDateFilter <> '' then begin
    //         pStartDate := lDataBuffer.GetRangeMin("Date Filter");
    //         pEndDate := lDataBuffer.GetRangeMax("Date Filter");
    //     end else begin
    //         pStartDate := 0D;
    //         pEndDate := 0D;
    //     end;
    // end;

    [Scope('OnPrem')]
    procedure ReturnDateFilter(pStartDate: Date; pEndDate: Date): Text
    var
        lDataBuffer: Record "Temporary Data Buffer";
    begin
        lDataBuffer.SetRange("Date Filter", pStartDate, pEndDate);
        exit(lDataBuffer.GetFilter("Date Filter"));
    end;

    [Scope('OnPrem')]
    procedure ReturnBankAccountNo(): Text[100]
    begin
        gCompanyInfo.Get;
        exit(gCompanyInfo."Bank Account No.");
    end;
}

