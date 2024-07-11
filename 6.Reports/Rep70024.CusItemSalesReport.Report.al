report 70024 CusItemSalesReport
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/CusItemSalesReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            column(Quantity; "Value Entry"."Valued Quantity")
            {
            }
            column(Item_No_; "Value Entry"."Item No.")
            {
            }
            column(PostingDate; "Value Entry"."Posting Date")
            {
            }
            column(LocationCode; "Value Entry"."Location Code")
            {
            }
            column(InvoicedQuantity; "Value Entry"."Invoiced Quantity")
            {
            }
            column(DiscountAmount; "Value Entry"."Discount Amount")
            {
            }
            column(CostAmountActual; "Value Entry"."Cost Amount (Actual)")
            {
            }
            column(CostAmount; "Value Entry"."Cost Amount (Non-Invtbl.)")
            {
            }
            column(SalesAmountActual; "Value Entry"."Sales Amount (Actual)")
            {
            }
            column(CustomerNo; "Value Entry"."Source No.")
            {
            }
            column(Description; "Value Entry".Description)
            {
            }
            column(CustomerName; customerName)
            {
            }
            column(Profit; profit)
            {
            }
            column(ProfitPercent; profitPer)
            {
            }
            column(StartDate; startDate)
            {
            }
            column(EndDate; endDate)
            {
            }
            column(Location; locatCode)
            {
            }
            column(TodayDate; TDate)
            {
            }
            column(VariantCode; "Value Entry"."Variant Code")
            {
            }
            column(VarDesc; VarDesc)
            {
            }
            column(UnitPrice; UnitPrice)
            {
            }
            column(UOM; UOM)
            {
            }
            column(ItemQty; ItemQty)
            {
            }

            trigger OnAfterGetRecord()
            begin
                customerName := GetCustomerName("Value Entry"."Source No.");
                //profit := "Value Entry"."Sales Amount (Actual)" + "Value Entry"."Cost Amount (Actual)" + "Value Entry"."Cost Amount (Non-Invtbl.)";

                VarDesc := '';
                UOM := '';
                ItemVairant.Reset;
                ItemVairant.SetRange("Item No.", "Value Entry"."Item No.");
                ItemVairant.SetRange(Code, "Value Entry"."Variant Code");
                if ItemVairant.FindFirst then begin

                    VarDesc := ItemVairant."Description 2";

                end;
                ItemR.Reset;
                ItemR."No." := "Value Entry"."Item No.";
                if ItemR.Find('=') then
                    UOM := ItemR."Base Unit of Measure";


                ItemQty := 0;

                ValueEntryR.Reset;
                ValueEntryR.SetRange("Item No.", "Value Entry"."Item No.");
                ValueEntryR.SetRange("Source No.", "Value Entry"."Source No.");
                ValueEntryR.SetRange("Posting Date", startDate, endDate);
                ValueEntryR.SetRange("Source Type", ValueEntryR."Source Type"::Customer);
                ValueEntryR.SetRange("Item Ledger Entry Type", ValueEntryR."Item Ledger Entry Type"::Sale);
                ValueEntryR.SetRange("Document Type", ValueEntryR."Document Type"::"Sales Invoice");
                if ValueEntryR.FindFirst then begin

                    ValueEntryR.CalcSums("Invoiced Quantity");
                    ItemQty := ValueEntryR."Invoiced Quantity" * (-1);

                end;
            end;

            trigger OnPostDataItem()
            begin
                //GetProfit;
            end;

            trigger OnPreDataItem()
            begin
                if (startDate <> 0D) and (endDate <> 0D) then
                    "Value Entry".SetRange("Posting Date", startDate, endDate);

                if locatCode <> '' then
                    "Value Entry".SetRange("Location Code", locatCode);

                "Value Entry".SetRange("Item Ledger Entry Type", "Value Entry"."Item Ledger Entry Type"::Sale);
                "Value Entry".SetRange("Document Type", "Value Entry"."Document Type"::"Sales Invoice");

                if custNo <> '' then
                    "Value Entry".SetFilter("Source No.", custNo);

                TDate := Today;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control10014501)
                {
                    ShowCaption = false;
                    field(startDate; startDate)
                    {
                        Caption = 'Starting Date';
                        ShowMandatory = true;
                    }
                    field(endDate; endDate)
                    {
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
                    field(locatCode; locatCode)
                    {
                        Caption = 'Location Code';
                        TableRelation = Location;
                    }
                    field(custNo; custNo)
                    {
                        Caption = 'Customer No';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CustomerList: Page "Customer List";
                        begin

                            Clear(CustomerList);
                            CustomerList.LookupMode := true;
                            if CustomerList.RunModal = ACTION::LookupOK then
                                Text := CustomerList.GetSelectionFilter
                            else
                                exit(false);
                            exit(true);
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        startDate: Date;
        endDate: Date;
        locatCode: Code[30];
        profit: Decimal;
        customerName: Text[100];
        profitPer: Decimal;
        ValueEntryBuffer: Record "Value Entry";
        TDate: Date;
        custNo: Code[100];
        ItemVairant: Record "Item Variant";
        VarDesc: Text;
        UnitPrice: Decimal;
        SalesPriceR: Record "Sales Price";
        ItemLedEntryR: Record "Item Ledger Entry";
        UOM: Code[10];
        ItemR: Record Item;
        ItemQty: Decimal;
        ValueEntryR: Record "Value Entry";

    local procedure GetCustomerName(SourceNo: Code[20]) CustName: Text[100]
    var
        CustomerR: Record Customer;
        VendorR: Record Vendor;
    begin
        CustomerR.Reset();
        CustomerR."No." := SourceNo;
        if CustomerR.Find('=') then
            CustName := CustomerR.Name;
        if CustName = '' then begin
            VendorR.Reset;
            VendorR."No." := SourceNo;
            if VendorR.Find('=') then
                CustName := VendorR.Name;
        end;
        exit(CustName);
    end;

    local procedure GetProfit()
    begin
        ValueEntryBuffer.Reset;
        if (startDate <> 0D) and (endDate <> 0D) then
            ValueEntryBuffer.SetRange("Posting Date", startDate, endDate);
        if locatCode <> '' then
            ValueEntryBuffer.SetRange("Location Code", locatCode);
        if custNo <> '' then
            ValueEntryBuffer.SetRange("Source No.", custNo);
        ValueEntryBuffer.SetRange("Item No.", ValueEntryBuffer."Item No.");
        ValueEntryBuffer.SetRange("Item Ledger Entry Type", ValueEntryBuffer."Item Ledger Entry Type"::Sale);
        ValueEntryBuffer.SetRange("Document Type", ValueEntryBuffer."Document Type"::"Sales Invoice");
        if ValueEntryBuffer.FindSet then
            repeat
                ValueEntryBuffer.CalcSums("Sales Amount (Actual)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)");
                profit := ValueEntryBuffer."Sales Amount (Actual)" + ValueEntryBuffer."Cost Amount (Actual)" + ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                if (profit <> 0) and (ValueEntryBuffer."Sales Amount (Actual)" <> 0) then
                    profitPer := (profit / ValueEntryBuffer."Sales Amount (Actual)") * 100;
            until ValueEntryBuffer.Next = 0;
    end;
}

