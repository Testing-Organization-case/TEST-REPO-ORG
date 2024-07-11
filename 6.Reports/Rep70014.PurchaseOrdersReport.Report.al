report 70014 "Purchase Orders Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/PurchaseOrdersReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(PurchNo; PurchNo)
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(BuyfromAddress_PurchaseHeader; "Purchase Header"."Buy-from Address")
            {
            }
            column(BuyfromCounty_PurchaseHeader; "Purchase Header"."Buy-from County")
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(Email; Email)
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(PaymentTerm; PaymentTerm)
            {
            }
            column(ShipmentMethod; ShipmentMethod)
            {
            }
            column(ShiptoName_PurchaseHeader; "Purchase Header"."Ship-to Name")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCounty_PurchaseHeader; "Purchase Header"."Ship-to County")
            {
            }
            column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
            {
            }
            column(DocumentDate_PurchaseHeader; "Purchase Header"."Document Date")
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(BankNo; BankNo)
            {
            }
            column(BankName; BankName)
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
            column(CurrReportPageNoCaptionLbl; CurrReportPageNoCaptionLbl)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(ItemReferenceNo_PurchaseLine; "Purchase Line"."Item Reference No.")
                {
                }
                column(VariantDescriptions_PurchaseLine; VariantDescription)
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Purchase Line"."Line Discount Amount")
                {
                }
                column(InvDiscountAmount_PurchaseLine; "Purchase Line"."Inv. Discount Amount")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(InvDiscPercent; InvDiscPercent)
                {
                }
                column(TotalAmt; TotalAmt)
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(SumLineAmt; SumLineAmt)
                {
                }
                column(TotalLineAmt; TotalLineAmt)
                {
                }
                column(SumInvdisAmt; SumInvdisAmt)
                {
                }
                column(TotalInvDisPercent; TotalInvDisPercent)
                {
                }
                // column(VariantDescription; VariantDescription)
                // {
                // }

                trigger OnAfterGetRecord()
                begin
                    //"Purchase Line".SETRANGE(Type,"Purchase Line".Type::Item);
                    VATAmount := 0;
                    TotalAmt := 0;
                    SumLineAmt := 0;
                    SumInvdisAmt := 0;
                    Subtotal := 0;
                    InvDiscAmt := 0;
                    InvDiscPercent := 0;

                    if "Purchase Header"."No." <> '' then begin
                        "Purchase Line".Reset;
                        "Purchase Line".SetRange("Document No.", "Purchase Header"."No.");
                        "Purchase Line".CalcSums(Amount, "Amount Including VAT", "Inv. Discount Amount");
                        VATAmount := "Purchase Line"."Amount Including VAT" - "Purchase Line".Amount;
                        Subtotal += "Purchase Line"."Line Amount";
                        InvDiscAmt += "Purchase Line"."Inv. Discount Amount";
                        TotalInvDisPercent += InvDiscPercent;
                        TotalLineAmt := "Purchase Line"."Line Amount";
                        "Purchase Line".CalcSums("Line Amount");
                        SumLineAmt += "Purchase Line"."Line Amount";
                        SumInvdisAmt += "Purchase Line"."Inv. Discount Amount";
                        if InvDiscAmt <> 0 then begin
                            InvDiscPercent := Round(("Purchase Line"."Inv. Discount Amount" / SumLineAmt) * 100, 0.001);
                        end
                        else begin
                            InvDiscPercent := 0;
                        end;

                        if SumLineAmt <> 0 then begin
                            TotalAmt := (SumLineAmt - SumInvdisAmt) + VATAmount;
                        end
                        else begin
                            TotalAmt := 0;
                        end;
                    end; //Added by HHA


                end;
            }

            trigger OnAfterGetRecord()
            var
                PurchHeader: Record "Purchase Header";
            begin

                GetVendorInfo;// Added by HHA
            end;

            trigger OnPreDataItem()
            var
                PurchHeader: Record "Purchase Header";
            begin
            end;
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
        PhoneNo: Text;
        Email: Text;
        PaymentTerm: Text;
        ShipmentMethod: Text;
        BankNo: Code[20];
        BankName: Text;
        VATAmount: Decimal;
        PurchaseLineTable: Record "Purchase Line";
        Subtotal: Decimal;
        InvDiscAmt: Decimal;
        InvDiscPercent: Decimal;
        ShiptoName: Text;
        ShiptoAddress: Text;
        ShiptoCR: Text;
        CountryRegion: Record "Country/Region";
        SumLineAmt: Decimal;
        SumInvdisAmt: Decimal;
        TotalAmt: Decimal;
        PurchNo: Code[10];
        CurrReportPageNoCaptionLbl: Label 'Page';
        TotalLineAmt: Decimal;
        TotalInvDisPercent: Decimal;
        VariantDescription: Text;
        VariantR: Record "Item Variant";

    local procedure GetVendorInfo()
    var
        VendorRec: Record Vendor;
        PaymentTermRec: Record "Payment Terms";
        ShipmentMethodRec: Record "Shipment Method";
        VendorBankRec: Record "Vendor Bank Account";
    begin
        TotalAmt := 0;
        VendorRec.Reset;
        VendorRec.SetRange("No.", "Purchase Header"."Buy-from Vendor No.");
        if VendorRec.FindFirst then begin
            PhoneNo := VendorRec."Phone No.";
            Email := VendorRec."E-Mail";
            BankNo := VendorRec."Preferred Bank Account Code";
            VendorBankRec.Reset;
            VendorBankRec.SetRange(Code, BankNo);
            if VendorBankRec.FindFirst then begin
                BankName := VendorBankRec.Name;
                BankNo := VendorBankRec."Bank Account No.";
            end;
        end; //Added by HHA

        PaymentTermRec.Reset;
        PaymentTermRec.SetRange(Code, "Purchase Header"."Payment Terms Code");
        if PaymentTermRec.FindFirst then begin
            PaymentTerm := PaymentTermRec.Description;
        end;

        ShipmentMethodRec.Reset;
        ShipmentMethodRec.SetRange(Code, "Purchase Header"."Shipment Method Code");
        if ShipmentMethodRec.FindFirst then begin
            ShipmentMethod := ShipmentMethodRec.Description;
        end;

        if "Purchase Header"."Ship-to Name" = '' then begin
            ShiptoName := "Purchase Header"."Buy-from Vendor Name";
            ShiptoAddress := "Purchase Header"."Buy-from Address" + ',' + "Purchase Header"."Buy-from Address 2";
            CountryRegion.Reset;
            CountryRegion.SetRange(Code, "Purchase Header"."Buy-from Country/Region Code");
            if CountryRegion.FindFirst then begin
                ShiptoCR := CountryRegion.Name;
            end;
        end
        else begin
            ShiptoName := "Purchase Header"."Ship-to Name";
            ShiptoAddress := "Purchase Header"."Ship-to Address" + ',' + "Purchase Header"."Ship-to Address 2";
            CountryRegion.Reset;
            CountryRegion.SetRange(Code, "Purchase Header"."Ship-to Country/Region Code");
            if CountryRegion.FindFirst then begin
                ShiptoCR := CountryRegion.Name;
            end;
        end
    end;
}

