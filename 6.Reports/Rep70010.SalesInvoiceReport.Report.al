report 70010 "Sales Invoice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/SalesInvoiceReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(Address2_CompanyInformation; "Company Information"."Address 2")
            {
            }
            column(City_CompanyInformation; "Company Information".City)
            {
            }
            column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
            column(County_CompanyInformation; "Company Information".County)
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                column(SelltoCusInfo; SelltoCusInfo)
                {
                }
                column(ShiptoName; ShiptoName)
                {
                }
                column(ShiptoAddress; ShiptoAddress)
                {
                }
                column(ShiptoCR; ShiptoCR)
                {
                }
                column(ShiptoPh; ShiptoPh)
                {
                }
                column(LocAddress; LocAddress)
                {
                }
                column(LocCity; LocCity)
                {
                }
                column(LocPhone; LocPhone)
                {
                }
                column(ShiptoCounty_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to County")
                {
                }
                column(ShiptoName_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name")
                {
                }
                column(ShiptoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address")
                {
                }
                column(ShiptoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address 2")
                {
                }
                column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
                {
                }
                column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
                {
                }
                column(SelltoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Address")
                {
                }
                column(SelltoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Address 2")
                {
                }
                column(SelltoCity_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to City")
                {
                }
                column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
                {
                }
                column(SelltoPhoneNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Phone No.")
                {
                }
                column(ShipmentMethodCode_SalesInvoiceHeader; "Sales Invoice Header"."Shipment Method Code")
                {
                }
                column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
                {
                }
                column(DocumentDate_SalesInvoiceHeader; "Sales Invoice Header"."Document Date")
                {
                }
                column(QuoteNo_SalesInvoiceHeader; "Sales Invoice Header"."Quote No.")
                {
                }
                column(SelltoPostCode_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Post Code")
                {
                }
                column(SelltoCounty_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to County")
                {
                }
                column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
                {
                }
                column(PaymentTerm; PaymentTerm)
                {
                }
                column(PaymentMethod; PaymentMethod)
                {
                }
                column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
                {
                }
                column(ShiptoCR1; ShiptoCR1)
                {
                }
                column(InvoiceDiscountAmount_SalesInvoiceHeader; "Sales Invoice Header"."Invoice Discount Amount")
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    // column(VarDescription; VarDescription)
                    // {
                    // }
                    column(VarientDescriptions_SalesInvoiceLine; "Sales Invoice Line"."Varient Descriptions")
                    {
                    }
                    column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                    {
                    }
                    column(UnitofMeasure_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure")
                    {
                    }
                    column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                    {
                    }
                    column(PackagingInfo_SalesInvoiceLine; "Sales Invoice Line"."Packaging Info")
                    {
                    }
                    column(LineDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Line Discount Amount")
                    {
                    }
                    column(InvDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Inv. Discount Amount")
                    {
                    }
                    column(LineAmount_SalesInvoiceLine; "Sales Invoice Line"."Line Amount")
                    {
                    }
                    column(AmountIncludingVAT_SalesInvoiceLine; "Sales Invoice Line"."Amount Including VAT")
                    {
                    }
                    column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                    {
                    }

                    trigger OnAfterGetRecord()

                    begin
                        LocationR.Reset;
                        LocationR.SetRange(Code, "Sales Invoice Line"."Location Code");
                        if LocationR.FindFirst then begin
                            LocAddress := LocationR.Address + ',' + LocationR."Address 2";
                            LocCity := LocationR.City;
                            LocPhone := LocationR."Phone No.";
                            CountryRegion.Reset;
                            CountryRegion.SetRange(Code, LocationR."Country/Region Code");
                            if CountryRegion.FindFirst then begin
                                ShiptoCR := CountryRegion.Name;

                            end;
                        end;


                    end;


                }

                trigger OnAfterGetRecord()
                begin
                    if "Sales Invoice Header"."Sell-to City" <> '' then begin
                        SelltoCusInfo := "Sales Invoice Header"."Sell-to City" + ',' + ' ' + "Sales Invoice Header"."Sell-to Post Code";
                    end
                    else
                        SelltoCusInfo := '';


                    // IF "Sales Invoice Header"."Ship-to Code" = '' THEN
                    //   BEGIN
                    //     ShiptoName := "Sales Invoice Header"."Ship-to Name";
                    if "Sales Invoice Header"."Ship-to Address" <> '' then begin
                        ShiptoAddress := "Sales Invoice Header"."Ship-to Address" + ',' + "Sales Invoice Header"."Ship-to Address 2";
                    end
                    else begin
                        ShiptoAddress := '';
                    end;
                    if "Sales Invoice Header"."Ship-to County" <> '' then begin
                        ShiptoCR := "Sales Invoice Header"."Ship-to County" + ',' + "Sales Invoice Header"."Ship-to Post Code";
                    end;

                    //    END;
                    // ELSE
                    //   BEGIN
                    //     ShiptoName := "Sales Invoice Header"."Sell-to Customer Name";
                    //          IF "Sales Invoice Header"."Ship-to County" <> '' THEN
                    //       BEGIN
                    //     ShiptoAddress := "Sales Invoice Header"."Ship-to Address" + ',' + "Sales Invoice Header"."Ship-to Address 2";
                    //         END;
                    //       IF "Sales Invoice Header"."Sell-to County" <> '' THEN
                    //       BEGIN
                    //
                    //
                    //          ShiptoCR := "Sales Invoice Header"."Sell-to County" + ',' + "Sales Invoice Header"."Sell-to Post Code";
                    //          ShiptoPh := "Sales Invoice Header"."Sell-to Phone No.";
                    //       END;
                    //    END;

                    PaymentTermR.Reset;
                    PaymentTermR.SetRange(Code, "Sales Invoice Header"."Payment Terms Code");
                    if PaymentTermR.FindFirst then begin
                        PaymentTerm := PaymentTermR.Description;
                    end;

                    PaymentMethodR.Reset;
                    PaymentMethodR.SetRange(Code, "Sales Invoice Header"."Payment Method Code");
                    if PaymentMethodR.FindFirst then begin
                        PaymentMethod := PaymentMethodR.Description;
                    end;

                    if "Sales Invoice Header"."Ship-to City" <> '' then begin
                        ShiptoCR1 := "Sales Invoice Header"."Ship-to City" + ',' + ' ' + "Sales Invoice Header"."Ship-to County";
                    end
                    else begin
                        ShiptoCR1 := '';
                    end;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SelltoCusInfo: Text;
        ShiptoName: Text;
        ShiptoAddress: Text;
        ShiptoCR: Text;
        CountryRegion: Record "Country/Region";
        ShiptoPh: Text;
        CompanyInfo: Text;
        LocAddress: Text;
        LocationR: Record Location;
        LocCity: Text;
        LocPhone: Text;
        PaymentTermR: Record "Payment Terms";
        PaymentMethodR: Record "Payment Method";
        PaymentTerm: Text;
        PaymentMethod: Text;
        ShiptoCR1: Text;
        ItemVariantR: Record "Item Variant";
        //VarDescription: Text;
        VATAmount: Decimal;


}

