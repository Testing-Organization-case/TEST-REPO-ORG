page 70065 "Customer Entity"
{
    Caption = 'customers', Locked = true;
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    EntityName = 'customer';
    EntitySetName = 'customers';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    ApplicationArea = All;
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Number', Locked = true;
                }
                field(displayName; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'DisplayName', Locked = true;

                    trigger OnValidate()
                    begin
                        if Rec.Name = '' then
                            Error(BlankCustomerNameErr);
                        RegisterFieldSet(Rec.FieldNo(Name));
                    end;
                }
                field(type; Rec."Contact Type")
                {
                    ApplicationArea = All;
                    Caption = 'type', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Contact Type"));
                    end;
                }
                field(address; PostalAddressJSON)
                {
                    ApplicationArea = All;
                    Caption = 'address', Locked = true;
                    ODataEDMType = 'POSTALADDRESS';
                    ToolTip = 'Specifies the address for the customer.';

                    trigger OnValidate()
                    begin
                        PostalAddressSet := true;
                    end;
                }
                field(street; Rec.Address)
                {
                    Caption = 'street';
                }
                field(street2; Rec."Address 2")
                {
                    Caption = 'street2';
                }
                field(city; Rec.City)
                {
                    Caption = 'city';
                }
                field(state; Rec."Country/Region Code")
                {
                    Caption = 'state';
                }
                field(postalCode; Rec."Post Code")
                {
                    Caption = 'postalCode';
                }
                field(countryLetterCode; Rec.County)
                {
                    Caption = 'countryLetterCode';
                }
                field(phoneNumber; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'PhoneNumber', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Phone No."));
                    end;
                }
                field(email; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Email', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("E-Mail"));
                    end;
                }
                field(website; Rec."Home Page")
                {
                    ApplicationArea = All;
                    Caption = 'Website', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Home Page"));
                    end;
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Caption = 'TaxLiable', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Tax Liable"));
                    end;
                }
                field(taxAreaId; Rec."Tax Area ID")
                {
                    ApplicationArea = All;
                    Caption = 'taxAreaId', Locked = true;

                    trigger OnValidate()
                    var
                        GeneralLedgerSetup: Record "General Ledger Setup";
                    begin
                        RegisterFieldSet(Rec.FieldNo("Tax Area ID"));

                        if not GeneralLedgerSetup.UseVat then
                            RegisterFieldSet(Rec.FieldNo("Tax Area Code"))
                        else
                            RegisterFieldSet(Rec.FieldNo("VAT Bus. Posting Group"));
                    end;
                }
                field(taxAreaDisplayName; TaxAreaDisplayName)
                {
                    ApplicationArea = All;
                    Caption = 'taxAreaDisplayName', Locked = true;
                    Editable = false;
                    ToolTip = 'Specifies the display name of the tax area.';
                }
                field(taxRegistrationNumber; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Caption = 'taxRegistrationNumber', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("VAT Registration No."));
                    end;
                }
                field(currencyId; Rec."Currency Id")
                {
                    ApplicationArea = All;
                    Caption = 'CurrencyId', Locked = true;

                    trigger OnValidate()
                    begin
                        if Rec."Currency Id" = BlankGUID then
                            Rec."Currency Code" := ''
                        else begin
                            Currency.SetRange(SystemId, Rec."Currency Id");
                            if not Currency.FindFirst then
                                Error(CurrencyIdDoesNotMatchACurrencyErr);

                            Rec."Currency Code" := Currency.Code;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Currency Id"));
                        RegisterFieldSet(Rec.FieldNo("Currency Code"));
                    end;
                }
                field(currencyCode; CurrencyCodeTxt)
                {
                    ApplicationArea = All;
                    Caption = 'CurrencyCode', Locked = true;

                    trigger OnValidate()
                    begin
                        Rec."Currency Code" :=
                          GraphMgtGeneralTools.TranslateCurrencyCodeToNAVCurrencyCode(
                            LCYCurrencyCode, CopyStr(CurrencyCodeTxt, 1, MaxStrLen(LCYCurrencyCode)));

                        if Currency.Code <> '' then begin
                            if Currency.Code <> Rec."Currency Code" then
                                Error(CurrencyValuesDontMatchErr);
                            exit;
                        end;

                        if Rec."Currency Code" = '' then
                            Rec."Currency Id" := BlankGUID
                        else begin
                            if not Currency.Get(Rec."Currency Code") then
                                Error(CurrencyCodeDoesNotMatchACurrencyErr);

                            Rec."Currency Id" := Currency.SystemId;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Currency Id"));
                        RegisterFieldSet(Rec.FieldNo("Currency Code"));
                    end;
                }
                field(paymentTermsId; Rec."Payment Terms Id")
                {
                    ApplicationArea = All;
                    Caption = 'PaymentTermsId', Locked = true;

                    trigger OnValidate()
                    begin
                        if Rec."Payment Terms Id" = BlankGUID then
                            Rec."Payment Terms Code" := ''
                        else begin
                            PaymentTerms.SetRange(SystemId, Rec."Payment Terms Id");
                            if not PaymentTerms.FindFirst then
                                Error(PaymentTermsIdDoesNotMatchAPaymentTermsErr);

                            Rec."Payment Terms Code" := PaymentTerms.Code;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Payment Terms Id"));
                        RegisterFieldSet(Rec.FieldNo("Payment Terms Code"));
                    end;
                }
                field(shipmentMethodId; Rec."Shipment Method Id")
                {
                    ApplicationArea = All;
                    Caption = 'ShipmentMethodId', Locked = true;

                    trigger OnValidate()
                    begin
                        if Rec."Shipment Method Id" = BlankGUID then
                            Rec."Shipment Method Code" := ''
                        else begin
                            ShipmentMethod.SetRange(SystemId, Rec."Shipment Method Id");
                            if not ShipmentMethod.FindFirst then
                                Error(ShipmentMethodIdDoesNotMatchAShipmentMethodErr);

                            Rec."Shipment Method Code" := ShipmentMethod.Code;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Shipment Method Id"));
                        RegisterFieldSet(Rec.FieldNo("Shipment Method Code"));
                    end;
                }
                field(paymentMethodId; Rec."Payment Method Id")
                {
                    ApplicationArea = All;
                    Caption = 'PaymentMethodId', Locked = true;

                    trigger OnValidate()
                    begin
                        if Rec."Payment Method Id" = BlankGUID then
                            Rec."Payment Method Code" := ''
                        else begin
                            PaymentMethod.SetRange(SystemId, Rec."Payment Method Id");
                            if not PaymentMethod.FindFirst then
                                Error(PaymentMethodIdDoesNotMatchAPaymentMethodErr);

                            Rec."Payment Method Code" := PaymentMethod.Code;
                        end;

                        RegisterFieldSet(Rec.FieldNo("Payment Method Id"));
                        RegisterFieldSet(Rec.FieldNo("Payment Method Code"));
                    end;
                }
                field(blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Caption = 'Blocked', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Blocked));
                    end;
                }
                field(balance; BalanceLCY)
                {
                    ApplicationArea = All;
                    Caption = 'Balance', Locked = true;
                    Editable = false;
                }
                field(overdueAmount; OverdueAmount)
                {
                    ApplicationArea = All;
                    Caption = 'overdueAmount', Locked = true;
                    Editable = false;
                }
                field(totalSalesExcludingTax; SalesLCY)
                {
                    ApplicationArea = All;
                    Caption = 'totalSalesExcludingTax', Locked = true;
                    Editable = false;
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    ApplicationArea = All;
                    Caption = 'LastModifiedDateTime', Locked = true;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetCalculatedFields;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Customer: Record Customer;
        RecRef: RecordRef;
    begin
        if Rec.Name = '' then
            Error(NotProvidedCustomerNameErr);

        Customer.SetRange("No.", Rec."No.");
        if not Customer.IsEmpty then
            Rec.Insert;

        Rec.Insert(true);

        ProcessPostalAddress;

        RecRef.GetTable(Rec);
        GraphMgtGeneralTools.ProcessNewRecordFromAPI(RecRef, TempFieldSet, CurrentDateTime);
        RecRef.SetTable(Rec);

        Rec.Modify(true);
        SetCalculatedFields;
        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    var
        Customer: Record Customer;
        GraphMgtGeneralTools: Codeunit "Graph Mgt - General Tools";
    begin
        if xRec.SystemId <> Rec.SystemId then
            GraphMgtGeneralTools.ErrorIdImmutable;

        Customer.SetRange(SystemId, Rec.SystemId);
        Customer.FindFirst;

        ProcessPostalAddress;

        if Rec."No." = Customer."No." then
            Rec.Modify(true)
        else begin
            Customer.TransferFields(Rec, false);
            Customer.Rename(Rec."No.");
            Rec.TransferFields(Customer);
        end;

        SetCalculatedFields;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearCalculatedFields;
    end;

    var
        Currency: Record Currency;
        PaymentTerms: Record "Payment Terms";
        ShipmentMethod: Record "Shipment Method";
        PaymentMethod: Record "Payment Method";
        TempFieldSet: Record "Field" temporary;
        GraphMgtGeneralTools: Codeunit "Graph Mgt - General Tools";
        LCYCurrencyCode: Code[10];
        CurrencyCodeTxt: Text;
        PostalAddressJSON: Text;
        TaxAreaDisplayName: Text;
        OverdueAmount: Decimal;
        CurrencyValuesDontMatchErr: Label 'The currency values do not match to a specific Currency.', Locked = true;
        CurrencyIdDoesNotMatchACurrencyErr: Label 'The "currencyId" does not match to a Currency.', Locked = true;
        CurrencyCodeDoesNotMatchACurrencyErr: Label 'The "currencyCode" does not match to a Currency.', Locked = true;
        PaymentTermsIdDoesNotMatchAPaymentTermsErr: Label 'The "paymentTermsId" does not match to a Payment Terms.', Locked = true;
        ShipmentMethodIdDoesNotMatchAShipmentMethodErr: Label 'The "shipmentMethodId" does not match to a Shipment Method.', Locked = true;
        PaymentMethodIdDoesNotMatchAPaymentMethodErr: Label 'The "paymentMethodId" does not match to a Payment Method.', Locked = true;
        BlankGUID: Guid;
        NotProvidedCustomerNameErr: Label 'A "displayName" must be provided.', Locked = true;
        BlankCustomerNameErr: Label 'The blank "displayName" is not allowed.', Locked = true;
        PostalAddressSet: Boolean;
        BalanceLCY: Decimal;
        SalesLCY: Decimal;

    local procedure SetCalculatedFields()
    var
        TaxAreaBuffer: Record "Tax Area Buffer";
        GraphMgtCustomer: Codeunit "Graph Mgt - Customer";
    begin
        PostalAddressJSON := GraphMgtCustomer.PostalAddressToJSON(Rec);
        CurrencyCodeTxt := GraphMgtGeneralTools.TranslateNAVCurrencyCodeToCurrencyCode(LCYCurrencyCode, Rec."Currency Code");

        Rec.SetRange("Date Filter", 0D, WorkDate - 1);
        Rec.CalcFields("Balance Due (LCY)");
        OverdueAmount := Rec."Balance Due (LCY)";
        Rec.SetRange("Date Filter", 0D, WorkDate);
        Rec.CalcFields("Sales (LCY)", "Balance (LCY)");
        SalesLCY := Rec."Sales (LCY)";
        BalanceLCY := Rec."Balance (LCY)";
        TaxAreaDisplayName := TaxAreaBuffer.GetTaxAreaDisplayName(Rec."Tax Area ID");
    end;

    local procedure ClearCalculatedFields()
    begin
        Clear(Rec.SystemId);
        Clear(TaxAreaDisplayName);
        Clear(PostalAddressJSON);
        Clear(OverdueAmount);
        Clear(BalanceLCY);
        Clear(SalesLCY);
        Clear(PostalAddressSet);
        TempFieldSet.DeleteAll;
    end;

    local procedure RegisterFieldSet(FieldNo: Integer)
    begin
        if TempFieldSet.Get(DATABASE::Customer, FieldNo) then
            exit;

        TempFieldSet.Init;
        TempFieldSet.TableNo := DATABASE::Customer;
        TempFieldSet.Validate("No.", FieldNo);
        TempFieldSet.Insert(true);
    end;

    local procedure ProcessPostalAddress()
    var
        GraphMgtCustomer: Codeunit "Graph Mgt - Customer";
    begin
        if not PostalAddressSet then
            exit;

        GraphMgtCustomer.UpdatePostalAddress(PostalAddressJSON, Rec);

        if xRec.Address <> Rec.Address then
            RegisterFieldSet(Rec.FieldNo(Address));

        if xRec."Address 2" <> Rec."Address 2" then
            RegisterFieldSet(Rec.FieldNo("Address 2"));

        if xRec.City <> Rec.City then
            RegisterFieldSet(Rec.FieldNo(City));

        if xRec."Country/Region Code" <> Rec."Country/Region Code" then
            RegisterFieldSet(Rec.FieldNo("Country/Region Code"));

        if xRec."Post Code" <> Rec."Post Code" then
            RegisterFieldSet(Rec.FieldNo("Post Code"));

        if xRec.County <> Rec.County then
            RegisterFieldSet(Rec.FieldNo(County));
    end;
}

