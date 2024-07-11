report 70009 "Order Confirmation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/OrderConfirmationReport.rdl';
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
            dataitem("Sales Header"; "Sales Header")
            {
                column(SelltoPhoneNo_SalesHeader; "Sales Header"."Sell-to Phone No.")
                {
                }
                column(SelltoCustomerName_SalesHeader; "Sales Header"."Sell-to Customer Name")
                {
                }
                column(SelltoAddress_SalesHeader; "Sales Header"."Sell-to Address")
                {
                }
                column(SelltoAddress2_SalesHeader; "Sales Header"."Sell-to Address 2")
                {
                }
                column(SelltoCity_SalesHeader; "Sales Header"."Sell-to City")
                {
                }
                column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
                {
                }
                column(ShipmentMethodCode_SalesHeader; "Sales Header"."Shipment Method Code")
                {
                }
                column(No_SalesHeader; "Sales Header"."No.")
                {
                }
                column(DocumentDate_SalesHeader; "Sales Header"."Document Date")
                {
                }
                column(SelltoCounty_SalesHeader; "Sales Header"."Sell-to County")
                {
                }
                column(SelltoPostCode_SalesHeader; "Sales Header"."Sell-to Post Code")
                {
                }
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
                column(QuoteNo_SalesHeader; "Sales Header"."Quote No.")
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
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");

                    column(Description_SalesLine; "Sales Line".Description)
                    {
                    }
                    column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                    {
                    }
                    column(Quantity_SalesLine; "Sales Line".Quantity)
                    {
                    }
                    column(PackagingInfo; PackagingInfo)
                    {
                    }
                    column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                    {
                    }
                    column(LineDiscountAmount_SalesLine; "Sales Line"."Line Discount Amount")
                    {
                    }
                    column(InvDiscountAmount_SalesLine; "Sales Line"."Inv. Discount Amount")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        LocationR.Reset;
                        LocationR.SetRange(Code, "Sales Line"."Location Code");
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



                        PackagingInfo := '';
                        ItemPackR.Reset;
                        ItemPackR.SetRange("No.", "Sales Line"."No.");
                        if ItemPackR.FindFirst then begin
                            PackagingInfo := ItemPackR."Packaging Info";
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if "Sales Header"."Sell-to City" <> '' then begin
                        SelltoCusInfo := "Sales Header"."Sell-to City" + ',' + ' ' + "Sales Header"."Sell-to Post Code";
                    end
                    else
                        SelltoCusInfo := '';


                    if "Sales Header"."Ship-to Code" = '' then begin
                        ShiptoName := "Sales Header"."Ship-to Name";
                        if "Sales Header"."Ship-to Address" <> '' then begin
                            ShiptoAddress := "Sales Header"."Ship-to Address" + ',' + "Sales Header"."Ship-to Address 2";
                        end;
                        if "Sales Header"."Ship-to County" <> '' then begin
                            ShiptoCR := "Sales Header"."Ship-to County" + ',' + "Sales Header"."Ship-to Post Code";
                        end;

                    end
                    else begin
                        ShiptoName := "Sales Header"."Sell-to Customer Name";
                        if "Sales Header"."Ship-to County" <> '' then begin
                            ShiptoAddress := "Sales Header"."Ship-to Address" + ',' + "Sales Header"."Ship-to Address 2";
                        end;
                        if "Sales Header"."Sell-to County" <> '' then begin


                            ShiptoCR := "Sales Header"."Sell-to County" + ',' + "Sales Header"."Sell-to Post Code";
                            ShiptoPh := "Sales Header"."Sell-to Phone No.";
                        end;
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
        ItemVariantR: Record "Item Variant";
        //VarDescription: Text;
        ItemPackR: Record Item;
        PackagingInfo: Text;
}

