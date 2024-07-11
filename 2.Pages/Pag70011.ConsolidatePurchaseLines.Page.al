page 70011 "Consolidate Purchase Lines"
{
    PageType = List;
    SourceTable = "Consolidate Purchase Line";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Direct Unit Cost Excl. VAT"; Rec."Direct Unit Cost Excl. VAT")
                {
                }
                field("Net Cost Price"; Rec."Net Cost Price")
                {
                }
                field("Total Dis AMT"; Rec."Total Dis AMT")
                {
                }
                field("Line Amount Excl. VAT"; Rec."Line Amount Excl. VAT")
                {
                }
                field("Scheme Code"; Rec."Scheme Code")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(MaxQtyperUOM; Rec.MaxQtyperUOM)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Purchase Order List")
            {

                trigger OnAction()
                var
                    SelectionFilterManagement: Codeunit SelectionFilterManagement;
                    LoopCount: Integer;
                    SelectionFilter1: Text;
                    AlreadyExist: Boolean;
                    CuzFunction: Codeunit CustomizeFunctions;          //Modify By MK
                begin
                    Commit;
                    CPOHeader.Reset;
                    CPOHeader.SetRange("No.", Rec."Document No.");
                    if CPOHeader.FindFirst then begin
                        if CPOHeader."Vendor No." = '' then
                            Error('"Vendor No." must be filled to get related purchase order!');

                        Clear(POListPage);
                        PORecord.Reset;
                        PORecord.SetRange("Buy-from Vendor No.", CPOHeader."Vendor No.");
                        PORecord.SetRange("CPO Confirm", false);
                        PORecord.SetCurrentKey("No.");
                        PORecord.Ascending;
                        POListPage.SetTableView(PORecord);
                        POListPage.LookupMode(true);
                        if POListPage.RunModal in [ACTION::LookupOK, ACTION::LookupOK] then begin
                            POListPage.SetSelectionFilter(PORecord);
                            SelectionFilter1 := CuzFunction.GetSelectionFilterForPORecord(PORecord);        // Fix SelectionFilterManagement to CuzFunction / Jan252024
                            Message('SelectionFilter1 %1', SelectionFilter1);
                            if SelectionFilter1 <> '' then begin
                                AlreadyExist := false;
                                PORecord.Reset;
                                PORecord.SetFilter("No.", SelectionFilter1);
                                if PORecord.FindSet then
                                    if PORecord."CPO Confirm" = true then begin
                                        AlreadyExist := true;
                                    end;


                                //         IF AlreadyExist = FALSE THEN
                                //         BEGIN
                                //         SalesShptLine.RESET;
                                // //         SalesShptLine.SETFILTER("Document No.",SelectionFilter1);
                                // //         SalesShptLine.SETFILTER("Line No.",SelectionFilter2);
                                //         SalesShptLine.SETFILTER(DocumentNoLineNo,SelectionFilter3);
                                //         SalesShptLine.SETRANGE(Type,SalesShptLine.Type::Item);
                                //         SalesShptLine.SETCURRENTKEY("Line No.");
                                //         IF SalesShptLine.FINDSET THEN
                                //          REPEAT
                                //            DemandLine.SETCURRENTKEY("Sales Shipment No");
                                //            DemandLine.INIT;
                                //            DemandLine."Demand Order No." := Rec."Demand Order No.";
                                //            DemandLine."Line No." += 1;
                                //            DemandLine.VALIDATE("Customer No.",SalesShptLine."Sell-to Customer No.");
                                //            DemandLine.VALIDATE("Sale Order No.",SalesShptLine."Order No.");
                                //            DemandLine.VALIDATE(Quantity,SalesShptLine.Quantity);
                                //            DemandLine.VALIDATE(Location,SalesShptLine."Location Code");
                                //            DemandLine.VALIDATE("Unit of Measure",SalesShptLine."Unit of Measure");
                                //            DemandLine.VALIDATE("Item Code",SalesShptLine."No.");
                                //            DemandLine.VALIDATE("Item Description",SalesShptLine.Description);
                                //            DemandLine.VALIDATE("Sales Shipment No",SalesShptLine."Document No.");
                                //            DemandLine.VALIDATE("Sales Shipment Line No",SalesShptLine."Line No.");
                                //            DemandLine.INSERT(TRUE);
                                //          UNTIL SalesShptLine.NEXT = 0;
                                //
                                //           CalculateTotalQty;
                                //
                                //          END ELSE
                                //          ERROR('Some selected lines already existed in Demand Order!');
                            end;
                        end;
                    end;
                end;
            }
        }
    }

    var
        CPOHeader: Record "Consolidate Purchase Header";
        POListPage: Page "Purchase Order List";
        PORecord: Record "Purchase Header";
}

