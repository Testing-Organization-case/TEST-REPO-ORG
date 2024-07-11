page 70015 "Consolidate PO Worksheets"
{
    PageType = Worksheet;
    SourceTable = "Consolidate PO Worksheet";
    ApplicationArea = ALl;

    layout
    {
        area(content)
        {
            group("Filter")
            {
                field(StartingDateFilter; StartingDateFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Starting Date Filter';
                    ToolTip = 'Specifies a filter for which purchase prices to display.';

                    trigger OnValidate()
                    var
                    //TextManagement: Codeunit TextManagement;
                    begin
                    end;
                }
                field(EndingDateFilter; EndingDateFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ending Date Filter';
                    ToolTip = 'Specifies a filter for which purchase prices to display.';

                    trigger OnValidate()
                    var
                    //TextManagement: Codeunit TextManagement;
                    begin
                    end;
                }
                field(VendNoFilterCtrl; VendNoFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor No. Filter';
                    ShowMandatory = true;
                    ToolTip = 'Specifies a filter for which purchase prices display.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        VendList: Page "Vendor List";
                    begin

                        VendList.LookupMode := true;
                        if VendList.RunModal = ACTION::LookupOK then
                            Text := VendList.GetSelectionFilter
                        else
                            exit(false);

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin

                        VendNoFilterOnAfterValidate;
                    end;
                }
                field(ItemNoFIlterCtrl; LocationFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies a filter for which purchase prices to display.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LocationList: Page "Location List";
                    begin

                        LocationList.LookupMode := true;
                        if LocationList.RunModal = ACTION::LookupOK then
                            Text := LocationList.GetSelectionFilter
                        else
                            exit(false);

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin

                        if VendNoFilter = '' then begin
                            Error('Vendor No. cannot be blank!');
                        end;
                        EndDateValidate;
                    end;
                }
            }
            repeater(General)
            {
                Caption = 'General';
                field("Vendor No."; rec."Vendor No.")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Direct Unit Cost Excl. VAT"; Rec."Direct Unit Cost Excl. VAT")
                {
                }
                field("Net Cost Price"; Rec."Net Cost Price")
                {
                }
                field("Total Line Dis AMT"; Rec."Total Line Dis AMT")
                {
                }
                field("Line Amount Excl. VAT"; Rec."Line Amount Excl. VAT")
                {
                }
                field("Scheme Code"; Rec."Scheme Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        VendNoFilter: Text;
        LocationFilter: Text;
        StartingDateFilter: Date;
        EndingDateFilter: Date;
        NoDataWithinFilterErr: Label 'There is no %1 within the filter %2.', Comment = '%1: Field(Code), %2: GetFilter(Code)';

    local procedure VendNoFilterOnAfterValidate()
    var
        Item: Record Item;
    begin
        if Item.Get(Rec."Item No.") then
            CurrPage.SaveRecord;
        SetRecFilters;
    end;

    procedure SetRecFilters()
    begin
        if VendNoFilter <> '' then
            Rec.SetFilter("Vendor No.", VendNoFilter)
        else
            Rec.SetRange("Vendor No.");

        if StartingDateFilter <> 0D then
            Rec.SetRange("Starting Date", StartingDateFilter)
        else
            Rec.SetRange("Starting Date");

        if EndingDateFilter <> 0D then
            Rec.SetRange("Ending Date", EndingDateFilter)
        else
            Rec.SetRange("Ending Date");


        CheckFilters(DATABASE::Vendor, VendNoFilter);


        CurrPage.Update(false);
    end;

    procedure CheckFilters(TableNo: Integer; FilterTxt: Text)
    var
        FilterRecordRef: RecordRef;
        FilterFieldRef: FieldRef;
    begin
        if FilterTxt = '' then
            exit;
        Clear(FilterRecordRef);
        Clear(FilterFieldRef);
        FilterRecordRef.Open(TableNo);
        FilterFieldRef := FilterRecordRef.Field(1);
        FilterFieldRef.SetFilter(FilterTxt);
        if FilterRecordRef.IsEmpty then
            Error(NoDataWithinFilterErr, FilterRecordRef.Caption, FilterTxt);
    end;

    local procedure LocationFilterOnAfterValidate()
    var
        Item: Record Item;
    begin
        if Item.Get(Rec."Item No.") then
            CurrPage.SaveRecord;
        SetRecFilters;
    end;

    local procedure EndDateValidate()
    var
        PurchHeader: Record "Purchase Header";
        ConPOHeader: Record "Consolidate Purchase Header";
        ConPOLine: Record "Consolidate PO Worksheet";
        PurchLine: Record "Purchase Line";
        VenTradeScheme: Record "Vendor Trade Scheme";
        Purch: Record "Purchase Header";
        TempPurchLine: Record "Purchase Line";
        i: Integer;
        PurchPrice: Record "Purchase Price";
    begin

        PurchHeader.Reset;
        PurchHeader.SetRange("Buy-from Vendor No.", VendNoFilter);
        PurchHeader.SetRange(Status, PurchHeader.Status::Open);
        if PurchHeader.FindSet then
            repeat

                if (PurchHeader."Document Date" >= StartingDateFilter) or (PurchHeader."Document Date" <= EndingDateFilter) or (StartingDateFilter = PurchHeader."Document Date") then begin
                    PurchLine.Reset;
                    PurchLine.SetRange("Document No.", PurchHeader."No.");
                    PurchLine.SetRange("Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SetRange("Location Code", LocationFilter);
                    if PurchLine.FindSet then
                        repeat

                            ConPOLine.Init;
                            ConPOLine."Vendor No." := '1';
                            ConPOLine.Insert;


                        until PurchLine.Next = 0;
                end;
            until PurchHeader.Next = 0;
    end;
}

