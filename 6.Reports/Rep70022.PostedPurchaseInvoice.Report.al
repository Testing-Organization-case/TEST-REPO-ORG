report 70022 "Posted Purchase Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/PostedPurchaseInvoice.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(PostingDate_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(DueDate_PurchInvHeader; "Purch. Inv. Header"."Due Date")
            {
            }
            column(LocationCode_PurchInvHeader; "Purch. Inv. Header"."Location Code")
            {
            }
            column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
            {
            }
            column(DocumentDate_PurchInvHeader; "Purch. Inv. Header"."Document Date")
            {
            }
            column(InvoiceDiscountAmount_PurchInvHeader; "Purch. Inv. Header"."Invoice Discount Amount")
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(CountryName; CountryName)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(VendorAddress; VendorAddress)
            {
            }
            column(VendorCountryName; VendorCountryName)
            {
            }
            column(PaymentTerm; PaymentTerm)
            {
            }
            column(CurrencyCode_PurchInvHeader; "Purch. Inv. Header"."Currency Code")
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(No_PurchInvLine; "Purch. Inv. Line"."No.")
                {
                }
                column(Description_PurchInvLine; "Purch. Inv. Line".Description)
                {
                }
                column(UnitofMeasure_PurchInvLine; "Purch. Inv. Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(LineDiscount_PurchInvLine; "Purch. Inv. Line"."Line Discount %")
                {
                }
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                column(PackagingInfo_PurchInvLine; "Purch. Inv. Line"."Packaging Info")
                {
                }

                column(DirectUnitCost_PurchInvLine; "Purch. Inv. Line"."Direct Unit Cost")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                Location.Reset;
                Location.SetRange(Code, "Purch. Inv. Header"."Location Code");
                if Location.FindSet then
                    repeat
                        Name := Location.Name;
                        Address := Location.Address;
                        Country.Reset;
                        Country.SetRange(Code, Location."Country/Region Code");
                        if Country.FindSet then
                            repeat
                                CountryName := Country.Name;
                            until Country.Next = 0;
                    until Location.Next = 0;

                Vendor.Reset;
                Vendor.SetRange("No.", "Purch. Inv. Header"."Buy-from Vendor No.");
                if Vendor.FindSet then
                    repeat
                        VendorName := Vendor.Name;
                        VendorAddress := Vendor.Address;
                        Country.Reset;
                        Country.SetRange(Code, Vendor."Country/Region Code");
                        if Country.FindSet then
                            repeat
                                VendorCountryName := Country.Name;
                            until Country.Next = 0;
                    until Vendor.Next = 0;

                PaymentTermR.Reset;
                PaymentTermR.SetRange(Code, "Purch. Inv. Header"."Payment Terms Code");
                if PaymentTermR.FindSet then
                    repeat
                        PaymentTerm := PaymentTermR.Description;
                    until PaymentTermR.Next = 0;
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
        Location: Record Location;
        Name: Code[100];
        Address: Code[100];
        CountryName: Text;
        Country: Record "Country/Region";
        Vendor: Record Vendor;
        VendorName: Code[100];
        VendorAddress: Code[100];
        VendorCountryName: Text;
        PaymentTerm: Text;
        PaymentTermR: Record "Payment Terms";
}

