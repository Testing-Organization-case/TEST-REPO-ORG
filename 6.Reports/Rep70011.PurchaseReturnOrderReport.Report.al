report 70011 "Purchase Return Order Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/PurchaseReturnOrderReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(BuyfromAddress_PurchaseHeader; "Purchase Header"."Buy-from Address")
            {
            }
            column(DocumentDate_PurchaseHeader; "Purchase Header"."Document Date")
            {
            }
            column(VATRegistrationNo_PurchaseHeader; "Purchase Header"."VAT Registration No.")
            {
            }
            column(YourReference_PurchaseHeader; "Purchase Header"."Your Reference")
            {
            }
            column(BuyfromCity_PurchaseHeader; "Purchase Header"."Buy-from City")
            {
            }
            column(BuyfromCounty_PurchaseHeader; "Purchase Header"."Buy-from County")
            {
            }
            column(LocationCode_PurchaseHeader; "Purchase Header"."Location Code")
            {
            }
            column(Status_PurchaseHeader; "Purchase Header".Status)
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(CRCode; CRCode)
            {
            }
            column(Page_Lbl; Page_Lbl)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(LocAddress; LocAddress)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(VariantCode_PurchaseLine; "Purchase Line"."Variant Code")
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(PackagingInfo_PurchaseLine; "Purchase Line"."Packaging Info")
                {
                }
                column(UnitCost_PurchaseLine; "Purchase Line"."Unit Cost")
                {
                }
                column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %")
                {
                }
                column(InvDiscountAmount_PurchaseLine; "Purchase Line"."Inv. Discount Amount")
                {
                }
                // column(VDesc; VDesc)
                // {
                // }
                column(LocCity; LocCity)
                {
                }
                column(LocPhone; LocPhone)
                {
                }
                column(Type_PurchaseLine; "Purchase Line".Type)
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                {
                }
                column(InvDiscPercent; InvDiscPercent)
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(Subtotal; Subtotal)
                {
                }
                column(SubTotalAmount; SubTotalAmount)
                {
                }
                column(LineDisc; LineDisc)
                {
                }
                column(SumTotalAmt; SumTotalAmt)
                {
                }
                column(InvoiceDisAmount; InvoiceDisAmount)
                {
                }
                column(InvPer; InvPer)
                {
                }
                column(LocationAddress; LocationAddress)
                {
                }

                trigger OnAfterGetRecord()
                begin





                    DiscG := "Purchase Line"."Line Discount %" / 100;
                    DiscountG := "Purchase Line"."Direct Unit Cost" * "Purchase Line".Quantity * DiscG;
                    TotalAmount := "Purchase Line"."Direct Unit Cost" * "Purchase Line".Quantity - DiscountG;


                    LineDisc := Format("Purchase Line"."Line Discount %") + '%';

                    if "Purchase Line"."Line Discount %" = 0 then begin
                        LineDisc := '-';
                    end;




                    if "Purchase Line".Type = "Purchase Line".Type::Item then begin
                        if "Purchase Line"."Location Code" <> '' then begin
                            LocationR.Reset;
                            LocationR.SetRange(Code, "Purchase Line"."Location Code");
                            if LocationR.FindFirst then begin


                                LocationAddress := LocationR.Address;
                                LocCity := LocationR.City + ',' + LocationR."Post Code";
                                LocPhone := LocationR.County;

                            end;
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CountryRegionR.Reset;
                CountryRegionR.SetRange(Code, "Purchase Header"."Buy-from Country/Region Code");
                if CountryRegionR.FindFirst then begin
                    CRCode := CountryRegionR.Name;
                end;

                VATAmount := 0;
                if "Purchase Header"."No." <> '' then begin
                    PurchaseLineTable.Reset;
                    PurchaseLineTable.SetRange("Document No.", "Purchase Header"."No.");
                    PurchaseLineTable.CalcSums("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                    VATAmount := PurchaseLineTable."Amount Including VAT" - PurchaseLineTable.Amount;
                    Subtotal += PurchaseLineTable."Line Amount";
                    InvDiscAmt += PurchaseLineTable."Inv. Discount Amount";
                    if InvDiscAmt <> 0 then begin
                        InvPer := ((InvDiscAmt / Subtotal) * 100);
                        InvDiscPercent := Format(Round((InvDiscAmt / Subtotal) * 100, 0.001)) + '%';


                    end
                    else begin
                        InvDiscPercent := '-';
                    end;
                end;
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
        //VDesc: Text;
        CRCode: Text;
        CountryRegionR: Record "Country/Region";
        VariantDesc: Record "Item Variant";
        LocationR: Record Location;
        LocAddress: Text;
        LocCity: Text;
        LocPhone: Text;
        TotalAmount: Decimal;
        DiscG: Decimal;
        DiscountG: Decimal;
        PurchaseLineTable: Record "Purchase Line";
        VATAmount: Decimal;
        Subtotal: Decimal;
        InvDiscAmt: Decimal;
        InvDiscPercent: Text;
        SubTotalAmount: Decimal;
        InvPer: Decimal;
        Page_Lbl: Label 'Page';
        LineDisc: Text;
        SubTotalDiscG: Decimal;
        SubTotalDiscountG: Decimal;
        SumTotalAmt: Decimal;
        InvoiceDisAmount: Decimal;
        InvDiscG: Decimal;
        InvDiscountG: Decimal;
        LocationAddress: Text;
}

