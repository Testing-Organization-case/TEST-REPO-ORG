pageextension 70071 "Purchase Order List Extension" extends "Purchase Order List"
{
    layout
    {
        addafter(Status)
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("Job Queue Status")
        {
            field("A. Rcd. Not Inv. Ex. VAT (LCY)"; Rec."A. Rcd. Not Inv. Ex. VAT (LCY)")
            {
                ApplicationArea = All;
            }
            field("Amt. Rcd. Not Invoiced (LCY)"; Rec."Amt. Rcd. Not Invoiced (LCY)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Description")
        {
            field("CPO No."; Rec."CPO No.")
            {
                ApplicationArea = All;
            }
            field("CPO Confirm"; Rec."CPO Confirm")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            action(NAVAttributes)
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    PurchaseAttributeListL: Page PurchaseAttributesList;
                begin
                    // @22_Jun_2021_02_09_PM
                    CLEAR(PurchaseAttributeListL);
                    PurchaseAttributeListL.SetPurchaseDocumentNo(Rec."No.");
                    PurchaseAttributeListL.RUN;
                end;
            }

        }
        addafter(TestReport)
        {
            action("Consolidate PO")
            {
                Caption = 'Consolidate PO';
                ApplicationArea = All;
                Image = TestReport;
                Ellipsis = true;
                RunObject = page "Consolidate Purchase Order";
                RunPageOnRec = false;
                RunPageMode = Create;
            }
        }
        addafter(RemoveFromJobQueue)
        {
            action("Set Net Cost")
            {
                Caption = 'Set Net Cost';
                Image = SelectLineToApply;
                trigger OnAction()
                var
                    SelectionFilterManagement: Codeunit SelectionFilterManagement;
                    SelectionFilter1: Text;
                    PORecord: Record "Purchase Header";
                    PurchLine: Record "Purchase Line";
                    Answer: Boolean;
                    PurchPriceWorksheet: Record "Purchase Price";
                    VendorTradeSchemeR: Record "Vendor Trade Scheme";
                    PurHeader: Record "Purchase Header";
                    CustomizeFunction: Codeunit CustomizeFunctions;
                begin
                    Answer := CONFIRM('Are you sure to set Net Cost And Scheme for selected PO?', FALSE);
                    IF Answer = TRUE THEN BEGIN
                        CurrPage.SETSELECTIONFILTER(PORecord);
                        //SelectionFilter1 := SelectionFilterManagement.GetSelectionFilterForPORecord(PORecord);
                        SelectionFilter1 := CustomizeFunction.GetSelectionFilterForPORecord(PORecord);//Modify by CSH
                        //Message('NetCost');
                        IF SelectionFilter1 <> '' THEN BEGIN
                            PurchLine.SETFILTER("Document No.", SelectionFilter1);
                            IF PurchLine.FINDSET THEN
                                REPEAT
                                    IF PurchLine."Net Price" > 0 THEN BEGIN
                                        //Net Price already existed 
                                    END ELSE BEGIN
                                        PurchPriceWorksheet.RESET;
                                        PurchPriceWorksheet.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
                                        PurchPriceWorksheet.SETRANGE("Item No.", PurchLine."No.");
                                        PurchPriceWorksheet.SETRANGE("Unit of Measure Code", PurchLine."Unit of Measure Code");
                                        //PurchPriceWorksheet.SETRANGE("Variant Code", PurchLine."Variant Code");
                                        IF PurchPriceWorksheet.FINDSET THEN
                                            REPEAT

                                                PurHeader.RESET;
                                                PurHeader.SETRANGE("No.", PurchLine."Document No.");
                                                IF PurHeader.FINDFIRST THEN BEGIN
                                                    IF ((PurchPriceWorksheet."Starting Date" <> 0D) AND (PurchPriceWorksheet."Ending Date" <> 0D)) THEN BEGIN
                                                        //                        PurchPriceWorksheet.SETFILTER("Starting Date",'<=%1',PurHeader."Document Date");
                                                        //                        PurchPriceWorksheet.SETFILTER("Ending Date",'>=%1',PurHeader."Document Date");
                                                        IF ((PurchPriceWorksheet."Starting Date" <= PurHeader."Document Date") AND (PurchPriceWorksheet."Ending Date" >= PurHeader."Document Date")) THEN BEGIN
                                                            PurchLine."Net Price" := PurchPriceWorksheet."Net Price";
                                                            PurchLine.MODIFY(TRUE);
                                                        END;
                                                    END ELSE
                                                        IF PurchPriceWorksheet."Ending Date" = 0D THEN BEGIN
                                                            IF PurchPriceWorksheet."Starting Date" <= PurHeader."Document Date" THEN BEGIN
                                                                PurchLine."Net Price" := PurchPriceWorksheet."Net Price";
                                                                PurchLine.MODIFY(TRUE);
                                                            END;
                                                        END;
                                                END;

                                            UNTIL PurchPriceWorksheet.NEXT = 0;
                                    END;
                                    BEGIN
                                        VendorTradeSchemeR.RESET;
                                        VendorTradeSchemeR.SETRANGE("Vendor No.", PurchLine."Buy-from Vendor No.");
                                        VendorTradeSchemeR.SETRANGE("Item No.", PurchLine."No.");
                                        //VendorTradeSchemeR.SETRANGE("Variant Code", PurchLine."Variant Code");
                                        IF VendorTradeSchemeR.FINDFIRST THEN BEGIN
                                            PurchLine.Scheme := VendorTradeSchemeR.Scheme;
                                            PurchLine.MODIFY(TRUE);
                                        END;
                                    END;
                                UNTIL PurchLine.NEXT = 0;
                            MESSAGE('Net Costs And Scheme are successfully set in related Purchase Lines.')
                        END ELSE
                            MESSAGE('Please select PO to set Net Cost!');
                    END;
                end;
            }
        }
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action(PrintNWMM)
            {
                ApplicationArea = Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader := Rec;
                    CurrPage.SetSelectionFilter(PurchaseHeader);
                    REPORT.RUNMODAL(70014, TRUE, FALSE, PurchaseHeader);
                end;
            }
        }
    }

}

