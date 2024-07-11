report 70002 "Way Plan Detail Report For WHS"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/WayPlanDetailReportForWHS.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            column(RouteNo; "Warehouse Shipment Header"."Route No.")
            {
            }
            column(SequenceNo; "Warehouse Shipment Header"."Sequence No.")
            {
            }
            column(ExpectedArrivalTime; "Warehouse Shipment Header"."Expected Arrival")
            {
            }
            column(ExpectedUnloadingTime; "Warehouse Shipment Header"."Unloading Time")
            {
            }
            column(TruckID; "Warehouse Shipment Header"."Truck ID")
            {
            }
            column(NoOfBulkUnits; "Warehouse Shipment Header"."Number of Bult Units")
            {
            }
            column(Driver; "Warehouse Shipment Header".Driver)
            {
            }
            column(Dock_BayNumber; "Warehouse Shipment Header"."Dock/Bay Lane Number")
            {
            }
            column(Priority; "Warehouse Shipment Header".Priority)
            {
            }
            column(No; "Warehouse Shipment Header"."No.")
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
                DataItemLink = "Document No." = FIELD("No.");
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
                // LocationP.SETRANGE(Code,"Warehouse Shipment Header"."Location Code");
                // IF LocationP.FINDSET THEN
                //  REPEAT
                //    NameP    := LocationP.Name;
                //    Address1 := LocationP.Address + LocationP."Address 2";
                //   // Address2 := LocationP."Address 2";
                //    UNTIL LocationP.NEXT =0; //IF LocationP.FINDSET THEN

                WarehouseShipmentLine.Reset;
                WarehouseShipmentLine.SetRange("No.", "Warehouse Shipment Header"."No.");
                if WarehouseShipmentLine.FindSet then
                    repeat

                        //  OrderNo := WarehouseShipmentLine."Source No.";

                        // Outbound Transfer
                        if WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Outbound Transfer" then begin
                            TransferHeader.Reset;
                            TransferHeader.SetRange("No.", WarehouseShipmentLine."Source No.");
                            if TransferHeader.FindFirst then begin
                                LocationP.Reset;
                                LocationP.SetRange(Code, TransferHeader."Transfer-to Code");
                                if LocationP.FindFirst then begin

                                    NameP := LocationP.Name;
                                    Address1 := LocationP.Address + LocationP."Address 2" + LocationP."Post Code" + LocationP.City;

                                end; //IF LocationP.FINDFIRST THEN

                            end; //IF TransferShipmentHeader.FINDFIRST THEN
                        end; // IF WarehouseShipmentLine."Source Document" := WarehouseShipmentLine."Source Document"::"Outbound Transfer" THEN

                        // Sale Order
                        if WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Order" then begin

                            SaleHeader.Reset;
                            SaleHeader.SetRange("No.", WarehouseShipmentLine."Source No.");
                            if SaleHeader.FindFirst then begin
                                //NameP    := LocationP.Name;
                                Address1 := SaleHeader."Sell-to Address" + SaleHeader."Sell-to Address 2" + SaleHeader."Sell-to Post Code" + SaleHeader."Sell-to City";

                            end;// IF SaleHeader.FINDFIRST THEN
                        end; // IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Order" THEN

                        // Purchase Order
                        if WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Purchase Order" then begin

                            PurchaseHeader.Reset;
                            PurchaseHeader.SetRange("No.", WarehouseShipmentLine."Source No.");
                            if PurchaseHeader.FindFirst then begin
                                //NameP := PurchaseHeader.
                                Address1 := PurchaseHeader."Ship-to Address" + PurchaseHeader."Ship-to Address 2" + PurchaseHeader."Ship-to Post Code" + PurchaseHeader."Ship-to City" + PurchaseHeader."Ship-to County";

                            end;// IF PurchaseHeader.FINDFIRST THEN
                        end; //  IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Purchase Order" THEN


                    until WarehouseShipmentLine.Next = 0;

                // PackagingInfo.RESET;
                // PackagingInfo.SETRANGE("Document No.","Warehouse Shipment Header"."No.");
                // IF PackagingInfo.FINDSET THEN
                //  REPEAT
                //     ItemNo       := PackagingInfo."Item No.";
                //     PackagingInfo.CALCFIELDS(Description);
                //     DescriptionP := PackagingInfo.Description;
                //              Qty := PackagingInfo.Quantity;
                //     PakgRefNo    := PackagingInfo."Packaging Ref No.";
                //     ReasonCode   := PackagingInfo."Reason Code";
                //   // END;
                //    UNTIL PackagingInfo.NEXT = 0; //IF PackagingInfo.FINDSET THEN
            end;

            trigger OnPreDataItem()
            begin

                if RouteID <> '' then begin
                    "Warehouse Shipment Header".SetRange("Route No.", RouteID);
                end;
                if RouteID = '' then begin

                    Error('Please Enter Route ID....');

                end;

                if Date <> 0D then begin
                    "Warehouse Shipment Header".SetRange("Posting Date", Date);
                end;

                if Date = 0D then begin

                    Error('Please Enter Date....');
                end;

                if TruckID <> '' then begin
                    "Warehouse Shipment Header".SetRange("Truck ID", TruckID);
                end;

                // IF DriverID <> '' THEN
                //  BEGIN
                //    "Warehouse Shipment Header".SETRANGE(Driver,DriverID);
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
        ItemNo: Code[100];
        DescriptionP: Text;
        Qty: Integer;
        PakgRefNo: Code[100];
        ReasonCode: Code[100];
        PackagingInfo: Record "Packaging Information";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        SaleHeader: Record "Sales Header";
        TransferHeader: Record "Transfer Header";
        PurchaseHeader: Record "Purchase Header";
        PackagingType: Code[50];
}

