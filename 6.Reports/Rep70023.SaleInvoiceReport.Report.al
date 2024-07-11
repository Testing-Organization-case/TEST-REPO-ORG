report 70023 "Sale Invoice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/SaleInvoiceReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
            dataitem("Sales Header"; "Sales Header")
            {
                column(SelltoCustomerNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
                {
                }
                column(No_SalesHeader; "Sales Header"."No.")
                {
                }
                column(PostingDate_SalesHeader; "Sales Header"."Posting Date")
                {
                }
                column(DueDate_SalesHeader; "Sales Header"."Due Date")
                {
                }
                column(SalespersonCode_SalesHeader; "Sales Header"."Salesperson Code")
                {
                }
                column(DocumentDate_SalesHeader; "Sales Header"."Document Date")
                {
                }
                column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
                {
                }
                column(PrintDate; PrintDate)
                {
                }
                column(ContactName; ContactName)
                {
                }
                column(PhoneNo; PhoneNo)
                {
                }
                column(WorkDescription_SalesHeader; "Sales Header"."Work Description")
                {
                }
                column(PaymentTermCode; PaymentTermCode)
                {
                }
                column(PaymentMethodCode_SalesHeader; "Sales Header"."Payment Method Code")
                {
                }
                column(InvoiceDiscountAmount_SalesHeader; "Sales Header"."Invoice Discount Amount")
                {
                }
                column(CustomerName; CustomerName)
                {
                }
                column(CustomerAddress; CustomerAddress)
                {
                }
                column(Country; Country)
                {
                }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    column(No_SalesLine; "Sales Line"."No.")
                    {
                    }
                    column(Description_SalesLine; "Sales Line".Description)
                    {
                    }
                    column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                    {
                    }
                    column(Quantity_SalesLine; "Sales Line".Quantity)
                    {
                    }

                    column(VariantCode_SalesLine; "Sales Line"."Variant Code")
                    {
                    }
                    column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
                    {
                    }
                    column(LineDiscountAmount_SalesLine; "Sales Line"."Line Discount Amount")
                    {
                    }
                    column(Amount_SalesLine; "Sales Line".Amount)
                    {
                    }
                    column(LineAmount_SalesLine; "Sales Line"."Line Amount")
                    {
                    }
                    column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                    {
                    }
                    column(LocationCode_SalesLine; "Sales Line"."Location Code")
                    {
                    }
                    column(Name; Name)
                    {
                    }
                    column(Address1; Address1)
                    {
                    }
                    column(Address2; Address2)
                    {
                    }
                    column(LocationCode; LocationCode)
                    {
                    }
                    dataitem(WorkDescriptionLines; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = filter(199999));
                        column(WorkDescriptionLineNumber; Number)
                        {
                        }
                        column(WorkDescriptionLine; WorkDescriptionLine)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            TypeHelper: Codeunit "Type Helper";
                        begin
                            // if WorkDescriptionInstream.EOS then
                            //     CurrReport.Break();
                            // WorkDescriptionInstream.ReadText(WorkDescriptionLine);
                            if WorkDescriptionLines.Number <> 1 then
                                if WorkDescriptionInstream.EOS then
                                    CurrReport.Break();

                            WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInstream, TypeHelper.LFSeparator);
                        end;

                        trigger OnPostDataItem()
                        begin
                            Clear(WorkDescriptionInstream)
                        end;

                        trigger OnPreDataItem()
                        begin

                            if not ShowWorkDescription then
                                CurrReport.Break();
                            "Sales Header"."Work Description".CreateInStream(WorkDescriptionInstream, TextEncoding::UTF8);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin

                        if "Sales Line"."Location Code" <> '' then begin
                            LocationCode := "Sales Line"."Location Code";
                        end
                        else
                            LocationCode := "Sales Header"."Location Code";

                        Location.Reset;
                        Location.SetRange(Code, LocationCode);
                        if Location.FindSet then
                            repeat
                                Name := Location.Name;
                                Address1 := Location.Address;
                                Address2 := Location."Address 2";
                            until Location.Next = 0;

                    end;

                    trigger OnPreDataItem()
                    begin

                        "Sales Line".SetRange("Document Type", "Sales Line"."Document Type"::Invoice);
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    PrintDate := Today;

                    Contact.Reset;
                    Contact.SetRange("No.", "Sales Header"."Sell-to Contact No.");
                    if Contact.FindSet then
                        repeat
                            ContactName := Contact.Name;
                            PhoneNo := Contact."Phone No.";
                        until Contact.Next = 0;

                    PaymentTerm.Reset;
                    PaymentTerm.SetRange(Code, "Sales Header"."Payment Terms Code");
                    if PaymentTerm.FindSet then
                        repeat
                            PaymentTermCode := PaymentTerm.Description;
                        until PaymentTerm.Next = 0;

                    Customer.Reset;
                    Customer.SetRange("No.", "Sales Header"."Sell-to Customer No.");
                    if Customer.FindSet then
                        repeat
                            CustomerName := Customer.Name;
                            CustomerAddress := Customer.Address;

                            CountryR.SetRange(Code, Customer."Country/Region Code");
                            if CountryR.FindSet then
                                repeat
                                    Country := CountryR.Name;
                                until CountryR.Next = 0;
                        until Customer.Next = 0;

                    ShowWorkDescription := "Work Description".HASVALUE;
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
        PrintDate: Date;
        Location: Record Location;
        Name: Text;
        Address1: Text;
        Address2: Text;
        Contact: Record Contact;
        ContactName: Text;
        PhoneNo: Text;
        PaymentTerm: Record "Payment Terms";
        PaymentTermCode: Text;
        Customer: Record Customer;
        CustomerName: Text;
        CustomerAddress: Text;
        CountryR: Record "Country/Region";
        Country: Text;
        LocationCode: Text;
        ShowWorkDescription: Boolean;
        WorkDescriptionLine: Text;
        WorkDescriptionInstream: InStream;
}

