page 70058 CustomerItemSalesPage
{
    Editable = false;
    PageType = ListPart;
    SourceTable = CustomerItemSales;
    SourceTableTemporary = false;

    layout
    {
        area(content)
        {
            field(CustomerInfo; Rec.CustomerInfo)
            {
            }
            field("Posting Date"; Rec."Posting Date")
            {
                Visible = false;
            }
            repeater(Group)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field(Date; Rec."Post Date")
                {
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }

                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    Visible = false;
                }
            }
            group("Customer/Item Sales Total")
            {
                Caption = 'Customer/Item Sales Total';
                Visible = false;
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Total Discount Amount"; Rec."Total Discount Amount")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin


        CusItemR.SetRange("Customer No.", Rec."Customer No.");

        CusItemR.CalcSums(Amount);
        CusItemR.CalcSums("Discount Amount");
        LineAmt := CusItemR.Amount;
        LineDis := CusItemR."Discount Amount";
        Rec."Total Amount" := LineAmt;
        Rec."Total Discount Amount" := LineDis;
        Rec.Modify(true);
    end;

    trigger OnOpenPage()
    begin
        // ValueEntryBuffer.RESET;
        // ValueEntryBuffer.SETRANGE("Item No.",CusItemR."Item No.");
        // ValueEntryBuffer.SETRANGE("Source No.",CusItemR."Customer No.");
        // //ValueEntryBuffer.SETRANGE("Posting Date",PostingDateFrom,PostingDateTo);
        // IF ValueEntryBuffer.FINDSET THEN
        //  REPEAT
        //  ValueEntryBuffer.CALCSUMS("Invoiced Quantity");
        //  ValueEntryBuffer.CALCSUMS("Sales Amount (Actual)");
        //  ValueEntryBuffer.CALCSUMS("Discount Amount");
        //  ValueEntryBuffer.CALCSUMS("Cost Amount (Actual)");
        //  ValueEntryBuffer.CALCSUMS("Cost Amount (Non-Invtbl.)");
        // //  CusItemR."Invoiced Quantity":= ValueEntryBuffer."Invoiced Quantity"*-1;
        // //  CusItemR.Amount := ValueEntryBuffer."Sales Amount (Actual)";
        // //  CusItemR."Discount Amount" := ValueEntryBuffer."Discount Amount" * -1;
        //  Rec.Profit :=
        //        ValueEntryBuffer."Sales Amount (Actual)" +
        //        ValueEntryBuffer."Cost Amount (Actual)" +
        //        ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
        //        IF (CusItemR.Profit <>0)AND(CusItemR.Amount<>0) THEN
        //          BEGIN
        //              Rec."Profit %" := (CusItemR.Profit / CusItemR.Amount) * 100;
        //          END;
        //  Rec.MODIFY;
        //  UNTIL ValueEntryBuffer.NEXT=0;
    end;

    var
        //CustomerItemSalesNWMM: Query CustomerItemSalesNWMM;
        CustomerR: Record Customer;
        CusItemR: Record CustomerItemSales;
        LineNo: Integer;
        ValueEntryR: Record "Value Entry";
        LineAmt: Decimal;
        LineDis: Decimal;
        ValueEntryBuffer: Record "Value Entry";
}

