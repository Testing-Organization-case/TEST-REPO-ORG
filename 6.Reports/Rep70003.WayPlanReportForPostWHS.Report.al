report 70003 "WayPlan Report For PostWHS"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/WayPlanReportForPostWHS.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Posted Whse. Shipment Header"; "Posted Whse. Shipment Header")
        {
            column(RouteNo; "Posted Whse. Shipment Header"."Route No.")
            {
            }
            column(SequenceNo; "Posted Whse. Shipment Header"."Sequence No.")
            {
            }
            column(ExpectedArrivalTime; "Posted Whse. Shipment Header"."Expected Arrival")
            {
            }
            column(ExpectedUnloadingTime; "Posted Whse. Shipment Header"."Unloading Time")
            {
            }
            column(TruckID; "Posted Whse. Shipment Header"."Truck ID")
            {
            }
            column(NoOfBulkUnits; "Posted Whse. Shipment Header"."Number of Bult Units")
            {
            }
            column(Driver; "Posted Whse. Shipment Header".Driver)
            {
            }
            column(Dock_BayNumber; "Posted Whse. Shipment Header"."Dock/Bay Lane Number")
            {
            }
            column(Priority; "Posted Whse. Shipment Header".Priority)
            {
            }
            column(RouteID; RouteID)
            {
            }
            column(Truck_ID; TruckID)
            {
            }
            column(DriverID; DriverID)
            {
            }
            column(Date; Date)
            {
            }
            column(Name; NameP)
            {
            }
            column(Address; Address1)
            {
            }
            column(Address2; Address2)
            {
            }
            dataitem("Packaging Information"; "Packaging Information")
            {
                DataItemLink = "Document No." = FIELD("Whse. Shipment No.");
                column(itemNo; "Packaging Information"."Item No.")
                {
                }
                column(Description; "Packaging Information".Description)
                {
                }
                column(Qty; "Packaging Information".Quantity)
                {
                }
                column(PackagingRefNo; "Packaging Information"."Packaging Ref No.")
                {
                }
                column(ReasonCode; "Packaging Information"."Reason Code")
                {
                }
                column(PackagingType; "Packaging Information"."Packaging Type")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                // LocationP.RESET;
                // LocationP.SETRANGE(Code,"Posted Whse. Shipment Header"."Location Code");
                // IF LocationP.FINDSET THEN
                //  REPEAT
                //    NameP    := LocationP.Name;
                //    Address1 := LocationP.Address + LocationP."Address 2";
                //   // Address2 := LocationP."Address 2";
                //    UNTIL LocationP.NEXT =0; //IF LocationP.FINDSET THEN

                PostedWhShiLine.Reset;
                PostedWhShiLine.SetRange("No.", "Posted Whse. Shipment Header"."No.");
                PostedWhShiLine.SetRange("Whse. Shipment No.", "Posted Whse. Shipment Header"."Whse. Shipment No.");
                if PostedWhShiLine.FindSet then
                    repeat

                        //  OrderNo := WarehouseShipmentLine."Source No.";

                        // Outbound Transfer
                        if PostedWhShiLine."Source Document" = PostedWhShiLine."Source Document"::"Outbound Transfer" then begin
                            TransferShipHeader.Reset;
                            TransferShipHeader.SetRange("Transfer Order No.", PostedWhShiLine."Source No.");
                            if TransferShipHeader.FindFirst then begin
                                LocationP.Reset;
                                LocationP.SetRange(Code, TransferShipHeader."Transfer-to Code");
                                if LocationP.FindFirst then begin

                                    NameP := LocationP.Name;
                                    Address1 := LocationP.Address + LocationP."Address 2" + LocationP."Post Code" + LocationP.City;

                                end; //IF LocationP.FINDFIRST THEN

                            end; //IF TransferShipmentHeader.FINDFIRST THEN
                        end; // IF WarehouseShipmentLine."Source Document" := WarehouseShipmentLine."Source Document"::"Outbound Transfer" THEN

                        // Sale Order
                        if PostedWhShiLine."Source Document" = PostedWhShiLine."Source Document"::"Sales Order" then begin

                            SalesShipmentHeader.Reset;
                            SalesShipmentHeader.SetRange("Order No.", PostedWhShiLine."Source No.");
                            if SalesShipmentHeader.FindFirst then begin
                                //NameP    := LocationP.Name;
                                Address1 := SalesShipmentHeader."Sell-to Address" + SalesShipmentHeader."Sell-to Address 2" + SalesShipmentHeader."Sell-to Post Code" + SalesShipmentHeader."Sell-to City";

                            end;// IF SaleHeader.FINDFIRST THEN
                        end; // IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Order" THEN

                    //    // Purchase Order
                    //     IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Purchase Order" THEN
                    //     BEGIN
                    //
                    //       PurchaseHeader.RESET;
                    //       PurchaseHeader.SETRANGE("No.",WarehouseShipmentLine."Source No.");
                    //       IF PurchaseHeader.FINDFIRST THEN
                    //         BEGIN
                    //             //NameP := PurchaseHeader.
                    //             Address1 := PurchaseHeader."Ship-to Address" + PurchaseHeader."Ship-to Address 2" + PurchaseHeader."Ship-to Post Code" + PurchaseHeader."Ship-to City" + PurchaseHeader."Ship-to County";
                    //
                    //           END;// IF PurchaseHeader.FINDFIRST THEN
                    //       END; //  IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Purchase Order" THEN
                    //

                    until PostedWhShiLine.Next = 0;
            end;

            trigger OnPreDataItem()
            begin

                if RouteID <> '' then begin
                    "Posted Whse. Shipment Header".SetRange("Route No.", RouteID);
                end;
                if RouteID = '' then begin

                    Error('Please Enter Route ID....');

                end;

                if Date <> 0D then begin
                    "Posted Whse. Shipment Header".SetRange("Posting Date", Date);
                end;

                if Date = 0D then begin

                    Error('Please Enter Date....');
                end;

                if TruckID <> '' then begin
                    "Posted Whse. Shipment Header".SetRange("Truck ID", TruckID);
                end;

                // IF DriverID <> '' THEN
                //  BEGIN
                //    "Posted Whse. Shipment Header".SETRANGE(Driver,DriverID);
                //    END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Filter")
                {
                    Caption = 'Filter';
                    field(Date; Date)
                    {
                        Caption = 'Date';
                    }
                    field(RouteID; RouteID)
                    {
                        Caption = 'Route No.';
                    }
                    field(TruckID; TruckID)
                    {
                        Caption = 'Truck ID';
                        TableRelation = "Truck Registration";
                    }
                    field(DriverID; DriverID)
                    {
                        Caption = 'Driver ID';
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
        Date: Date;
        RouteID: Code[50];
        TruckID: Code[50];
        DriverID: Text;
        NameP: Text[100];
        Address1: Text[100];
        Address2: Text[100];
        LocationP: Record Location;
        PostedWhShiLine: Record "Posted Whse. Shipment Line";
        TransferHeader: Integer;
        SalesShipmentHeader: Record "Sales Shipment Header";
        TransferShipHeader: Record "Transfer Shipment Header";
}

