report 70020 "Customer Sales POS Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/CustomerSalesPOSReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem("Trans. Sales Entry"; "LSC Trans. Sales Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                RequestFilterFields = Date, "Location Code", "Item No.";
                column(ItemNo_TransSalesEntry; "Trans. Sales Entry"."Item No.")
                {
                }
                column(Quantity_TransSalesEntry; "Trans. Sales Entry".Quantity)
                {
                }
                column(ItemDesc; ItemDesc)
                {
                }
                column(UnitofMeasure_TransSalesEntry; "Trans. Sales Entry"."Unit of Measure")
                {
                }
                column(CustomerNo_TransSalesEntry; "Trans. Sales Entry"."Customer No.")
                {
                }
                column(LocationCode_TransSalesEntry; "Trans. Sales Entry"."Location Code")
                {
                }
                column(Date_TransSalesEntry; "Trans. Sales Entry".Date)
                {
                }
                column(VariantCode_TransSalesEntry; "Trans. Sales Entry"."Variant Code")
                {
                }
                column(VDesc; VDesc)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ItemR.Reset;
                    ItemR.SetRange("No.", "Trans. Sales Entry"."Item No.");
                    if ItemR.FindFirst then begin
                        ItemDesc := ItemR.Description;
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

    trigger OnPreReport()
    begin
        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
    end;

    var
        ItemDesc: Text;
        ItemR: Record Item;
        CustFilter: Text;
        FormatDocument: Codeunit "Format Document";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        VDesc: Text;
        ItemVariantR: Record "Item Variant";
}

