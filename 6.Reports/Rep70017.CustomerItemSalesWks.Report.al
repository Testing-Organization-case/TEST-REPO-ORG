report 70017 "Customer Item Sales Wks."
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
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
        LineNoL: Integer;
        CustomerR: Record Customer;
        CusItemR: Record CustomerItemSales;
        CusNoReq: Code[50];
        ValueEntryR: Record "Value Entry";
        ItemVariantR: Record "Item Variant";
        ItemUOMR: Record "Item Unit of Measure";
        PostingDateFrom: Date;
        PostingDateTo: Date;
        ValueEntryBuffer: Record "Value Entry";
        Item: Record Item;
        TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
        CustFilter: Text;
        ValueEntryFilter: Text;
        PeriodText: Text;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        EntryInBufferExists: Boolean;
        CurrPage: Page CustomerItemSalesPage;
        LineAmt: Decimal;
        LineDis: Decimal;
        ValueEntryBuffer1: Record "Value Entry";
        TransSalesEntry: Record "LSC Trans. Sales Entry";
        TransSalesEntryBuffer: Record "LSC Trans. Sales Entry";
        ItemNoReq: Code[100];
        VarCodeReq: Code[50];

    local procedure GetInfo()
    begin
        CusItemR.DeleteAll;
        LineNoL := 1;
        CustomerR.Reset;
        CustomerR.SetRange("No.", CusNoReq);
        if CustomerR.FindSet then
            repeat

                if (CusNoReq <> '') and (ItemNoReq = '') and (PostingDateFrom = 0D) and (PostingDateTo = 0D) then begin
                    TransSalesEntry.Reset;
                    TransSalesEntry.SetRange("Customer No.", CusNoReq);

                    if TransSalesEntry.FindSet then
                        repeat
                            CusItemR.Reset;
                            if CusItemR.FindLast then begin
                                LineNoL := CusItemR."No." + 1;
                            end;

                            CusItemR.Init;
                            CusItemR."No." := LineNoL;
                            CusItemR."Item No." := TransSalesEntry."Item No.";
                            //CusItemR.Description := TransSalesEntry.Description;
                            CusItemR."Post Date" := TransSalesEntry.Date;
                            CusItemR."Customer No." := TransSalesEntry."Customer No.";



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

                            TransSalesEntryBuffer.Reset;
                            TransSalesEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                            TransSalesEntryBuffer.SetRange("Customer No.", CusItemR."Customer No.");

                            if TransSalesEntryBuffer.FindSet then
                                repeat
                                    TransSalesEntryBuffer.CalcSums(Quantity);
                                    TransSalesEntryBuffer.CalcSums("Net Amount");
                                    TransSalesEntryBuffer.CalcSums("Discount Amount");
                                    CusItemR.Amount := TransSalesEntryBuffer."Net Amount" * -1;
                                    CusItemR."Invoiced Quantity" := TransSalesEntryBuffer.Quantity * -1;

                                    CusItemR."Discount Amount" := TransSalesEntryBuffer."Discount Amount" * -1;
                                until TransSalesEntryBuffer.Next = 0;




                            CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";

                            CusItemR.Reset;
                            CusItemR.SetRange("Item No.", CusItemR."Item No.");
                            CusItemR.SetRange("Customer No.", CusItemR."Customer No.");

                            if CusItemR.FindSet then
                                repeat
                                    CusItemR.Delete;
                                until CusItemR.Next = 0;
                            CusItemR.Insert;


                        until TransSalesEntry.Next = 0;
                end
                else
                    if (CusNoReq <> '') and (ItemNoReq <> '') and (PostingDateFrom = 0D) and (PostingDateTo = 0D) then begin
                        TransSalesEntry.Reset;
                        TransSalesEntry.SetRange("Customer No.", CusNoReq);
                        TransSalesEntry.SetRange("Item No.", ItemNoReq);

                        if TransSalesEntry.FindSet then
                            repeat
                                CusItemR.Reset;
                                if CusItemR.FindLast then begin
                                    LineNoL := CusItemR."No." + 1;
                                end;

                                CusItemR.Init;
                                CusItemR."No." := LineNoL;
                                CusItemR."Item No." := TransSalesEntry."Item No.";
                                //CusItemR.Description := TransSalesEntry.Description;
                                CusItemR."Post Date" := TransSalesEntry.Date;

                                CusItemR."Customer No." := TransSalesEntry."Customer No.";


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

                                TransSalesEntryBuffer.Reset;
                                TransSalesEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                                TransSalesEntryBuffer.SetRange("Customer No.", CusItemR."Customer No.");

                                if TransSalesEntryBuffer.FindSet then
                                    repeat
                                        TransSalesEntryBuffer.CalcSums(Quantity);
                                        TransSalesEntryBuffer.CalcSums("Net Amount");
                                        TransSalesEntryBuffer.CalcSums("Discount Amount");
                                        CusItemR.Amount := TransSalesEntryBuffer."Net Amount" * -1;
                                        CusItemR."Invoiced Quantity" := TransSalesEntryBuffer.Quantity * -1;

                                        CusItemR."Discount Amount" := TransSalesEntryBuffer."Discount Amount" * -1;
                                    until TransSalesEntryBuffer.Next = 0;




                                CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";

                                CusItemR.Reset;
                                CusItemR.SetRange("Item No.", CusItemR."Item No.");
                                CusItemR.SetRange("Customer No.", CusItemR."Customer No.");

                                if CusItemR.FindSet then
                                    repeat
                                        CusItemR.Delete;
                                    until CusItemR.Next = 0;
                                CusItemR.Insert;


                            until TransSalesEntry.Next = 0;
                    end else
                        if (CusNoReq <> '') and (ItemNoReq <> '') and (PostingDateFrom <> 0D) and (PostingDateTo <> 0D) then begin
                            TransSalesEntry.Reset;
                            TransSalesEntry.SetRange("Customer No.", CusNoReq);
                            TransSalesEntry.SetRange("Item No.", ItemNoReq);
                            TransSalesEntry.SetRange(Date, PostingDateFrom, PostingDateTo);
                            if TransSalesEntry.FindSet then
                                repeat
                                    CusItemR.Reset;
                                    if CusItemR.FindLast then begin
                                        LineNoL := CusItemR."No." + 1;
                                    end;

                                    CusItemR.Init;
                                    CusItemR."No." := LineNoL;
                                    CusItemR."Item No." := TransSalesEntry."Item No.";
                                    //CusItemR.Description := TransSalesEntry.Description;
                                    CusItemR."Post Date" := TransSalesEntry.Date;

                                    CusItemR."Customer No." := TransSalesEntry."Customer No.";



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

                                    TransSalesEntryBuffer.Reset;
                                    TransSalesEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                                    TransSalesEntryBuffer.SetRange("Customer No.", CusItemR."Customer No.");

                                    TransSalesEntryBuffer.SetRange(Date, PostingDateFrom, PostingDateTo);
                                    if TransSalesEntryBuffer.FindSet then
                                        repeat
                                            TransSalesEntryBuffer.CalcSums(Quantity);
                                            TransSalesEntryBuffer.CalcSums("Net Amount");
                                            TransSalesEntryBuffer.CalcSums("Discount Amount");
                                            CusItemR.Amount := TransSalesEntryBuffer."Net Amount" * -1;
                                            CusItemR."Invoiced Quantity" := TransSalesEntryBuffer.Quantity * -1;

                                            CusItemR."Discount Amount" := TransSalesEntryBuffer."Discount Amount" * -1;
                                        until TransSalesEntryBuffer.Next = 0;




                                    CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";

                                    CusItemR.Reset;
                                    CusItemR.SetRange("Item No.", CusItemR."Item No.");
                                    CusItemR.SetRange("Customer No.", CusItemR."Customer No.");

                                    if CusItemR.FindSet then
                                        repeat
                                            CusItemR.Delete;
                                        until CusItemR.Next = 0;
                                    CusItemR.Insert;


                                until TransSalesEntry.Next = 0;
                        end
                        else
                            if (CusNoReq <> '') and (ItemNoReq = '') and (PostingDateFrom <> 0D) and (PostingDateTo <> 0D) then begin
                                TransSalesEntry.Reset;
                                TransSalesEntry.SetRange("Customer No.", CusNoReq);

                                TransSalesEntry.SetRange(Date, PostingDateFrom, PostingDateTo);
                                if TransSalesEntry.FindSet then
                                    repeat
                                        CusItemR.Reset;
                                        if CusItemR.FindLast then begin
                                            LineNoL := CusItemR."No." + 1;
                                        end;

                                        CusItemR.Init;
                                        CusItemR."No." := LineNoL;
                                        CusItemR."Item No." := TransSalesEntry."Item No.";
                                        //CusItemR.Description := TransSalesEntry.Description;
                                        CusItemR."Post Date" := TransSalesEntry.Date;

                                        CusItemR."Customer No." := TransSalesEntry."Customer No.";



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

                                        TransSalesEntryBuffer.Reset;
                                        TransSalesEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                                        TransSalesEntryBuffer.SetRange("Customer No.", CusItemR."Customer No.");

                                        TransSalesEntryBuffer.SetRange(Date, PostingDateFrom, PostingDateTo);
                                        if TransSalesEntryBuffer.FindSet then
                                            repeat
                                                TransSalesEntryBuffer.CalcSums(Quantity);
                                                TransSalesEntryBuffer.CalcSums("Net Amount");
                                                TransSalesEntryBuffer.CalcSums("Discount Amount");
                                                CusItemR.Amount := TransSalesEntryBuffer."Net Amount" * -1;
                                                CusItemR."Invoiced Quantity" := TransSalesEntryBuffer.Quantity * -1;

                                                CusItemR."Discount Amount" := TransSalesEntryBuffer."Discount Amount" * -1;
                                            until TransSalesEntryBuffer.Next = 0;




                                        CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";

                                        CusItemR.Reset;
                                        CusItemR.SetRange("Item No.", CusItemR."Item No.");
                                        CusItemR.SetRange("Customer No.", CusItemR."Customer No.");

                                        if CusItemR.FindSet then
                                            repeat
                                                CusItemR.Delete;
                                            until CusItemR.Next = 0;
                                        CusItemR.Insert;


                                    until TransSalesEntry.Next = 0;
                            end;









            until CustomerR.Next = 0;

    end;

    local procedure GetInfo1()
    begin
        CusItemR.DeleteAll;
        LineNoL := 1;
        CustomerR.Reset;
        CustomerR.SetRange("No.", CusNoReq);
        if CustomerR.FindSet then
            repeat

                if (CusNoReq <> '') and (PostingDateFrom <> 0D) and (PostingDateTo <> 0D) then begin
                    ValueEntryR.Reset;
                    ValueEntryR.SetRange("Source No.", CusNoReq);
                    ValueEntryR.SetRange("Posting Date", PostingDateFrom, PostingDateTo);
                    if ValueEntryR.FindSet then
                        repeat
                            CusItemR.Reset;
                            if CusItemR.FindLast then begin
                                LineNoL := CusItemR."No." + 1;
                            end;

                            CusItemR.Init;
                            CusItemR."No." := LineNoL;
                            CusItemR."Item No." := ValueEntryR."Item No.";
                            CusItemR.Description := ValueEntryR.Description;

                            CusItemR."Customer No." := ValueEntryR."Source No.";
                            //CusItemR.Amount:= ValueEntryR."Sales Amount (Actual)";
                            CusItemR."Discount Amount" := ValueEntryR."Discount Amount";
                            CusItemR."Invoiced Quantity" := ValueEntryR."Invoiced Quantity";

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
                                until Item.Next = 0;

                            ValueEntryBuffer.Reset;
                            ValueEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                            ValueEntryBuffer.SetRange("Source No.", CusItemR."Customer No.");
                            ValueEntryBuffer.SetRange("Posting Date", PostingDateFrom, PostingDateTo);
                            if ValueEntryBuffer.FindSet then
                                repeat
                                    ValueEntryBuffer.CalcSums("Invoiced Quantity");
                                    ValueEntryBuffer.CalcSums("Sales Amount (Actual)");
                                    ValueEntryBuffer.CalcSums("Discount Amount");
                                    ValueEntryBuffer.CalcSums("Cost Amount (Actual)");
                                    ValueEntryBuffer.CalcSums("Cost Amount (Non-Invtbl.)");
                                    CusItemR."Invoiced Quantity" := ValueEntryBuffer."Invoiced Quantity" * -1;
                                    CusItemR.Amount := ValueEntryBuffer."Sales Amount (Actual)";
                                    CusItemR."Discount Amount" := ValueEntryBuffer."Discount Amount" * -1;
                                    CusItemR.Profit :=
                                           ValueEntryBuffer."Sales Amount (Actual)" +
                                           ValueEntryBuffer."Cost Amount (Actual)" +
                                           ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                                    if (CusItemR.Profit <> 0) and (CusItemR.Amount <> 0) then begin
                                        CusItemR."Profit %" := (CusItemR.Profit / CusItemR.Amount) * 100;
                                    end;

                                until ValueEntryBuffer.Next = 0;



                            CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";
                            CusItemR."Posting Date" := 'Posting Date : ' + Format(PostingDateFrom) + '..' + Format(PostingDateTo);




                            CusItemR.Reset;
                            CusItemR.SetRange("Item No.", CusItemR."Item No.");
                            CusItemR.SetRange("Customer No.", CusItemR."Customer No.");
                            if CusItemR.FindSet then
                                repeat
                                    CusItemR.Delete;
                                until CusItemR.Next = 0;
                            CusItemR.Insert;


                        until ValueEntryR.Next = 0;
                end
                else begin
                    if (CusNoReq <> '') and (PostingDateFrom = 0D) and (PostingDateTo = 0D) then begin
                        ValueEntryR.Reset;
                        ValueEntryR.SetRange("Source No.", CusNoReq);
                        if ValueEntryR.FindSet then
                            repeat
                                CusItemR.Reset;
                                if CusItemR.FindLast then begin
                                    LineNoL := CusItemR."No." + 1;
                                end;

                                CusItemR.Init;
                                CusItemR."No." := LineNoL;
                                CusItemR."Item No." := ValueEntryR."Item No.";
                                CusItemR.Description := ValueEntryR.Description;

                                CusItemR."Customer No." := ValueEntryR."Source No.";
                                //CusItemR.Amount:= ValueEntryR."Sales Amount (Actual)";
                                CusItemR."Discount Amount" := ValueEntryR."Discount Amount";
                                CusItemR."Invoiced Quantity" := ValueEntryR."Invoiced Quantity";

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
                                    until Item.Next = 0;

                                ValueEntryBuffer.Reset;
                                ValueEntryBuffer.SetRange("Item No.", CusItemR."Item No.");
                                ValueEntryBuffer.SetRange("Source No.", CusItemR."Customer No.");

                                if ValueEntryBuffer.FindSet then
                                    repeat
                                        ValueEntryBuffer.CalcSums("Invoiced Quantity");
                                        ValueEntryBuffer.CalcSums("Sales Amount (Actual)");
                                        ValueEntryBuffer.CalcSums("Discount Amount");
                                        ValueEntryBuffer.CalcSums("Cost Amount (Actual)");
                                        ValueEntryBuffer.CalcSums("Cost Amount (Non-Invtbl.)");
                                        CusItemR."Invoiced Quantity" := ValueEntryBuffer."Invoiced Quantity" * -1;
                                        CusItemR.Amount := ValueEntryBuffer."Sales Amount (Actual)";
                                        CusItemR."Discount Amount" := ValueEntryBuffer."Discount Amount" * -1;
                                        CusItemR.Profit :=
                                               ValueEntryBuffer."Sales Amount (Actual)" +
                                               ValueEntryBuffer."Cost Amount (Actual)" +
                                               ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                                        if (CusItemR.Profit <> 0) and (CusItemR.Amount <> 0) then begin
                                            CusItemR."Profit %" := (CusItemR.Profit / CusItemR.Amount) * 100;
                                        end;


                                    until ValueEntryBuffer.Next = 0;




                                CusItemR.CustomerInfo := 'Customer No : ' + CusItemR."Customer No." + ' ' + ' ' + ' ' + 'Name : ' + CusItemR."Customer Name";




                                // CusItemR."Invoiced Quantity":=ValueEntryR."Invoiced Quantity"* -1;

                                CusItemR.Reset;
                                CusItemR.SetRange("Item No.", CusItemR."Item No.");
                                CusItemR.SetRange("Customer No.", CusItemR."Customer No.");
                                if CusItemR.FindSet then
                                    repeat
                                        CusItemR.Delete;
                                    until CusItemR.Next = 0;
                                CusItemR.Insert;
                            until ValueEntryR.Next = 0;
                    end;

                end;
            until CustomerR.Next = 0;







    end;
}

