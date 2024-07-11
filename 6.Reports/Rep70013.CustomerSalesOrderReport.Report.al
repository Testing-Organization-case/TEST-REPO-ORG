report 70013 "Customer Sales Order Report"
{
    PreviewMode = Normal;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                //GetProfit;
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
                }
                field(CusNoReq; CusNoReq)
                {
                    Caption = 'Customer No. Filter';
                    TableRelation = Customer;
                    Visible = true;
                }
                field(ItemNoReq; ItemNoReq)
                {
                    Caption = 'Item No. Filter';
                    TableRelation = Item;
                }

                field("From Date"; PostingDateFrom)
                {
                    Caption = 'From Date';
                    Visible = true;
                }
                field("To Date"; PostingDateTo)
                {
                    Caption = 'To Date';
                    Visible = true;
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

    trigger OnPostReport()
    begin
        if CusNoReq = '' then begin
            Error('Customer No. must have a value!');
        end else
            if CusNoReq <> '' then begin
                CurrPage.Run;
            end else
                exit;
        GetInfo;
    end;

    var
        CusNoReq: Code[50];
        ItemNoReq: Code[100];
        VarCodeReq: Code[50];
        PostingDateFrom: Date;
        PostingDateTo: Date;
        CurrPage: Page CustomerItemSalesPageTwo;
        CustomerR: Record Customer;
        CusItemR: Record CustomerItemSales;
        ValueEntry: Record "Value Entry";
        LineNoL: Integer;
        ValueEntryBuffer: Record "Value Entry";
        Item: Record Item;
        ItemVariantR: Record "Item Variant";

    local procedure GetInfo()
    begin
        CusItemR.DeleteAll;
        LineNoL := 1;
        CustomerR.Reset;
        CustomerR.SetRange("No.", CusNoReq);
        if CustomerR.FindSet then
            repeat

                if (CusNoReq <> '') and (ItemNoReq = '') and (PostingDateFrom = 0D) and (PostingDateTo = 0D) then begin
                    ValueEntry.Reset;
                    ValueEntry.SetRange("Source No.", CusNoReq);
                    ValueEntry.SetFilter("Document Type", '<>%1', ValueEntry."Document Type"::" ");
                    if ValueEntry.FindSet then
                        repeat
                            CusItemR.Reset;
                            if CusItemR.FindLast then begin
                                LineNoL := CusItemR."No." + 1;
                            end;

                            CusItemR.Init;
                            CusItemR."No." := LineNoL;
                            CusItemR."Item No." := ValueEntry."Item No.";
                            CusItemR."Post Date" := ValueEntry."Posting Date";
                            CusItemR."Customer No." := ValueEntry."Source No.";



                            CustomerR.Reset;
                            CustomerR.SetRange("No.", CusItemR."Customer No.");
                            if CustomerR.FindSet then
                                repeat
                                    CusItemR."Customer Name" := CustomerR.Name;
                                until CustomerR.Next = 0;

                            Item.Reset;
                            Item.SetRange("No.", CusItemR."Item No.");
                            if Item.FindSet then
                                repeat
                                    CusItemR."Unit of Measure" := Item."Base Unit of Measure";
                                    CusItemR.Description := Item.Description;
                                until Item.Next = 0;

                            ValueEntryBuffer.Reset;
                            ValueEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                            ValueEntryBuffer.SetRange("Source No.", CusItemR."Customer No.");

                            if ValueEntryBuffer.FindSet then
                                repeat
                                    ValueEntryBuffer.CalcSums("Invoiced Quantity");
                                    ValueEntryBuffer.CalcSums("Sales Amount (Actual)");
                                    ValueEntryBuffer.CalcSums("Cost Amount (Actual)");
                                    ValueEntryBuffer.CalcSums("Cost Amount (Non-Invtbl.)");
                                    ValueEntryBuffer.CalcSums("Discount Amount");
                                    CusItemR.Amount := ValueEntryBuffer."Sales Amount (Actual)";  //*-1
                                    CusItemR."Invoiced Quantity" := ValueEntryBuffer."Invoiced Quantity" * -1;

                                    CusItemR."Discount Amount" := ValueEntryBuffer."Discount Amount" * -1;
                                    CusItemR.Profit := ValueEntryBuffer."Sales Amount (Actual)" + ValueEntryBuffer."Cost Amount (Actual)" + ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                                    if (CusItemR.Profit <> 0) and (CusItemR.Amount <> 0) then begin
                                        CusItemR."Profit %" := (CusItemR.Profit / CusItemR.Amount) * 100;
                                    end;
                                until ValueEntryBuffer.Next = 0;


                            CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";

                            CusItemR.Reset;
                            CusItemR.SetRange("Item No.", CusItemR."Item No.");
                            CusItemR.SetRange("Customer No.", CusItemR."Customer No.");
                            if CusItemR.FindSet then
                                repeat
                                    CusItemR.Delete;
                                until CusItemR.Next = 0;
                            CusItemR.Insert;


                        until ValueEntry.Next = 0;
                end
                else
                    if (CusNoReq <> '') and (ItemNoReq <> '') and (PostingDateFrom = 0D) and (PostingDateTo = 0D) then begin
                        ValueEntry.Reset;
                        ValueEntry.SetRange("Source No.", CusNoReq);
                        ValueEntry.SetRange("Item No.", ItemNoReq);

                        if ValueEntry.FindSet then
                            repeat
                                CusItemR.Reset;
                                if CusItemR.FindLast then begin
                                    LineNoL := CusItemR."No." + 1;
                                end;

                                CusItemR.Init;
                                CusItemR."No." := LineNoL;
                                CusItemR."Item No." := ValueEntry."Item No.";
                                //CusItemR.Description := TransSalesEntry.Description;
                                CusItemR."Post Date" := ValueEntry."Posting Date";
                                CusItemR."Customer No." := ValueEntry."Source No.";



                                CustomerR.Reset;
                                CustomerR.SetRange("No.", CusItemR."Customer No.");
                                if CustomerR.FindSet then
                                    repeat
                                        CusItemR."Customer Name" := CustomerR.Name;
                                    until CustomerR.Next = 0;

                                Item.Reset;
                                Item.SetRange("No.", CusItemR."Item No.");
                                if Item.FindSet then
                                    repeat
                                        CusItemR."Unit of Measure" := Item."Base Unit of Measure";
                                        CusItemR.Description := Item.Description;
                                    until Item.Next = 0;

                                ValueEntryBuffer.Reset;
                                ValueEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                                ValueEntryBuffer.SetRange("Source No.", CusItemR."Customer No.");
                                //ValueEntryBuffer.SetRange("Variant Code", CusItemR."Variant Code");
                                if ValueEntryBuffer.FindSet then
                                    repeat
                                        ValueEntryBuffer.CalcSums("Invoiced Quantity");
                                        ValueEntryBuffer.CalcSums("Sales Amount (Actual)");
                                        ValueEntryBuffer.CalcSums("Cost Amount (Actual)");
                                        ValueEntryBuffer.CalcSums("Cost Amount (Non-Invtbl.)");
                                        ValueEntryBuffer.CalcSums("Discount Amount");
                                        CusItemR.Amount := ValueEntryBuffer."Sales Amount (Actual)";    //*-1
                                        CusItemR."Invoiced Quantity" := ValueEntryBuffer."Invoiced Quantity" * -1;

                                        CusItemR."Discount Amount" := ValueEntryBuffer."Discount Amount" * -1;
                                        CusItemR.Profit := ValueEntryBuffer."Sales Amount (Actual)" + +ValueEntryBuffer."Cost Amount (Actual)" + ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                                        if (CusItemR.Profit <> 0) and (CusItemR.Amount <> 0) then begin
                                            CusItemR."Profit %" := (CusItemR.Profit / CusItemR.Amount) * 100;
                                        end;
                                    until ValueEntryBuffer.Next = 0;




                                CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";

                                CusItemR.Reset;
                                CusItemR.SetRange("Item No.", CusItemR."Item No.");
                                CusItemR.SetRange("Customer No.", CusItemR."Customer No.");
                                //CusItemR.SetRange("Variant Code", CusItemR."Variant Code");
                                if CusItemR.FindSet then
                                    repeat
                                        CusItemR.Delete;
                                    until CusItemR.Next = 0;
                                CusItemR.Insert;


                            until ValueEntry.Next = 0;
                    end else
                        if (CusNoReq <> '') and (ItemNoReq <> '') and (PostingDateFrom <> 0D) and (PostingDateTo <> 0D) then begin
                            ValueEntry.Reset;
                            ValueEntry.SetRange("Source No.", CusNoReq);
                            ValueEntry.SetRange("Item No.", ItemNoReq);
                            ValueEntry.SetRange("Posting Date", PostingDateFrom, PostingDateTo);
                            if ValueEntry.FindSet then
                                repeat
                                    CusItemR.Reset;
                                    if CusItemR.FindLast then begin
                                        LineNoL := CusItemR."No." + 1;
                                    end;

                                    CusItemR.Init;
                                    CusItemR."No." := LineNoL;
                                    CusItemR."Item No." := ValueEntry."Item No.";
                                    CusItemR."Post Date" := ValueEntry."Posting Date";
                                    CusItemR."Customer No." := ValueEntry."Source No.";



                                    CustomerR.Reset;
                                    CustomerR.SetRange("No.", CusItemR."Customer No.");
                                    if CustomerR.FindSet then
                                        repeat
                                            CusItemR."Customer Name" := CustomerR.Name;
                                        until CustomerR.Next = 0;

                                    Item.Reset;
                                    Item.SetRange("No.", CusItemR."Item No.");
                                    if Item.FindSet then
                                        repeat
                                            CusItemR."Unit of Measure" := Item."Base Unit of Measure";
                                            CusItemR.Description := Item.Description;
                                        until Item.Next = 0;

                                    ValueEntryBuffer.Reset;
                                    ValueEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                                    ValueEntryBuffer.SetRange("Source No.", CusItemR."Customer No.");
                                    //ValueEntryBuffer.SetRange("Variant Code", CusItemR."Variant Code");
                                    ValueEntryBuffer.SetRange("Posting Date", PostingDateFrom, PostingDateTo);
                                    if ValueEntryBuffer.FindSet then
                                        repeat
                                            ValueEntryBuffer.CalcSums("Invoiced Quantity");
                                            ValueEntryBuffer.CalcSums("Sales Amount (Actual)");
                                            ValueEntryBuffer.CalcSums("Discount Amount");
                                            CusItemR.Amount := ValueEntryBuffer."Sales Amount (Actual)";  //*-1
                                            CusItemR."Invoiced Quantity" := ValueEntryBuffer."Invoiced Quantity" * -1;

                                            CusItemR."Discount Amount" := ValueEntryBuffer."Discount Amount" * -1;
                                            CusItemR.Profit := ValueEntryBuffer."Sales Amount (Actual)" + +ValueEntryBuffer."Cost Amount (Actual)" + ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                                            if (CusItemR.Profit <> 0) and (CusItemR.Amount <> 0) then begin
                                                CusItemR."Profit %" := (CusItemR.Profit / CusItemR.Amount) * 100;
                                            end;
                                        until ValueEntryBuffer.Next = 0;




                                    CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";

                                    CusItemR.Reset;
                                    CusItemR.SetRange("Item No.", CusItemR."Item No.");
                                    CusItemR.SetRange("Customer No.", CusItemR."Customer No.");
                                    //CusItemR.SetRange("Variant Code", CusItemR."Variant Code");
                                    if CusItemR.FindSet then
                                        repeat
                                            CusItemR.Delete;
                                        until CusItemR.Next = 0;
                                    CusItemR.Insert;


                                until ValueEntry.Next = 0;
                        end
                        else
                            if (CusNoReq <> '') and (ItemNoReq = '') and (PostingDateFrom <> 0D) and (PostingDateTo <> 0D) then begin
                                ValueEntry.Reset;
                                ValueEntry.SetRange("Source No.", CusNoReq);

                                ValueEntry.SetRange("Posting Date", PostingDateFrom, PostingDateTo);
                                if ValueEntry.FindSet then
                                    repeat
                                        CusItemR.Reset;
                                        if CusItemR.FindLast then begin
                                            LineNoL := CusItemR."No." + 1;
                                        end;

                                        CusItemR.Init;
                                        CusItemR."No." := LineNoL;
                                        CusItemR."Item No." := ValueEntry."Item No.";
                                        //CusItemR.Description := TransSalesEntry.Description;
                                        CusItemR."Post Date" := ValueEntry."Posting Date";

                                        CusItemR."Customer No." := ValueEntry."Source No.";


                                        CustomerR.Reset;
                                        CustomerR.SetRange("No.", CusItemR."Customer No.");
                                        if CustomerR.FindSet then
                                            repeat
                                                CusItemR."Customer Name" := CustomerR.Name;
                                            until CustomerR.Next = 0;

                                        Item.Reset;
                                        Item.SetRange("No.", CusItemR."Item No.");
                                        if Item.FindSet then
                                            repeat
                                                CusItemR."Unit of Measure" := Item."Base Unit of Measure";
                                                CusItemR.Description := Item.Description;
                                            until Item.Next = 0;

                                        ValueEntryBuffer.Reset;
                                        ValueEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                                        ValueEntryBuffer.SetRange("Source No.", CusItemR."Customer No.");
                                        //ValueEntryBuffer.SetRange("Variant Code", CusItemR."Variant Code");
                                        ValueEntryBuffer.SetRange("Posting Date", PostingDateFrom, PostingDateTo);
                                        if ValueEntryBuffer.FindSet then
                                            repeat
                                                ValueEntryBuffer.CalcSums("Invoiced Quantity");
                                                ValueEntryBuffer.CalcSums("Sales Amount (Actual)");
                                                ValueEntryBuffer.CalcSums("Discount Amount");
                                                CusItemR.Amount := ValueEntryBuffer."Sales Amount (Actual)";  //*-1
                                                CusItemR."Invoiced Quantity" := ValueEntryBuffer."Invoiced Quantity" * -1;

                                                CusItemR."Discount Amount" := ValueEntryBuffer."Discount Amount" * -1;
                                                CusItemR.Profit := ValueEntryBuffer."Sales Amount (Actual)" + +ValueEntryBuffer."Cost Amount (Actual)" + ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                                                if (CusItemR.Profit <> 0) and (CusItemR.Amount <> 0) then begin
                                                    CusItemR."Profit %" := (CusItemR.Profit / CusItemR.Amount) * 100;
                                                end;
                                            until ValueEntryBuffer.Next = 0;




                                        CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";

                                        CusItemR.Reset;
                                        CusItemR.SetRange("Item No.", CusItemR."Item No.");
                                        CusItemR.SetRange("Customer No.", CusItemR."Customer No.");
                                        //CusItemR.SetRange("Variant Code", CusItemR."Variant Code");
                                        if CusItemR.FindSet then
                                            repeat
                                                CusItemR.Delete;
                                            until CusItemR.Next = 0;
                                        CusItemR.Insert;


                                    until ValueEntry.Next = 0;
                            end;
            until CustomerR.Next = 0;
    end;

    local procedure GetProfit()
    begin
        ValueEntryBuffer.Reset;
        ValueEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
        ValueEntryBuffer.SetRange("Source No.", CusItemR."Customer No.");
        ValueEntryBuffer.SetRange("Posting Date", PostingDateFrom, PostingDateTo);
        if ValueEntryBuffer.FindSet then
            repeat
                //  ValueEntryBuffer.CALCSUMS("Invoiced Quantity");
                //  ValueEntryBuffer.CALCSUMS("Sales Amount (Actual)");
                //  ValueEntryBuffer.CALCSUMS("Discount Amount");
                //  ValueEntryBuffer.CALCSUMS("Cost Amount (Actual)");
                //  ValueEntryBuffer.CALCSUMS("Cost Amount (Non-Invtbl.)");
                //  CusItemR."Invoiced Quantity":= ValueEntryBuffer."Invoiced Quantity"*-1;
                //  CusItemR.Amount := ValueEntryBuffer."Sales Amount (Actual)";
                //  CusItemR."Discount Amount" := ValueEntryBuffer."Discount Amount" * -1;
                CusItemR.Profit :=
                      ValueEntryBuffer."Sales Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                if (CusItemR.Profit <> 0) and (CusItemR.Amount <> 0) then begin
                    CusItemR."Profit %" := (CusItemR.Profit / CusItemR.Amount) * 100;
                end;

            until ValueEntryBuffer.Next = 0;
    end;
}

