report 70012 "Purchase Cr. Memo Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/PurchaseCrMemoReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            column(CRCode; CRCode)
            {
            }
            column(Page_Lbl; Page_Lbl)
            {
            }
            column(PostingDate_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Posting Date")
            {
            }
            column(ReturnOrderNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Return Order No.")
            {
            }
            column(BuyfromAddress_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Address")
            {
            }
            column(BuyfromCity_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from City")
            {
            }
            column(BuyfromCounty_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from County")
            {
            }
            column(BuyfromVendorNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Vendor No.")
            {
            }
            column(No_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(PaytoVendorNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Pay-to Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
            {
            }
            column(DocumentDate_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Document Date")
            {
            }
            column(PreAssignedNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Pre-Assigned No.")
            {
            }
            column(ReturnOrderNo; ReturnOrderNo)
            {
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(LocAddress; LocAddress)
                {
                }
                column(TotalAmount; TotalAmount)
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
                column(InvDiscPercent; InvDiscPercent)
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
                column(Type_PurchCrMemoLine; "Purch. Cr. Memo Line".Type)
                {
                }
                column(No_PurchCrMemoLine; "Purch. Cr. Memo Line"."No.")
                {
                }
                column(Description_PurchCrMemoLine; "Purch. Cr. Memo Line".Description)
                {
                }
                column(UnitofMeasure_PurchCrMemoLine; "Purch. Cr. Memo Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchCrMemoLine; "Purch. Cr. Memo Line".Quantity)
                {
                }
                column(LineDiscount_PurchCrMemoLine; "Purch. Cr. Memo Line"."Line Discount %")
                {
                }
                column(VariantCode_PurchCrMemoLine; "Purch. Cr. Memo Line"."Variant Code")
                {
                }
                column(PackagingInfo_PurchCrMemoLine; "Purch. Cr. Memo Line"."Packaging Info")
                {
                }
                column(UnitCost_PurchCrMemoLine; "Purch. Cr. Memo Line"."Unit Cost")
                {
                }
                column(InvDiscountAmount_PurchCrMemoLine; "Purch. Cr. Memo Line"."Inv. Discount Amount")
                {
                }
                column(LineAmount_PurchCrMemoLine; "Purch. Cr. Memo Line"."Line Amount")
                {
                }
                column(Amount_PurchCrMemoLine; "Purch. Cr. Memo Line".Amount)
                {
                }
                column(LocationCode_PurchCrMemoLine; "Purch. Cr. Memo Line"."Location Code")
                {
                }
                column(DirectUnitCost_PurchCrMemoLine; "Purch. Cr. Memo Line"."Direct Unit Cost")
                {
                }

                trigger OnAfterGetRecord()
                begin


                    if "Purch. Cr. Memo Line"."Location Code" <> '' then begin
                        LocationR.Reset;
                        LocationR.SetRange(Code, "Purch. Cr. Memo Line"."Location Code");
                        if LocationR.FindFirst then begin

                            LocationAddress := LocationR.Address + LocationR."Address 2";

                            LocCity := LocationR.City + ',' + LocationR."Post Code";
                            LocPhone := LocationR.County;

                        end;
                    end;




                    DiscG := "Purch. Cr. Memo Line"."Line Discount %" / 100;
                    DiscountG := "Purch. Cr. Memo Line"."Direct Unit Cost" * "Purch. Cr. Memo Line".Quantity * DiscG;
                    TotalAmount := "Purch. Cr. Memo Line"."Direct Unit Cost" * "Purch. Cr. Memo Line".Quantity - DiscountG;
                    SumTotalAmt += "Purch. Cr. Memo Line"."Direct Unit Cost" * "Purch. Cr. Memo Line".Quantity - DiscountG;

                    SubTotalDiscG += TotalAmount;


                    LineDisc := Format("Purch. Cr. Memo Line"."Line Discount %") + '%';

                    if "Purch. Cr. Memo Line"."Line Discount %" = 0 then begin
                        LineDisc := '-';
                    end;





                end;
            }

            trigger OnAfterGetRecord()
            begin
                CountryRegionR.Reset;
                CountryRegionR.SetRange(Code, "Purch. Cr. Memo Hdr."."Buy-from Country/Region Code");
                if CountryRegionR.FindFirst then begin
                    CRCode := CountryRegionR.Name;
                end;

                if "Purch. Cr. Memo Hdr."."Pre-Assigned No." <> '' then begin
                    ReturnOrderNo := "Purch. Cr. Memo Hdr."."Pre-Assigned No.";
                end
                else
                    if "Purch. Cr. Memo Hdr."."Return Order No." <> '' then begin
                        ReturnOrderNo := "Purch. Cr. Memo Hdr."."Return Order No.";
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
        PurchaseCrMemoLineTable: Record "Purchase Line";
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
        ReturnOrderNo: Text;
}

