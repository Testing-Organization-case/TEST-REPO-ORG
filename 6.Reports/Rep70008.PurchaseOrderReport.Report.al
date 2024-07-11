report 70008 "Purchase Order Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/PurchaseOrderReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
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
            column(No_PurchaseHeader; "Purchase Header"."No.")
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

                trigger OnAfterGetRecord()
                begin
                    "Purchase Line".SetFilter("No.", '<>%1', '');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GetVendorInfo; //Added by HHA
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
        CurrReportPageNoCaptionLbl: Label 'Page';

    local procedure GetVendorInfo()
    var
        VendorRec: Record Vendor;
        PaymentTermRec: Record "Payment Terms";
        ShipmentMethodRec: Record "Shipment Method";
        VendorBankRec: Record "Vendor Bank Account";
    begin
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

        VATAmount := 0;
        if "Purchase Header"."No." <> '' then begin
            PurchaseLineTable.Reset;
            PurchaseLineTable.SetRange("Document No.", "Purchase Header"."No.");
            PurchaseLineTable.CalcSums("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
            VATAmount := PurchaseLineTable."Amount Including VAT" - PurchaseLineTable.Amount;
            Subtotal += PurchaseLineTable."Line Amount";
            InvDiscAmt += PurchaseLineTable."Inv. Discount Amount";
            InvDiscPercent := Round((InvDiscAmt / Subtotal) * 100, 0.001);
        end; //Added by HHA

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

